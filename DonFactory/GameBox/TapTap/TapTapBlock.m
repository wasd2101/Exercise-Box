//
//  TapTapBlock.m
//  DonFactory
//
//  Created by Don on 2014/10/25.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "TapTapBlock.h"

@implementation TapTapBlock

-(id)initWithWidth:(NSInteger)width height:(NSInteger)height isOppsite:(NSInteger)isOpp blockNumber:(NSInteger)number{
    self = [super init];
    if(self){
        blockWidth = width;
        blockHeight = height;
        blockIsOppsite = isOpp;
        blockNumber = number;
        
        [self initblock];

    }
    return self;
}


-(void)initblock{
    self.layer.cornerRadius =15;
    self.frame = CGRectMake(0, 0, blockWidth/3, blockHeight/3);
    
    if(blockIsOppsite ==0){
        //正向
        self.backgroundColor = [UIColor blueColor];
        
    }else if(blockIsOppsite ==1){
        //反向
        self.backgroundColor = [UIColor redColor];
        
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(blockTapped)];
    [self addGestureRecognizer:tap];
}
-(void)blockTapped{
    [self.delegate judgeTapWithNumber:self];
}




-(NSInteger)getBlockNumber{
    return blockNumber;
}

-(void)setBlockRemove{
    CGFloat animationTime = 0.1;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:animationTime];
    self.alpha = 0;
    [UIView commitAnimations];
    
    [NSTimer scheduledTimerWithTimeInterval:animationTime target:self selector:@selector(blockRemove) userInfo:nil repeats:NO];
}
-(void)blockRemove{
    [self removeFromSuperview];
}


//代理方法
-(void)judgeTapWithNumber:(TapTapBlock *)block{
    
}
@end
