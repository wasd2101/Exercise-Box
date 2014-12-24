//
//  WhichWayVC.m
//  DonFactory
//
//  Created by Don on 2014/10/24.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "WhichWayVC.h"

@interface WhichWayVC ()

@end

@implementation WhichWayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    gameName = @"WhichWay";

    whichWayCenter = [[WhichWayCenter alloc]init];
    whichWayCenter.delegate = self;
    [self modelInitUIWithGameName:gameName delegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)modelInitGameTips{
    pageWidth = gameTipsBodyView.frame.size.width;
    UIScrollView *mainScrollView =[[UIScrollView alloc]init];
    mainScrollView.frame = CGRectMake(0, 0, gameTipsBodyView.frame.size.width, gameTipsBodyView.frame.size.height-30);
    mainScrollView.contentSize =CGSizeMake(pageWidth*3, mainScrollView.frame.size.height);
    mainScrollView.pagingEnabled = YES;
    mainScrollView.delegate = self;
    mainScrollView.showsHorizontalScrollIndicator = NO;
    [gameTipsBodyView addSubview:mainScrollView];
    
    tipsPageControl = [[UIPageControl alloc]init];
    tipsPageControl.numberOfPages =3;
    tipsPageControl.currentPage = 0;
    tipsPageControl.frame = CGRectMake(0,gameTipsBodyView.frame.size.height-30 , gameTipsBodyView.frame.size.width, 30);
    tipsPageControl.backgroundColor = [UIColor blackColor];
    [gameTipsBodyView addSubview:tipsPageControl];
    
    
    UIImageView *tip1View = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"whichWay_tips1.png"]];
    tip1View.frame = CGRectMake(0, 0, pageWidth, mainScrollView.frame.size.height);
    [mainScrollView addSubview:tip1View];
    
    UIImageView *tip2View = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"whichWay_tips2.png"]];
    tip2View.frame = CGRectMake(pageWidth, 0, pageWidth, mainScrollView.frame.size.height);
    [mainScrollView addSubview:tip2View];
    
    UIImageView *tip3View = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"whichWay_tips3.png"]];
    tip3View.frame = CGRectMake(pageWidth*2, 0, pageWidth, mainScrollView.frame.size.height);
    [mainScrollView addSubview:tip3View];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int current = scrollView.contentOffset.x/pageWidth;
    tipsPageControl.currentPage = current;
}


-(void)modelBackToGameList{
    [whichWayCenter centerEndGame];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)modelStartGame{
    [gameTipsView removeFromSuperview];
    [whichWayCenter centerStartGame];
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeUp)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRight)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDown)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    UISwipeGestureRecognizer *swipeLeft =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLeft)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [gameBodyView addGestureRecognizer:swipeUp];
    [gameBodyView addGestureRecognizer:swipeRight];
    [gameBodyView addGestureRecognizer:swipeDown];
    [gameBodyView addGestureRecognizer:swipeLeft];
}

-(void)swipeUp{
    [whichWayCenter swipeDirection:@"Up"];
}
-(void)swipeRight{
    [whichWayCenter swipeDirection:@"Right"];
}
-(void)swipeDown{
    [whichWayCenter swipeDirection:@"Down"];
}
-(void)swipeLeft{
    [whichWayCenter swipeDirection:@"Left"];
}

-(void)modelRestartGame{
    timerLabel.text = [NSString stringWithFormat:@"剩下%@秒",gameTime];
    [whichWayCenter centerEndGame];
    [self initTips];
    [self modelInitGameTips];

}



//代理
-(void)refreshBlockWithDirection:(NSString *)dir opssite:(NSInteger)opp{
    if(block !=nil){
        [block setTimerToRemoveSelfWithTime:0.01];
    }
    block = [[WhichWayBlock alloc]initBlockWithDirection:dir oppsite:opp width:128 height:128];
    block.frame = CGRectMake(0, 0, 128, 128);
    block.center = CGPointMake(ScreenWidth/2, ScreenHeight/2-64);
    block.alpha = 0;
    [gameBodyView addSubview:block];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    block.alpha = 1;
    [UIView commitAnimations];
}

-(void)refreshFinishedGameWithSwipe:(NSInteger)swipeSuccess{
    NSNumber *successCount = [NSNumber numberWithInteger:swipeSuccess];
    NSString *finishedMsg = [NSString stringWithFormat:@"滑對了 %@ 次",successCount];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"遊戲結束" message:finishedMsg delegate:self cancelButtonTitle:@"再來一次" otherButtonTitles:@"休息咯", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex ==0){
        [self modelRestartGame];
    }else if(buttonIndex ==1){
        [self modelBackToGameList];
    }
}

@end
