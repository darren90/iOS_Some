//
//  DatabaseTool.m
//  Diancai1
//
//  Created by user on 14-3-11.
//  Copyright (c) 2014年 user. All rights reserved.
//

#import "DatabaseTool.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "RollModel.h"
#import "ItemImags.h"
//下载


static FMDatabase *_db;
//order by id desc:降序 asc：升序
@implementation DatabaseTool

+ (void)initialize
{
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask , YES) firstObject];
    NSString* sqlPath = [NSString stringWithFormat:@"%@/rrmj.sqlite",cachesPath];
    NSLog(@"--sqlPath:%@",sqlPath);
    _db = [[FMDatabase alloc] initWithPath:sqlPath];
//    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;

    if (![_db open]) {
        [_db close];
        NSLog(@"打开数据库失败");
    }
    
    [_db setShouldCacheStatements:YES];

//    [_db executeUpdate:@"CREATE TABLE if not exists mainData (id integer primary key autoincrement,idstr TEXT, dict blob)"];

    //1：收藏
    if (![_db tableExists:@"rollList"]) {
        [_db executeUpdate:@"CREATE TABLE if not exists rollList (id integer primary key autoincrement,idstr TEXT, dict blob)"];
    }
     //2：缓存
    if (![_db tableExists:@"rollCollect"]) {
        [_db executeUpdate:@"CREATE TABLE if not exists rollCollect (id integer primary key autoincrement,idstr TEXT, dict blob)"];
    }

    [_db close];
}



/*******************************收藏****************************************/
////收藏////////////////////
+(BOOL)isHadCollected:(NSString *)idStr{
    if (![_db open]) {
        [_db close];
        NSLog(@"数据库打开失败");
        return nil;
    }
    
    [_db setShouldCacheStatements:YES];
    int count = [_db intForQuery:@"SELECT count(*) FROM rollCollect where idstr = ?",idStr];
    
    [_db close];
    if (count >= 1) {
        return YES;
    }else{
        return NO;
    }
}

+ (void)saveRollCollect:(RollModel *)model withId:(NSString *)idStr
{
    if (![_db open])
    {
        [_db close];
        NSAssert(NO, @"数据库打开失败");
        return;
    }
    [_db setShouldCacheStatements:YES];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
    BOOL result = [_db executeUpdate:@"insert into rollCollect (dict,idstr) values (?,?)",data,idStr];
    NSLog(@"%d",result);
    [_db close];
}

+ (void)deleteRollCollect:(NSString*)idStr
{
    if (![_db open]) {
        [_db close];
        NSLog(@"数据库打开失败！");
        return;
    }
    [_db setShouldCacheStatements:YES];
    [_db executeUpdate:@"DELETE FROM rollCollect where idstr = ?",idStr];
    [_db close];
}

+ (NSMutableArray *)getRollCollects
{
    if (![_db open]) {
        [_db close];
        NSLog(@"数据库打开失败");
        return nil;
    }
    
    [_db setShouldCacheStatements:YES];
    FMResultSet *rs = [_db executeQuery:@"SELECT * FROM rollCollect"];
    NSMutableArray * array = [NSMutableArray array];
    
    while (rs.next) {
        NSData *data = [rs dataForColumn:@"dict"];
        RollModel *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [array addObject:dict];
    }
    [rs close];
    [_db close];
    return array;
}


////收藏////////////////////
+ (void)saveRollList:(NSDictionary *)dictionary withId:(NSString *)idStr
{
    if (![_db open])
    {
        [_db close];
        NSAssert(NO, @"数据库打开失败");
        return;
    }
    [_db setShouldCacheStatements:YES];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dictionary];
    [_db executeUpdate:@"insert into rollList (dict,idstr) values (?,?)",data,idStr];
    [_db close];
}

+ (void)saveRollListW:(RollModel *)model withId:(NSString *)idStr
{
    if (![_db open])
    {
        [_db close];
        NSAssert(NO, @"数据库打开失败");
        return;
    }
    [_db setShouldCacheStatements:YES];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
    [_db executeUpdate:@"insert into rollList (dict,idstr) values (?,?)",data,idStr];
    [_db close];
}

+ (void)deleteRollListWith:(NSString*)idStr
{
    if (![_db open]) {
        [_db close];
        NSLog(@"数据库打开失败！");
        return;
    }
    [_db setShouldCacheStatements:YES];
    [_db executeUpdate:@"DELETE FROM rollList where idstr = ?",idStr];
    [_db close];
}

+ (NSMutableArray *)getRollList
{
    if (![_db open]) {
        [_db close];
        NSLog(@"数据库打开失败");
        return nil;
    }
    
    [_db setShouldCacheStatements:YES];
    FMResultSet *rs = [_db executeQuery:@"SELECT * FROM rollList"];
    NSMutableArray * array = [NSMutableArray array];
    
    while (rs.next) {
        NSData *data = [rs dataForColumn:@"dict"];
        RollModel *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [array addObject:dict];
    }
    [rs close];
    [_db close];
    return array;
}


/*******************************收藏****************************************/


