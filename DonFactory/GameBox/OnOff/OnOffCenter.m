//
//  OnOffCenter.m
//  DonFactory
//
//  Created by Don on 2014/10/31.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "OnOffCenter.h"

@implementation OnOffCenter

-(void)initGame{
    gameName = @"OnOff";
    tapSuccess = 0;
    lightAmt = 15;
    lightLevel = 1;
    judgePos = 0;

    [self randomLights];
}
-(void)centerFinishedGame{
    gameFinishedPoint = tapSuccess;
    [self centerEndGame];
    [self centerUpdateGameData];
    [self.delegate refreshFinishedGameWithTap:gameFinishedPoint];
}

#pragma mark - Main
-(void)randomLights{
    answerArray = [[NSMutableArray alloc]init];
    for(NSInteger i = 0;i<lightAmt;i++){
        NSInteger status = arc4random()%2;
        NSNumber *statusNum =[NSNumber numberWithInteger:status];
        [answerArray addObject:statusNum];
    }
    [self.delegate refreshLightStatus:answerArray level:lightLevel];
}



#pragma mark - Judge
-(void)judgeLight:(NSInteger)onOff{
    NSInteger answerInt = [answerArray[judgePos]integerValue];
    NSInteger answerAmt = lightLevel*5;
    if(answerInt == onOff){
        [self.delegate judgeSuccesWithPos:judgePos];
        judgePos +=1;
        tapSuccess +=1;
    }else{
        [self judgeFail];
    }
    if(judgePos ==lightAmt){
        //猜光了
        [self centerFinishedGame];
    }else if(judgePos == answerAmt){
        [self levelUp];
    }
}

-(void)levelUp{
    lightLevel +=1;
    judgePos = 0;
    [self.delegate judgeSuccessWithLevel:lightLevel];
}


-(void)judgeFail{
    [self centerFinishedGame];
}




#pragma mark - Delegate
-(void)refreshFinishedGameWithTap:(NSInteger)tap{
    
}

-(void)refreshLightStatus:(NSMutableArray *)array level:(NSInteger)level{
    
}

-(void)judgeSuccesWithPos:(NSInteger)pos{
    
}
-(void)judgeSuccessWithLevel:(NSInteger)level{
    
}
@end
