//
//  GameModelCenter.m
//  DonFactory
//
//  Created by Don on 2014/10/16.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "GameModelCenter.h"


#import "SqlTool.h"

@implementation GameModelCenter
-(id)init{
    self = [super init];
    if(self){
        gameCenterUpdateData = [[GameCenterUpdateData alloc]init];
        gameCenter = [GameCenter shareGameCenter];
    }
    return self;
}

-(void)centerStartGame{
    gameTimer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerCountDown) userInfo:nil repeats:YES];
    [self initGame];
    SqlTool *sqlTool = [SqlTool shareSqlTool];
    gameDetail = [NSArray arrayWithArray:[sqlTool loadSingleGameBoxDetailWithGameName:gameName]];
    gameTime = [[gameDetail[0]objectForKey:@"gameTime"]integerValue];
    
}

-(void)initGame{
    
}

-(void)timerCountDown{
    if(gameTime ==0){
        [self centerFinishedGame];
    }else{
        gameTime -=1;
        [self.delegate refreshGameTime:gameTime];
    }
}

-(void)centerFinishedGame{
    
}

-(void)centerEndGame{
    [gameTimer invalidate];
    [gameCenter refreshMVC];
}

-(void)centerUpdateGameData{
    //更新DB數據，並且刷新MVC的View
    [gameCenterUpdateData updateGameDataWithName:gameName point:gameFinishedPoint];
    [gameCenter refreshMVC];
}


//代理
-(void)refreshGameTime:(NSInteger)time{
    
}

@end
