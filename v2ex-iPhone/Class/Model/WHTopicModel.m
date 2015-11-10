//
//  WHTopicModel.m
//  
//
//  Created by hhw on 15/11/9.
//
//

#import "WHTopicModel.h"
#import "WHMacros.h"

@implementation WHTopicModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n*********分割线**********",_id,_title,_url,_content,_content_rendered,_replies,_created,_last_modified,_last_touched];
    
}

+ (NSArray *)topicModelsFromResponseObject:(id)responseObject
{
    NSMutableArray *models = [NSMutableArray array];
    
    return models;
}

@end
