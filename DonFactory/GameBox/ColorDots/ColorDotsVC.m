//
//  ColorDotsVC.m
//  DonFactory
//
//  Created by Don on 2014/10/28.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "ColorDotsVC.h"
#import "ColorDotsPress.h"
#import "UIColor+DonColor.h"


@interface ColorDotsVC ()

@end

@implementation ColorDotsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    gameName = @"ColorDots";
    
    colorDotsCenter = [[ColorDotsCenter alloc]init];
    colorDotsCenter.delegate = self;
    [self modelInitUIWithGameName:gameName delegate:self];
    [self initPresses];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - ColorDots Main
-(void)initColorDotsBarLayoutWithColorArray:(NSMutableArray *)array indicatorColor:(NSString *)color{
    //dots
    colorDotsBarLayout = [[UIView alloc]init];
    colorDotsBarLayout.frame = CGRectMake(0, 0, 160, 40);
    colorDotsBarLayout.center = CGPointMake(gameBodyView.frame.size.width/2, gameBodyView.frame.size.height/2);
    colorDotsBarLayout.layer.borderWidth = 2;
    [gameBodyView addSubview:colorDotsBarLayout];
    
    colorDotsBar = [[ColorDotsBar alloc]initBarWithColorArray:array];
    colorDotsBar.frame = CGRectMake(0, 0, 45*4, 40);
    [colorDotsBarLayout addSubview:colorDotsBar];
    
    
    //indicator
    colorIndicator = [[UIView alloc]init];
    colorIndicator.frame = CGRectMake(0, 0, colorDotsBarLayout.frame.size.width+10, 10);
    colorIndicator.center = CGPointMake(gameBodyView.frame.size.width/2, gameBodyView.frame.size.height/2+30);
    colorIndicator.layer.cornerRadius = 5;
    if([color isEqualToString:@"Blue"]){
        colorIndicator.backgroundColor = [UIColor donBlue];
    }else if([color isEqualToString:@"Red"]){
        colorIndicator.backgroundColor = [UIColor donRed];
    }
    [gameBodyView addSubview:colorIndicator];
}

-(void)initPresses{
    NSInteger pressWidth = 80;
    NSInteger pressHeight = 80;

    ColorDotsPress *pressRed = [[ColorDotsPress alloc]initWithColor:@"Red" width:pressWidth height:pressHeight delegate:self];
    ColorDotsPress *pressYellow = [[ColorDotsPress alloc]initWithColor:@"Yellow" width:pressWidth height:pressHeight delegate:self];
    ColorDotsPress *pressBlue = [[ColorDotsPress alloc]initWithColor:@"Blue" width:pressWidth height:pressHeight delegate:self];
    ColorDotsPress *pressGreen = [[ColorDotsPress alloc]initWithColor:@"Green" width:pressWidth height:pressHeight delegate:self];
    NSArray *pressArray = [[NSArray alloc]initWithObjects:pressRed,pressYellow,pressBlue,pressGreen, nil];
    for(NSInteger i=0;i<4;i++){
        ColorDotsPress *press = pressArray[i];
        press.frame = CGRectMake(pressWidth*i, gameBodyView.frame.size.height-pressHeight, pressWidth, pressHeight);
        [gameBodyView addSubview:press];
    }
    //cover
    pressCover = [[UIView alloc]init];
    pressCover.frame = CGRectMake(0, gameBodyView.frame.size.height-pressHeight, gameBodyView.frame.size.width, pressHeight);
    pressCover.backgroundColor = [UIColor blackColor];
    pressCover.alpha =0.8;
    [gameBodyView addSubview:pressCover];
}

