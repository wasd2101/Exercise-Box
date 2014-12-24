//
//  LeftRightCenter.m
//  DonFactory
//
//  Created by Don on 2014/10/30.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "LeftRightCenter.h"

@implementation LeftRightCenter
-(void)initGame{
    gameName = @"LeftRight";
    tapSuccess = 0;
    answerArray = [[NSMutableArray alloc]init];
    [self initBlock];

}
-(void)centerFinishedGame{
    gameFinishedPoint = tapSuccess;
    [self centerEndGame];
    [self centerUpdateGameData];
    [self.delegate refreshFinishedGameWithTap:gameFinishedPoint];
}

#pragma mark - main
-(void)initBlock{
    //遊戲初始化，產生4個有方向的數組
    NSMutableArray *blockArray = [[NSMutableArray alloc]init];
    for(NSInteger i = 0;i<4;i++){
        NSInteger way = arc4random()%2;
        NSNumber *answerNum = [[NSNumber alloc]initWithInteger:1-way];
        [answerArray addObject:answerNum];
        NSMutableString *wayStr = [[NSMutableString alloc]init];
        if(way ==0){
            wayStr = [NSMutableString stringWithString:@"Left"];
        }else if(way ==1){
            wayStr = [NSMutableString stringWithString:@"Right"];
        }
        [blockArray addObject:wayStr];
    }
    [self.delegate didInitWay:blockArray];
}

-(void)randomWay{
    NSInteger way = arc4random()%2;
    NSMutableString *wayStr = [[NSMutableString alloc]init];
    if(way ==0){
        wayStr = [NSMutableString stringWithString:@"Left"];
    }else if(way ==1){
        wayStr = [NSMutableString stringWithString:@"Right"];
    }
    NSInteger answerInt = 1-way;
    NSNumber *answerNum = [NSNumber numberWithInteger:answerInt];
    [answerArray addObject:answerNum];
    [self.delegate refreshWay:wayStr level:[self blockLevel]];
}

#pragma mark - Judge
-(void)judgeWay:(NSString *)way{
    NSInteger wayInt =0;
    if([way isEqualToString:@"Left"]){
        wayInt = 0;
    }else if([way isEqualToString:@"Right"]){
        wayInt = 1;
    }
    
    if(wayInt == [answerArray[0]integerValue]){
        [self judgeSuccess];
        [answerArray removeObjectAtIndex:0];
    }else{
        [self judgeFail];
    }
}
-(NSInteger)blockLevel{
    //一定有更好的寫法吧？不然每次都判斷這麼多次？= =||
    NSInteger blockLevel = 1;
    NSInteger baseCount = 10;
    if(tapSuccess <baseCount*1){
        blockLevel = 1;
    }else if(tapSuccess < baseCount*2){
        blockLevel = 2;
    }else if(tapSuccess < baseCount*3){
        blockLevel = 3;
    }else if(tapSuccess < baseCount*4){
        blockLevel = 4;
    }else if(tapSuccess < baseCount*5){
        blockLevel = 5;
    }else if(tapSuccess < baseCount*6){
        blockLevel = 6;
    }else if(tapSuccess < baseCount*7){
        blockLevel = 7;
    }else if(tapSuccess < baseCount*8){
        blockLevel = 8;
    }else if(tapSuccess < baseCount*9){
        blockLevel = 9;
    }else if(tapSuccess < baseCount*10){
        blockLevel = 10;
    }else if(tapSuccess < baseCount*11){
        blockLevel = 11;
    }else if(tapSuccess < baseCount*12){
        blockLevel = 12;
    }else{
        blockLevel = 12;
    }
    return blockLevel;
}

-(void)judgeSuccess{
    tapSuccess +=1;
    [self randomWay];
}
-(void)judgeFail{
    [self centerFinishedGame];
}

#pragma mark - Delegate
-(void)refreshWay:(NSString *)direction level:(NSInteger)level{
    
}

-(void)refreshFinishedGameWithTap:(NSInteger)tap{
    
}
-(void)didInitWay:(NSMutableArray *)array{
    
}

@end
