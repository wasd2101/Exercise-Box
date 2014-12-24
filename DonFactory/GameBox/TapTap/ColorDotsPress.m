//
//  ColorDotsPress.m
//  DonFactory
//
//  Created by Don on 2014/10/28.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "ColorDotsPress.h"
#import "UIColor+DonColor.h"

@implementation ColorDotsPress

-(id)initWithColor:(NSString *)colorName width:(NSInteger)width height:(NSInteger)height delegate:(id)delegate{
    self = [super init];
    if(self){
        pressColor = [NSString stringWithString:colorName];
        pressWidth = width;
        pressHeight = height;
        pressDelegate = delegate;
        [self initColorPress];
        
    }
    return self;
}


-(void)initColorPress{
    //layout
    self.frame = CGRectMake(0, 0, pressWidth, pressHeight);
    self.layer.cornerRadius = 10;
    
    if([pressColor isEqualToString:@"Red"]){
        self.backgroundColor = [UIColor donRed];
    }else if([pressColor isEqualToString:@"Yellow"]){
        self.backgroundColor = [UIColor donYellow];
    }else if([pressColor isEqualToString:@"Blue"]){
        self.backgroundColor = [UIColor donBlue];
    }else if([pressColor isEqualToString:@"Green"]){
        self.backgroundColor = [UIColor donGreen];
    }
    
    //function
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressed)];
    
    [self addGestureRecognizer:tap];
}

-(void)pressed{
    [pressDelegate pressedWithColorName:pressColor];
    [self pressAnimation];
}

-(void)pressAnimation{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    self.alpha = 0.4;
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDelay:0.1];
    self.alpha =1;
    [UIView commitAnimations];
    
    
}


//代理
-(void)pressedWithColorName:(NSString *)colorName{
    
}

@end
