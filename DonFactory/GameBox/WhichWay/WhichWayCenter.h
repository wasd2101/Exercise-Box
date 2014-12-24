//
//  WhichWayCenter.h
//  DonFactory
//
//  Created by Don on 2014/10/24.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "GameModelCenter.h"

@interface WhichWayCenter : GameModelCenter{
    NSMutableString *blockDirectionStr;
    NSInteger blockDirectionInt;
    NSInteger swipeSuccess;
    NSInteger swipeOpp;
    
    NSArray *wayArray;
    NSArray *opsiteWayArray;
}

-(void)swipeDirection:(NSString *)direction;

@property id delegate;


@end
