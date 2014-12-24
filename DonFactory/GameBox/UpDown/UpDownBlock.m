//
//  UpDownBlock.m
//  DonFactory
//
//  Created by Don on 2014/10/23.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "UpDownBlock.h"

@implementation UpDownBlock

-(id)initUpDownBlockWithNumber:(NSInteger)number{
    self = [super init];
    if(self){
        blockNumber = [NSNumber numberWithInteger:number];
        blockWidth = 128;
        blockHeight = 128;
        [self initNumberBlock];
        
    }
    return self;
}

-(void)initNumberBlock{
    UIImage *image = [[UIImage imageNamed:@"UpDown_Paper.png"]stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    self.frame = CGRectMake(0, 0, blockWidth, blockHeight);
    self.backgroundColor = [UIColor colorWithPatternImage:image];

    numberLabel = [[UILabel alloc]init];
    numberLabel.frame = CGRectMake(0, 0, blockWidth, blockHeight);
    numberLabel.text = [NSString stringWithFormat:@"%@",blockNumber];
    numberLabel.font = [UIFont systemFontOfSize:40];
    numberLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:numberLabel];
}
-(void)setTimerToRemoveSelfWithTime:(NSInteger)time{
    [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(removeSelf) userInfo:nil repeats:NO];
    
}
-(void)removeSelf{
    [self removeFromSuperview];
}


@end
