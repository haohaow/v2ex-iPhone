//
//  WHCatalogModel.m
//  v2ex-iPhone
//
//  Created by hhw on 15/10/22.
//  Copyright (c) 2015年 wuhao. All rights reserved.
//

#import "WHTitleModel.h"
#import "HTMLParser.h"
#import "WHMacros.h"

@implementation WHTitleModel
+ (NSArray *)titleCatalogsFromResponseObject:(id)responseObject
{
    NSMutableArray *catalogs = [NSMutableArray array];
    
    NSString *htmlString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
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
        WHTitleModel *title = [[WHTitleModel alloc] init];
        title.name = [[node getAttributeNamed:@"href"] stringByReplacingOccurrencesOfString:@"/?tab=" withString:@""];
        title.label = [node contents];
        
        [catalogs addObject:title];
    }];
    
    return catalogs;
}
@end

@implementation WHNodeModel

@end