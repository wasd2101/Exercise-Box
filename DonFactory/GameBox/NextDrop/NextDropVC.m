//
//  NextDropVC.m
//  DonFactory
//
//  Created by Don on 2014/11/3.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "NextDropVC.h"
#import "NextDropUmbrella.h"
#import "NextDropDrop.h"

@interface NextDropVC ()

@end

@implementation NextDropVC

- (void)viewDidLoad {
    [super viewDidLoad];
    gameName = @"NextDrop";
    
    [self modelInitUIWithGameName:gameName delegate:self];

    
    nextDropCenter =[[NextDropCenter alloc]init];
    nextDropCenter.delegate = self;
    
    [self initSetting];
    [self initCloud];
    [self initUmbrella];
    [self initDropTable];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UI
-(void)initSetting{
    baseX = gameBodyView.frame.size.width/4;
    
    cloudWidth = 80;
    cloudHeight = 80;
    
    umbrellaWidth = 80;
    umbrellaHeight = 80;
    umbrellaY = gameBodyView.frame.size.height - umbrellaHeight/2;
    
    dropTableWidth = gameBodyView.frame.size.width;
    dropTableHeight = gameBodyView.frame.size.height - umbrellaHeight - cloudHeight - 80;
    
    dropWidth = 32;
    dropHeight = 32;
    
    dropStep = 0;
    dropLeft = 0;
    dropLevel = 0;
    
    dropTimer = [[NSTimer alloc]init];
}

-(void)initDropTable{
    dropTable = [[UIView alloc]init];
    dropTable.frame = CGRectMake(0, 80 +cloudHeight, dropTableWidth, dropTableHeight);
    [gameBodyView addSubview:dropTable];
    
    leftLabel =[[UILabel alloc]init];
    leftLabel.frame = CGRectMake(0, 0, dropTableWidth, 60);
    leftLabel.center = CGPointMake(dropTableWidth/2, dropTableHeight/2);
    leftLabel.layer.borderWidth = 2;
    leftLabel.text = [NSString stringWithFormat:@"還剩下%@滴水",[NSNumber numberWithInteger:dropLeft]];
    leftLabel.textAlignment = NSTextAlignmentCenter;
    leftLabel.backgroundColor = [UIColor grayColor];
    leftLabel.alpha = 0.6;
    leftLabel.hidden = YES;
    [dropTable addSubview:leftLabel];
    
    levelLabel = [[UILabel alloc]init];
    levelLabel =[[UILabel alloc]init];
    levelLabel.frame = CGRectMake(0, 0, dropTableWidth, 30);
    levelLabel.center = CGPointMake(dropTableWidth/2, 20);
    levelLabel.layer.borderWidth = 2;
    levelLabel.text = [NSString stringWithFormat:@"Level: %@",[NSNumber numberWithInteger:dropLevel]];
    levelLabel.textAlignment = NSTextAlignmentCenter;
    levelLabel.backgroundColor = [UIColor yellowColor];
    levelLabel.alpha = 0.6;
    [dropTable addSubview:levelLabel];
}
-(void)initCloud{
    for(NSInteger i=0;i<4;i++){
        UIImageView *cloud = [[UIImageView alloc]init];
        cloud.image = [UIImage imageNamed:@"nextDrop_cloud.png"];
        cloud.frame = CGRectMake(0, 0, cloudWidth, cloudHeight);
        cloud.center = CGPointMake(baseX/2 +baseX*i, 80+cloudHeight/2);
        [gameBodyView addSubview:cloud];
    }
}
-(void)initUmbrella{
    NSArray *colorArray = [[NSArray alloc]initWithObjects:@"Red",@"Yellow",@"Blue",@"Green", nil];
    for(NSInteger i=0;i<4;i++){
        NextDropUmbrella *umbrella = [[NextDropUmbrella alloc]initWithWidth:umbrellaWidth height:umbrellaHeight color:colorArray[i] delegate:self];
        umbrella.center = CGPointMake(umbrellaWidth/2 +umbrellaWidth*i, umbrellaY);
        [gameBodyView addSubview:umbrella];
    }
    
    umbrellaCover = [[UIView alloc]init];
    umbrellaCover.frame = CGRectMake(0, gameBodyView.frame.size.height - umbrellaHeight, gameBodyView.frame.size.width, umbrellaHeight);
    umbrellaCover.backgroundColor = [UIColor blackColor];
    umbrellaCover.alpha = 0.8;
    [gameBodyView addSubview:umbrellaCover];
}


#pragma mark - Model
-(void)modelInitGameTips{
    umbrellaCover.hidden = NO;
    NSInteger baseWidth = gameTipsBodyView.frame.size.width;
    
    UIView *view1 = [[UIView alloc]init];
    view1.frame = CGRectMake(10, 100, baseWidth-20, 40);
    view1.backgroundColor = [UIColor blackColor];
    view1.alpha = 0.7;
    view1.layer.cornerRadius = 15;
    [gameTipsBodyView addSubview:view1];
    
    UILabel *label1 = [[UILabel alloc]init];
    label1.text = @"記住水滴下的順序";
    label1.textColor = [UIColor whiteColor];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.frame = CGRectMake(0, 0, baseWidth-20, 40);
    [view1 addSubview:label1];
}

-(void)modelBackToGameList{
    [nextDropCenter centerEndGame];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)modelStartGame{
    [gameTipsView removeFromSuperview];
    [self initSetting];
    [nextDropCenter centerStartGame];
}

-(void)modelRestartGame{
    timerLabel.text = [NSString stringWithFormat:@"剩下%@秒",gameTime];
    [nextDropCenter centerEndGame];
    [self initTips];
    [self modelInitGameTips];
    
}
#pragma mark - Drop
-(void)didRandomDropWithArray:(NSArray *)dropArray dropInterval:(CGFloat)time{
    umbrellaCover.hidden = NO;
    umbrellaCover.alpha = 0.5;
    dropLevel +=1;
    dropStep =0;
    dropLeft =[dropArray count];
    [self refreshLabel];
    dropAmt = [dropArray count];
    dropTimer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(doDropWithPosition:) userInfo:dropArray repeats:YES];    
}
-(void)doDropWithPosition:(NSTimer *)timer{
    NSInteger dropTime = 1;
    
    NSInteger dropPos = [[timer userInfo][dropStep]integerValue];
    NextDropDrop *drop = [[NextDropDrop alloc]initWithWidth:dropWidth height:dropHeight];
    drop.center = CGPointMake(baseX/2 +baseX*dropPos, dropHeight/2);
    drop.alpha = 0.5;
    [dropTable addSubview:drop];
    
    //動畫1  透明->不透明
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    drop.alpha = 1;
    [UIView commitAnimations];
    
    //動畫2 落下過程
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:dropTime];
    [UIView setAnimationDelay:0.2];
    drop.center =CGPointMake(baseX/2 +baseX*dropPos, dropTableHeight);
    drop.alpha = 0.5;
    [UIView commitAnimations];
    
    //落完消失
    [drop setTimerRemoveDrop:dropTime +0.5];
    
    //落完後
    if(dropStep+1 ==dropAmt){
        [dropTimer invalidate];
        dropPos =0;
        umbrellaCover.hidden = YES;
        leftLabel.hidden = NO;
        
    }
    dropStep +=1;
}

-(void)refreshJudgeSuccess{
    dropLeft -=1;

    [self refreshLabel];
}

-(void)refreshLabel{
    levelLabel.text = [NSString stringWithFormat:@"Level: %@",[NSNumber numberWithInteger:dropLevel]];
    leftLabel.text = [NSString stringWithFormat:@"還剩下%@滴水",[NSNumber numberWithInteger:dropLeft]];
}
#pragma mark - Delegate
-(void)tappedForVC:(NSString *)color{
    [nextDropCenter judgeDropWithColor:color];
}

-(void)refreshFinishedGameWithTap:(NSInteger)tap{
    NSNumber *successCount = [NSNumber numberWithInteger:tap];
    NSString *finishedMsg = [NSString stringWithFormat:@"猜對了 %@ 滴水的順序",successCount];
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



@end
