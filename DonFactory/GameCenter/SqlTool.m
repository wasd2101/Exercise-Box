//
//  SqlTool.m
//  DonFactory
//
//  Created by Don on 2014/10/20.
//  Copyright (c) 2014年 DON (blog.00don.com). All rights reserved.
//

#import "SqlTool.h"
#import <sqlite3.h>
static SqlTool *sqlTool = nil;
@implementation SqlTool

+(SqlTool *)shareSqlTool{
    if(!sqlTool){
        sqlTool = [[SqlTool alloc]init];
    }
    return sqlTool;
}

-(BOOL)ifFirstTimeOpenWithDBPath{
    NSLog(@"first Time");
    sqlite3 *sqlite = nil;
    int openResult = sqlite3_open([DBPath UTF8String], &sqlite);
    
    if(openResult != SQLITE_OK){
        NSLog(@"open DB error");
    }
    NSString *sql = @"SELECT COUNT(gameID) FROM gameList";
    NSLog(@"%d",sqlite3_exec(sqlite, [sql UTF8String], nil, nil, nil));
    if(sqlite3_exec(sqlite, [sql UTF8String], nil, nil, nil)<2){
        return YES;
    }else{
        return NO;
    }
    
}

-(void)execSqliteWithSQL:(NSString *)sql{
    sqlite3 *sqlite = nil;
    
    int openResult = sqlite3_open([DBPath UTF8String], &sqlite);
    if(openResult != SQLITE_OK){
        NSLog(@"open DB error");
    }
    char *error;
    int execResult = sqlite3_exec(sqlite, [sql UTF8String], nil, nil, &error);
    if(execResult != SQLITE_OK){
        //利用創建DB來判斷是否已經創建過。
//        NSLog(@"exec SQL error \n %s",error);
        NSString *errorString = [NSString stringWithFormat:@"%s",error];
        [self.delegate execSqlError:errorString];
    }
    sqlite3_close(sqlite);
}