#pragma mark - model
-(void)modelInitGameTips{
    pressCover.hidden = NO;

    NSInteger baseWidth = gameTipsBodyView.frame.size.width;
    
    //tip1
    UIImageView *image1 = [[UIImageView alloc]init];
    image1.image = [UIImage imageNamed:@"colorDots_tips1.png"];
    image1.frame = CGRectMake(0, 0, 173, 66);
    image1.center = CGPointMake(baseWidth/2, 50*HeightChangedRate);
    [gameTipsBodyView addSubview:image1];
    

    UIView *view1 = [[UIView alloc]init];
    view1.frame = CGRectMake(10, 100*HeightChangedRate, baseWidth-20, 40);
    view1.backgroundColor = [UIColor blackColor];
    view1.alpha = 0.7;
    view1.layer.cornerRadius = 15;
    [gameTipsBodyView addSubview:view1];
    
    UILabel *label1 = [[UILabel alloc]init];
    label1.text = @"橫條為藍色，從左邊開始點";
    label1.textColor = [UIColor whiteColor];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.frame = CGRectMake(0, 0, baseWidth-20, 40);
    [view1 addSubview:label1];
    
    //tip2
    UIImageView *image2 = [[UIImageView alloc]init];
    image2.frame = CGRectMake(0, 0, 173, 66);
    image2.image = [UIImage imageNamed:@"colorDots_tips2.png"];
    image2.center = CGPointMake(baseWidth/2, 200*HeightChangedRate);
    [gameTipsBodyView addSubview:image2];

    UIView *view2 = [[UIView alloc]init];
    view2.frame = CGRectMake(10, 250*HeightChangedRate, baseWidth-20, 40);
    view2.backgroundColor = [UIColor blackColor];
    view2.alpha = 0.7;
    view2.layer.cornerRadius = 15;
    [gameTipsBodyView addSubview:view2];
    
    UILabel *label2 = [[UILabel alloc]init];
    label2.text = @"橫條為紅色，從右邊開始點";
    label2.textColor = [UIColor whiteColor];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.frame = CGRectMake(0, 0, baseWidth-20, 40);
    [view2 addSubview:label2];

    
    
}

-(void)modelBackToGameList{
    [colorDotsCenter centerEndGame];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)modelStartGame{
    pressCover.hidden =YES;
    [gameTipsView removeFromSuperview];
    [colorDotsCenter centerStartGame];
}


-(void)modelRestartGame{
    timerLabel.text = [NSString stringWithFormat:@"剩下%@秒",gameTime];
    [colorDotsCenter centerEndGame];
    [self initTips];
    [self modelInitGameTips];
    
}

#pragma mark - Delegate
-(void)refreshColorDotsBar:(NSMutableArray *)array indicatorColor:(NSString *)color{
    [self initColorDotsBarLayoutWithColorArray:array indicatorColor:color];
}

-(void)refreshFinishedGameWithTap:(NSInteger)tap{
    NSNumber *successCount = [NSNumber numberWithInteger:tap];
    NSString *finishedMsg = [NSString stringWithFormat:@"你共滑對了 %@ 次",successCount];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"遊戲結束" message:finishedMsg delegate:self cancelButtonTitle:@"再來一次" otherButtonTitles:@"休息咯", nil];
    [alertView show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex ==0){
        [self modelRestartGame];
        [self cleanGameBoard];
    }else if(buttonIndex ==1){
        [self modelBackToGameList];
    }
}

-(void)cleanGameBoard{
    NSMutableArray *subviews = [[NSMutableArray alloc]initWithArray:[colorDotsBarLayout subviews]];
    for(UIView *obj in subviews){
        [obj removeFromSuperview];
    }
    NSMutableArray *subviews2 = [[NSMutableArray alloc]initWithArray:[colorIndicator subviews]];
    for(UIView *obj in subviews2){
        [obj removeFromSuperview];
    }
}
-(void)pressedWithColorName:(NSString *)colorName{
    [colorDotsCenter judgeTapWithColorName:colorName];
}
-(void)tapSuccessForVCWithPosition:(NSInteger)position{
    [colorDotsBar setRemoveDotsWithPosition:position];
}
@end
