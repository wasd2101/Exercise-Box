//
//  NextDropUmbrella.h
//  DonFactory
//
//  Created by Don on 2014/11/3.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NextDropUmbrella : UIView{
    NSInteger umbrellaWidth;
    NSInteger umbrellaHeight;
    NSString *umbrellaColor;
    
}


@property id umbrellaDelegate;
-(id)initWithWidth:(NSInteger)width height:(NSInteger)height color:(NSString *)color delegate:(id)delegate;

@end
