//
//  UpDownBlock.h
//  DonFactory
//
//  Created by Don on 2014/10/23.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpDownBlock : UIView{
    UILabel *numberLabel;
    NSNumber *blockNumber;
    NSInteger blockWidth;
    NSInteger blockHeight;
}

-(id)initUpDownBlockWithNumber:(NSInteger)number;
-(void)setTimerToRemoveSelfWithTime:(NSInteger)time;

@end
