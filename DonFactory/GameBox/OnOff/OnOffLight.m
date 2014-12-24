//
//  OnOffLight.m
//  DonFactory
//
//  Created by Don on 2014/10/31.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "OnOffLight.h"

@implementation OnOffLight

-(id)initWithStatus:(NSInteger)status width:(NSInteger)width height:(NSInteger)height{
    self = [super init];
    if(self){
        lightStatus = status;
        lightWidth = width;
        lightHeight = height;
        [self initLight];
    }
    return self;
}

-(void)initLight{
    self.frame = CGRectMake(0, 0, lightWidth, lightHeight);
    
    UIImageView *backImage = [[UIImageView alloc]init];
    backImage.frame = CGRectMake(0, 0, lightWidth, lightHeight);
    if(lightStatus ==0){
        backImage.image = [UIImage imageNamed:@"onOff_lingt_0.png"];
    }else if(lightStatus ==1){
        backImage.image = [UIImage imageNamed:@"onOff_lingt_1.png"];
    }
    [self addSubview:backImage];
    
}

@end
