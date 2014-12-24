//
//  GameCenter.m
//  DonFactory
//
//  Created by Don on 2014/10/20.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "GameCenter.h"
#import "MainViewController.h"
static GameCenter *gameCenter = nil;

@implementation GameCenter

+(GameCenter *)shareGameCenter{
    if(gameCenter ==nil){
        gameCenter = [[GameCenter alloc]init];
    }
    return gameCenter;
}

-(id)init{
    self = [super init];
    if(self){
        [self initGameCenter];
        sqlTool = [SqlTool shareSqlTool];
    }
    return self;
}

-(void)initGameCenter{
    gameCenterInitData = [GameCenterInitData shareGameCenterInitData];
    
}
-(void)refreshMVC{
    MainViewController *MVC = [MainViewController shareMVC];
    [MVC refreshMVC];
}

-(NSMutableArray *)loadGameBoxDetail{
    NSMutableArray *array = [[NSMutableArray alloc]initWithArray:[sqlTool loadGameBoxDetail]];
    return array;
}




@end
