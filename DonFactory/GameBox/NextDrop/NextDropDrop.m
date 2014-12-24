//
//  NextDropDrop.m
//  DonFactory
//
//  Created by Don on 2014/11/3.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "NextDropDrop.h"

@implementation NextDropDrop

-(id)initWithWidth:(NSInteger)width height:(NSInteger)height{
    self = [super init];
    if(self){
        dropWidth = width;
        dropHeight = height;
        [self initDrop];
    }
    return self;
}

-(void)initDrop{
    self.frame = CGRectMake(0, 0, dropWidth, dropHeight);
    UIImageView *dropImg = [[UIImageView alloc]init];
    dropImg.image = [[UIImage imageNamed:@"nextDrop_drop.png"]stretchableImageWithLeftCapWidth:1 topCapHeight:1];
    dropImg.frame = CGRectMake(0, 0, dropWidth, dropHeight);
    [self addSubview:dropImg];
}

-(void)setTimerRemoveDrop:(NSInteger)time{
    [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(removeDrop) userInfo:nil repeats:NO];
}
-(void)removeDrop{
    [self removeFromSuperview];
}


@end
