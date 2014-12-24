//
//  GameUIModelHeader.h
//  DonFactory
//
//  Created by Don on 2014/10/15.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameUIModelHeader : UIView{
    NSString *gameName;
    
    CGFloat basicHeaderWidth;
    CGFloat basicHeaderHeight;
    
    CGFloat newHowToPlayWidth;
    CGFloat newHowToPlayHeight;
    
    UIImageView *homeImageView;



}

-(id)initGameHeaderViewWithGameName:(NSString *)name delegate:(id)delegate width:(CGFloat)width height:(CGFloat)height;


//代理
@property id delegate;

@end
