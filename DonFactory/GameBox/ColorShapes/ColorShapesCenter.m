//
//  ColorShapesCenter.m
//  DonFactory
//
//  Created by Don on 2014/10/28.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "ColorShapesCenter.h"

@implementation ColorShapesCenter
-(void)initGame{
    gameName = @"ColorShapes";
    tapSuccess = 0;
    [self initColorShapes];
    [self randomColorShapes];    
}

-(void)initColorShapes{
    shapeArray = [[NSArray alloc]initWithObjects:@"Circle",@"Cloud",@"Heart",@"Star",@"Sun", nil];
    colorArray = [[NSArray alloc]initWithObjects:@"Green",@"Blue",@"Red",@"Black",@"Yellow", nil];
    correctShapeToColor = [[NSDictionary alloc]initWithObjects:colorArray forKeys:shapeArray];
    correctColorToShape = [[NSDictionary alloc]initWithObjects:shapeArray forKeys:colorArray];
}

-(void)centerFinishedGame{
    gameFinishedPoint = tapSuccess;
    [self centerEndGame];
    [self centerUpdateGameData];
    [self.delegate refreshFinishedGameWithTap:gameFinishedPoint];
}

#pragma mark - random
-(void)randomColorShapes{
    [self.delegate refreshShapeLayout];
    usedShapeAll = [[NSMutableArray alloc]init];
    usedColorAll = [[NSMutableArray alloc]init];
    twoColorShapesArray = [[NSMutableArray alloc]init];
    
    //0代表答案出現在場上，1代表答案不在場上
    NSInteger randomMode = arc4random()%2;
    if(randomMode ==0){
        [self randomMode1];
    }else if(randomMode ==1){
        [self randomMode2];
    }
    
}

//mode1->場上有一張顏色和形狀都正確的牌
-(void)randomMode1{
    //先挑出一個形狀和顏色都正確的。
    correctShape = [NSString stringWithString:[self randomShapes]];
    correctColor = [NSString stringWithString:[correctShapeToColor objectForKey:correctShape]];
    [usedColorAll addObject:correctColor];
    
    //加到場上
    [twoColorShapesArray addObject:@{@"Shape":correctShape,@"Color":correctColor}];
    
    NSString *errorShape = [NSString stringWithString:[self randomShapes]];
    NSString *correctColor2= [correctShapeToColor objectForKey:errorShape];
    [usedColorAll addObject:correctColor2];
    
    NSString *errorColor = [self randomColor];
    [twoColorShapesArray addObject:@{@"Shape":errorShape,@"Color":errorColor}];
    [self.delegate refreshTwoCards:twoColorShapesArray];
}

-(void)randomMode2{
    //先挑出一個形狀和顏色都正確的。
    correctShape = [NSString stringWithString:[self randomShapes]];
    correctColor = [NSString stringWithString:[correctShapeToColor objectForKey:correctShape]];
    [usedColorAll addObject:correctColor];
    
    NSString *errorShape1 = [NSString stringWithString:[self randomShapes]];
    NSString *correctColor1 = [NSString stringWithString:[correctShapeToColor objectForKey:errorShape1]];
    [usedColorAll addObject:correctColor1];

    NSString *errorShape2 = [NSString stringWithString:[self randomShapes]];
    NSString *correctColor2 = [NSString stringWithString:[correctShapeToColor objectForKey:errorShape2]];
    [usedColorAll addObject:correctColor2];
    
    NSString *errorColor1 = [self randomColor];
    NSString *errorColor2 = [self randomColor];
    
    [twoColorShapesArray addObject:@{@"Shape":errorShape1,@"Color":errorColor1}];
    [twoColorShapesArray addObject:@{@"Shape":errorShape2,@"Color":errorColor2}];
    [self.delegate refreshTwoCards:twoColorShapesArray];
}

-(NSMutableString *)randomShapes{
    NSInteger flag = 0;
    NSMutableString *randomShapeStr = [[NSMutableString alloc]init];
    while(flag==0){
        NSInteger randomInt = arc4random()%5;
        if([usedShapeAll containsObject:shapeArray[randomInt]]){
            
        }else{
            randomShapeStr = [NSMutableString stringWithString:shapeArray[randomInt]];
            [usedShapeAll addObject:randomShapeStr];
            flag =1;
        }
        
    }
    return randomShapeStr;
}

-(NSMutableString *)randomColor{
    NSInteger flag = 0;
    NSMutableString *randomColorStr = [[NSMutableString alloc]init];
    while(flag==0){
        NSInteger randomInt = arc4random()%5;
        if([usedColorAll containsObject:colorArray[randomInt]]){
            
        }else{
            randomColorStr = [NSMutableString stringWithString:colorArray[randomInt]];
            [usedColorAll addObject:randomColorStr];
            flag =1;
        }
        
    }
    return randomColorStr;
}
#pragma mark - judge
-(void)judgeShapes:(NSString *)shapeName{
    if([correctShape isEqualToString:shapeName]){
        [self judgeCorrect];
    }else{
        [self judgeError];
    }
}

-(void)judgeCorrect{
    tapSuccess +=1;
    [self randomColorShapes];
}

-(void)judgeError{
    [self centerFinishedGame];
}


#pragma mark - Delegate;
-(void)refreshTwoCards:(NSMutableArray *)array{
    
}
-(void)refreshShapeLayout{
    
}
-(void)refreshFinishedGameWithTap:(NSInteger)tap{
    
}


@end
