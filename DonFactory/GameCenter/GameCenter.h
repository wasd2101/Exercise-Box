//
//  GameCenter.h
//  DonFactory
//
//  Created by Don on 2014/10/20.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameCenterInitData.h"
#import "SqlTool.h"

@interface GameCenter : NSObject{
    GameCenterInitData *gameCenterInitData;
    SqlTool *sqlTool;
}

+(GameCenter *)shareGameCenter;
-(NSMutableArray *)loadGameBoxDetail;
-(void)refreshMVC;
@end
