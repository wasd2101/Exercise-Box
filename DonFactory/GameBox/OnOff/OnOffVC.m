//
//  OnOffVC.m
//  DonFactory
//
//  Created by Don on 2014/10/31.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "OnOffVC.h"
#import "OnOffLight.h"
#import "OnOffBox.h"

@interface OnOffVC ()

@end

@implementation OnOffVC

- (void)viewDidLoad {
    [super viewDidLoad];
    gameName = @"OnOff";
    
    [self modelInitUIWithGameName:gameName delegate:self];
    
    onOffCenter = [[OnOffCenter alloc]init];
    onOffCenter.delegate = self;
    
    [self initSetting];
    [self initPress];
    [self initStartPress];
    [self initLightTable];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - GameUI

-(void)initSetting{
    lightLevel = 1;
    
    pressWidth = gameBodyView.frame.size.width/2;
    pressHeight = 80*HeightChangedRate;
    
    startPressWidth = gameBodyView.frame.size.width;
    startPressHeight = pressHeight;
    
    boxWidth = 48;
    boxHeight = 48;
    
    lightWidth = 42;
    lightHeight = 42;
    
    lightTableWidth = gameBodyView.frame.size.width;
    lightTableHeight = gameBodyView.frame.size.height-pressHeight-80;
}

-(void)initLightTable{
    lightTable = [[UIView alloc]init];
    lightTable.frame = CGRectMake(0, 80, lightTableWidth , lightTableHeight);
    [gameBodyView addSubview:lightTable];
    
    NSInteger basePosX =lightTable.frame.size.width/10;
    NSInteger basePosY =lightTable.frame.size.height/12;
    
    centerBoxPos = [[NSMutableArray alloc]init];
    centerLightPos = [[NSMutableArray alloc]init];
    for(NSInteger i=0;i<3;i++){
        for(NSInteger m=0;m<5;m++){
            CGPoint pos = CGPointMake(basePosX+basePosX*2*m, basePosY +basePosY*4*i);
            NSValue *value = [NSValue valueWithCGPoint:pos];
            [centerBoxPos addObject:value];
            
            CGPoint pos2 = CGPointMake(basePosX+basePosX*2*m, basePosY*3 +basePosY*4*i);
            NSValue *value2 = [NSValue valueWithCGPoint:pos2];
            [centerLightPos addObject:value2];
        }
    }


    
}

-(void)initBoxWithNumber:(NSInteger)boxAmt{
    boxArray = [[NSMutableArray alloc]init];
    for(NSInteger i =0;i<boxAmt;i++){
        OnOffBox *box = [[OnOffBox alloc]initWithWidth:boxWidth height:boxHeight];
        box.frame = CGRectMake(0, 0, boxWidth, boxHeight);
        [boxArray addObject:box];
    }
    
    for (NSInteger i =0; i<boxAmt; i++) {
        OnOffBox *box = boxArray[i];
        CGPoint pos = [centerLightPos[i]CGPointValue];
        box.frame = CGRectMake(0, 0, lightWidth, lightHeight);
        box.center = pos;
        [lightTable addSubview:box];
    }
    
}
-(void)initLightWithStatusArray:(NSMutableArray *)array{
    
    NSInteger lightAmt = [array count];
    lightArray = [[NSMutableArray alloc]init];
    for(NSInteger i =0;i<lightAmt;i++){
        NSInteger status = [array[i]integerValue];
        OnOffLight *light = [[OnOffLight alloc]initWithStatus:status width:lightWidth height:lightHeight];
        light.frame = CGRectMake(0, 0, boxWidth, boxHeight);
        [lightArray addObject:light];
    }

    
    for (NSInteger i =0; i<lightAmt; i++) {
        OnOffLight *light = lightArray[i];
        CGPoint pos = [centerLightPos[i]CGPointValue];
        light.frame = CGRectMake(0, 0, lightWidth, lightHeight);
        light.center = pos;
        [lightTable addSubview:light];
    }

    
}


-(void)initPress{
    //Left
    leftPress = [[UIView alloc]init];
    leftPress.frame = CGRectMake(0, gameBodyView.frame.size.height-pressHeight, pressWidth, pressHeight);
    leftPress.backgroundColor = [UIColor yellowColor];
    [gameBodyView addSubview:leftPress];
    
    UILabel *leftLabel = [[UILabel alloc]init];
    leftLabel.frame = CGRectMake(0, 0, pressWidth, pressHeight);
    leftLabel.text = @"ON";
    leftLabel.textColor = [UIColor blackColor];
    leftLabel.font = [UIFont systemFontOfSize:40];
    leftLabel.textAlignment = NSTextAlignmentCenter;
    [leftPress addSubview:leftLabel];
    
    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftPressed)];
    [leftPress addGestureRecognizer:leftTap];
    
    //Right
    rightPress = [[UIView alloc]init];
    rightPress.frame = CGRectMake(pressWidth, gameBodyView.frame.size.height-pressHeight, pressWidth, pressHeight);
    rightPress.backgroundColor = [UIColor blackColor];
    [gameBodyView addSubview:rightPress];
    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightPressed)];
    [rightPress addGestureRecognizer:rightTap];
    
    UILabel *rightLabel = [[UILabel alloc]init];
    rightLabel.frame = CGRectMake(0, 0, pressWidth, pressHeight);
    rightLabel.text = @"OFF";
    rightLabel.textColor = [UIColor whiteColor];
    rightLabel.font = [UIFont systemFontOfSize:40];
    rightLabel.textAlignment = NSTextAlignmentCenter;
    [rightPress addSubview:rightLabel];
    

    
}

