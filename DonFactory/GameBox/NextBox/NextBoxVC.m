//
//  NextBoxVC.m
//  DonFactory
//
//  Created by Don on 2014/11/2.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "NextBoxVC.h"


@interface NextBoxVC ()

@end

@implementation NextBoxVC

- (void)viewDidLoad {
    [super viewDidLoad];
    gameName = @"NextBox";
    
    [self modelInitUIWithGameName:gameName delegate:self];
    
    nextBoxCenter = [[NextBoxCenter alloc]init];
    nextBoxCenter.delegate = self;
    
    
    [self initSetting];
    [self initPress];
    [self initBoxTable];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - GameUI
-(void)initSetting{
    pressWidth = gameBodyView.frame.size.width/2;
    pressHeight = 80 *HeightChangedRate;
    
    boxTableWidth = gameBodyView.frame.size.width;
    boxTableHeight = gameBodyView.frame.size.height - pressHeight - 80;
    
    boxWidth = 128;
    boxHeight = 128;
    boxX = boxTableWidth/2;
    boxY = boxTableHeight/2;
    
}

-(void)initBoxTable{
    boxTable = [[UIView alloc]init];
    boxTable.frame = CGRectMake(0, 80, boxTableWidth, boxTableHeight);
    [gameBodyView addSubview:boxTable];
    
    
}


-(void)initPress{
    //Left
    leftPress = [[UIView alloc]init];
    leftPress.frame = CGRectMake(0, gameBodyView.frame.size.height-pressHeight, pressWidth, pressHeight);
    leftPress.backgroundColor = [UIColor orangeColor];
    [gameBodyView addSubview:leftPress];
    
    UILabel *leftLabel = [[UILabel alloc]init];
    leftLabel.frame = CGRectMake(0, 0, pressWidth, pressHeight);
    leftLabel.text = @"YES";
    leftLabel.textColor = [UIColor whiteColor];
    leftLabel.font = [UIFont systemFontOfSize:40];
    leftLabel.textAlignment = NSTextAlignmentCenter;
    [leftPress addSubview:leftLabel];
    
    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftPressed)];
    [leftPress addGestureRecognizer:leftTap];
    
    //Right
    rightPress = [[UIView alloc]init];
    rightPress.frame = CGRectMake(pressWidth, gameBodyView.frame.size.height-pressHeight, pressWidth, pressHeight);
    rightPress.backgroundColor = [UIColor orangeColor];
    [gameBodyView addSubview:rightPress];
    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightPressed)];
    [rightPress addGestureRecognizer:rightTap];
    
    UILabel *rightLabel = [[UILabel alloc]init];
    rightLabel.frame = CGRectMake(0, 0, pressWidth, pressHeight);
    rightLabel.text = @"NO";
    rightLabel.textColor = [UIColor whiteColor];
    rightLabel.font = [UIFont systemFontOfSize:40];
    rightLabel.textAlignment = NSTextAlignmentCenter;
    [rightPress addSubview:rightLabel];
    
    //cover
    yesNoCover = [[UIView alloc]init];
    yesNoCover.frame = CGRectMake(0, gameBodyView.frame.size.height-pressHeight, gameBodyView.frame.size.width, pressHeight);
    yesNoCover.backgroundColor = [UIColor blackColor];
    yesNoCover.alpha = 0.8;
    [gameBodyView addSubview:yesNoCover];

    
}

-(void)leftPressed{
    [nextBoxCenter judgeSameColor:1];
    //動畫
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    leftPress.alpha = 0.5;
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDelay:0.1];
    leftPress.alpha = 1;
    [UIView commitAnimations];
    

    
}

-(void)rightPressed{
    [nextBoxCenter judgeSameColor:0];
    //動畫
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    rightPress.alpha = 0.5;
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDelay:0.1];
    rightPress.alpha = 1;
    [UIView commitAnimations];
    
}

-(void)cleanBoxTable{
    NSArray *array = [boxTable subviews];
    for(UIView *obj in array){
        [obj removeFromSuperview];
    }
}


#pragma mark - Model
-(void)modelInitGameTips{
    yesNoCover.hidden = NO;

    NSInteger baseWidth = gameTipsBodyView.frame.size.width;
    UIView *view1 = [[UIView alloc]init];
    view1.frame = CGRectMake(10, 100, baseWidth-20, 40);
    view1.backgroundColor = [UIColor blackColor];
    view1.alpha = 0.7;
    view1.layer.cornerRadius = 15;
    [gameTipsBodyView addSubview:view1];
    
    UILabel *label1 = [[UILabel alloc]init];
    label1.text = @"和前一個箱子";
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
    label2.text = @"顏色一樣嗎？";
    label2.textColor = [UIColor whiteColor];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.frame = CGRectMake(0, 0, baseWidth-20, 40);
    [view2 addSubview:label2];

}

-(void)modelBackToGameList{
    [nextBoxCenter centerEndGame];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)modelStartGame{
    yesNoCover.hidden = YES;
    [gameTipsView removeFromSuperview];
    [self cleanBoxTable];
    [nextBoxCenter centerStartGame];
}

-(void)modelRestartGame{
    timerLabel.text = [NSString stringWithFormat:@"剩下%@秒",gameTime];
    [nextBoxCenter centerEndGame];
    [self initTips];
    [self modelInitGameTips];
    
}

#pragma mark - Delegate
-(void)refreshFinishedGameWithTap:(NSInteger)tap{
    NSNumber *successCount = [NSNumber numberWithInteger:tap];
    NSString *finishedMsg = [NSString stringWithFormat:@"總共猜對了 %@ 個箱子",successCount];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"遊戲結束" message:finishedMsg delegate:self cancelButtonTitle:@"再來一次" otherButtonTitles:@"休息一下", nil];
    [alertView show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex ==0){
        [self modelRestartGame];
        
    }else if(buttonIndex ==1){
        [self modelBackToGameList];
    }
}

-(void)refreshBoxWithColorStr:(NSMutableString *)str{
    if(box !=nil){
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.1];
        box.center = CGPointMake(-128, boxY);
        box.alpha  = 0;
        [box setTimerRemoveBox:0.3];
        [UIView commitAnimations];
    }
    
    box = [[NextBoxBox alloc]initWithWidth:boxWidth height:boxHeight color:str];
    box.frame = CGRectMake(0, 0, boxWidth, boxHeight);
    box.center = CGPointMake(boxX*2, boxY);
    box.alpha = 0.5;
    [boxTable addSubview:box];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    box.alpha = 1;
    box.center = CGPointMake(boxX, boxY);
    [UIView commitAnimations];
}





@end
