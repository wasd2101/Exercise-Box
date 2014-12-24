//
//  GameUIModelTipsBody.m
//  DonFactory
//
//  Created by Don on 2014/10/21.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "GameUIModelTipsBody.h"

@implementation GameUIModelTipsBody

-(id)initTipsBodyWithWidth:(CGFloat)width height:(CGFloat)height{
    self = [super init];
    if(self){
        basicHeaderWidth = width;
        basicHeaderHeight = height;
        
        newTipsWidth = basicHeaderWidth *WidthChangedRate;
        newTipsHeight = basicHeaderHeight *HeightChangedRate;
        
        [self initTipsBody];
    }
    return self;
}


-(void)initTipsBody{
    self.frame = CGRectMake(0, 0, newTipsWidth, newTipsHeight);
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gameTips_background.png"]];
}

@end
