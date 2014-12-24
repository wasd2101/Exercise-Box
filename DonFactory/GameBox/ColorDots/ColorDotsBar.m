//
//  ColorDotsBar.m
//  DonFactory
//
//  Created by Don on 2014/10/28.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "ColorDotsBar.h"
#import "UIColor+DonColor.h"

@implementation ColorDotsBar

-(id)initBarWithColorArray:(NSMutableArray *)array{
    self = [super init];
    if(self){
        dotsWidth = 40;
        dotsHeight = 40;
        blankWidth = 5;
        dotsAmt = [array count];
        barWidth = (dotsWidth+blankWidth) *dotsAmt;
        barHeight = barHeight+blankWidth;
        
        dotsColorArray = [[NSMutableArray alloc]initWithArray:array];

        [self initBar];
        [self arrangeDotsColor];
        
    }
    return self;
}

-(void)initBar{
    self.frame = CGRectMake(0, 0, barWidth, barHeight);
    dotView1 = [[UIView alloc]init];
    dotView1.layer.cornerRadius = 20;
    dotView1.layer.borderWidth = 1;
    
    dotView2 = [[UIView alloc]init];
    dotView2.layer.cornerRadius = 20;
    dotView2.layer.borderWidth = 1;
    
    dotView3 = [[UIView alloc]init];
    dotView3.layer.cornerRadius = 20;
    dotView3.layer.borderWidth = 1;
    
    dotView4 = [[UIView alloc]init];
    dotView4.layer.cornerRadius = 20;
    dotView4.layer.borderWidth = 1;
    
    NSMutableArray *dotViews = [[NSMutableArray alloc]initWithObjects:dotView1,dotView2,dotView3,dotView4, nil];

    for(NSInteger i=0;i<[dotViews count];i++){
        UIView *dotView = dotViews[i];
        dotView.frame =CGRectMake(dotsWidth*i, 0, dotsWidth, dotsHeight);
        [self addSubview:dotView];
    }

}

-(void)arrangeDotsColor{
    NSMutableString *sysDotColorStr = [[NSMutableString alloc]init];
    for(NSInteger i=0;i<[dotsColorArray count];i++){
        sysDotColorStr = [NSMutableString stringWithString:dotsColorArray[i]];
        UIColor *sysColor=[self getColorWithColorName:sysDotColorStr];
        [self arrangeDotsWithPosition:i UIColor:sysColor];
    }
}

-(void)arrangeDotsWithPosition:(NSInteger)position UIColor:(UIColor *)color{

    switch (position) {
        case 0:
            dotView1.backgroundColor = color;
            break;
        case 1:
            dotView2.backgroundColor = color;
            break;
        case 2:
            dotView3.backgroundColor = color;
            break;
        case 3:
            dotView4.backgroundColor = color;
            break;
        default:
            break;
    }
}

-(UIColor *)getColorWithColorName:(NSString *)colorName{
    UIColor *sysColor = [[UIColor alloc]init];
    if([colorName isEqualToString:@"Red"]){
        sysColor = [UIColor donRed];
    }else if([colorName isEqualToString:@"Yellow"]){
        sysColor = [UIColor donYellow];
    }else if([colorName isEqualToString:@"Blue"]){
        sysColor = [UIColor donBlue];
    }else if([colorName isEqualToString:@"Green"]){
        sysColor = [UIColor donGreen];
    }
    return sysColor;
}

-(void)setRemoveDotsWithPosition:(NSInteger)position{
    switch (position) {
        case 0:
            [self removeAnimationWithDotView:dotView1 position:0];
            break;
        case 1:
            [self removeAnimationWithDotView:dotView2 position:1];
            break;
        case 2:
            [self removeAnimationWithDotView:dotView3 position:2];
            break;
        case 3:
            [self removeAnimationWithDotView:dotView4 position:3];
            break;
            
        default:
            break;
    }
}

-(void)removeAnimationWithDotView:(UIView *)view position:(NSInteger)position{
    NSNumber *posNum = [[NSNumber alloc]initWithInteger:position];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    view.alpha = 0.5;
    [UIView commitAnimations];
    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(setTimerToRemove:) userInfo:posNum repeats:NO];
}


-(void)setTimerToRemove:(NSTimer *)timer{
    NSInteger pos =[[timer userInfo]integerValue];
    switch (pos) {
        case 0:
            [dotView1 removeFromSuperview];
            break;
        case 1:
            [dotView2 removeFromSuperview];
            break;
        case 2:
            [dotView3 removeFromSuperview];
            break;
        case 3:
            [dotView4 removeFromSuperview];
            break;
            
        default:
            break;
    }
}

@end
