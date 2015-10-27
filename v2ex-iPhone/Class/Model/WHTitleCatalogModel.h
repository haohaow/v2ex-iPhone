//
//  WHCatalogModel.h
//  v2ex-iPhone
//
//  Created by hhw on 15/10/22.
//  Copyright (c) 2015年 wuhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WHTitleCatalogModel : NSObject
@property (nonatomic,copy) NSString *label;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSArray *catalogs;

- (instancetype)initWithDictionay:(NSDictionary *)dict;

@end

@interface WHCatalogModel : NSObject

@property (nonatomic,copy) NSString *label;
@property (nonatomic,copy) NSString *name;
@end
