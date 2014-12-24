//
//  ColorShapesVC.m
//  DonFactory
//
//  Created by Don on 2014/10/28.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "ColorShapesVC.h"
#import "ColorShapesPress.h"
#import "ColorShapesShape.h"

@interface ColorShapesVC ()

@end

@implementation ColorShapesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    gameName = @"ColorShapes";
    [self modelInitUIWithGameName:gameName delegate:self];
    [self initSetting];
    [self initColorShapes];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initSetting{
    pressWidth = 96;
    pressHeight = 96;
    
    shapeWidth = 96;
    shapeHeight = 96;
    
    colorShapesCenter = [[ColorShapesCenter alloc]init];
    colorShapesCenter.delegate = self;
    
    pressLayoutWidth = gameBodyView.frame.size.width;
    pressLayoutHeight = 220;

}
#pragma mark -Main
-(void)initColorShapes{
    shapesLayout =[[UIImageView alloc]init];
    shapesLayout.frame = CGRectMake(0, 0, (128+5)*2, 150);
    shapesLayout.center = CGPointMake(gameBodyView.frame.size.width/2, gameBodyView.frame.size.height - pressLayoutHeight - 150/2);
    shapesLayout.image = [[UIImage imageNamed:@"colorShapes_board.png"]stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    [gameBodyView addSubview:shapesLayout];
    
    
    //Press
    UIView *pressLayout = [[UIView alloc]init];
    pressLayout.frame = CGRectMake(0, gameBodyView.frame.size.height-pressLayoutHeight, pressLayoutWidth, pressLayoutHeight);
    pressLayout.layer.borderWidth = 2;
    [gameBodyView addSubview:pressLayout];
    
    NSArray *shapesArray = [[NSArray alloc]initWithObjects:@"Circle",@"Cloud",@"Star",@"Heart",@"Sun", nil];
    for(NSInteger i =0;i<3;i++){
        ColorShapesPress *press = [[ColorShapesPress alloc]initWithPressName:shapesArray[i] width:pressWidth height:pressHeight delegate:self];
        press.frame = CGRectMake(0, 0, pressWidth, pressHeight);
        press.center = CGPointMake(pressWidth -pressWidth/3 +pressWidth*i, 60);
        [pressLayout addSubview:press];
        
    }
    for(NSInteger i =3;i<5;i++){
        ColorShapesPress *press = [[ColorShapesPress alloc]initWithPressName:shapesArray[i] width:pressWidth height:pressHeight delegate:self];
        press.frame = CGRectMake(0, 0, pressWidth, pressHeight);
        press.center = CGPointMake(pressWidth +pressWidth*(i-3) +20, 160);
        [pressLayout addSubview:press];
    }
    
    //cover
    pressCover = [[UIView alloc]init];
    pressCover.frame = CGRectMake(0, 0, pressLayout.frame.size.width, pressLayout.frame.size.height);
    pressCover.backgroundColor = [UIColor blackColor];
    pressCover.alpha =0.8;
    [pressLayout addSubview:pressCover];
    
}


#pragma mark - model
-(void)modelInitGameTips{
    pressCover.hidden = NO;
    baseWidth = gameTipsBodyView.frame.size.width;
    NSInteger baseHeight = gameTipsBodyView.frame.size.height;
    
    UIScrollView *tipsView = [[UIScrollView alloc]init];
    tipsView.frame = CGRectMake(0, 0, baseWidth, baseHeight-30);
    tipsView.contentSize = CGSizeMake(baseWidth*3, baseHeight-30);
    tipsView.pagingEnabled = YES;
    tipsView.delegate = self;
    tipsView.showsHorizontalScrollIndicator = NO;
    
    
    
    [gameTipsBodyView addSubview:tipsView];
    
    tipsPageControl = [[UIPageControl alloc]init];
    tipsPageControl.numberOfPages =3;
    tipsPageControl.currentPage = 0;
    tipsPageControl.frame = CGRectMake(0,baseHeight-30 , baseWidth, 30);
    tipsPageControl.backgroundColor = [UIColor blackColor];
    [gameTipsBodyView addSubview:tipsPageControl];
    
    
    //tip - 1
    UIView *tips1 = [[UIView alloc]init];
    tips1.frame = CGRectMake(0, 0, baseWidth, baseHeight);
    [tipsView addSubview:tips1];
    
    UIImageView *tipsImage1 = [[UIImageView alloc]init];
    tipsImage1.frame = CGRectMake(0, 0, 254, 170);
    tipsImage1.center = CGPointMake(baseWidth/2, 170/2+10);
    tipsImage1.image = [[UIImage imageNamed:@"colorShapes_tips1.png"]stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    [tips1 addSubview:tipsImage1];
    
    UIView *view1 = [[UIView alloc]init];
    view1.frame = CGRectMake(10, 200, baseWidth-20, 40);
    view1.backgroundColor = [UIColor blackColor];
    view1.alpha = 0.7;
    view1.layer.cornerRadius = 15;
    [tips1 addSubview:view1];
    
    UILabel *label1 = [[UILabel alloc]init];
    label1.text = @"記住每個形狀的顏色";
    label1.textColor = [UIColor whiteColor];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.frame = CGRectMake(0, 0, baseWidth-20, 40);
    [view1 addSubview:label1];
    
    UIView *view2 = [[UIView alloc]init];
    view2.frame = CGRectMake(10, 250, baseWidth-20, 40);
    view2.backgroundColor = [UIColor blackColor];
    view2.alpha = 0.7;
    view2.layer.cornerRadius = 15;
    [tips1 addSubview:view2];
    
    UILabel *label2 = [[UILabel alloc]init];
    label2.text = @"比如 太陽 是 黃色";
    label2.textColor = [UIColor whiteColor];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.frame = CGRectMake(0, 0, baseWidth-20, 40);
    [view2 addSubview:label2];
    
    //tip - 2
    UIView *tips2 = [[UIView alloc]init];
    tips2.frame = CGRectMake(baseWidth, 0, baseWidth, baseHeight);
    [tipsView addSubview:tips2];

    UIImageView *tipsImage2 = [[UIImageView alloc]init];
    tipsImage2.frame = CGRectMake(0, 0, 208, 120);
    tipsImage2.center = CGPointMake(baseWidth/2, 120/2+10);
    tipsImage2.image = [[UIImage imageNamed:@"colorShapes_tips2.png"]stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    [tips2 addSubview:tipsImage2];
    
    UIView *view3 = [[UIView alloc]init];
    view3.frame = CGRectMake(10, 150, baseWidth-20, 40);
    view3.backgroundColor = [UIColor blackColor];
    view3.alpha = 0.7;
    view3.layer.cornerRadius = 15;
    [tips2 addSubview:view3];
    
    UILabel *label3 = [[UILabel alloc]init];
    label3.text = @"狀況一：圖案有正確的顏色";
    label3.textColor = [UIColor whiteColor];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.frame = CGRectMake(0, 0, baseWidth-20, 40);
    [view3 addSubview:label3];
    
    UIView *view4 = [[UIView alloc]init];
    view4.frame = CGRectMake(10, 200, baseWidth-20, 40);
    view4.backgroundColor = [UIColor blackColor];
    view4.alpha = 0.7;
    view4.layer.cornerRadius = 15;
    [tips2 addSubview:view4];
    
    UILabel *label4 = [[UILabel alloc]init];
    label4.text = @"圓圈是綠色的";
    label4.textColor = [UIColor whiteColor];
    label4.textAlignment = NSTextAlignmentCenter;
    label4.frame = CGRectMake(0, 0, baseWidth-20, 40);
    [view4 addSubview:label4];
    
    UIView *view5 = [[UIView alloc]init];
    view5.frame = CGRectMake(10, 250, baseWidth-20, 40);
    view5.backgroundColor = [UIColor blackColor];
    view5.alpha = 0.7;
    view5.layer.cornerRadius = 15;
    [tips2 addSubview:view5];
    
    UILabel *label5 = [[UILabel alloc]init];
    label5.text = @"馬上點一下 綠色圓圈";
    label5.textColor = [UIColor whiteColor];
    label5.textAlignment = NSTextAlignmentCenter;
    label5.frame = CGRectMake(0, 0, baseWidth-20, 40);
    [view5 addSubview:label5];
    
    
    //tip - 3
    UIView *tips3 = [[UIView alloc]init];
    tips3.frame = CGRectMake(baseWidth*2, 0, baseWidth, baseHeight);
    [tipsView addSubview:tips3];
    
    UIImageView *tipsImage3 = [[UIImageView alloc]init];
    tipsImage3.frame = CGRectMake(0, 0, 208, 120);
    tipsImage3.center= CGPointMake(baseWidth/2, 120/2+10);
    tipsImage3.image = [[UIImage imageNamed:@"colorShapes_tips3.png"]stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    [tips3 addSubview:tipsImage3];
    
    UIView *view6 = [[UIView alloc]init];
    view6.frame = CGRectMake(10, 150, baseWidth-20, 40);
    view6.backgroundColor = [UIColor blackColor];
    view6.alpha = 0.7;
    view6.layer.cornerRadius = 15;
    [tips3 addSubview:view6];
    
    UILabel *label6 = [[UILabel alloc]init];
    label6.text = @"狀況二：圖案的顏色都不對";
    label6.textColor = [UIColor whiteColor];
    label6.textAlignment = NSTextAlignmentCenter;
    label6.frame = CGRectMake(0, 0, baseWidth-20, 40);
    [view6 addSubview:label6];
    
    UIView *view7 = [[UIView alloc]init];
    view7.frame = CGRectMake(10, 200, baseWidth-20, 40);
    view7.backgroundColor = [UIColor blackColor];
    view7.alpha = 0.7;
    view7.layer.cornerRadius = 15;
    [tips3 addSubview:view7];
    
    UILabel *label7 = [[UILabel alloc]init];
    label7.text = @"圓圈＝綠色 ， 星星＝黑色";
    label7.textColor = [UIColor whiteColor];
    label7.textAlignment = NSTextAlignmentCenter;
    label7.frame = CGRectMake(0, 0, baseWidth-20, 40);
    [view7 addSubview:label7];
    
    UIView *view8 = [[UIView alloc]init];
    view8.frame = CGRectMake(10, 250, baseWidth-20, 40);
    view8.backgroundColor = [UIColor blackColor];
    view8.alpha = 0.7;
    view8.layer.cornerRadius = 15;
    [tips3 addSubview:view8];
    
    UILabel *label8 = [[UILabel alloc]init];
    label8.text = @"答案是 紅色的愛心";
    label8.textColor = [UIColor whiteColor];
    label8.textAlignment = NSTextAlignmentCenter;
    label8.frame = CGRectMake(0, 0, baseWidth-20, 40);
    [view8 addSubview:label8];

    
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int current = scrollView.contentOffset.x/baseWidth;
    tipsPageControl.currentPage = current;
}

-(void)modelBackToGameList{
    [colorShapesCenter centerEndGame];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)modelStartGame{
    pressCover.hidden = YES;
    [gameTipsView removeFromSuperview];
    [colorShapesCenter centerStartGame];
}


-(void)modelRestartGame{
    timerLabel.text = [NSString stringWithFormat:@"剩下%@秒",gameTime];
    [colorShapesCenter centerEndGame];
    [self initTips];
    [self modelInitGameTips];
    
}

#pragma mark - Delegate
-(void)pressedGotPressName:(NSString *)name{
    [colorShapesCenter judgeShapes:name];
}

-(void)refreshFinishedGameWithTap:(NSInteger)tap{
    NSNumber *successCount = [NSNumber numberWithInteger:tap];
    NSString *finishedMsg = [NSString stringWithFormat:@"你共滑對了 %@ 次",successCount];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"遊戲結束" message:finishedMsg delegate:self cancelButtonTitle:@"再來一次" otherButtonTitles:@"休息咯", nil];
    [alertView show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex ==0){
        [self refreshShapeLayout];
        [self modelRestartGame];
    }else if(buttonIndex ==1){
        [self modelBackToGameList];
    }
}


-(void)refreshTwoCards:(NSMutableArray *)array{
    NSInteger pos = 0;
    for(NSDictionary *obj in array){
        NSString *shapeName = [[NSString stringWithString:[obj objectForKey:@"Shape"]]lowercaseString];
        NSString *colorName = [[NSString stringWithString:[obj objectForKey:@"Color"]]lowercaseString];
        ColorShapesShape *shape = [[ColorShapesShape alloc]initShapeWithWidth:shapeWidth height:shapeHeight shapeName:shapeName colorName:colorName];
        shape.frame = CGRectMake(shapeWidth/2 +(shapeWidth+20)*pos -20, 10, shapeWidth, shapeHeight);
        [shapesLayout addSubview:shape];
        pos +=1;
    }
}
-(void)refreshShapeLayout{
    for(UIView *obj in [shapesLayout subviews]){
        [obj removeFromSuperview];
    }
}


@end
