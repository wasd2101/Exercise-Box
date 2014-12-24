//
//  GameListViewController.h
//  DonFactory
//
//  Created by Don on 2014/10/20.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameListCenter.h"

@interface GameListViewController : UIViewController{
    GameListCenter *gameListCenter;
    NSMutableArray *gameBox;
    UIView *gameListHeaderView;
    UIView *baseView;
    UIScrollView *gameListScrollView;
}
@end
