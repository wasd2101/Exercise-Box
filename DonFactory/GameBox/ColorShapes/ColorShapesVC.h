//
//  ColorShapesVC.h
//  DonFactory
//
//  Created by Don on 2014/10/28.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "GameUIModel.h"
#import "ColorShapesCenter.h"

@interface ColorShapesVC : GameUIModel<UIScrollViewDelegate>{
    ColorShapesCenter *colorShapesCenter;
    
    UIImageView *shapesLayout;
    
    NSInteger pressWidth;
    NSInteger pressHeight;
    
    NSInteger shapeWidth;
    NSInteger shapeHeight;
    
    NSInteger pressLayoutWidth;
    NSInteger pressLayoutHeight;
    
    UIView *pressCover;
    UIPageControl *tipsPageControl;
    NSInteger baseWidth;

}

@end
