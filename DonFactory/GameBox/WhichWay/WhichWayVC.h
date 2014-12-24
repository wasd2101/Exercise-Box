//
//  WhichWayVC.h
//  DonFactory
//
//  Created by Don on 2014/10/24.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "GameUIModel.h"
#import "WhichWayCenter.h"
#import "WhichWayBlock.h"
@interface WhichWayVC : GameUIModel<UIScrollViewDelegate>{
    WhichWayCenter *whichWayCenter;
    UIPageControl *tipsPageControl;
    NSInteger pageWidth;
    WhichWayBlock *block;
    

}

@end
