//
//  MainViewController.m
//  DonFactory
//
//  Created by Don on 2014/10/20.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "MainViewController.h"
#import "GameListViewController.h"
#import "GameSettingVC.h"


static MainViewController *MVC = nil;
@interface MainViewController ()

@end

@implementation MainViewController

+(MainViewController *)shareMVC{
    if(MVC == nil){
        MVC = [[MainViewController alloc]init];
    }
    return MVC;
}

-(id)init{
    self = [super init];
    if(self){
        screenName = [NSMutableString stringWithString:@"訓練場"];
        [self refreshMVC];
        [self initTabHeader];
        [self initTabBar];
        [self.tabBar setHidden:YES];
    }
    return self;
}
-(void)refreshMVC{
    GameListViewController *gameList = [[GameListViewController alloc]init];
    gameList.title = @"訓練場";
    GameSettingVC *gameSetting = [[GameSettingVC alloc]init];
    gameSetting.title = @"訓練場資訊";
    
    NSArray *VCs = [[NSArray alloc]initWithObjects:gameList,gameSetting, nil];
    self.viewControllers = VCs;
}

-(void)refreshTitle{
    headerLabel.text = screenName;
}


-(void)initTabHeader{
    UIView *statusBar = [[UIView alloc]init];
    statusBar.frame = CGRectMake(0, 0, ScreenWidth, 22);
    statusBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:statusBar];
    
    gameListHeaderView = [[UIView alloc]init];
    gameListHeaderView.frame = CGRectMake(0, 22, ScreenWidth, 44);
    [self.view addSubview:gameListHeaderView];
    
    UIImageView *headerIV = [[UIImageView alloc]init];
    headerIV.frame = CGRectMake(0, 0, ScreenWidth, 44);
    headerIV.image = [[UIImage imageNamed:@"gameList_header02.png"]stretchableImageWithLeftCapWidth:15 topCapHeight:15];
    headerIV.userInteractionEnabled = YES;
    [gameListHeaderView addSubview:headerIV];
    
    headerLabel = [[UILabel alloc]init];
    headerLabel.text = screenName;
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.textAlignment = NSTextAlignmentLeft;
    headerLabel.font = [UIFont systemFontOfSize:22];
    headerLabel.frame =CGRectMake(30, 0 , 290, 40);
    headerLabel.center = CGPointMake(gameListHeaderView.frame.size.width/2, gameListHeaderView.frame.size.height/2);
    [gameListHeaderView addSubview:headerLabel];
    
    
}


-(void)initTabBar{
    tabBarView = [[UIImageView alloc]init];
    tabBarView.frame = CGRectMake(0, ScreenHeight-64, ScreenWidth, 64);
    tabBarView.image = [UIImage imageNamed:@"gameList_header02.png"];
    tabBarView.layer.borderWidth = 2;
    tabBarView.userInteractionEnabled = YES;
    [self.view addSubview:tabBarView];
    
    homeTab = [[UIImageView alloc]init];
    homeTab.frame = CGRectMake(0,0 , 48, 48);
    homeTab.center = CGPointMake(tabBarView.frame.size.width/4, tabBarView.frame.size.height/2);
    homeTab.image = [UIImage imageNamed:@"gameList_homeBtn.png"];
    [tabBarView addSubview:homeTab];
    homeTab.userInteractionEnabled = YES;
    UITapGestureRecognizer *homeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(homeTabPressed)];
    [homeTab addGestureRecognizer:homeTap];
    
    settingTab = [[UIImageView alloc]init];
    settingTab.frame = CGRectMake(0, 0, 48, 48);
    settingTab.center = CGPointMake(tabBarView.frame.size.width/4*3, tabBarView.frame.size.height/2);
    settingTab.image = [UIImage imageNamed:@"section_setting.png"];
    [tabBarView addSubview:settingTab];
    settingTab.userInteractionEnabled = YES;
    UITapGestureRecognizer *settingTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(settingTabPressed)];
    [settingTab addGestureRecognizer:settingTap];
    
    
}
-(void)homeTabPressed{
    [self refreshMVC];

    screenName = [NSMutableString stringWithString:@"訓練場"];
    [self refreshTitle];
    
    self.selectedIndex = 0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    homeTab.alpha = 0.5;
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDelay:0.1];
    homeTab.alpha = 1;
    [UIView commitAnimations];
}
-(void)settingTabPressed{
    screenName = [NSMutableString stringWithString:@"訓練場資訊"];
    [self refreshTitle];
    self.selectedIndex = 1;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    settingTab.alpha = 0.5;
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDelay:0.1];
    settingTab.alpha = 1;
    [UIView commitAnimations];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
