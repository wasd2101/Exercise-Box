//
//  LeftRightVC.h
//  DonFactory
//
//  Created by Don on 2014/10/30.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "GameUIModel.h"
#import "LeftRightCenter.h"
#import <AVFoundation/AVFoundation.h>
@interface LeftRightVC : GameUIModel{
    LeftRightCenter *leftRightCenter;
    
    NSInteger pressWidth;
    NSInteger pressHeight;
    
    UIView *leftPress;
    UIView *rightPress;
    UIView *pressCover;
    
    NSInteger blockWidth;
    NSInteger blockHeight;
    
    UIImageView *car;
    NSInteger carWidth;
    NSInteger carHeight;
    NSInteger carCenterX;
    NSInteger carCenterY;
    
    NSMutableArray *blockArray;
    
    UIView *roadView;
    NSMutableArray *leftCenterPos;
    NSMutableArray *rightCenterPos;
    
    NSInteger roadWidth;
    NSInteger roadHeight;
    
    AVAudioPlayer *audioPlayer;
    
}

@end
