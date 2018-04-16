//
//  LoadData.m
//  manager
//
//  Created by 王博 on 16/1/5.
//  Copyright © 2016年 aoli. All rights reserved.
//

#import "LoadData.h"
#import "AFNetworking.h"
@interface LoadData ()

@end
@implementation LoadData

//懒加载
+(AFHTTPSessionManager*)manager{

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

//    [_manager.requestSerializer setValue:[NSString stringWithFormat:@"JSESSIONID=%@", self.singleGlobal.SID] forHTTPHeaderField:@"Cookie"];
    return manager;
}

+(void)RequestWithString:(NSString*)urlStr isPost:(BOOL)isPost andPara:(NSDictionary*)para andComplete:(Complete)complete{
    
    if (isPost) {
    
        [self POSTWithUrl:urlStr andPara:para andComplete:complete];
    }else{
     [self GETWithUrl:urlStr andComplete:complete];
    }
}

+(void)GETWithUrl:(NSString*)urlStr andComplete:(Complete)complete{
    [self.manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        complete(responseObject,YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(nil,NO);
    }];
}

+(void)POSTWithUrl:(NSString*)urlStr andPara:(NSDictionary*)para andComplete:(Complete)complete{
    
    [self.manager POST:urlStr parameters:para progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        complete(responseObject,YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(nil,NO);
    }];
}

+(NSString *)formatUrlNSDictionary:(NSDictionary *)dic andNeedUrlEncode:(BOOL)isNeedUrlEncode andKeyToLower :(BOOL )isNeedLower{
    
    NSArray *itemAllKey = [[dic allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString *key1 = (NSString *)obj1;
        NSString *key2 =  (NSString *)obj2;
        return [key1 compare:key2];
    }];
    NSMutableArray *keyValues = [NSMutableArray arrayWithCapacity:0];
    for (NSString * itemKey in itemAllKey) {
        NSString *itemValue = [dic objectForKey: itemKey];
        NSString*endKey;
        NSString *endValue;
        if (isNeedLower) {
            endKey = itemKey. lowercaseString;
            endValue = itemValue.lowercaseString;
        }
        if (isNeedUrlEncode) {
            endValue = [endValue stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        [keyValues addObject:[NSString stringWithFormat:@"%@=%@",endKey,endValue]];
    }
    return [keyValues componentsJoinedByString:@"&"];
}

@end
