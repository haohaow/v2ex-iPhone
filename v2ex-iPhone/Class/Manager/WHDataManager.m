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
#import "HTMLParser.h"
#import "WHTitleCatalogModel.h"
#define API_SITEINFO @"api/site/info.json"

typedef enum{
    WHRequestMethodGet = 0,
    WHRequestMethodPost = 1
} WHRequestMethod;

static NSString * const baseURLStr = @"http://www.v2ex.com";

@implementation WHDataManager

{
    AFHTTPSessionManager *_manager;
    NSString *_userAgentMobile;
    NSString *_userAgentPC;
}

- (instancetype)init
{
    self = [super init];
    if(self){
        UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectZero];
        _userAgentMobile = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
        _userAgentPC = @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.71 Safari/537.36";
        
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

    [_manager.requestSerializer setValue:_userAgentMobile forHTTPHeaderField:@"User-Agent"];

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

- (void)titleCatalogsSuccess:(void(^)(NSArray *))success
               failure:(void(^)(NSError *error))failure
{
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [self requestWithMethod:WHRequestMethodGet URIString:@"" params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *nodes = [self titleCatalogsWithResponseObject:responseObject];
        success(nodes);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}


#pragma mark private method

- (NSArray *)titleCatalogsWithResponseObject:(id)responseObject
{
    NSMutableArray *catalogs = [NSMutableArray array];
    
    NSString *htmlString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//    WHLog(@"htmlString:%@",htmlString);
    NSError *error = nil;
    HTMLParser *parser = [[HTMLParser alloc] initWithString:htmlString error:&error];
    if(error){
        WHLog(@"Error: %@",error);
    }
    
    HTMLNode *bodyNode = [parser body];
    
    HTMLNode *wrapperDiv = [bodyNode findChildWithAttribute:@"id" matchingName:@"Wrapper" allowPartial:YES];
    HTMLNode *contentDiv = [wrapperDiv findChildOfClass:@"content"];

    HTMLNode *cellNode = [contentDiv findChildOfClass:@"cell"];
    NSArray *aNodes = [cellNode findChildTags:@"a"];
    
    [aNodes enumerateObjectsUsingBlock:^(HTMLNode *node, NSUInteger idx, BOOL *stop) {
        WHTitleCatalogModel *catalog = [[WHTitleCatalogModel alloc] init];
        catalog.name = [[node getAttributeNamed:@"href"] stringByReplacingOccurrencesOfString:@"/?tab=" withString:@""];
        catalog.label = [node contents];
//        WHLog(@"node content:%@",[node contents]);
//        WHLog(@"node name:%@", [[node getAttributeNamed:@"href"] stringByReplacingOccurrencesOfString:@"/?tab=" withString:@""]);
        [catalogs addObject:catalog];
    }];

    return catalogs;
}







@end