#if 0
/** +++++++++++++++++++下载进度记录+++++++++++++++++++++++++++++++++++ */
/***  根据模型，更新数据库 */
+(BOOL)updateDownLoadWithUniquenName:(NSString *)uniquenName segmengTotal:(int)segmangTotal segmengNotDown:(int)segmentNotDown haveDownSize:(double)haveDownSize
{
    if (uniquenName== nil || uniquenName.length == 0) {
//        [IanAlert alertError:@"MovieId为空，更新进度失败"];
        return NO;
    }
    
    if (![_db open]) {
        [_db close];
        NSLog(@"数据库打开失败");
        return nil;
    }
    [_db setShouldCacheStatements:YES];
    
    BOOL result = false ;
    if (segmangTotal == 0) {
//        [IanAlert alertError:@"系统出错，无法更新进度"];
        return NO;
    }else{
        float progress =  1 - (float)segmentNotDown / segmangTotal;
        result = [_db executeUpdate:@"update movieDown set progress = ?,segmentTotal = ?,segmentNotDown = ?, downedSize = ? where uniquenName = ?;",@(progress),@(segmangTotal),@(segmentNotDown),@(haveDownSize),uniquenName];
        [_db close];
        return result;
    }
}
+(NSDictionary *)getMovieTotalSegment:(NSString *)uniquenName
{
    if (![_db open]) {
        [_db close];
        NSLog(@"数据库打开失败");
        return nil;
    }
    
    [_db setShouldCacheStatements:YES];
    
    FMResultSet * rs = [_db executeQuery:@"SELECT * FROM movieDown where uniquenName = ?;",uniquenName];
    int totalSegment = 0 ,notHaveSegment = 0;
    while (rs.next) {
        totalSegment = [rs intForColumn:@"segmentTotal"];
        notHaveSegment = [rs intForColumn:@"segmentNotDown"];
    }
    [rs close];
    [_db close];
    return @{@"segmentTotal" : @(totalSegment),@"segmentNotDown" : @(notHaveSegment)};
}

/**
 *  暂停http的下载，同时记录下载进度
 *
 *  @param uniquenName  剧集的唯一名字movieId+episode
 *  @param progress     进度值float
 *  @param haveDownSize 已经下载的文件大小
 *
 *  @return 是否保存进度成功
 */
+(BOOL)updateDownLoadWithUniquenName:(NSString *)uniquenName progress:(float)progress haveDownSize:(double)haveDownSize
{
    if (uniquenName== nil || uniquenName.length == 0) {
//        [IanAlert alertError:@"MovieId为空，更新进度失败"];
        return NO;
    }
    
    if (![_db open]) {
        [_db close];
        NSLog(@"数据库打开失败");
        return nil;
    }
    [_db setShouldCacheStatements:YES];
   
    BOOL result = [_db executeUpdate:@"update movieDown set progress = ?, downedSize = ? where uniquenName = ?;",@(progress),@(haveDownSize),uniquenName];
    [_db close];
    return result;
}
  
+(BOOL)updateUrlIsInvalid:(NSString *)uniquenName
{
    if (uniquenName== nil || uniquenName.length == 0) {
        [IanAlert alertError:@"MovieId为空，更新进度失败"];
        return NO;
    }
    
    if (![_db open]) {
        [_db close];
        NSLog(@"数据库打开失败");
        return nil;
    }
    [_db setShouldCacheStatements:YES];
    
    BOOL result = [_db executeUpdate:@"update movieDown set isInvalid = ? where uniquenName = ?;",@(NO),uniquenName];
    [_db close];
    return result;
}

/*******************************2--看剧，搜索历史****************************************/
/***  根据title 添加搜索历史 SearchHistory */
+(void)addSearchHistoryWithTitle:(NSString *)title
{
    if (![_db open]) {
        [_db close];
        NSAssert(NO, @"数据库打开失败");
        return;
    }
    [_db setShouldCacheStatements:YES];
    [_db executeUpdate:@"delete from SearchHistory where title = (select title from SearchHistory where title = ?)",title];
    [_db executeUpdate:@"insert into SearchHistory (title) values (?);",title];
    
    [_db close];
}
/** *  读取历史记录  */
+(NSArray *)getSearchHistory
{
    if (![_db open]) {
        [_db close];
        NSLog(@"数据库打开失败");
        return nil;
    }
    [_db setShouldCacheStatements:YES];
    NSMutableArray *array = [NSMutableArray array];
    FMResultSet *rs = [_db executeQuery:@"select * from SearchHistory order by id desc"];
    while (rs.next) {
        NSString *title = [rs stringForColumn:@"title"];
        SearchHistoryModel *modle = [SearchHistoryModel searchHistoryWithName:title];
        [array addObject:modle];
    }
    [rs close];
    [_db close];
    return array;
}

/***  数据库中是否已经存在了这个title @return yes:存在；no：不存在  */
+(BOOL)isDBHadThisSearchHistory:(NSString *)title
{
    if (![_db open]) {
        [_db close];
        NSLog(@"数据库打开失败");
        return NO;
    }
    [_db setShouldCacheStatements:YES];
    FMResultSet *rs = [_db executeQuery:@"select * from SearchHistory where title = ? order by id desc",title];
    if (rs.columnCount == 0) {
        return NO;
    }else{
        return YES;
    }
}

