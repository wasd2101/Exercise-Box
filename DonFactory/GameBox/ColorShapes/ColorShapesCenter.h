//
//  ColorShapesCenter.h
//  DonFactory
//
//  Created by Don on 2014/10/28.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "GameModelCenter.h"

@interface ColorShapesCenter : GameModelCenter{
    NSInteger tapSuccess;
    
    NSArray *shapeArray;
    NSArray *colorArray;
    NSDictionary *correctShapeToColor;
    NSDictionary *correctColorToShape;
    NSMutableArray *usedShapeAll;
    NSMutableArray *usedColorAll;
    
    NSMutableArray *twoColorShapesArray;
    
    NSString *correctShape;
    NSString *correctColor;
}

-(void)judgeShapes:(NSString *)shapeName;

@end
