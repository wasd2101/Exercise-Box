//
//  WhichWayCenter.m
//  DonFactory
//
//  Created by Don on 2014/10/24.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "WhichWayCenter.h"


@implementation WhichWayCenter
-(void)initGame{
    gameName = @"WhichWay";
    
    blockDirectionStr = [[NSMutableString alloc]init];
    swipeSuccess = 0;
    [self randomBlock];
}

-(void)centerFinishedGame{
    gameFinishedPoint = swipeSuccess;
    [self centerEndGame];
    [self centerUpdateGameData];
    [self.delegate refreshFinishedGameWithSwipe:gameFinishedPoint];
}

#pragma mark -遊戲主體
-(void)swipeDirection:(NSString *)direction{
    wayArray = [[NSArray alloc]initWithObjects:@"Up",@"Right",@"Down",@"Left",@"LeftRight", nil];
    opsiteWayArray = [[NSArray alloc]initWithObjects:@"Down",@"Left",@"Up",@"Right",@"LeftRight", nil];
    NSString *wayStr =[wayArray objectAtIndex:blockDirectionInt];
    
    
    //先判斷是否為LeftRight
    if(blockDirectionInt ==4){
        //判斷是否為正向圖片，即綠色的
        if(swipeOpp ==0){
            if([direction isEqualToString:@"Right"]|[direction isEqualToString:@"Left"]){
                [self swipeSuccess];
            }else {
                [self swipeFail];
            }
        }else if(swipeOpp ==1){
            if([direction isEqualToString:@"Up"]|[direction isEqualToString:@"Down"]){
                [self swipeSuccess];
            }else{
                [self swipeFail];
            }
        }
    }else{
        //其他四種方向的判斷
        if(swipeOpp ==0){
            if([direction isEqualToString:wayStr]){
                [self swipeSuccess];
            }else{
                [self swipeFail];
            }
        }else if(swipeOpp ==1){
            if([direction isEqualToString:opsiteWayArray[blockDirectionInt]]){
                [self swipeSuccess];
            }else{
                [self swipeFail];
            }
        }
    }
}

-(void)swipeSuccess{
    [self randomBlock];
    swipeSuccess +=1;
}

-(void)swipeFail{
    [self centerFinishedGame];
}

-(void)randomBlock{
    blockDirectionInt = arc4random()%5;
    swipeOpp = arc4random()%2;

    switch (blockDirectionInt) {
        case 0:
            blockDirectionStr =[NSMutableString stringWithString:@"Up"];
            break;
        case 1:
            blockDirectionStr =[NSMutableString stringWithString:@"Right"];
            break;
        case 2:
            blockDirectionStr =[NSMutableString stringWithString:@"Down"];
            break;
        case 3:
            blockDirectionStr =[NSMutableString stringWithString:@"Left"];
            break;
        case 4:
            blockDirectionStr = [NSMutableString stringWithString:@"LeftRight"];
        default:
            break;
    }
    [self.delegate refreshBlockWithDirection:blockDirectionStr opssite:swipeOpp];
    
}

//代理
-(void)refreshBlockWithDirection:(NSString *)dir opssite:(NSInteger)opp{
    
}

-(void)refreshFinishedGameWithSwipe:(NSInteger)swipeSuccess{
    
}
@end
