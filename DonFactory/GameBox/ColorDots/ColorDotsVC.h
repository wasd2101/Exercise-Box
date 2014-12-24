//
//  ColorDotsVC.h
//  DonFactory
//
//  Created by Don on 2014/10/28.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "GameUIModel.h"
#import "ColorDotsCenter.h"
#import "ColorDotsBar.h"


@interface ColorDotsVC : GameUIModel{
    ColorDotsCenter *colorDotsCenter;
    
    UIView *colorDotsBarLayout;
    UIView *colorIndicator;
    ColorDotsBar *colorDotsBar;
    
    UIView *pressCover;
}

@end
