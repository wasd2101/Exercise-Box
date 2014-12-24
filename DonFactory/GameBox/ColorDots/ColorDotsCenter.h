//
//  ColorDotsCenter.h
//  DonFactory
//
//  Created by Don on 2014/10/28.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "GameModelCenter.h"

@interface ColorDotsCenter : GameModelCenter{
    NSMutableString *indicatorColor;
    NSMutableArray *colorArray;
    NSInteger tapSuccess;
    NSInteger colorDotsAmt;
    
    NSInteger dotPos;
}
-(void)judgeTapWithColorName:(NSString *)color;
@end