/***  根据title删除  */
+(BOOL)deleteSearchHistoryWithTitle:(NSString *)title
{
    if (title.length == 0) { return NO;}
    if (![_db open]) {
        [_db close];
        NSLog(@"数据库打开失败");
        return NO;
    }
    BOOL result = [_db executeUpdate:@"delete from SearchHistory where title = ?",title];
    return result;
}
/***  全部删除 */
+(BOOL)deleteAllSearchHistory
{
    if (![_db open]) {
        [_db close];
        NSLog(@"数据库打开失败");
        return NO;
    }
    BOOL result = [_db executeUpdate:@"delete from SearchHistory "];
    return result;
}
/*******************************2--看剧，搜索历史****************************************/


#pragma mark - 3--记录看剧时间
/*******************************3--记录看剧时间 - seekTVDuration****************************************/
//movieId TEXT,episode integer,lastDuration
+(void)addSeekTVDuration:(NSString *)movieID episode:(int)episode duration:(double)duration title:(NSString *)title urltpye:(NSInteger)type quality:(NSString *)quality episodeID:(NSString *)episodeID coverUrl:(NSString *)coverUrl
{
    if (movieID ==  nil || movieID.length == 0 || episode == 0 || title.length == 0 || episodeID == nil || episodeID.length == 0 || coverUrl == nil || coverUrl.length == 0) {
        return;
    }
    if (![_db open]) {
        [_db close];
        NSAssert(NO, @"数据库打开失败");
        return;
    }
    [_db setShouldCacheStatements:YES];
        [_db executeUpdate:@"DELETE FROM seekTVDuration where movieId = ? and episode = ?",movieID,@(episode)];
        [_db executeUpdate:@"insert into seekTVDuration (movieId,episode,lastDuration,title,urlType,quality,closeMovieTime,episodeID,coverUrl) values (?,?,?,?,?,?,?,?,?);",movieID,@(episode),@(duration),title,@(type),quality,[NSString timeStrWithDate:[NSDate new] format:nil],episodeID,coverUrl];
    [_db close];
}

//movieId TEXT,episode integer,lastDuration
+(NSNumber *)getSeekTVDuration:(NSString *)movieID episode:(int)episode
{
    if (movieID ==  nil || movieID.length == 0 || episode == 0) {
        return @0;
    }
    if (![_db open]) {
        [_db close];
        NSLog(@"数据库打开失败");
        return @0;
    }
    [_db setShouldCacheStatements:YES];
    double duration = 0.0;
    FMResultSet *rs = [_db executeQuery:@"select lastDuration from seekTVDuration where movieId = ? and episode = ?",movieID,@(episode)];
    while (rs.next) {
        duration = [rs doubleForColumn:@"lastDuration"];
        break;
    }
    [rs close];
    [_db close];
    return [NSNumber numberWithDouble:duration];
}
/*******************************3--记录看剧时间****************************************/

#pragma mark - 下载2.0
/*******************************5 -- 新 - 下载2.0****************************************/
+(BOOL)addFileModelWithModel:(FileModel *)model
{
    if (![_db open]) {
        [_db close];
        NSAssert(NO, @"数据库打开失败");
        return NO;
    }
    [_db setShouldCacheStatements:YES];
    
    if (model == nil || model.uniquenName == nil || model.uniquenName.length == 0) {
        [IanAlert alertError:@"加入下载列表失败-ID为空"];
        return NO;
    }
 
    //1:判断是否已经加入到数据库中
    int count = [_db intForQuery:@"SELECT COUNT(uniquenName) FROM fileModel where uniquenName = ?;",model.uniquenName];
    
    if (count >= 1) {
        NSLog(@"-已经在下载列表中--");
        return NO;
    }
    //2:存储
    BOOL result = [_db executeUpdate:@"insert into fileModel (uniquenName,movieId,episode,fileName,fileURL,targetPath,tempPath,filesize,filerecievesize ,basepath,time,isHadDown,iconUrl,title,urlType,webPlayUrl,quality,episodeSid) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);",model.uniquenName,model.movieId,@(model.episode),model.fileName,model.fileURL,model.targetPath,model.tempPath,model.fileSize,model.fileReceivedSize,kDownDomanPath,model.time,@(NO),model.iconUrl,model.title,@(model.urlType),model.webPlayUrl,model.quality,model.episodeSid];
    
    [_db close];
    if (result) {
//        [IanAlert alertSuccess:@"加入下载列表成功"];
    }else{
        [IanAlert alertError:@"加入下载列表失败"];
    }
    return result;
}

/**
 *  根据是否下载完毕取出所有的数据
 *
 *  @param isDowned YES：已经下载，NO：未下载
 *
 *  @return 装有FileModel的模型
 */
