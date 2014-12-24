//
//  NextDropDrop.h
//  DonFactory
//
//  Created by Don on 2014/11/3.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NextDropDrop : UIView{
    NSInteger dropWidth;
    NSInteger dropHeight;
    
}


-(id)initWithWidth:(NSInteger)width height:(NSInteger)height;
-(void)setTimerRemoveDrop:(NSInteger)time;
@end