-(void)leftPressed{
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
    
    [onOffCenter judgeLight:1];
    
}

-(void)rightPressed{
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
    
    [onOffCenter judgeLight:0];

}

-(void)initStartPress{
    startPress.hidden = YES;
    startPress = [[UIView alloc]init];
    startPress.frame = CGRectMake(0, gameBodyView.frame.size.height-startPressHeight, startPressWidth, startPressHeight);
    startPress.backgroundColor = [UIColor purpleColor];
    [gameBodyView addSubview:startPress];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(startPressed)];
    [startPress addGestureRecognizer:tap];
    
    UILabel *startPressLabel =[[UILabel alloc]init];
    startPressLabel.text = @"GO";
    startPressLabel.font = [UIFont systemFontOfSize:40];
    startPressLabel.textColor = [UIColor whiteColor];
    startPressLabel.textAlignment = NSTextAlignmentCenter;
    startPressLabel.frame = CGRectMake(0, 0, startPress.frame.size.width, startPress.frame.size.height);
    [startPress addSubview:startPressLabel];
    
    //cover
    pressCover = [[UIView alloc]init];
    pressCover.frame = CGRectMake(0, gameBodyView.frame.size.height-pressHeight, gameBodyView.frame.size.width, pressHeight);
    pressCover.backgroundColor = [UIColor blackColor];
    pressCover.alpha =0.8;
    [gameBodyView addSubview:pressCover];
    
}
-(void)startPressed{
    startPress.hidden = YES;
    NSInteger openBoxAmt = lightLevel*5;
    for(NSInteger i=0;i<openBoxAmt;i++){
        OnOffBox *box = boxArray[i];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        box.center = [centerLightPos[i]CGPointValue];
        [UIView commitAnimations];
    }
    
}

-(void)cleanLightTable{
    NSArray *array = [lightTable subviews];
    for(UIView *obj in array){
        [obj removeFromSuperview];
    }
}

#pragma mark - Main
-(void)prepareGame{
    startPress.hidden = NO;
    NSInteger openBoxAmt = lightLevel*5;
    for(NSInteger i=0;i<openBoxAmt;i++){
        OnOffBox *box = boxArray[i];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        box.center = [centerBoxPos[i]CGPointValue];
        [UIView commitAnimations];
    }
}



#pragma mark - Model
-(void)modelInitGameTips{
    pressCover.hidden = NO;

    NSInteger baseWidth = gameTipsBodyView.frame.size.width;
    
    UIView *view1 = [[UIView alloc]init];
    view1.frame = CGRectMake(10, 100, baseWidth-20, 40);
    view1.backgroundColor = [UIColor blackColor];
    view1.alpha = 0.7;
    view1.layer.cornerRadius = 15;
    [gameTipsBodyView addSubview:view1];
    
    UILabel *label1 = [[UILabel alloc]init];
    label1.text = @"燈";
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
    label2.text = @"開 還是 關";
    label2.textColor = [UIColor whiteColor];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.frame = CGRectMake(0, 0, baseWidth-20, 40);
    [view2 addSubview:label2];
}

-(void)modelBackToGameList{
    [onOffCenter centerEndGame];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)modelStartGame{
    startPress.hidden = NO;
    pressCover.hidden = YES;
    [gameTipsView removeFromSuperview];
    [self cleanLightTable];
    [onOffCenter centerStartGame];
}

-(void)modelRestartGame{
    timerLabel.text = [NSString stringWithFormat:@"剩下%@秒",gameTime];
    [onOffCenter centerEndGame];
    [self initTips];
    [self modelInitGameTips];
    
}

#pragma mark - Delegate
-(void)refreshFinishedGameWithTap:(NSInteger)tap{
    NSNumber *successCount = [NSNumber numberWithInteger:tap];
    NSString *finishedMsg = [NSString stringWithFormat:@"總共猜對了 %@ 個開關",successCount];
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

-(void)refreshLightStatus:(NSMutableArray *)array level:(NSInteger)level{
    lightLevel = level;
    [self initLightWithStatusArray:array];
    NSInteger boxAmt = [array count];
    [self initBoxWithNumber:boxAmt];
    [self prepareGame];
    
}

-(void)judgeSuccesWithPos:(NSInteger)pos{
    //按對 箱子就會上升
    OnOffBox *box = boxArray[pos];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    box.center = [centerBoxPos[pos]CGPointValue];
    [UIView commitAnimations];
    
}

-(void)judgeSuccessWithLevel:(NSInteger)level{
    lightLevel = level;
    [self prepareGame];
}
@end