+(NSArray *)getFileModeArray:(BOOL)isHadDown
{
    if (![_db open]) {
        [_db close];
        NSLog(@"数据库打开失败");
        return nil;
    }
    
    [_db setShouldCacheStatements:YES];
     
    FMResultSet *rs = [_db executeQuery:@"SELECT * FROM fileModel where isHadDown = ? order by id asc;",@(isHadDown)];
//    uniquenName,movieId,episode,fileName,fileURL,targetPath,tempPath,filesize,filerecievesize ,basepath,basepath,time,isHadDown,iconUrl,title
    
    NSMutableArray * array = [NSMutableArray array];
    while (rs.next) {
        FileModel *file = [[FileModel alloc]init];
        file.fileName = [rs stringForColumn:@"fileName"];
        file.fileURL = [rs stringForColumn:@"fileURL"];
        file.fileSize = [rs stringForColumn:@"filesize"];
        file.fileReceivedSize = [rs stringForColumn:@"filerecievesize"];
 
        file.targetPath = [DownLoadTools getTargetPath:file.fileName];
 
        file.tempPath = [DownLoadTools getTempPath:file.fileName];
        file.time = [rs stringForColumn:@"time"];
        file.iconUrl = [rs stringForColumn:@"iconUrl"];
        file.isHadDown  = [rs boolForColumn:@"isHadDown"];
        file.uniquenName = [rs stringForColumn:@"uniquenName"];
        file.title = [rs stringForColumn:@"title"];
        file.movieId = [rs stringForColumn:@"movieId"];
        file.episode = [rs intForColumn:@"episode"];
        file.urlType = [rs intForColumn:@"urlType"];
        file.webPlayUrl =[rs stringForColumn:@"webPlayUrl"];
        file.quality = [rs stringForColumn:@"quality"];
        file.episodeSid = [rs stringForColumn:@"episodeSid"];
        
        file.progress = [rs doubleForColumn:@"progress"];
        file.segmentHadDown = [rs intForColumn:@"segmentHadDown"];
        NSLog(@"progress:%f,seg:%d",[rs doubleForColumn:@"progress"],[rs intForColumn:@"segmentHadDown"]);
        
        file.isDownloading=NO;
        file.isDownloading = NO;
        file.willDownloading = NO;
        // file.isFirstReceived = YES;
        file.error = NO;
        
        NSData *fileData=[[NSFileManager defaultManager ] contentsAtPath:file.tempPath];
        NSInteger receivedDataLength=[fileData length];//获取已经下载的部分文件的大小
        file.fileReceivedSize=[NSString stringWithFormat:@"%ld",(long)receivedDataLength];        
        [array addObject:file];
    }
    [rs close];
    [_db close];
    return array;
}

+(void)updateFilesModeWhenDownFinish:(NSArray *)array
{
    if (array == nil || array.count == 0) {
        return;
    }
    for (FileModel *model in array) {
        [self updateFileModeWhenDownFinish:model];
    }
}


/**
 *  针对获取到真正的文件总大小的时候，更新文件的总大小
 *
 *  @param model FileModel模型
 *
 *  @return 是否更新成功
 */
+(BOOL)updateFileModeTotalSize:(FileModel *)model
{
    if (model.uniquenName == nil || model.uniquenName.length == 0) {
        [IanAlert alertError:@"MovieId为空，跟新下载完毕列表失败"];
        return NO;
    }
    
    if (![_db open]) {
        [_db close];
        NSLog(@"数据库打开失败");
        return NO;
    }
    [_db setShouldCacheStatements:YES];
 
    int count = [_db intForQuery:@"SELECT COUNT(1) FROM fileModel where isHadDown = ? and uniquenName = ?;",@(NO),model.uniquenName];
    if (count == 0) {
        NSLog(@"没有剧集记录，无法更新");
        return NO;
    }
    
    BOOL result = false ;
    if (model.fileSize != nil || model.fileSize.length != 0 || [model.fileSize longLongValue] != 0) {
        result = [_db executeUpdate:@"update fileModel set filesize =? where uniquenName = ?;",model.fileSize,model.uniquenName];
    }
    
    [_db close];
    if (!result) {
        NSLog(@"---更改数据库信息失败---");
    }
    
    return result;
}

/**
 *  针对下载地址失效的，更新最新的下载地址
 *
 *  @param downUrl 最新的下载地址
 *  @param uniqueName 唯一的标示
 *
 *  @return YES:成功 ； NO：失败
 */
+(BOOL)updateFileModeDownUrl:(NSString *)downUrl uniqueName:(NSString *)uniqueName
{
    if (uniqueName == nil || uniqueName.length == 0) {
        [IanAlert alertError:@"MovieId为空，跟新下载完毕列表失败"];
        return NO;
    }
    
    if (![_db open]) {
        [_db close];
        NSLog(@"数据库打开失败");
        return NO;
    }
    [_db setShouldCacheStatements:YES];
    
    int count = [_db intForQuery:@"SELECT COUNT(1) FROM fileModel where isHadDown = ? and uniquenName = ?;",@(NO),uniqueName];
    if (count == 0) {
        NSLog(@"没有剧集记录，无法更新");
        return NO;
    }
    
    BOOL result = false ;
    if (downUrl != nil ||downUrl.length != 0) {
        result = [_db executeUpdate:@"update fileModel set fileURL =? where uniquenName = ?;",downUrl,uniqueName];
    }
    [_db close];
    if (!result) {
        NSLog(@"---更改数据库信息失败---");
    }
    
    return result;
}

/**
 *  针对m3u8的下载，暂停下载的时候：存储已经下载了多少片段
 *
 *  @param model FileModel模型
 *
 *  @return 是否更新成功
 */
