//
//  TapTapCenter.m
//  DonFactory
//
//  Created by Don on 2014/10/25.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "TapTapCenter.h"


@implementation TapTapCenter
-(void)initGame{
    tapSuccess = 0;

    gameName = @"TapTap";
    centerBlockAmt = 4;
    centerBlockNumber = 0;
    [self randomBlock];

}

-(void)centerFinishedGame{
    gameFinishedPoint = tapSuccess;
    [self centerEndGame];
    [self centerUpdateGameData];
    [self.delegate refreshFinishedGameWithTap:gameFinishedPoint];
}


#pragma mark -遊戲主體
-(void)randomBlock{
    blockIsOppsite = arc4random()%2;
    blockArray = [[NSMutableArray alloc]init];
    //blockNumber都是0、1、2、3，只是放入array的順序有正有反
    if(blockIsOppsite ==0){
        for(NSInteger i=0; i<centerBlockAmt;i++){
            TapTapBlock *block = [[TapTapBlock alloc]initWithWidth:_blockWidth height:_blockHeight isOppsite:blockIsOppsite blockNumber:i];
            block.delegate = self;
            [blockArray addObject:block];
        }
    }else if(blockIsOppsite ==1){
        for(NSInteger i=centerBlockAmt-1;i>-1;i--){
            TapTapBlock *block = [[TapTapBlock alloc]initWithWidth:_blockWidth height:_blockHeight isOppsite:blockIsOppsite blockNumber:i];
            block.delegate = self;
            [blockArray addObject:block];
        }
    }
    [self.delegate refreshBlockWithArray:blockArray];
}

-(void)judgeTapWithNumber:(TapTapBlock *)block{

    NSInteger number = [block getBlockNumber];
    
    if(centerBlockNumber ==number){
        [block setBlockRemove];
        centerBlockNumber +=1;
        [self tapSuccess];
    }else{
        [self tapFail];
    }
}

-(void)tapSuccess{
    if(centerBlockNumber ==centerBlockAmt){
        //block都按完後
        tapSuccess +=1;//總積分＋1
        centerBlockNumber = 0;
        [self randomBlock];

    }
}

-(void)tapFail{
    [self.delegate cleanBlockBoard];
    [self centerFinishedGame];

}

-(NSInteger)getBlockAmt{

    return centerBlockAmt;
}


//代理
-(void)refreshBlockWithArray:(NSMutableArray *)array{
    
}
-(void)refreshFinishedGameWithTap:(NSInteger)tap{
    
}

-(void)cleanBlockBoard{
    
}
@end