-(NSMutableArray *)loadGameBoxDetail{
    sqlite3 *sqlite = nil;
    
    int openResult = sqlite3_open([DBPath UTF8String], &sqlite);
    if(openResult != SQLITE_OK){
        NSLog(@"open DB error");
    }
    
    sqlite3_stmt *stmt = nil;
    NSString *sql = @"SELECT * from GameList";
    sqlite3_prepare_v2(sqlite, [sql UTF8String], -1, &stmt, nil);
    int LoadResult = sqlite3_step(stmt);
    
    NSMutableArray *gameListArray = [[NSMutableArray alloc]init];
    while(LoadResult ==SQLITE_ROW){
        int gameIDInt = sqlite3_column_int(stmt,0);
        char *gameName_Char = (char *)sqlite3_column_text(stmt, 1);
        int blueBarPointInt =sqlite3_column_int(stmt,2);
        int yellowBarPointInt = sqlite3_column_int(stmt, 3);
        int goldBarPointInt = sqlite3_column_int(stmt, 4);
        int currentPointInt = sqlite3_column_int(stmt, 5);
        char *unLockBarTypeChar = (char *)sqlite3_column_text(stmt, 6);
        int unLockBarPoint = sqlite3_column_int(stmt, 7);
        int unLockStateInt = sqlite3_column_int(stmt, 8);
        char *currentBarType = (char *)sqlite3_column_text(stmt, 9);
        int playedCount = sqlite3_column_int(stmt, 10);
        int gameTime = sqlite3_column_int(stmt,11);
        
        
        NSNumber *gameNumber = [[NSNumber alloc]initWithInteger:gameIDInt];
        NSString *gameName = [NSString stringWithCString:gameName_Char encoding:NSUTF8StringEncoding];
        NSNumber *blueBarPointNumber = [NSNumber numberWithInt:blueBarPointInt];
        NSNumber *yellowBarPointNumber = [[NSNumber alloc]initWithInteger:yellowBarPointInt];
        NSNumber *goldBarPointNumber = [[NSNumber alloc]initWithInteger:goldBarPointInt];
        NSNumber *currentPointNumber = [[NSNumber alloc]initWithInteger:currentPointInt];
        NSString *unLockType = [NSString stringWithCString:unLockBarTypeChar encoding:NSUTF8StringEncoding];
        NSNumber *unLockBarPointNumber = [[NSNumber alloc]initWithInteger:unLockBarPoint];
        NSNumber *unLockStateNumber =[[NSNumber alloc]initWithInteger:unLockStateInt];
        NSString *currentBarTypeString =[NSString stringWithCString:currentBarType encoding:NSUTF8StringEncoding];
        NSNumber *playedCountNumber = [[NSNumber alloc]initWithInt:playedCount];
        NSNumber *gameTimeNumber = [[NSNumber alloc]initWithInt:gameTime];
        
        [gameListArray addObject:@{@"gameID":gameNumber,@"gameName":gameName,@"blueBarPoint":blueBarPointNumber,@"yellowBarPoint":yellowBarPointNumber,@"goldBarPoint":goldBarPointNumber,@"currentPoint":currentPointNumber,@"unLockBarType":unLockType,@"unLockBarPoint":unLockBarPointNumber,@"unLockState":unLockStateNumber,@"currentBarType":currentBarTypeString,@"playedCount":playedCountNumber,@"gameTime":gameTimeNumber}];
        LoadResult = sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
    sqlite3_close(sqlite);
    
    return gameListArray;
}

-(NSMutableArray *)loadSingleGameBoxDetailWithGameName:(NSString *)name{
    sqlite3 *sqlite = nil;
    
    int openResult = sqlite3_open([DBPath UTF8String], &sqlite);
    if(openResult != SQLITE_OK){
        NSLog(@"open DB error");
    }
    
    sqlite3_stmt *stmt = nil;
    NSString *sql = [NSString stringWithFormat:@"SELECT * from gameList where gameName = '%@'",name];
    sqlite3_prepare_v2(sqlite, [sql UTF8String], -1, &stmt, nil);
    int LoadResult = sqlite3_step(stmt);
    
    NSMutableArray *gameBox = [[NSMutableArray alloc]init];
    while(LoadResult ==SQLITE_ROW){
        int gameIDInt = sqlite3_column_int(stmt,0);
        char *gameName_Char = (char *)sqlite3_column_text(stmt, 1);
        int blueBarPointInt =sqlite3_column_int(stmt,2);
        int yellowBarPointInt = sqlite3_column_int(stmt, 3);
        int goldBarPointInt = sqlite3_column_int(stmt, 4);
        int currentPointInt = sqlite3_column_int(stmt, 5);
        char *unLockBarTypeChar = (char *)sqlite3_column_text(stmt, 6);
        int unLockBarPoint = sqlite3_column_int(stmt, 7);
        int unLockStateInt = sqlite3_column_int(stmt, 8);
        char *currentBarType = (char *)sqlite3_column_text(stmt, 9);
        int playedCount = sqlite3_column_int(stmt, 10);
        int gameTime = sqlite3_column_int(stmt,11);
        
        NSNumber *gameNumber = [[NSNumber alloc]initWithInteger:gameIDInt];
        NSString *gameName = [NSString stringWithCString:gameName_Char encoding:NSUTF8StringEncoding];
        NSNumber *blueBarPointNumber = [NSNumber numberWithInt:blueBarPointInt];
        NSNumber *yellowBarPointNumber = [[NSNumber alloc]initWithInteger:yellowBarPointInt];
        NSNumber *goldBarPointNumber = [[NSNumber alloc]initWithInteger:goldBarPointInt];
        NSNumber *currentPointNumber = [[NSNumber alloc]initWithInteger:currentPointInt];
        NSString *unLockType = [NSString stringWithCString:unLockBarTypeChar encoding:NSUTF8StringEncoding];
        NSNumber *unLockBarPointNumber = [[NSNumber alloc]initWithInteger:unLockBarPoint];
        NSNumber *unLockStateNumber =[[NSNumber alloc]initWithInteger:unLockStateInt];
        NSString *currentBarTypeString =[NSString stringWithCString:currentBarType encoding:NSUTF8StringEncoding];
        NSNumber *playedCountNumber = [[NSNumber alloc]initWithInt:playedCount];
        NSNumber *gameTimeNumber = [[NSNumber alloc]initWithInt:gameTime];
        
        [gameBox addObject:@{@"gameID":gameNumber,@"gameName":gameName,@"blueBarPoint":blueBarPointNumber,@"yellowBarPoint":yellowBarPointNumber,@"goldBarPoint":goldBarPointNumber,@"currentPoint":currentPointNumber,@"unLockBarType":unLockType,@"unLockBarPoint":unLockBarPointNumber,@"unLockState":unLockStateNumber,@"currentBarType":currentBarTypeString,@"playedCount":playedCountNumber,@"gameTime":gameTimeNumber}];
        LoadResult = sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
    sqlite3_close(sqlite);
    
    return gameBox;

}

-(NSNumber *)loadCurrentPointWithGameName:(NSString *)gameName{
    sqlite3 *sqlite = nil;
    int openResult = sqlite3_open([DBPath UTF8String], &sqlite);
    if(openResult != SQLITE_OK){
        NSLog(@"open DB error");
    }
    sqlite3_stmt *stmt = nil;
    NSString *sql = [NSString stringWithFormat:@"SELECT currentPoint from gameList where gameName = '%@'",gameName];
    sqlite3_prepare_v2(sqlite, [sql UTF8String], -1, &stmt, nil);
    int LoadResult = sqlite3_step(stmt);
    
    NSNumber *currentPointNumber;
    while(LoadResult ==SQLITE_ROW){
        int gameIDInt = sqlite3_column_int(stmt,0);
        currentPointNumber = [[NSNumber alloc]initWithInt:gameIDInt];
        LoadResult = sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
    sqlite3_close(sqlite);
    return currentPointNumber;
}

-(NSNumber *)loadPlayedCountWithGameName:(NSString *)gameName{
    sqlite3 *sqlite = nil;
    int openResult = sqlite3_open([DBPath UTF8String], &sqlite);
    if(openResult != SQLITE_OK){
        NSLog(@"open DB error");
    }
    sqlite3_stmt *stmt = nil;
    NSString *sql = [NSString stringWithFormat:@"SELECT playedCount from gameList where gameName = '%@'",gameName];
    sqlite3_prepare_v2(sqlite, [sql UTF8String], -1, &stmt, nil);
    int LoadResult = sqlite3_step(stmt);
    
    NSNumber *playedCount;
    while(LoadResult ==SQLITE_ROW){
        int playCountInt = sqlite3_column_int(stmt,0);
        playedCount = [[NSNumber alloc]initWithInt:playCountInt];
        LoadResult = sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
    sqlite3_close(sqlite);
    return playedCount;
}


-(void)updateGameDataWithGameName:(NSString *)name gamePoint:(NSInteger)point{
    NSString *sql = [NSString stringWithFormat:@"UPDATE gameList SET currentPoint = '%ld' WHERE gameName = '%@'",(long)point,name];
    [self execSqliteWithSQL:sql];
    
}
-(void)updateGameBarTypeWithGameName:(NSString *)name barType:(NSString *)barType{
    NSString *sql = [NSString stringWithFormat:@"UPDATE gameList SET currentBarType = '%@' WHERE gameName = '%@'",barType,name];
    [self execSqliteWithSQL:sql];
}
-(void)updateGameLockStateWithGameName:(NSString *)name unLockState:(NSInteger)unLockState{
    NSString *sql = [NSString stringWithFormat:@"UPDATE gameList SET unLockState = '%ld' WHERE gameName = '%@'",(long)unLockState,name];
    [self execSqliteWithSQL:sql];
}
-(void)updateGamePlayedCountWithGameName:(NSString *)gameName playedNumber:(NSNumber *)playedCountNumber{
        NSString *sql = [NSString stringWithFormat:@"UPDATE gameList SET playedCount = '%@' WHERE gameName = '%@'",playedCountNumber,gameName];
    [self execSqliteWithSQL:sql];
}
//代理方法
-(void)execSqlError:(NSString *)error{
    NSLog(@"%@",error);
}


@end