+(BOOL)updatePartWhenDownStoWithPprogress:(float)progress segmentHadDown:(int)segmentHadDown uniqueName:(NSString *)uniqueName
{
    if (uniqueName == nil || uniqueName.length == 0) {
        [IanAlert alertError:@"MovieId为空，跟新下载完毕列表失败"];
        return NO;
    }
    
    if (![_db open]) {
        [_db close];
        NSLog(@"updateM3u8Part -数据库打开失败");
        return NO;
    }
    [_db setShouldCacheStatements:YES];
    
    int count = [_db intForQuery:@"SELECT COUNT(1) FROM fileModel where isHadDown = ? and uniquenName = ?;",@(NO),uniqueName];
    if (count == 0) {
        NSLog(@"updateM3u8Part -没有剧集记录，无法更新");
        return NO;
    }
    
    BOOL result = NO ;
    if (progress != 0.0 || segmentHadDown != 0 || progress <= 1.0) {
        result = [_db executeUpdate:@"update fileModel set progress =? , segmentHadDown = ? where uniquenName = ?;",@(progress),@(segmentHadDown),uniqueName];
    }
    
    [_db close];
    if (!result) {
        NSLog(@"---updateM3u8Part -更改数据库信息失败---");
    }
    
    return result;
}

/**
 *  针对m3u8的下载，找到已经下载的片段
 *
 *  @param uniquenName 唯一的名字
 *
 *  @return 已经下载的片段数（Int）
 */
+(int)getMovieHadDownSegment:(NSString *)uniqueName{
    if (uniqueName == nil || uniqueName.length == 0) {
        [IanAlert alertError:@"MovieId为空，跟新下载完毕列表失败"];
        return 0;
    }
    
    if (![_db open]) {
        [_db close];
        NSLog(@"数据库打开失败");
        return 0;
    }
    
    [_db setShouldCacheStatements:YES];
    
    FMResultSet * rs = [_db executeQuery:@"SELECT * FROM fileModel where uniquenName = ?;",uniqueName];
    int hadDownSegment = 0;
    
    while (rs.next) {
        hadDownSegment = [rs intForColumn:@"segmentHadDown"];
    }
    [rs close];
    [_db close];
    
    return hadDownSegment;
}

/**
 *  下载完毕更新数据库
 *
 *  @param model FileModel模型
 *
 *  @return 是否更新成功
 */
+(BOOL)updateFileModeWhenDownFinish:(FileModel *)model
{
    if (model.uniquenName == nil || model.uniquenName.length == 0) {
        [IanAlert alertError:@"MovieId为空，跟新下载完毕列表失败"];
        return NO;
    }
    
    if (![_db open]) {
        [_db close];
        NSLog(@"数据库打开失败");
        return NO;
    }
    [_db setShouldCacheStatements:YES];
    /**
     NSDictionary *filedic = [NSDictionary dictionaryWithObjectsAndKeys:fileinfo.fileName,@"filename",fileinfo.time,@"time",fileinfo.fileSize,@"filesize",fileinfo.targetPath,@"filepath",imagedata,@"fileimage", nil];
     */
    int count = [_db intForQuery:@"SELECT COUNT(1) FROM fileModel where isHadDown = ? and uniquenName = ?;",@(NO),model.uniquenName];
    if (count == 0) {
        NSLog(@"没有剧集记录，无法更新");
        return NO;
    }
 
    BOOL result = false ;
//    if (model.fileName != nil || model.fileName.length != 0) {
//        result = [_db executeUpdate:@"update fileModel set title =?  where uniquenName = ?;",model.title,model.uniquenName];
//    }
    
    if (model.fileSize != nil || model.fileSize.length != 0 || [model.fileSize longLongValue] != 0) {
        result = [_db executeUpdate:@"update fileModel set filesize =? ,isHadDown=? where uniquenName = ?;",model.fileSize,@(YES),model.uniquenName];
    }
//    if (model.iconUrl != nil || model.iconUrl.length != 0) {
//        result = [_db executeUpdate:@"update fileModel set iconUrl = ? where uniquenName = ?;",model.iconUrl,model.uniquenName];
//    }
//    if (model.fileURL != nil || model.fileURL.length != 0) {
//        result = [_db executeUpdate:@"update fileModel set fileURL = ? where uniquenName = ?;",model.fileURL,model.uniquenName];
//    }
    [_db close];
    if (!result) {
        NSLog(@"---更改数据库信息失败---");
    }
    
    return result;
}

/**
 *  这个剧是否在下载列表
 *
 *  @param uniquenName uniquenName ： MovieId+epsiode
 *
 *  @return YES：存在 ； NO：不存在
 */
+(BOOL)isFileModelInDB:(NSString *)uniquenName
{
    if (uniquenName == nil || uniquenName.length == 0) {
        NSLog(@"剧集id为空，跟新下载完毕列表失败");
        return NO;
    }
    if (![_db open]) {
        [_db close];
        NSLog(@"数据库打开失败");
        return nil;
    }
    [_db setShouldCacheStatements:YES];
    int count = [_db intForQuery:@"SELECT COUNT(uniquenName) FROM fileModel where uniquenName = ?;",uniquenName];
    [_db close];
    if (count == 0) {
        return NO;
    }else{
        return YES;
    }
}

/**
 *  读取那些剧被下载 -- 不包括详细信息（只取到那些剧集被下载即可）
 *
 *  @return 下载完毕的剧集Array
 */
