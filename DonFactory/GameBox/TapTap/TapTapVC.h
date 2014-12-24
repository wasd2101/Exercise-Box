//
//  TapTapVC.h
//  DonFactory
//
//  Created by Don on 2014/10/25.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "GameUIModel.h"
#import "TapTapCenter.h"


@interface TapTapVC : GameUIModel{
    TapTapCenter *taptapCenter;
    NSInteger blockAmt;
    NSInteger blockWidth;
    NSInteger blockHeight;

    NSMutableArray *blockArray;
    NSMutableArray *blockPointArray;
    NSTimer *blockShowTimer;
    NSInteger blockOutPos;
    NSMutableArray *randNumberArray;
    
    CGFloat showBlockDelayTime;
    
    UIView *blockBoard;
    

    
}

@end



