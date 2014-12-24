//
//  NextDropVC.h
//  DonFactory
//
//  Created by Don on 2014/11/3.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "GameUIModel.h"
#import "NextDropCenter.h"

@interface NextDropVC : GameUIModel{
    NextDropCenter *nextDropCenter;
    
    NSInteger baseX;
    
    NSInteger cloudWidth;
    NSInteger cloudHeight;
    
    NSInteger umbrellaWidth;
    NSInteger umbrellaHeight;
    NSInteger umbrellaY;
    
    NSInteger dropTableWidth;
    NSInteger dropTableHeight;
    
    NSInteger dropWidth;
    NSInteger dropHeight;
    
    UIView *dropTable;
    
    NSInteger dropStep;
    NSInteger dropAmt;
    
    NSInteger dropLeft;
    UILabel *leftLabel;
    
    NSInteger dropLevel;
    UILabel *levelLabel;
    
    NSTimer *dropTimer;
    
    UIView *umbrellaCover;
    
}

@end
