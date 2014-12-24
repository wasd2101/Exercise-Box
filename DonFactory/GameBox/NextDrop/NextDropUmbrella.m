//
//  NextDropUmbrella.m
//  DonFactory
//
//  Created by Don on 2014/11/3.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "NextDropUmbrella.h"

@implementation NextDropUmbrella

-(id)initWithWidth:(NSInteger)width height:(NSInteger)height color:(NSString *)color delegate:(id)delegate{
    self = [super init];
    if(self){
        umbrellaWidth = width;
        umbrellaHeight = height;
        umbrellaColor = [NSString stringWithString:color];
        _umbrellaDelegate = delegate;
        [self initUnbrella];
    }
    return self;
}

-(void)initUnbrella{
    self.frame = CGRectMake(0, 0, umbrellaWidth, umbrellaHeight);
    NSString *colorStr = [[NSString stringWithString:umbrellaColor]lowercaseString];
    NSMutableString *imgStr = [[NSMutableString alloc]init];
    imgStr = [NSMutableString stringWithFormat:@"nextDrop_umbrella_%@.png",colorStr];

    UIImageView *umbrellaImg = [[UIImageView alloc]init];
    umbrellaImg.frame = CGRectMake(0, 0, umbrellaWidth, umbrellaHeight);
    umbrellaImg.image = [UIImage imageNamed:imgStr];
    [self addSubview:umbrellaImg];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped)];
    [self addGestureRecognizer:tap];
    
}

-(void)tapped{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    self.alpha = 0.6;
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDelay:0.1];
    self.alpha = 1;
    [UIView commitAnimations];
    
    [self.umbrellaDelegate tappedForVC:umbrellaColor];
    
}

//代理
-(void)tappedForVC:(NSString *)color{
    
}

@end
