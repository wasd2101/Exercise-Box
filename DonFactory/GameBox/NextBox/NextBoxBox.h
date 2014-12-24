//
//  NextBoxBox.h
//  DonFactory
//
//  Created by Don on 2014/11/2.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NextBoxBox : UIView{
    NSInteger boxWidth;
    NSInteger boxHeight;
    NSString *boxColor;
}


-(id)initWithWidth:(NSInteger)width height:(NSInteger)height color:(NSString *)color;
-(void)setTimerRemoveBox:(NSInteger)time;


@end
