//
//  LeftRightBlock.m
//  DonFactory
//
//  Created by Don on 2014/10/30.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "LeftRightBlock.h"

@implementation LeftRightBlock

-(id)initWithWidth:(NSInteger)width height:(NSInteger)height pos:(NSString *)pos level:(NSInteger)level{
    self = [super init];
    if(self){
        _blockPos = [NSString stringWithString:pos];
        blockWidth = width;
        blockHeight = height;
        _blockLevel = level;
        [self initBlock];
    }
    return self;
}

-(void)initBlock{
    self.frame = CGRectMake(0, 0, blockWidth, blockHeight);
    
    //隨機障礙物背景
    UIImageView *blockView = [[UIImageView alloc]init];
    blockView.image = [UIImage imageNamed:[self levelImg]];
    blockView.frame = CGRectMake(0, 0, blockWidth, blockHeight);
    [self addSubview:blockView];
    
}

-(NSString *)levelImg{
    NSNumber *levelNum = [NSNumber numberWithInteger:_blockLevel-1];
    NSString *imgStr = [NSString stringWithFormat:@"leftRight_block_%@.png",levelNum];
    return imgStr;
}

-(void)setTimerRemoveSelf:(NSInteger)time{
    [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(removeSelf) userInfo:nil repeats:NO];
}
-(void)removeSelf{
    [self removeFromSuperview];
}
@end
