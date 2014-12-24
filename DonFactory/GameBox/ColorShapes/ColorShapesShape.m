//
//  ColorShapesShape.m
//  DonFactory
//
//  Created by Don on 2014/10/29.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "ColorShapesShape.h"

@implementation ColorShapesShape

-(id)initShapeWithWidth:(NSInteger)width height:(NSInteger)height shapeName:(NSString *)name colorName:(NSString *)color{
    self = [super init];
    if(self){
        shapeWidth = width;
        shapeHeight = height;
        shapeName = [[NSMutableString alloc]initWithString:name];
        shapeColor = [[NSMutableString alloc]initWithString:color];
        [self initShape];
    }
    return self;
}

-(void)initShape{
    self.frame = CGRectMake(0, 0, shapeWidth, shapeHeight);
    NSString *imageName = [[NSString alloc]initWithFormat:@"colorShapes_%@_%@.png",shapeName,shapeColor];
    UIImageView *shapeBackground = [[UIImageView alloc]init];
    shapeBackground.image = [[UIImage imageNamed:imageName]stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    shapeBackground.frame = CGRectMake(0, 0, shapeWidth, shapeHeight);
    [self addSubview:shapeBackground];
}

@end
