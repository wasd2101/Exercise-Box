//
//  OnOffBox.m
//  DonFactory
//
//  Created by Don on 2014/10/31.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "OnOffBox.h"

@implementation OnOffBox

-(id)initWithWidth:(NSInteger)width height:(NSInteger)height{
    self = [super init];
    if(self){
        boxWidth = width;
        boxHeight = height;
        [self initBox];
    }
    return self;
}

-(void)initBox{
    
    self.frame = CGRectMake(0, 0, boxWidth, boxHeight);
    UIImageView *boxImage = [[UIImageView alloc]init];
    boxImage.image = [UIImage imageNamed:@"onOff_box.png"];
    boxImage.frame = CGRectMake(0, 0, boxWidth, boxHeight);
    [self addSubview:boxImage];
    

}

@end
