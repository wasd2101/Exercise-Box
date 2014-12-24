//
//  TapTapVC.m
//  DonFactory
//
//  Created by Don on 2014/10/25.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "TapTapVC.h"
#import "TapTapBlock.h"


@interface TapTapVC ()

@end

@implementation TapTapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    gameName = @"TapTap";

    blockWidth = 80;
    blockHeight = 80;
    blockAmt = 4;
    showBlockDelayTime =0.3;
    taptapCenter.blockWidth = blockWidth;
    taptapCenter.blockHeight = blockHeight;
    taptapCenter = [[TapTapCenter alloc]init];
    taptapCenter.delegate = self;
    
    [self modelInitUIWithGameName:gameName delegate:self];
    [self initGameTable];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initGameTable{
    
    blockBoard = [[UIView alloc]init];
    blockBoard.frame = CGRectMake(10, 80, gameBodyView.frame.size.width-20, gameBodyView.frame.size.height-80);
    blockBoard.center = CGPointMake(gameBodyView.frame.size.width/2, gameBodyView.frame.size.height/2);
    [gameBodyView addSubview:blockBoard];
    
    NSInteger baseCenterX = blockBoard.frame.size.width/6;
    NSInteger baseCenterY = blockBoard.frame.size.height/6+50;
    
    CGPoint blockCenterPoint;
    blockPointArray = [[NSMutableArray alloc]init];
    for(NSInteger m = 0;m<3;m++){
        for(NSInteger n = 0;n<3;n++){
            blockCenterPoint = CGPointMake(baseCenterX +blockWidth*n +10*n, baseCenterY +blockHeight*m +10*m);
            NSValue *pointValue = [NSValue valueWithCGPoint:blockCenterPoint];
            [blockPointArray addObject:pointValue];
        }
    }
    
}

-(void)initBlock{
    //取不同的數字，將取出blockOutPosition的數字歸零
    blockOutPos = 0;
    randNumberArray = [[NSMutableArray alloc]init];
    do{
        NSInteger rand = arc4random()%9;//0～8
        NSNumber *randNum = [[NSNumber alloc]initWithInteger:rand];
        if(![randNumberArray containsObject:randNum]){
            [randNumberArray addObject:randNum];
        }
    }while([randNumberArray count]<blockAmt);
    
    blockShowTimer = [[NSTimer alloc]init];
    blockShowTimer = [NSTimer scheduledTimerWithTimeInterval:showBlockDelayTime target:self selector:@selector(showBlock) userInfo:nil repeats:YES];
    [blockShowTimer fire];
}


-(void)showBlock{
    //先準備block的座標
    NSInteger posInt = [randNumberArray[blockOutPos]integerValue];
    NSValue *pointValue = blockPointArray[posInt];
    
    
    CGPoint blockPoint = [pointValue CGPointValue];
    NSInteger blockX = blockPoint.x - blockWidth/2;
    NSInteger blockY = blockPoint.y - blockHeight/2;
    
    //block的實例化
    TapTapBlock *block = blockArray[blockOutPos];
    block.frame = CGRectMake(blockX, blockY, blockWidth-5, blockHeight-5);
    block.alpha = 0.7;
    [blockBoard addSubview:block];
    
    

    
    CGFloat animationTime =0.2;
    //變大
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:animationTime];
    block.alpha = 1;
    block.frame = CGRectMake(blockX, blockY, blockWidth, blockHeight);
    [UIView commitAnimations];
    
    //縮回原形
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDelay:animationTime];
    [UIView setAnimationDuration:0.2];
    block.frame = CGRectMake(blockX, blockY, blockWidth-5, blockHeight-5);
    [UIView commitAnimations];
    
    if(blockOutPos ==blockAmt-1){
        [blockShowTimer invalidate];
    }
    blockOutPos +=1;
}

-(void)modelInitGameTips{
    NSInteger baseWidth = gameTipsBodyView.frame.size.width;
    UIView *view1 = [[UIView alloc]init];
    view1.frame = CGRectMake(10, 100, baseWidth-20, 40);
    view1.backgroundColor = [UIColor blackColor];
    view1.alpha = 0.7;
    view1.layer.cornerRadius = 15;
    [gameTipsBodyView addSubview:view1];
    
    UILabel *label1 = [[UILabel alloc]init];
    label1.text = @"藍色方塊 按出現順序點";
    label1.textColor = [UIColor whiteColor];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.frame = CGRectMake(0, 0, baseWidth-20, 40);
    [view1 addSubview:label1];
    
    UIView *view2 = [[UIView alloc]init];
    view2.frame = CGRectMake(10, 150, baseWidth-20, 40);
    view2.backgroundColor = [UIColor blackColor];
    view2.alpha = 0.7;
    view2.layer.cornerRadius = 15;
    [gameTipsBodyView addSubview:view2];
    
    UILabel *label2 = [[UILabel alloc]init];
    label2.text = @"紅色方塊 按出現順序 反過來點";
    label2.textColor = [UIColor whiteColor];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.frame = CGRectMake(0, 0, baseWidth-20, 40);
    [view2 addSubview:label2];
}

-(void)modelBackToGameList{
    [taptapCenter centerEndGame];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)modelStartGame{
    [gameTipsView removeFromSuperview];
    [taptapCenter centerStartGame];
}


-(void)modelRestartGame{
    timerLabel.text = [NSString stringWithFormat:@"剩下%@秒",gameTime];
    [taptapCenter centerEndGame];
    [self cleanBlockBoard];
    [self initTips];
    [self modelInitGameTips];
    
}

//代理方法
-(void)refreshBlockWithArray:(NSMutableArray *)array{
    blockArray = [[NSMutableArray alloc]initWithArray:array];
    [self initBlock];
}

-(void)refreshFinishedGameWithTap:(NSInteger)tap{
    NSNumber *successCount = [NSNumber numberWithInteger:tap];
    NSString *finishedMsg = [NSString stringWithFormat:@"你共滑對了 %@ 次",successCount];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"遊戲結束" message:finishedMsg delegate:self cancelButtonTitle:@"再來一次" otherButtonTitles:@"休息咯", nil];
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex ==0){
        [self modelRestartGame];
        [self cleanBlockBoard];
    }else if(buttonIndex ==1){
        [self modelBackToGameList];
    }
}
-(void)cleanBlockBoard{
    NSMutableArray *blocksInBoard = [[NSMutableArray alloc]initWithArray:[blockBoard subviews]];
    for(UIView *obj in blocksInBoard){
        [obj removeFromSuperview];
    }
}


@end
