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

- (void)siteInfoSuccess:(void (^)(id result))success failure:(void(^)(NSError *error))failure;

- (void)launchImageWithDevice:(NSString *)device success:(void (^)(id result))success failure:(void(^)(NSError *error))failure;

@end
