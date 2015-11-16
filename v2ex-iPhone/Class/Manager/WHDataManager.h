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
- (void)siteInfoSuccess:(void (^)(id result))success failure:(void(^)(NSError *error))failure;

- (void)titleCatalogsSuccess:(void(^)(NSArray *))success
               failure:(void(^)(NSError *error))failure;

- (void)topicLatestAtPage:(NSInteger)page success:(void(^)(NSArray *))success failure:(void(^)(NSError *error))failure;

- (void)topicDetailWithId:(NSString *)topicId success:(void(^)(NSArray *))success failure:(void(^)(NSError *error))failure;
@end
