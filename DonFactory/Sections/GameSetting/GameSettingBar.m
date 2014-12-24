//
//  GameSettingBar.m
//  DonFactory
//
//  Created by Don on 2014/11/5.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "GameSettingBar.h"

@implementation GameSettingBar

-(id)initWithString:(NSString *)string width:(NSInteger)width height:(NSInteger)height{
    self = [super init];
    if(self){
        barStr = [NSString stringWithString:string];
        barWidth = width;
        barHeight = height;
        [self initBar];
        
    }
    return self;
}


-(void)initBar{
    self.frame = CGRectMake(0, 0, barWidth, barHeight);
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0.6;
    self.layer.cornerRadius =15;
    
    
    
    UILabel *label1 = [[UILabel alloc]init];
    label1.text = barStr;
    label1.frame = CGRectMake(20, 0, barWidth, barHeight);
    label1.textColor = [UIColor whiteColor];
    label1.textAlignment = NSTextAlignmentLeft;
    [self addSubview:label1];
}

@end
