//
//  NextDropCenter.h
//  DonFactory
//
//  Created by Don on 2014/11/3.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "GameModelCenter.h"

@interface NextDropCenter : GameModelCenter{
    NSInteger tapSuccess;

    NSInteger dropLevel;
    NSInteger baseDropAmt;
    NSInteger dropAmt;
    CGFloat dropTime;
    

    NSInteger judgePos;
    
    NSMutableArray *answerArray;


}

-(void)judgeDropWithColor:(NSString *)color;
@end
