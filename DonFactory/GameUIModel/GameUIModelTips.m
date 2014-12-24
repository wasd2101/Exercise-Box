//
//  GameUIModelTips.m
//  DonFactory
//
//  Created by Don on 2014/10/21.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "GameUIModelTips.h"

@implementation GameUIModelTips
-(id)initWithDelegate:(id)tipsDelegate width:(NSInteger)width height:(CGFloat)height{
    self =[super init];
    if(self){
        _delegate = tipsDelegate;
        
        basicTipsWidth = width;
        basicTipsHeight = height;
        
        [self initTips];
        [self initTipsStartBtn];
    }
    return self;
}

-(void)initTips{
    self.frame = CGRectMake(0, 0, basicTipsWidth,  basicTipsHeight);
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 20;
    self.layer.borderColor = [[UIColor yellowColor]CGColor];
    self.layer.borderWidth = 2;
    
    tipsHeader = [[UIView alloc]init];
    tipsHeader.frame = CGRectMake(0, 0, basicTipsWidth, 40);
    tipsHeader.backgroundColor = [UIColor blackColor];
    tipsHeader.layer.cornerRadius = 20;
    [self addSubview:tipsHeader];
    
    UILabel *headerLabel =[[UILabel alloc]init];
    headerLabel.text =@"怎麼玩";
    headerLabel.font =[UIFont systemFontOfSize:20];
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.frame = CGRectMake(0, 0, tipsHeader.frame.size.width, tipsHeader.frame.size.height);
    headerLabel.textAlignment = NSTextAlignmentCenter;
    [tipsHeader addSubview:headerLabel];
    
}



-(void)initTipsStartBtn{
    tipsStartBtn = [[UIButton alloc]init];
    tipsStartBtn.frame = CGRectMake(0, basicTipsHeight-52, basicTipsWidth, 50);
    tipsStartBtn.layer.cornerRadius = 17;
    tipsStartBtn.backgroundColor = [UIColor purpleColor];
    [tipsStartBtn setTitle:@"開始遊戲" forState:UIControlStateNormal];
    [tipsStartBtn addTarget:self.delegate action:@selector(modelStartGame) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:tipsStartBtn];
}

//代理部分
-(void)modelStartGame{
    
}

@end
