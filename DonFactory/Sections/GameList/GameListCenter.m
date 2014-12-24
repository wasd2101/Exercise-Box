//
//  GameListCenter.m
//  DonFactory
//
//  Created by Don on 2014/10/20.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "GameListCenter.h"

//遊戲列表
#import "UpDownVC.h"
#import "WhichWayVC.h"
#import "TapTapVC.h"
#import "ColorDotsVC.h"
#import "ColorShapesVC.h"
#import "LeftRightVC.h"
#import "OnOffVC.h"
#import "NextBoxVC.h"
#import "NextDropVC.h"

@implementation GameListCenter

-(id)init{
    self = [super init];
    if(self){
        gameCenter = [GameCenter shareGameCenter];
        gameCenterBoxSeprate =[[GameCenterBoxSeprate alloc]init];
        [self initGameListCenter];

    }
    return self;
}

-(void)initGameListCenter{
    gameBox = [[NSMutableArray alloc]initWithArray:[gameCenterBoxSeprate loadGameBox]];
}

-(NSMutableArray *)loadGameBox{
    return gameBox;
}



-(void)selectedGameName:(NSString *)name{
    if([name isEqualToString:@"UpDown"]){
        UpDownVC *upDown = [[UpDownVC alloc]init];
        [self.delegate pushGameView:upDown];
    }else if([name isEqualToString:@"WhichWay"]){
        WhichWayVC *whichWay = [[WhichWayVC alloc]init];
        [self.delegate pushGameView:whichWay];
    }else if([name isEqualToString:@"TapTap"]){
        TapTapVC *taptap = [[TapTapVC alloc]init];
        [self.delegate pushGameView:taptap];
    }else if([name isEqualToString:@"ColorDots"]){
        ColorDotsVC *colorDots = [[ColorDotsVC alloc]init];
        [self.delegate pushGameView:colorDots];
    }else if([name isEqualToString:@"ColorShapes"]){
        ColorShapesVC *colorShapes = [[ColorShapesVC alloc]init];
        [self.delegate pushGameView:colorShapes];
    }else if([name isEqualToString:@"LeftRight"]){
        LeftRightVC *leftRight = [[LeftRightVC alloc]init];
        [self.delegate pushGameView:leftRight];
    }else if([name isEqualToString:@"OnOff"]){
        OnOffVC *onOff = [[OnOffVC alloc]init];
        [self.delegate pushGameView:onOff];
    }else if([name isEqualToString:@"NextBox"]){
        NextBoxVC *nextBox = [[NextBoxVC alloc]init];
        [self.delegate pushGameView:nextBox];
    }else if([name isEqualToString:@"NextDrop"]){
        NextDropVC *nextDrop = [[NextDropVC alloc]init];
        [self.delegate pushGameView:nextDrop];
    }
    
}


//代理方法
-(void)pushGameView:(id)game{
    
}




@end
