//
//  WHCatalogModel.h
//  v2ex-iPhone
//
//  Created by hhw on 15/10/22.
//  Copyright (c) 2015年 wuhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WHCatalogModel : NSObject
@property (nonatomic,copy) NSString *catalogLabel;
@property (nonatomic,copy) NSString *catalogName;

- (instancetype)initWithDictionay:(NSDictionary *)dict;

@end
