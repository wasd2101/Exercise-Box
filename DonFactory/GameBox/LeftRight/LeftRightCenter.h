//
//  LeftRightCenter.h
//  DonFactory
//
//  Created by Don on 2014/10/30.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "GameModelCenter.h"

@interface LeftRightCenter : GameModelCenter{
    NSInteger tapSuccess;
    NSMutableArray *answerArray;
    
}
-(void)judgeWay:(NSString *)way;
@end
