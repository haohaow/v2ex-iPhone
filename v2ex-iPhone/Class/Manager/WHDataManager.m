//
//  WHDataManager.m
//  v2ex-iPhone
//
//  Created by ;; on 15/10/20.
//  Copyright (c) 2015年 wuhao. All rights reserved.
//

#import "WHDataManager.h"
#import "WHMacros.h"
#import <AFNetworking.h>
typedef enum{
    WHRequestMethodGet = 0,
    WHRequestMethodPost = 1
} WHRequestMethod;

static NSString * const baseURLStr = @"http://www.v2ex.com";

@interface WHDataManager ()
{
    AFHTTPSessionManager *_manager;
}
@end

@implementation WHDataManager

- (instancetype)init
{
    self = [super init];
    if(self){
        NSURL *baseURL = [NSURL URLWithString:baseURLStr];
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    }
    return self;
}

+ (instancetype)sharedManager
{
    static WHDataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[WHDataManager alloc] init];
    });
    return manager;
}

- (void)requestWithMethod:(WHRequestMethod)method
                      URIString:(NSString *)URIString
                   params:(NSDictionary *)params
                  success:(void (^)(NSURLSessionDataTask *task,id responseObject))success
                  failure:(void (^)(NSURLSessionDataTask *task,NSError *error))failure
{
    //打开状态栏
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    //成功调用的block
    void(^successHandleBlock)(NSURLSessionDataTask *task,id responseObject) = ^(NSURLSessionDataTask *task,id responseObject){
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        success (task,responseObject);
    };
    //失败调用的block
    void(^failHandleBlock)(NSURLSessionDataTask *task, NSError *error) = ^(NSURLSessionDataTask *task,NSError *error){
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        failure (task,error);
    };
    //参数
    NSMutableDictionary *mutableParams = [NSMutableDictionary dictionaryWithDictionary:params];
    //请求
    if(method == WHRequestMethodGet){
      [_manager GET:URIString parameters:mutableParams success:^(NSURLSessionDataTask *task, id responseObject) {
          successHandleBlock(task,responseObject);
      } failure:^(NSURLSessionDataTask *task, NSError *error) {
          failHandleBlock(task,error);
      }];
    }else if(method == WHRequestMethodPost){
        [_manager POST:URIString parameters:mutableParams success:^(NSURLSessionDataTask *task, id responseObject) {
            successHandleBlock(task,responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            failHandleBlock(task,error);
        }];
    }
  
}

- (void)siteInfoSuccess:(void (^)(id result))success failure:(void(^)(NSError *error))failure
{
    [self requestWithMethod:WHRequestMethodGet URIString:API_SITEINFO params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}









@end
