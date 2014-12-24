//
//  TapTapBlock.h
//  DonFactory
//
//  Created by Don on 2014/10/25.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TapTapBlock : UIView{
    NSInteger blockWidth;
    NSInteger blockHeight;
    NSInteger blockIsOppsite;
    NSInteger blockNumber;
    
}

-(id)initWithWidth:(NSInteger)width height:(NSInteger)height isOppsite:(NSInteger)isOpp blockNumber:(NSInteger)number;

-(NSInteger)getBlockNumber;
-(void)setBlockRemove;

@property id delegate;

@end
