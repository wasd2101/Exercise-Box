//
//  ColorShapesPress.m
//  DonFactory
//
//  Created by Don on 2014/10/28.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "ColorShapesPress.h"

@implementation ColorShapesPress

-(id)initWithPressName:(NSString *)name width:(NSInteger)width height:(NSInteger)height delegate:(id)delegate{
    self = [super init];
    if(self){
        pressName = name;
        pressWidth = width;
        pressHeight = height;
        pressDelegate = delegate;
        [self initPress];
    }
    return self;
}

-(void)initPress{
    self.frame = CGRectMake(0, 0, pressWidth, pressHeight);
    UIImageView *backImageView = [[UIImageView alloc]init];
    backImageView.frame = CGRectMake(0, 0, pressWidth, pressHeight);

    if([pressName isEqualToString:@"Circle"]){
        backImageView.image = [[UIImage imageNamed:@"colorShapes_circle_green.png"]stretchableImageWithLeftCapWidth:1 topCapHeight:1];
    }else if([pressName isEqualToString:@"Cloud"]){
        backImageView.image = [[UIImage imageNamed:@"colorShapes_cloud_blue.png"]stretchableImageWithLeftCapWidth:1 topCapHeight:1];
    }else if([pressName isEqualToString:@"Heart"]){
        backImageView.image = [[UIImage imageNamed:@"colorShapes_heart_red.png"]stretchableImageWithLeftCapWidth:1 topCapHeight:1];
    }else if([pressName isEqualToString:@"Star"]){
        backImageView.image = [[UIImage imageNamed:@"colorShapes_star_black.png"]stretchableImageWithLeftCapWidth:1 topCapHeight:1];
    }else if([pressName isEqualToString:@"Sun"]){
        backImageView.image = [[UIImage imageNamed:@"colorShapes_sun_yellow.png"]stretchableImageWithLeftCapWidth:1 topCapHeight:1];
    }
    [self addSubview:backImageView];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressed)];
    [self addGestureRecognizer:tap];
    
}

-(void)pressed{
    [pressDelegate pressedGotPressName:pressName];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    self.alpha =0.6;
    self.backgroundColor = [UIColor whiteColor];
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelay:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    self.alpha =1;
    self.backgroundColor = nil;
    [UIView commitAnimations];
}

//代理
-(void)pressedGotPressName:(NSString *)name{
    
}

@end
