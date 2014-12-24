//
//  ColorShapesShape.h
//  DonFactory
//
//  Created by Don on 2014/10/29.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorShapesShape : UIView{
    NSInteger shapeWidth;
    NSInteger shapeHeight;
    NSMutableString *shapeName;
    NSMutableString *shapeColor;
}
-(id)initShapeWithWidth:(NSInteger)width height:(NSInteger)height shapeName:(NSString *)name colorName:(NSString *)color;
@end
