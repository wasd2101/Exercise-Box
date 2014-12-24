//
//  GameCenterInitData.m
//  DonFactory
//
//  Created by Don on 2014/10/20.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "GameCenterInitData.h"
static GameCenterInitData *gameCenterInitData = nil;

@implementation GameCenterInitData

+(GameCenterInitData *)shareGameCenterInitData{
    if(gameCenterInitData ==nil){
        gameCenterInitData = [[GameCenterInitData alloc]init];

    }
    return gameCenterInitData;
}

-(id)init{
    self = [super init];
    if(self){
        sqlTool = [SqlTool shareSqlTool];
        sqlTool.delegate = self;
        [self initDataBase];
    }
    return self;
}
#pragma mark GameList
-(void)initGameList{
    gameListArray = [[NSMutableArray alloc]init];
    [self addToGameList:gameListArray
                 gameID:1 gameName:@"UpDown"
           blueBarPoint:10 yellowBarPoint:12 goldBarPoint:17 currentPoint:0
          unLockBarType:@"White Bar" unLockBarPoint:0 unLockState:1
         currentBarType:@"White Bar" playedCount:0 gameTime:15];
    
    [self addToGameList:gameListArray
                 gameID:2 gameName:@"OnOff"
           blueBarPoint:5 yellowBarPoint:15 goldBarPoint:30 currentPoint:0
          unLockBarType:@"Yellow Bar" unLockBarPoint:1 unLockState:0
         currentBarType:@"White Bar" playedCount:0 gameTime:20];
    
    [self addToGameList:gameListArray
                 gameID:3 gameName:@"TapTap"
           blueBarPoint:6 yellowBarPoint:8 goldBarPoint:10 currentPoint:9
          unLockBarType:@"Gold Bar" unLockBarPoint:1 unLockState:0
         currentBarType:@"White Bar" playedCount:0 gameTime:25];

    [self addToGameList:gameListArray
                 gameID:4 gameName:@"WhichWay"
           blueBarPoint:20 yellowBarPoint:23 goldBarPoint:25 currentPoint:9
          unLockBarType:@"Gold Bar" unLockBarPoint:2 unLockState:0
         currentBarType:@"White Bar" playedCount:0 gameTime:15];
    
    [self addToGameList:gameListArray
                 gameID:5 gameName:@"NextDrop"
           blueBarPoint:8 yellowBarPoint:12 goldBarPoint:16 currentPoint:0
          unLockBarType:@"Yellow Bar" unLockBarPoint:4 unLockState:0
         currentBarType:@"White Bar" playedCount:0 gameTime:26];
    
    [self addToGameList:gameListArray
                 gameID:6 gameName:@"ColorDots"
           blueBarPoint:5 yellowBarPoint:7 goldBarPoint:9 currentPoint:9
          unLockBarType:@"Yellow Bar" unLockBarPoint:5 unLockState:0
         currentBarType:@"White Bar" playedCount:0 gameTime:15];
    
    [self addToGameList:gameListArray
                 gameID:7 gameName:@"NextBox"
           blueBarPoint:36 yellowBarPoint:38 goldBarPoint:45 currentPoint:0
          unLockBarType:@"Yellow Bar" unLockBarPoint:6 unLockState:0
         currentBarType:@"White Bar" playedCount:0 gameTime:20];
    
    [self addToGameList:gameListArray
                 gameID:8 gameName:@"LeftRight"
           blueBarPoint:100 yellowBarPoint:115 goldBarPoint:120 currentPoint:0
          unLockBarType:@"Yellow Bar" unLockBarPoint:7 unLockState:0
         currentBarType:@"White Bar" playedCount:0 gameTime:25];
    
    [self addToGameList:gameListArray
                 gameID:9 gameName:@"ColorShapes"
           blueBarPoint:12 yellowBarPoint:16 goldBarPoint:20 currentPoint:0
          unLockBarType:@"Yellow Bar" unLockBarPoint:8 unLockState:0
         currentBarType:@"White Bar" playedCount:0 gameTime:30];
}

