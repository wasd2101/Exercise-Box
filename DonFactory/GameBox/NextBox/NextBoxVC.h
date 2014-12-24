//
//  NextBoxVC.h
//  DonFactory
//
//  Created by Don on 2014/11/2.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "GameUIModel.h"
#import "NextBoxCenter.h"
#import "NextBoxBox.h"

@interface NextBoxVC : GameUIModel{
    NSInteger pressWidth;
    NSInteger pressHeight;
    
    UIView *boxTable;
    NSInteger boxTableWidth;
    NSInteger boxTableHeight;
    
    
    UIView *leftPress;
    UIView *rightPress;
    
    NextBoxBox *box;
    NSInteger boxWidth;
    NSInteger boxHeight;
    NSInteger boxX;
    NSInteger boxY;
    
    UIView *yesNoCover;
    
    NextBoxCenter *nextBoxCenter;
}

@end
