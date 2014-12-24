//
//  GameUIModelBody.m
//  DonFactory
//
//  Created by Don on 2014/10/16.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "GameUIModelBody.h"

@implementation GameUIModelBody

-(id)initBodyViewWithWidth:(CGFloat)width height:(CGFloat)height{
    self = [super init];
    if(self){
        basicHeaderWidth = width;
        basicHeaderHeight = height;
        
        newHowToPlayWidth = basicHeaderWidth *WidthChangedRate;
        newHowToPlayHeight = basicHeaderHeight *HeightChangedRate;
        
        [self initBodyView];
    }
    return self;
}

-(void)initBodyView{
    self.frame = CGRectMake(0, 0, newHowToPlayWidth, newHowToPlayHeight);

}

@end
