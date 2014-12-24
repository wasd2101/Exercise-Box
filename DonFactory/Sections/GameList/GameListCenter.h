//
//  GameListCenter.h
//  DonFactory
//
//  Created by Don on 2014/10/20.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameCenter.h"
#import "GameCenterBoxSeprate.h"
@interface GameListCenter : NSObject{
    GameCenter *gameCenter;
    GameCenterBoxSeprate *gameCenterBoxSeprate;
    NSMutableArray *gameBox;
}

-(void)selectedGameName:(NSString *)name;
-(NSMutableArray *)loadGameBox;
//代理
@property id delegate;

-(void)pushGameView:(id)game;

@end
