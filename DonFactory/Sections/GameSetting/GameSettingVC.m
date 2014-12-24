//
//  GameSettingVC.m
//  DonFactory
//
//  Created by Don on 2014/11/4.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "GameSettingVC.h"
#import "GameSettingBar.h"
#import "UIColor+DonColor.h"

@interface GameSettingVC ()

@end

@implementation GameSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSetting];
    [self initGameSetting];
    [self initContent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initSetting{
    barX = 20;
    barWidth = 290 *WidthChangedRate;
    barHeight = 40;

}

-(void)initGameSetting{
    self.view = baseView;
    baseView = [[UIView alloc]init];
    baseView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gameBackground02.jpeg"]];
    
    mainView = [[UIScrollView alloc]init];
    mainView.frame = CGRectMake(0, 66, ScreenWidth, ScreenHeight-115);
    mainView.layer.borderColor = [[UIColor redColor]CGColor];
    mainView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight-90);
    [baseView addSubview:mainView];
    
}

-(void)initContent{
    
    //Level
    NSString *levelStr = @"訓練難度分為：";
    GameSettingBar *levelBar = [[GameSettingBar alloc]initWithString:levelStr width:150 height:barHeight];
    levelBar.frame = CGRectMake(barX, 30, barWidth, barHeight);
    [mainView addSubview:levelBar];
    
    
    NSArray *colorArray = [NSArray arrayWithObjects:[UIColor donRed],[UIColor donYellow],[UIColor donBlue],[UIColor donGreen], nil];
    for (NSInteger i = 0; i<4; i++) {
        UIView *levelBar = [[UIView alloc]init];
        levelBar.frame = CGRectMake(160 +35*i, 32, 32, 32);
        levelBar.backgroundColor = colorArray[i];
        levelBar.layer.cornerRadius = 15;
        [mainView addSubview:levelBar];
    }
    
    
    
    NSString *str1 = @"教練：Don Chen (作者XD)";
    NSString *str2 = @"";
    NSString *str3 = @"";
    
    NSString *str10 = @"Contact me:";
    NSString *str11 = @"www.00don.com";
    NSString *str12 = @"idon.chen@gmail.com";
    NSString *str13 = @"www.github.com/slamdon";
    
    NSArray *strArray = [NSArray arrayWithObjects:str1,str2,str3,str10,str11,str12,str13, nil];
    
    for(NSInteger i=0;i<[strArray count];i++){
        GameSettingBar *bar = [[GameSettingBar alloc]initWithString:strArray[i] width:barWidth height:barHeight];
        bar.frame = CGRectMake(barX, 80+50*i, barWidth, barHeight);
        [mainView addSubview:bar];
    }
}

@end
