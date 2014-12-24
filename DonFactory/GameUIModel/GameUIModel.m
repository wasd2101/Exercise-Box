//
//  GameUIModel.m
//  DonFactory
//
//  Created by Don on 2014/10/15.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "GameUIModel.h"
#import "GameUIModelHeader.h"
#import "GameUIModelBody.h"
#import "GameUiModelTips.h"
#import "GameUIModelTipsBody.h"

#import "SqlTool.h"
@interface GameUIModel ()

@end

@implementation GameUIModel

#pragma mark - 好像可以刪除的部分
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - init UI
-(void)modelInitUIWithGameName:(NSString *)name delegate:(id)delegate{
    
    //這邊先計算好變化後的width/Height 之後實力化的時候直接使用。
    basicHeaderWidth = ScreenWidth;
    basicHeaderHeight = (25 +50)*HeightChangedRate;

    basicTipsWidth = 280 *WidthChangedRate;
    basicTipsHeight = 480 *HeightChangedRate;
    
    
    basicTipsBodyWidth = basicTipsWidth;
    basicTipsBodyHeight = basicTipsHeight-40-50;
    
    UIDelegate = delegate;
    gameName = name;

    [self initGameHeader];
    [self initGameBody];
    [self initTips];
    [self modelInitGameTips];//新創VC時，自己添加內容。
    [self loadGameDetail];
    
    timerLabel = [[UILabel alloc]init];
    timerLabel.text = [NSString stringWithFormat:@"剩下 %@ 秒",gameTime];
    timerLabel.textAlignment = NSTextAlignmentCenter;
    timerLabel.frame = CGRectMake(0, 0, 100, 40);
    timerLabel.center = CGPointMake(ScreenWidth/2, 40);
    timerLabel.layer.borderColor = [[UIColor blackColor]CGColor];
    timerLabel.layer.borderWidth = 4;
    [gameBodyView addSubview:timerLabel];
    
}
-(void)loadGameDetail{
    SqlTool *sqlTool = [SqlTool shareSqlTool];
    gameDetail = [NSArray arrayWithArray:[sqlTool loadSingleGameBoxDetailWithGameName:gameName]];
    gameTime = [gameDetail[0]objectForKey:@"gameTime"];
}

-(void)initGameHeader{
    gameHeaderView = [[GameUIModelHeader alloc]initGameHeaderViewWithGameName:gameName delegate:self width:basicHeaderWidth height:basicHeaderHeight];
    gameHeaderView.frame =CGRectMake(0, 0, basicHeaderWidth *WidthChangedRate, basicHeaderHeight *HeightChangedRate);
    [self.view addSubview:gameHeaderView];

}

-(void)initGameBody{
    gameBodyView =[[GameUIModelBody alloc]initBodyViewWithWidth:ScreenWidth height:basicHeaderHeight];
    gameBodyView.frame = CGRectMake(0, basicHeaderHeight, ScreenWidth, ScreenHeight-basicHeaderHeight);
    gameBodyView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gameBackground.png"]];
    [self.view addSubview:gameBodyView];

}

-(void)initTips{
    gameTipsView =[[GameUIModelTips alloc]initWithDelegate:self width:basicTipsWidth height:basicTipsHeight];
    gameTipsView.frame =CGRectMake(0, 0, basicTipsWidth,  basicTipsHeight);
    gameTipsView.center = CGPointMake(ScreenWidth/2, ScreenHeight/2);
    [self.view addSubview:gameTipsView];
    [self initTipsBody];

}
-(void)initTipsBody{
    gameTipsBodyView = [[GameUIModelTipsBody alloc]initTipsBodyWithWidth:basicTipsBodyWidth height:basicTipsBodyHeight];
    gameTipsBodyView.frame = CGRectMake(0, 40, basicTipsBodyWidth, basicTipsBodyHeight);
    [gameTipsView addSubview:gameTipsBodyView];
}


#pragma mark - Functions
-(void)modelInitGameTips{
    
}
-(void)modelBackToGameList{
    
}

-(void)modelRestartGame{
    
}

-(void)modelStartGame{
    
}

-(void)refreshGameTime:(NSInteger)time{
    NSNumber *gameTimeNumber = [NSNumber numberWithInteger:time];
    timerLabel.text = [NSString stringWithFormat:@"剩下 %@ 秒",gameTimeNumber];
    timerLabel.textAlignment = NSTextAlignmentCenter;
}


@end
