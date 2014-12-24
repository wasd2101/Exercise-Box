//
//  GameUIModel.h
//  DonFactory
//
//  Created by Don on 2014/10/15.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameUIModel : UIViewController{
    UIView *gameHeaderView;
    UIView *gameBodyView;
    
    UIView *gameTipsView;
    UIView *gameTipsBodyView;
    
    CGFloat basicHeaderWidth;
    CGFloat basicHeaderHeight;
    
    CGFloat basicBodyWidth;
    CGFloat basicBodyHeight;
    
    CGFloat basicTipsWidth;
    CGFloat basicTipsHeight;
    
    CGFloat basicTipsBodyWidth;
    CGFloat basicTipsBodyHeight;
    
    UILabel *timerLabel;
    
    //變量
    NSString *gameName;
    NSNumber *gameTime;
    id UIDelegate;
    NSArray *gameDetail;
    
}

//模板化
-(void)modelInitUIWithGameName:(NSString *)name delegate:(id)delegate;
-(void)modelInitGameTips;
-(void)modelBackToGameList;
-(void)modelStartGame;//這是Tips上Start Game會調用的
-(void)modelRestartGame;

//調用
-(void)initTips;





@end
