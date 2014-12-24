//
//  GameListBarModel.m
//  DonFactory
//
//  Created by Don on 2014/10/20.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "GameListBarModel.h"
#import "UIColor+DonColor.h"

@implementation GameListBarModel

-(id)initGameListBarWithGameDic:(NSDictionary *)gameDic{
    self = [super init];
    if(self){
        _gameName= [NSString stringWithString:[gameDic objectForKey:@"gameName"]];
        currentBarType= [NSString stringWithString:[gameDic objectForKey:@"currentBarType"]];
        currentPoint = [gameDic objectForKey:@"currentPoint"];
        barLimitPoint = [gameDic objectForKey:@"barLimitPoint"];
        unLockState = [[gameDic objectForKey:@"unLockState"]integerValue];
        currentPlayedCount = [gameDic objectForKey:@"playedCount"];
        unLockBarType = [NSString stringWithString:[gameDic objectForKey:@"unLockBarType"]];
        unLockBarPoint = [gameDic objectForKey:@"unLockBarPoint"];
        
        _barWidth = 310*WidthChangedRate;
        _barHeight = 60;
        [self initIconString];
        [self changeBarType];
        [self changeGameName];
        [self initGameListBar];
    }
    return self;
}

#pragma mark - Bar
-(void)initGameListBar{
    self.frame = CGRectMake(0, 0, _barWidth, _barHeight);

    [self initBarBody];
    [self initBarBackgroundWithBarType];
    [self judgeIsunLock];//鎖要蓋在最上層，最後執行。
}

-(void)initBarBody{
    self.layer.cornerRadius = 15;
    
    //遊戲名稱
    UIButton *btn = [[UIButton alloc]init];
    btn.frame = CGRectMake(0, 5, _barWidth, 40);
    btn.titleLabel.font = [UIFont systemFontOfSize:30];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:changedGameName forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnTouched) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    //遊戲圖標
    UIImageView *gameImg = [[UIImageView alloc]init];
    gameImg.frame = CGRectMake(0, 0, 36, 36);
    gameImg.center = CGPointMake(_barWidth/2 +20, 22);
    gameImg.layer.cornerRadius = 10;
    gameImg.image = [UIImage imageNamed:iconString];
    gameImg.backgroundColor = [UIColor whiteColor];
    gameImg.alpha = 0.9;
    [self addSubview:gameImg];
    
    //進度條
    CGFloat progressFloat = [currentPoint floatValue]/[barLimitPoint floatValue];
    UIProgressView *progressView = [[UIProgressView alloc]init];
    progressView.frame = CGRectMake(10, 45, _barWidth-120, 150);
    progressView.progressViewStyle = UIProgressViewStyleDefault;
    progressView.trackTintColor = [UIColor blackColor];
    progressView.progressTintColor = [UIColor redColor];
    [progressView setProgress:progressFloat animated:1];
    [self addSubview:progressView];
    
    //右側
    UILabel *processLabel = [[UILabel alloc]init];
    processLabel.frame = CGRectMake(_barWidth-85, 0, 85, 30);
    processLabel.text = [NSString stringWithFormat:@"%@ / %@",currentPoint,barLimitPoint];
    [self addSubview:processLabel];
    
    UILabel *playedCountLabel = [[UILabel alloc]init];
    playedCountLabel.frame = CGRectMake(_barWidth-100,30,100,30);
    playedCountLabel.text = [NSString stringWithFormat:@"玩了 %@ 次",currentPlayedCount];
    playedCountLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:playedCountLabel];
    
}

