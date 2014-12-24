//
//  NextDropCenter.m
//  DonFactory
//
//  Created by Don on 2014/11/3.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "NextDropCenter.h"

@implementation NextDropCenter

-(void)initGame{
    gameName = @"NextDrop";
    tapSuccess = 0;
    dropLevel = 1;
    baseDropAmt = 4;
    dropAmt = baseDropAmt +2*dropLevel;
    dropTime = 0.5;
    judgePos = 0;

    [self randomDrop];
    
}
-(void)centerFinishedGame{
    gameFinishedPoint = tapSuccess;
    [self centerEndGame];
    [self centerUpdateGameData];
    [self.delegate refreshFinishedGameWithTap:gameFinishedPoint];
}

#pragma mark - Main
-(void)randomDrop{
    answerArray = [[NSMutableArray alloc]init];
    for(NSInteger i = 0;i<dropAmt;i++){
        NSInteger m = arc4random()%4;
        NSNumber *num = [NSNumber numberWithInteger:m];
        [answerArray addObject:num];
    }
    
    [self.delegate didRandomDropWithArray:answerArray dropInterval:dropTime];
}

-(NSMutableString *)dropIntToStr:(NSInteger)dropInt{
    NSMutableString *str = [[NSMutableString alloc]init];
    switch (dropInt) {
        case 0:
            str = [NSMutableString stringWithString:@"Red"];
            break;
        case 1:
            str = [NSMutableString stringWithString:@"Yellow"];
            break;
        case 2:
            str = [NSMutableString stringWithString:@"Blue"];
            break;
        case 3:
            str = [NSMutableString stringWithString:@"Green"];
            break;
        default:
            break;
    }
    return str;
}

#pragma mark - judge
-(void)judgeDropWithColor:(NSString *)color{
    NSInteger answerInt = [answerArray[judgePos]integerValue];
    NSString *answerStr = [self dropIntToStr:answerInt];
    if([answerStr isEqualToString:color]){
        [self judgeSuccess];
    }else{
        [self judgeFail];
    }

}

-(void)judgeSuccess{
    tapSuccess +=1;

    [self.delegate refreshJudgeSuccess];
    if(judgePos+1 ==dropAmt){
        judgePos =0;
        dropLevel +=1;
        dropAmt = baseDropAmt +2*dropLevel;
        [self randomDrop];
    }else{
        judgePos +=1;        
    }

}

-(void)judgeFail{
    [self centerFinishedGame];
}



//代理
-(void)didRandomDropWithArray:(NSArray *)dropArray dropInterval:(CGFloat)time{
    
}
-(void)refreshJudgeSuccess{
    
}
-(void)refreshFinishedGameWithTap:(NSInteger)tap{
    
}

@end
