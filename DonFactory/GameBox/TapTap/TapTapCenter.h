//
//  TapTapCenter.h
//  DonFactory
//
//  Created by Don on 2014/10/25.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "GameModelCenter.h"
#import "TapTapBlock.h"
@interface TapTapCenter : GameModelCenter{
    NSInteger tapSuccess;
    NSInteger blockIsOppsite;
    NSInteger centerBlockNumber;
    NSInteger centerBlockAmt;
    NSMutableArray *blockArray;
    
}

@property NSInteger blockWidth;
@property NSInteger blockHeight;

-(void)judgeTapWithNumber:(TapTapBlock *)block;
-(NSInteger)getBlockAmt;
@end
