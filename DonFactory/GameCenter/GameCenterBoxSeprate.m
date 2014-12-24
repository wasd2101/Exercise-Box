//
//  GameCenterBoxSeprate.m
//  DonFactory
//
//  Created by Don on 2014/10/20.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "GameCenterBoxSeprate.h"

@implementation GameCenterBoxSeprate

-(id)init{
    self = [super init];
    if(self){
        gameCenter = [GameCenter shareGameCenter];
        [self seprateBox];
    }
    return self;
}

-(void)seprateBox{
    gameBoxDetail =[[NSMutableArray alloc]initWithArray:[gameCenter loadGameBoxDetail]];
    gameBox = [[NSMutableArray alloc]init];
    
    for(NSDictionary *obj in gameBoxDetail){
        NSNumber *blueBarPoint = [obj objectForKey:@"blueBarPoint"];
        NSNumber *yellowBarPoint = [obj objectForKey:@"yellowBarPoint"];
        NSNumber *goldBarPoint = [obj objectForKey:@"goldBarPoint"];
        
        
        NSNumber *gameID = [obj objectForKey:@"gameID"];
        NSString *gameName = [obj objectForKey:@"gameName"];
        NSString *currentBarType = [obj objectForKey:@"currentBarType"];
        NSNumber *barLimitPoint = [self checkBarProcessWithCurrentBarType:currentBarType bluePoint:blueBarPoint yellowPoint:yellowBarPoint goldPoint:goldBarPoint];
        NSNumber *unLockState = [obj objectForKey:@"unLockState"];
        NSNumber *currentPoint = [obj objectForKey:@"currentPoint"];
        NSNumber *playedCountNumber = [obj objectForKey:@"playedCount"];
        NSNumber *gameTimeNumber = [obj objectForKey:@"gameTime"];
        
        NSString *unLockBarType = [obj objectForKey:@"unLockBarType"];
        NSNumber *unLockBarPoint = [obj objectForKey:@"unLockBarPoint"];
        [self checkInGameBoxWithGameID:gameID gameName:gameName currentPoint:currentPoint currentBarType:currentBarType barLimitPoint:barLimitPoint unLockState:unLockState playedCount:playedCountNumber gameTime:gameTimeNumber unLockBarType:unLockBarType unLockBarPoint:unLockBarPoint];
    }

}

-(NSNumber *)checkBarProcessWithCurrentBarType:(NSString *)currentBarType bluePoint:(NSNumber *)bluePoint yellowPoint:(NSNumber *)yellowPoint goldPoint:(NSNumber *)goldPoint{
    NSNumber *barLimitPointNumber = [[NSNumber alloc]init];
    if([currentBarType  isEqual:@"White Bar"]){
        barLimitPointNumber = bluePoint;
    }else if([currentBarType isEqualToString:@"Blue Bar"]){
        barLimitPointNumber = yellowPoint;
    }else if([currentBarType isEqualToString:@"Yellow Bar"]){
        barLimitPointNumber = goldPoint;
    }else if([currentBarType isEqualToString:@"Gold Bar"]){
        barLimitPointNumber = goldPoint;
    }
    return barLimitPointNumber;
}

-(void)checkInGameBoxWithGameID:(NSNumber *)gameID gameName:(NSString *)gameName currentPoint:(NSNumber *)currentPoint currentBarType:(NSString *)currentBarType barLimitPoint:(NSNumber *)barLimitPoint unLockState:(NSNumber *)unLockState playedCount:(NSNumber *)played gameTime:(NSNumber *)time unLockBarType:(NSString *)unLockBarType unLockBarPoint:(NSNumber *)unLockBarPoint{
    [gameBox addObject:@{@"gameID":gameID,@"gameName":gameName,@"currentPoint":currentPoint,@"currentBarType":currentBarType,@"barLimitPoint":barLimitPoint,@"unLockState":unLockState,@"playedCount":played,@"gameTime":time,@"unLockBarType":unLockBarType,@"unLockBarPoint":unLockBarPoint}];
}

-(NSMutableString *)judgeBarTypeWithBluePoint:(NSInteger)bluePoint yellowPoint:(NSInteger)yellowPoint goldPoint:(NSInteger)goldPoint currentPoint:(NSInteger)currentPoint{
    NSMutableString *currentBarType = [[NSMutableString alloc]init];
    
    if(currentPoint > goldPoint){
        currentBarType = [NSMutableString stringWithString:@"Gold Bar"];
    }else if(currentPoint<goldPoint && currentPoint > yellowPoint){
        currentBarType = [NSMutableString stringWithString:@"Yellow Bar"];
    }else if(currentPoint>bluePoint && currentPoint<yellowPoint){
        currentBarType = [NSMutableString stringWithString:@"Blue Bar"];
    }else if(currentPoint<bluePoint){
        currentBarType = [NSMutableString stringWithString:@"White Bar"];
    }
    return currentBarType;
}

-(NSMutableArray *)loadGameBox{
    return gameBox;
}

-(NSMutableArray *)loadGameBoxDetail{
    return gameBoxDetail;
}
@end