-(void)addToGameList:(NSMutableArray *)array gameID:(NSInteger)gameID gameName:(NSString *)name blueBarPoint:(NSInteger)bluePoint yellowBarPoint:(NSInteger)yellowPoint goldBarPoint:(NSInteger)goldPoint currentPoint:(NSInteger)currentPoint unLockBarType:(NSString *)unLockType unLockBarPoint:(NSInteger)unLockBarPoint unLockState:(NSInteger)unLockState currentBarType:(NSString *)currentBarType playedCount:(NSInteger)playedCount gameTime:(NSInteger)time{
    
    NSNumber *gameNumber = [[NSNumber alloc]initWithInteger:gameID];
    NSNumber *blueBarPointNumber = [[NSNumber alloc]initWithInteger:bluePoint];
    NSNumber *yellowBarPointNumber = [[NSNumber alloc]initWithInteger:yellowPoint];
    NSNumber *goldBarPointNumber = [[NSNumber alloc]initWithInteger:goldPoint];
    NSNumber *currentPointNumber = [[NSNumber alloc]initWithInteger:currentPoint];
    NSNumber *unLockBarPointNumber = [[NSNumber alloc]initWithInteger:unLockBarPoint];
    NSNumber *unLockStateNumber =[[NSNumber alloc]initWithInteger:unLockState];
    NSNumber *playedCountNumber = [[NSNumber alloc]initWithInteger:playedCount];
    NSNumber *gameTime = [[NSNumber alloc]initWithInteger:time];
    
    [array addObject:@{@"gameID":gameNumber,@"gameName":name,@"blueBarPoint":blueBarPointNumber,@"yellowBarPoint":yellowBarPointNumber,@"goldBarPoint":goldBarPointNumber,@"currentPoint":currentPointNumber,@"unLockBarType":unLockType,@"unLockBarPoint":unLockBarPointNumber,@"unLockState":unLockStateNumber,@"currentBarType":currentBarType,@"playedCount":playedCountNumber,@"gameTime":gameTime}];
}

#pragma mark initDataBase
-(void)initDataBase{
    [self initGameList];
    //創建表
    NSString *sql = @"CREATE TABLE gameList(gameID int,gameName TEXT COLLATE NOCASE,blueBarPoint int,yellowBarPoint int,goldBarPoint int,currentPoint int,unLockBarType TEXT,unLockBarPoint int,unLockState int,currentBarType TEXT,playedCount int,gameTime int)";
    [sqlTool execSqliteWithSQL:sql];
    
    //我用創建表時看是否出錯來判斷是不是第一次打開app，不知道性能和判斷某table是否存在比較會不會性能差很多？
    //寫入基本信息
    if(execSqlGotError == 0){
        for(NSDictionary *gameDic in gameListArray){

            int gameID;
            NSMutableString *gameName = [[NSMutableString alloc]init];
            int bluePoint;
            int yellowPoint;
            int goldPoint;
            int currentPoint;
            NSMutableString *unLockBarType = [[NSMutableString alloc]init];
            int unLockBarPoint;
            int unLockState;
            NSMutableString *currentBarType = [[NSMutableString alloc]init];
            int playedCount;
            int gameTime;
            
            gameID = [[gameDic objectForKey:@"gameID"]intValue];
            gameName = [gameDic objectForKey:@"gameName"];
            bluePoint = [[gameDic objectForKey:@"blueBarPoint"]intValue];
            yellowPoint = [[gameDic objectForKey:@"yellowBarPoint"]intValue];
            goldPoint = [[gameDic objectForKey:@"goldBarPoint"]intValue];
            currentPoint = [[gameDic objectForKey:@"currentBarPoint"]intValue];
            unLockBarType =[gameDic objectForKey:@"unLockBarType"];
            unLockBarPoint = [[gameDic objectForKey:@"unLockBarPoint"]intValue];
            unLockState = [[gameDic objectForKey:@"unLockState"]intValue];
            currentBarType =[gameDic objectForKey:@"currentBarType"];
            playedCount = [[gameDic objectForKey:@"playedCount"]intValue];
            gameTime = [[gameDic objectForKey:@"gameTime"]intValue];
            
            
            NSString *sql =[NSString stringWithFormat:@"INSERT INTO gameList(gameID,gameName,blueBarPoint,yellowBarPoint,goldBarPoint,currentPoint,unLockBarType,unLockBarPoint,unLockState,currentBarType,playedCount,gameTime) VALUES ('%i','%@','%i','%i','%i','%i','%@','%i','%i','%@','%i','%i')",gameID,gameName,bluePoint,yellowPoint,goldPoint,currentPoint,unLockBarType,unLockBarPoint,unLockState,currentBarType,playedCount,gameTime];
            [sqlTool execSqliteWithSQL:sql];

        }
    }else if (execSqlGotError ==1){
        //把gotError改回0，不然永遠都是1了。
        execSqlGotError =0;
    }
}

-(NSMutableArray *)LoadGameBoxDetail{
    NSMutableArray *gameList = [[NSMutableArray alloc]initWithArray:[sqlTool loadGameBoxDetail]];
    return gameList;
}

//代理方法
-(void)execSqlError:(NSString *)error{
    execSqlGotError = 1;
}
@end
