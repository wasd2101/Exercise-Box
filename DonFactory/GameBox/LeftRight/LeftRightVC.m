//
//  LeftRightVC.m
//  DonFactory
//
//  Created by Don on 2014/10/30.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "LeftRightVC.h"
#import "LeftRightBlock.h"

@interface LeftRightVC ()

@end

@implementation LeftRightVC

- (void)viewDidLoad {
    [super viewDidLoad];
    gameName = @"LeftRight";
    
    [self modelInitUIWithGameName:gameName delegate:self];
    
    leftRightCenter = [[LeftRightCenter alloc]init];
    leftRightCenter.delegate = self;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"leftRight_blop" ofType:@"wav"];
    if(path){
        audioPlayer =[[AVAudioPlayer alloc]initWithContentsOfURL:[[NSURL alloc]initFileURLWithPath:path]error:nil];
        [audioPlayer prepareToPlay];
        audioPlayer.numberOfLoops = 0;
        audioPlayer.volume = 0.5f;
        
    }
    
    [self initSetting];
    [self initPress];
    [self initRoad];
    [self initCar];
    
}


-(void)initSetting{
    pressWidth = gameBodyView.frame.size.width/2;
    pressHeight = 80*HeightChangedRate;

    roadWidth = gameBodyView.frame.size.width;
    roadHeight = gameBodyView.frame.size.height-pressHeight-80;
    
    carWidth = 52*WidthChangedRate;
    carHeight = 52*HeightChangedRate;
    carCenterX = roadWidth/2;
    carCenterY = roadHeight- carHeight;
    blockWidth = 60*WidthChangedRate;
    blockHeight = 60*HeightChangedRate;
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UI
-(void)initCar{
    car = [[UIImageView alloc]init];
    car.image = [UIImage imageNamed:@"leftRight_car.png"];
    car.frame = CGRectMake(0, 0, carWidth, carHeight);
    car.center = CGPointMake(carCenterX, carCenterY);
    [roadView addSubview:car];
}
-(void)initRoad{
    roadView = [[UIView alloc]init];
    roadView.frame = CGRectMake(0, 80, roadWidth, roadHeight);
    [gameBodyView addSubview:roadView];
    
    //座標系
    CGFloat baseX = roadView.frame.size.width/4;
    CGFloat baseY = roadView.frame.size.height/10;
    
    leftCenterPos = [[NSMutableArray alloc]init];
    for(NSInteger i=0;i<5;i++){
        CGPoint point = CGPointMake(baseX, roadView.frame.size.height -baseY -baseY*i*2);
        NSValue *value = [NSValue valueWithCGPoint:point];
        [leftCenterPos addObject:value];
    }
    rightCenterPos = [[NSMutableArray alloc]init];
    for(NSInteger i=0;i<5;i++){
        CGPoint point = CGPointMake(baseX*3, roadView.frame.size.height -baseY -baseY*i*2);
        NSValue *value = [NSValue valueWithCGPoint:point];
        [rightCenterPos addObject:value];
    }
    
}
#pragma mark - Control
-(void)initPress{
//Left
    leftPress = [[UIView alloc]init];
    leftPress.frame = CGRectMake(0, gameBodyView.frame.size.height-pressHeight, pressWidth, pressHeight);
    leftPress.backgroundColor = [UIColor whiteColor];
    [gameBodyView addSubview:leftPress];
    
    UILabel *leftLabel = [[UILabel alloc]init];
    leftLabel.frame = CGRectMake(0, 0, pressWidth, pressHeight);
    leftLabel.text = @"LEFT";
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
    rightLabel.text = @"RIGHT";
    rightLabel.textColor = [UIColor whiteColor];
    rightLabel.font = [UIFont systemFontOfSize:40];
    rightLabel.textAlignment = NSTextAlignmentCenter;
    [rightPress addSubview:rightLabel];
    
    //cover
    pressCover = [[UIView alloc]init];
    pressCover.frame = CGRectMake(0, gameBodyView.frame.size.height-pressHeight, gameBodyView.frame.size.width, pressHeight);
    pressCover.backgroundColor = [UIColor blackColor];
    pressCover.alpha = 0.8;
    [gameBodyView addSubview:pressCover];
    
}

-(void)leftPressed{
    [leftRightCenter judgeWay:@"Left"];
    [audioPlayer play];
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
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    car.center = CGPointMake(carCenterX*0.5, carCenterY);
    [UIView commitAnimations];
    
}

-(void)rightPressed{
    [leftRightCenter judgeWay:@"Right"];
    [audioPlayer play];
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
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    car.center = CGPointMake(carCenterX*1.5, carCenterY);
    [UIView commitAnimations];
}

#pragma mark - model
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
    label1.text = @"避開障礙物";
    label1.textColor = [UIColor whiteColor];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.frame = CGRectMake(0, 0, baseWidth-20, 40);
    [view1 addSubview:label1];
}

