//
//  OnOffLight.h
//  DonFactory
//
//  Created by Don on 2014/10/31.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OnOffLight : UIView{
    NSInteger lightStatus;
    NSInteger lightWidth;
    NSInteger lightHeight;
    
    
}
-(id)initWithStatus:(NSInteger)status width:(NSInteger)width height:(NSInteger)height;
@end
