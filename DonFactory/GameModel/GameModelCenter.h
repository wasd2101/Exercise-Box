//
//  GameModelCenter.h
//  DonFactory
//
//  Created by Don on 2014/10/16.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GameCenterUpdateData.h"
#import "GameCenter.h"
@interface GameModelCenter : NSObject{
    GameCenter *gameCenter;
    GameCenterUpdateData *gameCenterUpdateData;
    NSString *gameName;
    NSInteger gameFinishedPoint;
    NSTimer *gameTimer;
    NSInteger gameTime;
    
    NSArray *gameDetail;//從數據庫拉出來的
}

-(void)initGame;
-(void)centerStartGame;
-(void)centerFinishedGame;
-(void)centerEndGame;
-(void)centerUpdateGameData;

@property id delegate;

@end
