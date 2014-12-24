//
//  UpDownVC.h
//  DonFactory
//
//  Created by Don on 2014/10/23.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "GameUIModel.h"
#import "UpDownCenter.h"
#import "UpDownBlock.h"
@interface UpDownVC : GameUIModel{
    UpDownCenter *upDownCenter;
    NSNumber *upDownGameTime;
    UpDownBlock *block;
    
    UpDownBlock *baseBlock;
    
}

@end