-(void)modelBackToGameList{
    [leftRightCenter centerEndGame];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)modelStartGame{
    pressCover.hidden = YES;
    [gameTipsView removeFromSuperview];
    [leftRightCenter centerStartGame];
}


-(void)modelRestartGame{
    timerLabel.text = [NSString stringWithFormat:@"剩下%@秒",gameTime];
    [leftRightCenter centerEndGame];
    [self initTips];
    [self modelInitGameTips];
    
}

#pragma mark - Delegate
-(void)refreshWay:(NSString *)direction level:(NSInteger)level{
    CGFloat animationTime = 0.2;

    for(NSInteger i=0;i<4;i++){
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:animationTime];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        LeftRightBlock *block = blockArray[i];
        if([block.blockPos isEqualToString:@"Left"]){
            block.center = [leftCenterPos[i]CGPointValue];
        }else if([block.blockPos isEqualToString:@"Right"]){
            block.center =[rightCenterPos[i]CGPointValue];
        }
        //最上面
        if(i==3){
            block.alpha = 1;
        }
        //最下面
        if(i==0){
            block.alpha = 0;
            [block setTimerRemoveSelf:1];
        }
        [UIView commitAnimations];
    }
    [blockArray removeObjectAtIndex:0];

    
    //新加入
    LeftRightBlock *block = [[LeftRightBlock alloc]initWithWidth:blockWidth height:blockHeight pos:direction level:level];
    block.frame = CGRectMake(0, 0, blockWidth, blockHeight);
    if([block.blockPos isEqualToString:@"Left"]){
        block.center = [leftCenterPos[4]CGPointValue];
    }else if([block.blockPos isEqualToString:@"Right"]){
        block.center = [rightCenterPos[4]CGPointValue];
    }
    block.alpha = 0;
    [roadView addSubview:block];
    [blockArray addObject:block];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationTime];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    block.alpha = 0.2;
    [UIView commitAnimations];
    
}

-(void)refreshFinishedGameWithTap:(NSInteger)tap{
    NSNumber *successCount = [NSNumber numberWithInteger:tap];
    NSString *finishedMsg = [NSString stringWithFormat:@"閃過了 %@ 個障礙物",successCount];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"遊戲結束" message:finishedMsg delegate:self cancelButtonTitle:@"再來一次" otherButtonTitles:@"休息一下", nil];
    [alertView show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex ==0){
        [self cleanRoad];
        [self initCar];
        [self modelRestartGame];

    }else if(buttonIndex ==1){
        [self modelBackToGameList];
    }
}

-(void)cleanRoad{
    NSArray *roadObj = [roadView subviews];
    for(UIView *obj in roadObj){
        [obj removeFromSuperview];
    }
}
-(void)didInitWay:(NSMutableArray *)array{
    //初始化四個Way
    blockArray = [[NSMutableArray alloc]init];
    NSMutableString *posStr = [[NSMutableString alloc]init];
    for(NSString *obj in array){
        if([obj isEqualToString:@"Left"]){
            posStr = [NSMutableString stringWithString:@"Left"];
        }else if([obj isEqualToString:@"Right"]){
            posStr = [NSMutableString stringWithString:@"Right"];
        }
        LeftRightBlock *block = [[LeftRightBlock alloc]initWithWidth:blockWidth height:blockHeight pos:posStr level:1];
        [blockArray addObject:block];
    }
    
    NSInteger i = 1;
    for(LeftRightBlock *block in blockArray){
        CGPoint point;
        if([block.blockPos isEqualToString:@"Left"]){
            point = [leftCenterPos[i]CGPointValue];
        }else if([block.blockPos isEqualToString:@"Right"]){
            point = [rightCenterPos[i]CGPointValue];
        }
        block.frame = CGRectMake(0, 0, blockWidth, blockHeight);
        block.center = point;

        [roadView addSubview:block];
        i +=1;
    }
    LeftRightBlock *block = blockArray[3];
    block.alpha = 0.2;
}

@end
