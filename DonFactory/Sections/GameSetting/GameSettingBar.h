//
//  GameSettingBar.h
//  DonFactory
//
//  Created by Don on 2014/11/5.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameSettingBar : UIView{
    NSString *barStr;
    NSInteger barWidth;
    NSInteger barHeight;
}

-(id)initWithString:(NSString *)string width:(NSInteger)width height:(NSInteger)height;



@end
