//
//  UpDownCenter.h
//  DonFactory
//
//  Created by Don on 2014/10/23.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "GameModelCenter.h"

@interface UpDownCenter : GameModelCenter{
    NSInteger countSuccess;
    NSInteger blockNewNumber;
    NSInteger blockPreNumber;
    
}


-(void)centerSwipeUp;
-(void)centerSwipeDown;
//-(void)finishedGameWithSuccessCount:(NSInteger)successCount;
@property id delegate;


@end
