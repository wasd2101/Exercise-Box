//
//  GameUIModelBody.h
//  DonFactory
//
//  Created by Don on 2014/10/16.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameUIModelBody : UIView{
    CGFloat basicHeaderWidth;
    CGFloat basicHeaderHeight;
    
    CGFloat newHowToPlayWidth;
    CGFloat newHowToPlayHeight;
}
-(id)initBodyViewWithWidth:(CGFloat)width height:(CGFloat)height;

@end
