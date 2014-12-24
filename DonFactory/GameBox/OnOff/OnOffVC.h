//
//  OnOffVC.h
//  DonFactory
//
//  Created by Don on 2014/10/31.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "GameUIModel.h"
#import "OnOffCenter.h"
@interface OnOffVC : GameUIModel{
    OnOffCenter *onOffCenter;
    
    UIView *leftPress;
    UIView *rightPress;
    NSInteger pressWidth;
    NSInteger pressHeight;
    UIView *pressCover;
    
    
    UIView *lightTable;
    NSInteger lightTableWidth;
    NSInteger lightTableHeight;
    
    NSMutableArray *lightArray;
    NSInteger lightWidth;
    NSInteger lightHeight;
    
    
    NSMutableArray *boxArray;
    NSInteger boxWidth;
    NSInteger boxHeight;
    
    NSMutableArray *centerBoxPos;
    NSMutableArray *centerLightPos;
    
    NSInteger lightLevel;
    
    UIView *startPress;
    NSInteger startPressWidth;
    NSInteger startPressHeight;
}

@end
