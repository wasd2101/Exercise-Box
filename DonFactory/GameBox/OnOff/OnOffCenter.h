//
//  OnOffCenter.h
//  DonFactory
//
//  Created by Don on 2014/10/31.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "GameModelCenter.h"

@interface OnOffCenter : GameModelCenter{
    NSInteger tapSuccess;
    NSInteger lightAmt;
    
    NSMutableArray *answerArray;
    NSInteger lightLevel;
    NSInteger judgePos;
}

-(void)judgeLight:(NSInteger)onOff;
@end
