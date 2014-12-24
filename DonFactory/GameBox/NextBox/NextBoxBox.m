//
//  NextBoxBox.m
//  DonFactory
//
//  Created by Don on 2014/11/2.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "NextBoxBox.h"

@implementation NextBoxBox

-(id)initWithWidth:(NSInteger)width height:(NSInteger)height color:(NSString *)color{
    self = [super init];
    if(self){
        boxWidth = width;
        boxHeight = height;
        boxColor = [NSString stringWithString:color];
        [self initBox];
    }
    return self;
}

-(void)initBox{
    self.frame = CGRectMake(0, 0, boxWidth, boxHeight);
    
    NSString *imgName = [NSString stringWithFormat:@"nextbox_box_%@.png",boxColor];
    
    UIImageView *boxImage = [[UIImageView alloc]init];
    boxImage.frame = CGRectMake(0, 0, boxWidth, boxHeight);
    boxImage.image = [UIImage imageNamed:imgName];
    
    [self addSubview:boxImage];
    
    
}

-(void)setTimerRemoveBox:(NSInteger)time{
    [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(removeBox) userInfo:nil repeats:NO];
}

-(void)removeBox{
    [self removeFromSuperview];
}


@end