+(NSArray *)getFileModelsHadDownLoad
{
    if (![_db open]) {
        [_db close];
        NSLog(@"数据库打开失败");
        return nil;
    }
    
    [_db setShouldCacheStatements:YES];
    FMResultSet *rs = [_db executeQuery:@"SELECT DISTINCT title,movieId,iconUrl from fileModel where isHadDown = ? order by id desc;",@(YES)];
    NSMutableArray * array = [NSMutableArray array];
    while (rs.next) {
        DownedSeriesModel *model = [[DownedSeriesModel alloc]init];
        model.title = [rs stringForColumn:@"title"] ;
        model.movieId = [rs stringForColumn:@"movieId"];
        model.iconUrl = [rs stringForColumn:@"iconUrl"];
        model.seriesCount = [self getFileModelCountWithMovieId:model.movieId];
        [array addObject:model];
    }
    [rs close];
    [_db close];
    return array;
}

/**
 *  找出某一部剧一共下载了几部
 *
 *  @param MovieId 剧集id
 *
 *  @return 下载次数
 */
+(int)getFileModelCountWithMovieId:(NSString *)MovieId
{
    if (![_db open]) {
        [_db close];   NSLog(@"数据库打开失败");  return 0; }
    
    [_db setShouldCacheStatements:YES];
    
    int count = [_db intForQuery:@"SELECT COUNT(movieId) FROM fileModel where isHadDown = 1 and movieId = ?;",MovieId];
    return (int)count;
}


/**
 *  根据剧集id，找到已经下载的那些剧
 *
 *  @param movieId 剧集id
 *
 *  @return 装有FileModel的数组
 */
+(NSArray *)getDownLoadFileModelWithMovidId:(NSString *)movieId
{
    if (![_db open]) {
        [_db close];
        NSLog(@"数据库打开失败");
        return nil;
    }
    
    [_db setShouldCacheStatements:YES];
    FMResultSet *rs = [_db executeQuery:@"SELECT * FROM fileModel where movieId = ? and isHadDown = 1  order by episode asc;",movieId];
    
    NSMutableArray * array = [NSMutableArray array];
    while (rs.next) {
        FileModel *file = [[FileModel alloc]init];
        file.fileName = [rs stringForColumn:@"fileName"];
        file.fileURL = [rs stringForColumn:@"fileURL"];
        file.fileSize = [rs stringForColumn:@"filesize"];
        file.fileReceivedSize = [rs stringForColumn:@"filerecievesize"];
 
        file.targetPath = [DownLoadTools getTargetPath:file.fileName];
 
        file.tempPath = [DownLoadTools getTempPath:file.fileName];;
        file.iconUrl = [rs stringForColumn:@"iconUrl"];
        file.uniquenName = [rs stringForColumn:@"uniquenName"];
        file.title = [rs stringForColumn:@"title"];
        file.movieId = [rs stringForColumn:@"movieId"];
        file.episode = [rs intForColumn:@"episode"];
        file.urlType = [rs intForColumn:@"urlType"];
        file.quality = [rs stringForColumn:@"quality"];
        file.episodeSid = [rs stringForColumn:@"episodeSid"];
        [array addObject:file];
    }
    [rs close];
    [_db close];
    return array;
}

/**
 *  是否这部剧已经下载完毕
 *
 *  @param uniquenName 剧集Id
 *
 *  @return YES:下载完毕 ； NO：没有下载完毕
 */
+(BOOL)isThisHadLoaded:(NSString *)movieID episode:(int)episode
{
    if (movieID ==  nil || movieID.length == 0) {
        return NO;
    }
    if (![_db open]) {
        [_db close];
        NSLog(@"数据库打开失败");
        return NO;
    }
    
    NSUInteger count = [_db intForQuery:@"SELECT COUNT(1) FROM fileModel where movieId = ? and episode = ?;",movieID,@(episode)];
    [_db close];
    
    if (count  == 0) {
        return NO;
    }else{
        return YES;
    }
}

/**
 *  根据uniquenName删除已经下载的剧 -- 只会删除一个
 *
 *  @param uniquenName MovieId+eposide
 *
 *  @return YES:成功；NO：失败
 */
+(BOOL)delFileModelWithUniquenName:(NSString *)uniquenName
{
    if (![_db open]) {
        [_db close];
        NSLog(@"数据库打开失败！");
        return NO;
    }
    [_db setShouldCacheStatements:YES];
    BOOL result = [_db executeUpdate:@"DELETE FROM fileModel where uniquenName = ?",uniquenName];
    [_db close];
    return result;
}
 
/**
 *  根据MovieId删除已经下载的剧 -- 会删除多个
 *
 *  @param movieId 剧集Id
 *
 *  @return YES:成功；NO：失败
 */
+(BOOL)delFileModelsWithMovieId:(NSString *)movieId
{
    if (![_db open]) {
        [_db close];
        NSLog(@"数据库打开失败！");
        return NO;
    }
    [_db setShouldCacheStatements:YES];
    BOOL result = [_db executeUpdate:@"DELETE FROM fileModel where movieId = ? and isHadDown = ?",movieId ,@(YES)];
    [_db close];
    return result;
}

/**
 *  是否这部剧已经下载完毕
 *
 *  @param uniquenName 剧集Id
 *
 *  @return YES:下载完毕 ； NO：没有下载完毕
 */
