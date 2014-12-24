//
//  NextBoxCenter.m
//  DonFactory
//
//  Created by Don on 2014/11/2.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "NextBoxCenter.h"

@implementation NextBoxCenter
-(void)initGame{
    gameName = @"NextBox";
    tapSuccess = 0;
    judgeSwitch = 0;
    answerArray = [[NSMutableArray alloc]init];
    [self randomBox];
    
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(randomBox) userInfo:nil repeats:NO];
}


-(void)centerFinishedGame{
    gameFinishedPoint = tapSuccess;
    [self centerEndGame];
    [self centerUpdateGameData];
    [self.delegate refreshFinishedGameWithTap:gameFinishedPoint];
}


#pragma mark - Main
-(void)randomBox{
    judgeSwitch +=1;
    randomColorInt = arc4random()%4;
    NSNumber *num = [NSNumber numberWithInteger:randomColorInt];
    [answerArray addObject:num];
    
    NSMutableString *colorStr = [[NSMutableString alloc]init];
    switch (randomColorInt) {
        case 0:
            colorStr = [NSMutableString stringWithString:@"red"];
            break;
        case 1:
            colorStr = [NSMutableString stringWithString:@"yellow"];
            break;
        case 2:
            colorStr = [NSMutableString stringWithString:@"blue"];
            break;
        case 3:
            colorStr = [NSMutableString stringWithString:@"green"];
            break;
        default:
            break;
    }
    [self.delegate refreshBoxWithColorStr:colorStr];
    
}
-(void)judgeSameColor:(NSInteger)judge{
    if(judgeSwitch>1){
        if(judge==0){
            if([answerArray[0]integerValue]!=[answerArray[1]integerValue]){
                [self judgeSuccess];
            }else{
                [self judgeFail];
            }
        }else if(judge ==1){
            if([answerArray[0]integerValue]==[answerArray[1]integerValue]){
                [self judgeSuccess];
            }else{
                [self judgeFail];
            }
        }
    }

}

-(void)judgeSuccess{
    tapSuccess +=1;
    [self randomBox];
    [answerArray removeObjectAtIndex:0];
}

-(void)judgeFail{
    [self centerFinishedGame];
}
#pragma mark - Delegate
-(void)refreshFinishedGameWithTap:(NSInteger)tap{
    
}

-(void)refreshBoxWithColorStr:(NSMutableString *)str{
    
}


@end
