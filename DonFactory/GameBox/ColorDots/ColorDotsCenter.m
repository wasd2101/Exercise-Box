//
//  ColorDotsCenter.m
//  DonFactory
//
//  Created by Don on 2014/10/28.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "ColorDotsCenter.h"

@implementation ColorDotsCenter

-(void)initGame{
    gameName = @"ColorDots";
    tapSuccess = 0;
    colorDotsAmt = 4;
    dotPos = 0;
    [self randomColor];
}

-(void)centerFinishedGame{
    gameFinishedPoint = tapSuccess;
    [self centerEndGame];
    [self centerUpdateGameData];
    [self.delegate refreshFinishedGameWithTap:gameFinishedPoint];
}

-(void)randomColor{
    dotPos =0;
    //dots
    colorArray = [[NSMutableArray alloc]init];
    for(NSInteger i=0;i<colorDotsAmt;i++){
        NSMutableString *colorStr = [[NSMutableString alloc]init];
        NSInteger m = arc4random()%4;
        switch (m) {
            case 0:
                colorStr = [NSMutableString stringWithString:@"Red"];
                break;
            case 1:
                colorStr = [NSMutableString stringWithString:@"Yellow"];
                break;
            case 2:
                colorStr = [NSMutableString stringWithString:@"Blue"];
                break;
            case 3:
                colorStr = [NSMutableString stringWithString:@"Green"];
                break;
            default:
                break;
        }
        [colorArray addObject:colorStr];
    }
    
    //indicator
    NSInteger randomIndicatorColor = arc4random()%2;
    if(randomIndicatorColor ==0){
        indicatorColor = [NSMutableString stringWithString:@"Blue"];
    }else if(randomIndicatorColor ==1){
        indicatorColor = [NSMutableString stringWithString:@"Red"];
    }
    

    [self.delegate refreshColorDotsBar:colorArray indicatorColor:indicatorColor];
}

-(void)judgeTapWithColorName:(NSString *)color{
    if([indicatorColor isEqualToString:@"Blue"]){
        if([colorArray[dotPos]isEqualToString:color]){
            [self tapSuccess];
        }else{
            [self tapFail];
        }
    }else if([indicatorColor isEqualToString:@"Red"]){
        if([colorArray[colorDotsAmt-1 -dotPos]isEqualToString:color]){
            [self tapSuccess];
        }else{
            [self tapFail];
        }
    }
}

-(void)tapSuccess{
    if([indicatorColor isEqualToString:@"Blue"]){
        [self.delegate tapSuccessForVCWithPosition:dotPos];
    }else if([indicatorColor isEqualToString:@"Red"]){
        [self.delegate tapSuccessForVCWithPosition:colorDotsAmt-1 - dotPos];
    }
        dotPos +=1;
    if(dotPos ==colorDotsAmt){
        [self cleanGameBoard];
        [self randomColor];
        tapSuccess +=1;
    }

}

-(void)tapFail{
    [self.delegate cleanGameBoard];
    [self centerFinishedGame];
}

#pragma mark - Delegate
-(void)refreshColorDotsBar:(NSMutableArray *)array indicatorColor:(NSString *)color{
    
}

-(void)refreshFinishedGameWithTap:(NSInteger)tap{
    
}

-(void)cleanGameBoard{
    
}
-(void)tapSuccessForVCWithPosition:(NSInteger)position{
    
}
@end
