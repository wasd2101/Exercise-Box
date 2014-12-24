//
//  LeftRightBlock.h
//  DonFactory
//
//  Created by Don on 2014/10/30.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftRightBlock : UIView{
    NSInteger blockWidth;
    NSInteger blockHeight;

    
}

@property NSString *blockPos;
@property NSInteger blockLevel;
-(void)setTimerRemoveSelf:(NSInteger)time;
-(id)initWithWidth:(NSInteger)width height:(NSInteger)height pos:(NSString *)pos level:(NSInteger)level;

@end
