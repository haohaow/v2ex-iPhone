//
//  WHCatalogModel.h
//  v2ex-iPhone
//
//  Created by hhw on 15/10/22.
//  Copyright (c) 2015年 wuhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WHTitleModel : NSObject

@property (nonatomic,copy) NSString *label;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSArray *node;

@end

@interface WHNodeModel : NSObject

@property (nonatomic,copy) NSString *label;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *header;
@property (nonatomic,copy) NSString *nodeImageUrl;

@end