+(NSDictionary *)isHadDowned:(NSString *)movieID episode:(int)episode
{
    int urlType = 0;
    
    if (movieID ==  nil || movieID.length == 0) {
        return @{@"isHad" : @(NO) , @"urlType" : @(0)};
    }
    if (![_db open]) {
        [_db close];
        NSLog(@"数据库打开失败");
        return @{@"isHad" : @(NO) , @"urlType" : @(0)};
    }
    
    int count = [_db intForQuery:@"SELECT COUNT(uniquenName) FROM fileModel where movieId = ? and isHadDown = ? and episode = ?;",movieID,@(YES),@(episode)];
    if (count == 0) {
        [_db close];
        return @{@"isHad" : @(NO) , @"urlType" : @(0)};
    }else{
        FMResultSet *rs = [_db executeQuery:@"select urlType from fileModel where movieId = ? and episode = ? order by id desc",movieID,@(episode)];
        while (rs.next) {
            urlType  = [rs intForColumn:@"urlType"];
        }
        [_db close];
        return @{@"isHad" : @(YES) , @"urlType" : @(urlType)};
    }
}

/*******************************5 -- 新 - 下载****************************************/


/*******************************6 -- 已 经 观 看****************************************/
/**
 *  得到最新观看的哪一集
 *
 *  @param movieID 剧集ID
 *
 *  @return 最新观看的集数，如果为0表示没有看过
 */
+(LastSeekMovieModel *)getLatestEpisode:(NSString *)movieID
{
    if (movieID == nil || movieID.length == 0) {
        return 0;
    }
    if (![_db open]) {
        [_db close];
        NSLog(@"数据库打开失败");
        return 0;
    }
    FMResultSet *rs = [_db executeQuery:@"select episode,episodeID from seekTVDuration where movieId = ? order by id desc",movieID];
    
    LastSeekMovieModel *lastEpisode = nil;
    NSMutableArray * arr = [NSMutableArray array];
    while (rs.next) {
        LastSeekMovieModel * model = [[LastSeekMovieModel alloc] init];
        model.episode  = [rs intForColumn:@"episode"];
        model.episodeSid = [rs stringForColumn:@"episodeID"];
        [arr addObject:model];
    }
    if (arr.count > 0 ) {
       lastEpisode = [arr firstObject];
    }
    [rs close];
    [_db close];
    return lastEpisode;
}
//得到观看过得剧集
+(NSArray *)getSeekTVLastSeekmovie:(NSString *)movieID
{
    if (movieID == nil || movieID.length == 0) {
        return @[];
    }
    if (![_db open]) {
        [_db close];
        NSLog(@"数据库打开失败");
        return @[];
    }
    FMResultSet *rs = [_db executeQuery:@"select episode from seekTVDuration where movieId = ? order by id desc",movieID];
    NSMutableArray * arr = [NSMutableArray array];
    while (rs.next) {
        LastSeekMovieModel * model = [[LastSeekMovieModel alloc] init];
        model.episode  = [rs intForColumn:@"episode"];
        [arr addObject:model];
    }
    [rs close];
    [_db close];
    return arr;
}

+(NSArray *)getRecentSeekmovie
{
    if (![_db open]) {
        [_db close];
        NSLog(@"数据库打开失败");
        return @[];
    }
    FMResultSet *rs = [_db executeQuery:@"SELECT * FROM seekTVDuration order by id desc"];
    NSMutableArray * arr = [NSMutableArray array];
    while (rs.next) {
        HistoryCellModel * model = [[HistoryCellModel alloc] init];
        model.movieID  = [rs stringForColumn:@"movieId"];
        model.title = [rs stringForColumn:@"title"];
        model.episode = [rs stringForColumn:@"episode"];
        model.time = [rs stringForColumn:@"closeMovieTime"];
        model.episodeID = [rs stringForColumn:@"episodeID"];
//        model.ID = [rs stringForColumn:@"id"];
        model.quality = [rs stringForColumn:@"quality"];
        model.urlType = [rs intForColumn:@"urlType"];
        model.coverUrl = [rs stringForColumn:@"coverUrl"];
        BOOL isSame = YES;
        HistoryCellModel * model_2 = [[HistoryCellModel alloc] init];
        for (model_2 in arr) {
            if ([model.movieID isEqualToString:model_2.movieID]) {
//                [arr addObject:model];
                isSame = NO;

            }
        }
        if (isSame == YES) {
            [arr addObject:model];
        }


    }
    [rs close];
    [_db close];
    return arr;

}
//(id integer primary key autoincrement,movieId TEXT,episode integer,lastDuration double,urlType integer,title TEXT,quality TEXT,closeMovieTime TEXT,episodeID TEXT)

/***  根据movieId删除  */
+(BOOL)deleteRecentSeekmovieWithMovieId:(NSString *)movieId
{
    if (movieId.length == 0) { return NO;}
    if (![_db open]) {
        [_db close];
        NSLog(@"数据库打开失败");
        return NO;
    }
    BOOL result = [_db executeUpdate:@"delete from seekTVDuration where movieId = ?",movieId];
    if (result) {
        [IanAlert alertSuccess:@"删除成功"];
    }else{
        [IanAlert alertError:@"删除失败，请稍后重试"];
    }
    return result;
}

