//
//  NextBoxCenter.h
//  DonFactory
//
//  Created by Don on 2014/11/2.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "GameModelCenter.h"

@interface NextBoxCenter : GameModelCenter{
    NSInteger tapSuccess;
    NSInteger randomColorInt;
    
    NSMutableArray *answerArray;
    
    NSInteger judgeSwitch;
}

-(void)judgeSameColor:(NSInteger)judge;

@end
