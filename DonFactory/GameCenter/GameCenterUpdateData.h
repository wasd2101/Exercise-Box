//
//  GameCenterUpdateData.h
//  DonFactory
//
//  Created by Don on 2014/10/21.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SqlTool.h"
@interface GameCenterUpdateData : NSObject{
    NSString *gameName;
    NSInteger gamePoint;
    NSMutableArray *gameBoxDetail;
    NSMutableArray *singleGameBoxDetail;
    SqlTool *sqlTool;
    
    NSInteger whiteBarAmt;
    NSInteger blueBarAmt;
    NSInteger yellowBarAmt;
    NSInteger goldBarAmt;

}


-(void)updateGameDataWithName:(NSString *)name point:(NSInteger)point;


@end
