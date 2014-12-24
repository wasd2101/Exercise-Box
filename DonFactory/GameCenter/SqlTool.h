//
//  SqlTool.h
//  DonFactory
//
//  Created by Don on 2014/10/20.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SqlTool : NSObject{
    
}

+(SqlTool *)shareSqlTool;
-(void)execSqliteWithSQL:(NSString *)sql;
-(BOOL)ifFirstTimeOpenWithDBPath;

-(NSMutableArray *)loadGameBoxDetail;
-(NSNumber *)loadCurrentPointWithGameName:(NSString *)gameName;
-(NSMutableArray *)loadSingleGameBoxDetailWithGameName:(NSString *)name;
-(void)updateGameDataWithGameName:(NSString *)name gamePoint:(NSInteger)point;
-(void)updateGameBarTypeWithGameName:(NSString *)name barType:(NSString *)barType;
-(void)updateGameLockStateWithGameName:(NSString *)name unLockState:(NSInteger)unLockState;
-(void)updateGamePlayedCountWithGameName:(NSString *)gameName playedNumber:(NSNumber *)playedCountNumber;
-(NSNumber *)loadPlayedCountWithGameName:(NSString *)gameName;



@property id delegate;
@end
