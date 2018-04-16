//
//  XNArchiverManager.m
//  CKYSPlatform
//
//  Created by ForgetFairy on 2017/12/26.
//  Copyright © 2017年 ckys. All rights reserved.
//

#import "XNArchiverManager.h"

@implementation XNArchiverManager

+(instancetype)shareInstance {
    static XNArchiverManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XNArchiverManager alloc] initPrivate];
    });
    return instance;
}

-(instancetype)initPrivate {
    self = [super init];
    if(self) {
        
    }
    return self;
}

#pragma mark - 归档
- (void)xnArchiverObject:(id)object archiverName:(NSString *)archiverName {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *filePath = [path stringByAppendingPathComponent:archiverName];
    [NSKeyedArchiver archiveRootObject:object toFile:filePath];
}

#pragma mark - 解归档
- (id)xnUnarchiverObject:(NSString *)archiverName {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *filePath = [path stringByAppendingPathComponent:archiverName];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}

#pragma mark - 删除归档
- (void)xnDeleteObject:(NSString *)archiverName {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    
    
    NSDirectoryEnumerator *homeDirectoryEnumerator = [fileManager enumeratorAtPath:path];
    NSString *homeFilePath = path;
    while((homeFilePath = [homeDirectoryEnumerator nextObject])!=nil) {
        
        NSString *deletePath = [path stringByAppendingPathComponent:homeFilePath];
        if ([fileManager fileExistsAtPath:deletePath]) {
            if ([deletePath.lastPathComponent isEqualToString:@"CKSC_myCouponList"]) {//
                [fileManager removeItemAtPath:deletePath error:nil];
            }
        }
    }
}

@end
