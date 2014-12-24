//
//  MainViewController.h
//  DonFactory
//
//  Created by Don on 2014/10/20.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UITabBarController{
    UIImageView *tabBarView;
    UIImageView *homeTab;
    UIImageView *infoTab;
    UIImageView *settingTab;
    
    UIView *gameListHeaderView;
    NSMutableString *screenName;
    
    UILabel *headerLabel;
}


+(MainViewController *)shareMVC;
-(void)refreshMVC;

@end
