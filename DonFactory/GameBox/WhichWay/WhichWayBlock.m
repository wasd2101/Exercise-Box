//
//  WhichWayBlock.m
//  DonFactory
//
//  Created by Don on 2014/10/24.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "WhichWayBlock.h"

@implementation WhichWayBlock

-(id)initBlockWithDirection:(NSString *)direction oppsite:(NSInteger)oppsite width:(NSInteger)width height:(NSInteger)height{
    self = [super init];
    if(self){
        blockWidth = width;
        blockHeight = height;
        blockOppsite = [NSNumber numberWithInteger:oppsite];
        blockDirection = [[NSMutableString alloc]initWithString:direction];
        self.frame = CGRectMake(0, 0, blockWidth, blockHeight);
        [self initBlcokImage];
    }
    return self;
}

-(void)initBlcokImage{
    if([blockDirection isEqualToString:@"Up"]){
        blockDirection = [NSMutableString stringWithFormat:@"whichWay_arrow_up_%@.png",blockOppsite];
    }else if([blockDirection isEqualToString:@"Right"]){
        blockDirection = [NSMutableString stringWithFormat:@"whichWay_arrow_right_%@.png",blockOppsite];
    }else if([blockDirection isEqualToString:@"Down"]){
        blockDirection = [NSMutableString stringWithFormat:@"whichWay_arrow_down_%@.png",blockOppsite];
    }else if([blockDirection isEqualToString:@"Left"]){
        blockDirection = [NSMutableString stringWithFormat:@"whichWay_arrow_left_%@.png",blockOppsite];
    }else if([blockDirection isEqualToString:@"LeftRight"]){
        blockDirection = [NSMutableString stringWithFormat:@"whichWay_arrow_leftRight_%@.png",blockOppsite];
    }
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:blockDirection]];
}

-(void)setTimerToRemoveSelfWithTime:(NSInteger)time{
    [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(removeSelf) userInfo:nil repeats:NO];
}
-(void)removeSelf{
    [self removeFromSuperview];
}

@end
