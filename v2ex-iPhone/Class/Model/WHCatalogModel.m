//
//  WHCatalogModel.m
//  v2ex-iPhone
//
//  Created by hhw on 15/10/22.
//  Copyright (c) 2015年 wuhao. All rights reserved.
//

#import "WHCatalogModel.h"

@implementation WHCatalogModel

- (instancetype)initWithDictionay:(NSDictionary *)dict
{
    self = [super init];
    if(self){
        self.catalogLabel = dict[@"catalogLabel"];
        self.catalogName = dict[@"catalogName"];
    }
    return self;
}

@end
