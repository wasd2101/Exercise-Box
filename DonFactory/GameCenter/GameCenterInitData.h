//
//  GameCenterInitData.h
//  DonFactory
//
//  Created by Don on 2014/10/20.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SqlTool.h"


@interface GameCenterInitData : NSObject{
    SqlTool *sqlTool;
    NSMutableArray *gameListArray;
    NSInteger execSqlGotError;

}

+(GameCenterInitData *)shareGameCenterInitData;
-(NSMutableArray *)LoadGameBoxDetail;


@end