-(void)initBarBackgroundWithBarType{
    if([currentBarType isEqualToString:@"White Bar"]){
        self.backgroundColor = [UIColor donRed];
    }else if([currentBarType isEqualToString:@"Blue Bar"]){
        self.backgroundColor = [UIColor donYellow];
    }else if([currentBarType isEqualToString:@"Yellow Bar"]){
        self.backgroundColor = [UIColor donBlue];
    }else if([currentBarType isEqualToString:@"Gold Bar"]){
        self.backgroundColor = [UIColor donGreen];
    }
}
#pragma mark - Lock
-(void)judgeIsunLock{
    
    UIView *lockView = [[UIView alloc]init];
    lockView.frame = CGRectMake(0, 0, _barWidth, _barHeight);
    lockView.layer.cornerRadius = 15;
    lockView.backgroundColor = [UIColor blackColor];
    lockView.alpha = 0.9;
    
    UIImageView *lockImageView = [[UIImageView alloc]init];
    lockImageView.frame = CGRectMake(0, 0, 48, 48);
    lockImageView.center = CGPointMake(30, _barHeight/2);
    lockImageView.image = [UIImage imageNamed:@"gameListLock.png"];
    [lockView addSubview:lockImageView];
    
    UILabel *lockBarDetailLabel = [[UILabel alloc]init];
    lockBarDetailLabel.text = [NSString stringWithFormat:@"需要 %@ 個遊戲達到 %@ 以上",unLockBarPoint,changedBarType];
    lockBarDetailLabel.textColor = [UIColor whiteColor];
    lockBarDetailLabel.frame = CGRectMake(0, 0, _barWidth, _barHeight);
    lockBarDetailLabel.center = CGPointMake(_barWidth/2+20, _barHeight/2);
    lockBarDetailLabel.textAlignment = NSTextAlignmentCenter;
    [lockView addSubview:lockBarDetailLabel];
    
    if(unLockState ==0){
        [self addSubview:lockView];
    }
}

-(void)changeBarType{
    changedBarType = [[NSMutableString alloc]init];
    if([unLockBarType isEqualToString:@"White Bar"]){
        changedBarType = [NSMutableString stringWithString:@"紅色"];
    }else if([unLockBarType isEqualToString:@"Blue Bar"]){
        changedBarType = [NSMutableString stringWithString:@"黃色"];
    }else if([unLockBarType isEqualToString:@"Yellow Bar"]){
        changedBarType = [NSMutableString stringWithString:@"藍色"];
    }else if([unLockBarType isEqualToString:@"Gold Bar"]){
        changedBarType = [NSMutableString stringWithString:@"綠色"];
    }
    
}
-(void)changeGameName{
    changedGameName = [[NSMutableString alloc]init];
    if([_gameName isEqualToString:@"UpDown"]){
        changedGameName = [NSMutableString stringWithString:@"上上下下"];
    }else if([_gameName isEqualToString:@"WhichWay"]){
        changedGameName = [NSMutableString stringWithString:@"往哪一邊"];
    }else if([_gameName isEqualToString:@"TapTap"]){
        changedGameName = [NSMutableString stringWithString:@"只點四下"];
    }else if([_gameName isEqualToString:@"ColorDots"]){
        changedGameName = [NSMutableString stringWithString:@"彩色豆子"];
    }else if([_gameName isEqualToString:@"NextDrop"]){
        changedGameName = [NSMutableString stringWithString:@"哪邊滴水"];
    }else if([_gameName isEqualToString:@"NextBox"]){
        changedGameName = [NSMutableString stringWithString:@"彩色箱子"];
    }else if([_gameName isEqualToString:@"LeftRight"]){
        changedGameName = [NSMutableString stringWithString:@"引擎全開"];
    }else if([_gameName isEqualToString:@"ColorShapes"]){
        changedGameName = [NSMutableString stringWithString:@"彩色圖型"];
    }else if([_gameName isEqualToString:@"OnOff"]){
        changedGameName = [NSMutableString stringWithString:@"開還是關"];
    }
}
-(void)initIconString{
    iconString = [[NSMutableString alloc]init];
    iconString = [NSMutableString stringWithFormat:@"gameIcon_%@.png",[_gameName lowercaseString]];
}

-(void)btnTouched{
    [self.delegate barTouched:self];
}

//代理
-(void)barTouched:(GameListBarModel *)model{
    
}

@end
