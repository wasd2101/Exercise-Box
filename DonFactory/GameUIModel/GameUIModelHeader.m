//
//  GameUIModelHeader.m
//  DonFactory
//
//  Created by Don on 2014/10/15.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "GameUIModelHeader.h"

@implementation GameUIModelHeader

-(id)initGameHeaderViewWithGameName:(NSString *)name delegate:(id)delegate width:(CGFloat)width height:(CGFloat)height{
    self = [super init];
    if(self){
        gameName = name;
        
        basicHeaderWidth = width;
        basicHeaderHeight = height;
        
        newHowToPlayWidth = basicHeaderWidth *WidthChangedRate;
        newHowToPlayHeight = basicHeaderHeight *HeightChangedRate;
        _delegate = delegate;

        [self initHeaderView];
    }
    return self;
}

-(void)initHeaderView{
    NSInteger statusBarHeight = 25 *HeightChangedRate;
    NSInteger headerIVHeight = 50 *HeightChangedRate;
    self.frame = CGRectMake(0, 0, newHowToPlayWidth, newHowToPlayHeight);
    
    //系統的時間欄
    UIView *gameUIStatusBar = [[UIView alloc]init];
    gameUIStatusBar.frame = CGRectMake(0, 0, ScreenWidth, statusBarHeight);
    gameUIStatusBar.backgroundColor = [UIColor whiteColor];
    [self addSubview:gameUIStatusBar];
    
    //headerView的底層
    UIImageView *gameUIheaderIV = [[UIImageView alloc]init];
    gameUIheaderIV.frame = CGRectMake(0, gameUIStatusBar.frame.size.height+2, ScreenWidth, headerIVHeight);
    gameUIheaderIV.image = [[UIImage imageNamed:@"gameList_header02.png"]stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    gameUIheaderIV.userInteractionEnabled = YES;
    [self addSubview:gameUIheaderIV];
    
    //label-標題
    UILabel *headerLabel = [[UILabel alloc]init];
    headerLabel.text = gameName;
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.font = [UIFont systemFontOfSize:18];
    headerLabel.frame =CGRectMake(0, 0 , 120 *WidthChangedRate, 40 *HeightChangedRate);
    headerLabel.center = CGPointMake(ScreenWidth/2, gameUIheaderIV.frame.size.height/2);
    [gameUIheaderIV addSubview:headerLabel];
    
    
    homeImageView = [[UIImageView alloc]init];
    homeImageView.frame = CGRectMake(10, 5, 36 *WidthChangedRate, 36 *HeightChangedRate);
    homeImageView.image = [UIImage imageNamed:@"gameHeader_home.png"];
    homeImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *homeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(homeBtnPressed)];
    [homeImageView addGestureRecognizer:homeTap];
    [gameUIheaderIV addSubview:homeImageView];

}
//按鈕效果
-(void)homeBtnPressed{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    homeImageView.alpha = 0.7;
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDelay:0.1];
    homeImageView.alpha = 1;
    [UIView commitAnimations];
    [self.delegate modelBackToGameList];

}
//代理部分，給GameVC代理
-(void)modelBackToGameList{
    
}


@end
