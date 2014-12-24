//
//  WhichWayBlock.h
//  DonFactory
//
//  Created by Don on 2014/10/24.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WhichWayBlock : UIView{
    NSInteger blockWidth;
    NSInteger blockHeight;
    NSString *blockDirection;
    NSNumber *blockOppsite;
}

-(id)initBlockWithDirection:(NSString *)direction oppsite:(NSInteger)oppsite width:(NSInteger)width height:(NSInteger)height;
-(void)setTimerToRemoveSelfWithTime:(NSInteger)time;

@end
