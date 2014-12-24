//
//  UpDownVC.m
//  DonFactory
//
//  Created by Don on 2014/10/23.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "UpDownVC.h"

@interface UpDownVC ()

@end

@implementation UpDownVC

- (void)viewDidLoad {
    [super viewDidLoad];
    gameName = @"UpDown";

    upDownCenter = [[UpDownCenter alloc]init];
    upDownCenter.delegate = self;
    
    [self modelInitUIWithGameName:gameName delegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 遊戲部份
-(void)modelStartGame{
    [gameTipsView removeFromSuperview];
    [upDownCenter centerStartGame];
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeUp)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDown)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    
    [gameBodyView addGestureRecognizer:swipeUp];
    [gameBodyView addGestureRecognizer:swipeDown];

}

-(void)swipeUp{
    [upDownCenter centerSwipeUp];
}

-(void)swipeDown{
    [upDownCenter centerSwipeDown];
}

#pragma mark - 介面&介面功能
-(void)modelInitGameTips{
    UIImageView *tipsView = [[UIImageView alloc]init];
    tipsView.frame = CGRectMake(0, 0, basicTipsBodyWidth-50, basicTipsBodyHeight-50);
    tipsView.image = [UIImage imageNamed:@"upDown_tips.png"];
    [gameTipsBodyView addSubview:tipsView];
    
    NSInteger baseWidth = gameTipsBodyView.frame.size.width;
    UIView *view1 = [[UIView alloc]init];
    view1.frame = CGRectMake(10, 240*HeightChangedRate, baseWidth-20, 40);
    view1.backgroundColor = [UIColor blackColor];
    view1.alpha = 0.7;
    view1.layer.cornerRadius = 15;
    [gameTipsBodyView addSubview:view1];
    
    UILabel *label1 = [[UILabel alloc]init];
    label1.text = @"數字變大 往上划";
    label1.textColor = [UIColor whiteColor];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.frame = CGRectMake(0, 0, baseWidth-20, 40);
    [view1 addSubview:label1];
    
    UIView *view2 = [[UIView alloc]init];
    view2.frame = CGRectMake(10, 300*HeightChangedRate, baseWidth-20, 40);
    view2.backgroundColor = [UIColor blackColor];
    view2.alpha = 0.7;
    view2.layer.cornerRadius = 15;
    [gameTipsBodyView addSubview:view2];
    
    UILabel *label2 = [[UILabel alloc]init];
    label2.text = @"數字變小 往下划";
    label2.textColor = [UIColor whiteColor];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.frame = CGRectMake(0, 0, baseWidth-20, 40);
    [view2 addSubview:label2];
    
    
}

-(void)modelBackToGameList{
    [upDownCenter centerEndGame];
    [self dismissViewControllerAnimated:YES completion:nil];
}



-(void)modelRestartGame{
//    [self cleanBoard];
    timerLabel.text = [NSString stringWithFormat:@"剩下%@秒",gameTime];
    [upDownCenter centerEndGame];
    [self initTips];
    [self modelInitGameTips];
    

}

//代理
-(void)refreshBlockNumber:(NSInteger)number{
    NSInteger blockWidth = 128;
    NSInteger blockHeight = 128;
    
    NSInteger blockX = gameBodyView.frame.size.width/2-blockWidth/2;
    NSInteger blockY = gameBodyView.frame.size.height/2-blockHeight;
    
    if(block != nil) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationDuration:0.3];
        block.frame = CGRectMake(blockX-blockWidth, blockY, blockWidth, blockHeight);
        block.alpha = 0.1;
        [block setTimerToRemoveSelfWithTime:1];
        [UIView commitAnimations];
    }
    
    block = [[UpDownBlock alloc]initUpDownBlockWithNumber:number];
    block.frame = CGRectMake(blockX+blockWidth*2, blockY, blockWidth, blockHeight);
    [gameBodyView addSubview:block];
    
    
    
    //給數字做個簡單的動畫。
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3];
    block.frame = CGRectMake(blockX, blockY, blockWidth, blockHeight);
    [UIView commitAnimations];
    
}

-(void)swipeSuccess{
    
}

-(void)swipeFail{
    [upDownCenter centerFinishedGame];
}
-(void)cleanBoard{
    NSArray *array =[gameBodyView subviews];
    for(UIView *obj in array){
        [obj removeFromSuperview];
    }
}

//代理
-(void)finishedGameWithSuccessCount:(NSInteger)successCount{
    NSNumber *successNumber = [NSNumber numberWithInteger:successCount];
    NSString *finishedMsg = [NSString stringWithFormat:@"滑對了 %@ 次",successNumber];
    UIAlertView *finishedAlert = [[UIAlertView alloc]initWithTitle:@"遊戲結束" message:finishedMsg delegate:self cancelButtonTitle:@"再來一次" otherButtonTitles:@"休息咯", nil];
    [finishedAlert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex ==0){
        [self modelRestartGame];
    }else if(buttonIndex ==1){
        [self modelBackToGameList];
    }
}

@end