+(void)deleteAllRecentSeekmovie
{

    if (![_db open]) {
        [_db close];
        NSLog(@"数据库打开失败");
        return;
    }
    [_db executeUpdate:@"delete from seekTVDuration "];
}

/*******************************6 -- 已 经 观 看****************************************/



/*******************************7 -- 视频收藏****************************************/
//[_db executeUpdate:@"CREATE TABLE if not exists movieCollect (id integer primary key autoincrement,movieId TEXT,episode integer,episodeSid TEXT,quality TEXT,coverUrl TEXT,score,TEXT)"];
+(BOOL)addCollectWithMovieId:(NSString *)movieId coverUrl:(NSString *)coverUrl title:(NSString *)title brief:(NSString *)brief score:(NSString *)score
{
    if (movieId.length == 0) { return NO;}
    
    if (![_db open]) {
        [_db close];
        NSAssert(NO, @"数据库打开失败");
        return NO;
    }
    [_db setShouldCacheStatements:YES];
    [_db executeUpdate:@"delete from movieCollect where movieId = ?",movieId];
    BOOL result = [_db executeUpdate:@"insert into movieCollect (movieId,coverUrl,title,brief,score) values (?,?,?,?,?);",movieId,coverUrl,title,brief,score];
    if (result) {
        [IanAlert alertSuccess:@"收藏成功"];
    }else{
        [IanAlert alertError:@"收藏失败，请稍后重试"];
    }
    [_db close];
    return result;
}

+(void)addCollectWithMovieId:(NSString *)movieId episode:(int)episode episodeSid:(NSString *)episodeSid coverUrl:(NSString *)coverUrl score:(NSString *)score
{
    if (movieId.length == 0) { return;}
    
    if (![_db open]) {
        [_db close];
        NSAssert(NO, @"数据库打开失败");
        return;
    }
    [_db setShouldCacheStatements:YES];
    [_db executeUpdate:@"delete from movieCollect where movieId = ?",movieId];
    [_db executeUpdate:@"insert into movieCollect (movieId,episode,episodeSid,coverUrl,score) values (?,?,?,?,?);",movieId,episode,episodeSid,coverUrl,score];
    [_db close];
}

/** *  读取历史记录  */
+(NSArray *)getCollect
{
    if (![_db open]) {
        [_db close];
        NSLog(@"数据库打开失败");
        return nil;
    }
    [_db setShouldCacheStatements:YES];
    NSMutableArray *array = [NSMutableArray array];
    FMResultSet *rs = [_db executeQuery:@"select * from movieCollect order by id desc"];
    while (rs.next) {
        CollectModel *model = [[CollectModel alloc]init];
        
        NSString *movieId = [rs stringForColumn:@"movieId"];
        int episode = [rs intForColumn:@"episode"];
        NSString *episodeSid = [rs stringForColumn:@"episodeSid"];
        NSString *coverUrl = [rs stringForColumn:@"coverUrl"];
        NSString *quality = [rs stringForColumn:@"quality"];
        NSString *score = [rs stringForColumn:@"score"];
        NSString *title = [rs stringForColumn:@"title"];
        NSString *brief = [rs stringForColumn:@"brief"];
 
        
        model.movieId = movieId;
        model.episode= episode;
        model.episodeSid = episodeSid;
        model.quality = quality;
        model.coverUrl = coverUrl;
        model.score = score;
        model.title = title;
        model.brief = brief;
        
        [array addObject:model];
    }
    [rs close];
    [_db close];
    return array;
}

/***  数据库中是否已经存在了这个收藏 @return yes:存在；no：不存在  */
+(BOOL)isDBHadThisCollect:(NSString *)movieId{
    if (movieId.length == 0) { return NO;}
    if (![_db open]) {
        [_db close];
        NSLog(@"数据库打开失败");
        return NO;
    }
    [_db setShouldCacheStatements:YES];
    FMResultSet *rs = [_db executeQuery:@"select * from movieCollect where movieId = ? order by id desc",movieId];
    [rs next];
    if (rs.columnCount == 0) {
        return NO;
    }else{
        return YES;
    }
}

/***  根据title删除  */
+(BOOL)deleteCollectWithMovieId:(NSString *)movieId
{
    if (movieId.length == 0) { return NO;}
    if (![_db open]) {
        [_db close];
        NSLog(@"数据库打开失败");
        return NO;
    }
    BOOL result = [_db executeUpdate:@"delete from movieCollect where movieId = ?",movieId];
    if (result) {
        [IanAlert alertSuccess:@"取消收藏成功"];
    }else{
        [IanAlert alertError:@"取消收藏失败，请稍后重试"];
    }
    return result;
}
/***  全部删除 */
+(BOOL)deleteAllCollect
{
    if (![_db open]) {
        [_db close];
        NSLog(@"数据库打开失败");
        return NO;
    }
    BOOL result = [_db executeUpdate:@"delete from movieCollect"];
    if (result) {
        [IanAlert alertSuccess:@"删除全部收藏成功"];
    }else{
        [IanAlert alertError:@"删除全部收藏失败，请稍后重试"];
    }
    return result;
}

/*******************************7 -- 视频收藏****************************************/

#endif
@end



