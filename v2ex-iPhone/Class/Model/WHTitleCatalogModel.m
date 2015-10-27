//
//  WHCatalogModel.m
//  v2ex-iPhone
//
//  Created by hhw on 15/10/22.
//  Copyright (c) 2015年 wuhao. All rights reserved.
//

#import "WHTitleCatalogModel.h"

@implementation WHTitleCatalogModel

- (instancetype)initWithDictionay:(NSDictionary *)dict
{
    self = [super init];
    if(self){
        self.label = dict[@"catalogLabel"];
        self.name = dict[@"catalogName"];
    }
    return self;
}

@end

@implementation WHCatalogModel


@end