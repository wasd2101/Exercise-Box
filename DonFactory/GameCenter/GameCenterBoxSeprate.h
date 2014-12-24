//
//  GameCenterBoxSeprate.h
//  DonFactory
//
//  Created by Don on 2014/10/20.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameCenter.h"
@interface GameCenterBoxSeprate : NSObject{
    GameCenter *gameCenter;
    NSMutableArray *gameBoxDetail;
    NSMutableArray *gameBox;
}
-(NSMutableArray *)loadGameBox;
-(NSMutableArray *)loadGameBoxDetail;
@end
