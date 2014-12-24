//
//  GameUIModelTips.h
//  DonFactory
//
//  Created by Don on 2014/10/21.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameUIModelTips : UIView{
    
    UIView *tipsHeader;
    UIView *tipsBody;
    UIButton *tipsStartBtn;
    
    CGFloat basicTipsWidth;
    CGFloat basicTipsHeight;
    
}

@property id delegate;
-(id)initWithDelegate:(id)tipsDelegate width:(NSInteger)width height:(CGFloat)height;

@end
