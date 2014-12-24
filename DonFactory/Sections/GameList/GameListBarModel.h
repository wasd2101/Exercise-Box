//
//  GameListBarModel.h
//  DonFactory
//
//  Created by Don on 2014/10/20.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameListBarModel : UIView{

    NSString *currentBarType;
    NSNumber *currentPoint;
    NSNumber *barLimitPoint;
    NSInteger unLockState;
    NSNumber *currentPlayedCount;
    NSString *unLockBarType;
    NSNumber *unLockBarPoint;
    
    NSMutableString *changedBarType;
    NSMutableString *iconString;
    
    NSMutableString *changedGameName;
}


@property NSString *gameName;
@property NSInteger barWidth;
@property NSInteger barHeight;


-(id)initGameListBarWithGameDic:(NSDictionary *)gameDic;


//代理
@property id delegate;

@end
