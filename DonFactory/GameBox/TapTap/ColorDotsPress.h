//
//  ColorDotsPress.h
//  DonFactory
//
//  Created by Don on 2014/10/28.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorDotsPress : UIView{
    NSString *pressColor;
    NSInteger pressWidth;
    NSInteger pressHeight;
    id pressDelegate;
}

-(id)initWithColor:(NSString *)colorName width:(NSInteger)width height:(NSInteger)height delegate:(id)delegate;
@end
