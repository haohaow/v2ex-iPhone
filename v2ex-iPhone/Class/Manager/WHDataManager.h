//
//  WHDataManager.h
//  v2ex-iPhone
//
//  Created by hhw on 15/10/20.
//  Copyright (c) 2015年 wuhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WHDataManager : NSObject

+ (instancetype)sharedManager;

#pragma mark - Get
//网站信息
- (void)siteInfoSuccess:(void (^)(id result))success failure:(void(^)(NSError *error))failure;
//最近的主题
- (void)topicRecentWithPage:(NSInteger)page
                    succses:(void (^)(NSArray *))success
                    failure:(void(^)(NSError *error))failure;

- (void)titleCatalogsSuccess:(void(^)(NSArray *))success
               failure:(void(^)(NSError *error))failure;

- (void)topicLatestAtPage:(NSInteger)page success:(void(^)(NSArray *))success failure:(void(^)(NSError *error))failure;
//单条主题详情
- (void)topicDetailWithId:(NSString *)topicId success:(void(^)(NSArray *))success failure:(void(^)(NSError *error))failure;
@end
