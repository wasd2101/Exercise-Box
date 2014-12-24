//
//  ColorShapesPress.h
//  DonFactory
//
//  Created by Don on 2014/10/28.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorShapesPress : UIView{
    NSString *pressName;
    NSInteger pressWidth;
    NSInteger pressHeight;
    
    id pressDelegate;
    
}

-(id)initWithPressName:(NSString *)name width:(NSInteger)width height:(NSInteger)height delegate:(id)delegate;

@end
