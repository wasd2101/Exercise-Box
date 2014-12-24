//
//  GameCenterUpdateData.m
//  DonFactory
//
//  Created by Don on 2014/10/21.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "GameCenterUpdateData.h"

@implementation GameCenterUpdateData

-(void)updateGameDataWithName:(NSString *)name point:(NSInteger)point{
    gameName = name;
    gamePoint = point;
    
    [self judgeNeedUpdate];
}

-(void)judgeNeedUpdate{
    sqlTool = [SqlTool shareSqlTool];
    
    //先playCount+1
    [self playedCount];
    
    
    NSNumber *dbPointNumber = [[NSNumber alloc]init];
    dbPointNumber =  [sqlTool loadCurrentPointWithGameName:gameName];
    //如果有創新紀錄，才需要update DB
    //更新單個遊戲的BarType，後面再整體更新
    if(gamePoint>[dbPointNumber integerValue]){
        [self updateSingleGameData];
        [self judgeNeedUnLockBar];
    }
    
}

-(void)updateSingleGameData{
    //先更新gamePoint，然後更新barType
    [sqlTool updateGameDataWithGameName:gameName gamePoint:gamePoint];
    
    singleGameBoxDetail = [[NSMutableArray alloc]initWithArray:[sqlTool loadSingleGameBoxDetailWithGameName:gameName]];
    if([singleGameBoxDetail count]==0){
        NSLog(@"update singleGameData error \n can't find the game");
    }else{
        NSNumber *blueBarPoint = [singleGameBoxDetail[0] objectForKey:@"blueBarPoint"];
        NSNumber *yellowBarPoint = [singleGameBoxDetail[0] objectForKey:@"yellowBarPoint"];
        NSNumber *goldBarPoint = [singleGameBoxDetail[0] objectForKey:@"goldBarPoint"];
        NSNumber *currentPoint = [singleGameBoxDetail[0] objectForKey:@"currentPoint"];
        NSMutableString *newBarType = [[NSMutableString alloc]init];
        if([currentPoint integerValue]>=[goldBarPoint integerValue]){
            newBarType = [NSMutableString stringWithString:@"Gold Bar"];
        }else if([currentPoint integerValue]>=[yellowBarPoint integerValue] &&
                 [currentPoint integerValue]<[goldBarPoint integerValue]){
            newBarType = [NSMutableString stringWithString:@"Yellow Bar"];
        }else if([currentPoint integerValue]>=[blueBarPoint integerValue] &&
                 [currentPoint integerValue]<[yellowBarPoint integerValue]){
            newBarType = [NSMutableString stringWithString:@"Blue Bar"];
        }else if([currentPoint integerValue]<[blueBarPoint integerValue]){
            newBarType = [NSMutableString stringWithString:@"White Bar"];
        }
        [sqlTool updateGameBarTypeWithGameName:gameName barType:newBarType];
    }
}
-(void)playedCount{
    NSNumber *playCountDB = [[NSNumber alloc]init];
    playCountDB = [sqlTool loadPlayedCountWithGameName:gameName];
    NSInteger playCountDBInt = [playCountDB integerValue];
    playCountDBInt +=1;
    NSNumber *newPlayedCountNumber = [[NSNumber alloc]initWithInteger:playCountDBInt];
    [sqlTool updateGamePlayedCountWithGameName:gameName playedNumber:newPlayedCountNumber];

}

-(void)judgeNeedUnLockBar{
    gameBoxDetail = [sqlTool loadGameBoxDetail];
    
    //計算各種BarType數量
    whiteBarAmt =0;
    blueBarAmt =0;
    yellowBarAmt =0;
    goldBarAmt =0;
    for(NSDictionary *obj in gameBoxDetail){
        //解鎖才計算
        if([[obj objectForKey:@"unLockState"]integerValue] ==1){
            NSMutableString *currentBarType = [[NSMutableString alloc]initWithString:[obj objectForKey:@"currentBarType"]];
            if([@"Gold Bar" isEqualToString:currentBarType]){
                goldBarAmt +=1;
            }else if([@"Yellow Bar" isEqualToString:currentBarType]){
                yellowBarAmt +=1;
            }else if([@"Blue Bar" isEqualToString:currentBarType]){
                blueBarAmt +=1;
            }else if([@"White Bar" isEqualToString:currentBarType]){
                whiteBarAmt +=1;
            }
        }
    }
    
    
    //把BarType數量，包裝成NSDictionary
    //高級bar可以代替低級bar所以疊加
    NSNumber *whiteBarAmtNumber = [[NSNumber alloc]initWithInteger:whiteBarAmt+blueBarAmt+yellowBarAmt+goldBarAmt];
    NSNumber *blueBarAmtNumber = [[NSNumber alloc]initWithInteger:blueBarAmt+yellowBarAmt+goldBarAmt];
    NSNumber *yellowBarAmtNumber = [[NSNumber alloc]initWithInteger:yellowBarAmt+goldBarAmt];
    NSNumber *goldBarAmtNumber = [[NSNumber alloc]initWithInteger:goldBarAmt];
    
    NSDictionary *whiteBarAmtDic = [[NSDictionary alloc]initWithObjectsAndKeys:whiteBarAmtNumber,@"White Bar", nil];
    NSDictionary *blueBarAmtDic = [[NSDictionary alloc]initWithObjectsAndKeys:blueBarAmtNumber,@"Blue Bar", nil];
    NSDictionary *yellowBarAmtDic = [[NSDictionary alloc]initWithObjectsAndKeys:yellowBarAmtNumber,@"Yellow Bar", nil];
    NSDictionary *goldBarAmtDic =[[NSDictionary alloc]initWithObjectsAndKeys:goldBarAmtNumber,@"Gold Bar", nil];
    
    //看是否有Bar需要解鎖
    for(NSDictionary *obj in gameBoxDetail){
        NSMutableString *judgeGameName = [[NSMutableString alloc]initWithString:[obj objectForKey:@"gameName"]];
        NSMutableString *judgeBarType = [[NSMutableString alloc]initWithString:[obj objectForKey:@"unLockBarType"]];
        NSNumber *judgeBarTypeAmt = [[NSNumber alloc]init];
        judgeBarTypeAmt = [obj objectForKey:@"unLockBarPoint"];
        
        //判斷是否已達到解鎖條件
        if([judgeBarType isEqualToString:@"Gold Bar"]){
            if([judgeBarTypeAmt integerValue]<=[[goldBarAmtDic objectForKey:@"Gold Bar"]integerValue]){
                [self unLockBarWithGameName:judgeGameName];
            }
        }else if([judgeBarType isEqualToString:@"Yellow Bar"]){
            if([judgeBarTypeAmt integerValue]<=[[yellowBarAmtDic objectForKey:@"Yellow Bar"]integerValue]){
                [self unLockBarWithGameName:judgeGameName];
            }
        }else if([judgeBarType isEqualToString:@"Blue Bar"]){
            if([judgeBarTypeAmt integerValue]<=[[blueBarAmtDic objectForKey:@"Blue Bar"]integerValue]){
                [self unLockBarWithGameName:judgeGameName];
            }
        }else if([judgeBarType isEqualToString:@"White Bar"]){
            if([judgeBarTypeAmt integerValue]<=[[whiteBarAmtDic objectForKey:@"White Bar"]integerValue]){
                [self unLockBarWithGameName:judgeGameName];
            }
        }
    }
}

-(void)unLockBarWithGameName:(NSString *)name{
    [sqlTool updateGameLockStateWithGameName:name unLockState:1];
}


@end
