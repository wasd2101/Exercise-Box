//
//  GameListViewController.m
//  DonFactory
//
//  Created by Don on 2014/10/20.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "GameListViewController.h"
#import "GameListBarModel.h"

static GameListViewController *gameListViewController = nil;
@interface GameListViewController ()

@end

@implementation GameListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    gameListCenter = [[GameListCenter alloc]init];
    gameListCenter.delegate = self;

    [self initGameList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initGameList{
    baseView = [[UIView alloc]init];
    baseView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gameBackground02.jpeg"]];
    self.view = baseView;
    [self initGameListBody];
}


-(void)initGameListBody{
    gameBox = [[NSMutableArray alloc]init];
    gameBox = [gameListCenter loadGameBox];
    NSInteger gameAmount = [gameBox count];
    
    gameListScrollView = [[UIScrollView alloc]init];
    gameListScrollView.frame =CGRectMake(0, 66, ScreenWidth, ScreenHeight-115);
    gameListScrollView.contentSize = CGSizeMake(ScreenWidth, gameAmount *80 +50);
    [self.view addSubview:gameListScrollView];
    

    //Bar
    for(int i=0;i<gameAmount;i++){
        NSDictionary *gameDic = [[NSDictionary alloc]initWithDictionary:gameBox[i]];
        GameListBarModel *gameListBar = [[GameListBarModel alloc]initGameListBarWithGameDic:gameDic];
        gameListBar.frame = CGRectMake(5, i*60 +20*i +20, gameListBar.barWidth, gameListBar.barHeight);
        gameListBar.delegate = self;
        gameListBar.layer.borderWidth = 2;
        gameListBar.layer.borderColor = [[UIColor redColor]CGColor];
        gameListBar.alpha = 0.8;
        [gameListScrollView addSubview:gameListBar];

    }
}

//代理方法
-(void)barTouched:(GameListBarModel *)model{
    [gameListCenter selectedGameName:model.gameName];
}
-(void)pushGameView:(id)game{
    //gameList傳入一個遊戲的ViewController，然後Push進來。
    [self presentViewController:game animated:YES completion:nil];
}

@end
