//
//  ColorDotsBar.h
//  DonFactory
//
//  Created by Don on 2014/10/28.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorDotsBar : UIView{
    NSInteger dotsAmt;
    NSInteger dotsWidth;
    NSInteger dotsHeight;
    NSInteger barWidth;
    NSInteger barHeight;
    NSInteger blankWidth;
    
    UIView *dotView1;
    UIView *dotView2;
    UIView *dotView3;
    UIView *dotView4;
        
    NSMutableArray *dotsColorArray;
    
}
-(id)initBarWithColorArray:(NSMutableArray *)array;
-(void)setRemoveDotsWithPosition:(NSInteger)position;
@end
