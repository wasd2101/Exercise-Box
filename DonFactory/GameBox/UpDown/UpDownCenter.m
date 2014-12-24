//
//  UpDownCenter.m
//  DonFactory
//
//  Created by Don on 2014/10/23.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "UpDownCenter.h"

@implementation UpDownCenter


-(void)initGame{
    gameName = @"upDown";

    countSuccess = 0;
    blockPreNumber = 0;
    blockNewNumber = 0;
    [self.delegate refreshBlockNumber:0];
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(randomBlockNumber) userInfo:nil repeats:NO];

}

-(void)centerFinishedGame{
    gameFinishedPoint = countSuccess;
    [self centerEndGame];
    [self centerUpdateGameData];
    [self.delegate finishedGameWithSuccessCount:countSuccess];
}

#pragma mark - 遊戲主體
-(void)centerSwipeUp{

    if(blockNewNumber > blockPreNumber){
        [self.delegate swipeSuccess];
        countSuccess +=1;
        [self randomBlockNumber];
    }else{
        [self.delegate swipeFail];
    }
}

-(void)centerSwipeDown{
    if(blockNewNumber < blockPreNumber){
        [self.delegate swipeSuccess];
        [self randomBlockNumber];
    }else{
        [self.delegate swipeFail];
    }
}


-(void)randomBlockNumber{
    blockPreNumber = blockNewNumber;
    blockNewNumber = arc4random()%99+1;
    
    //防止隨機數相同
    if(blockPreNumber == blockNewNumber){
        [self randomBlockNumber];
    }else{
        [self.delegate refreshBlockNumber:blockNewNumber];        
    }

}




//代理
-(void)refreshGameTime:(NSInteger)gameTime{
    
}
-(void)refreshBlockNumber:(NSInteger)number{
    
}
-(void)swipeSuccess{
    
}
-(void)swipeFail{
    
}
-(void)finishedGameWithSuccessCount:(NSInteger)successCount{
    
}

@end
