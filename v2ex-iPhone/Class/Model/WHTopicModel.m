//
//  WHTopicModel.m
//  
//
//  Created by hhw on 15/11/9.
//
//

#import "WHTopicModel.h"
#import "WHMacros.h"
#import "NSString+Extension.h"
#import "HTMLParser.h"
@implementation WHTopicModel

+ (NSArray *)topicRecentFromResponseObject:(id)responseObject
{
    NSMutableArray *models = [NSMutableArray array];

    NSString *htmlString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    
    NSError *error = nil;
    HTMLParser *parser = [[HTMLParser alloc] initWithString:htmlString error:&error];
    if(error){
        WHLog(@"Error: %@",error);
    }
    HTMLNode *bodyNode = [parser body];
    HTMLNode *boxNode = [bodyNode findChildOfClass:@"box"];
    //每一列数据node
    NSArray *itemNodes = [boxNode findChildrenWithAttribute:@"class" matchingName:@"cell item" allowPartial:YES];
    //循环
    [itemNodes enumerateObjectsUsingBlock:^(HTMLNode *node, NSUInteger idx, BOOL *stop) {
        
        WHTopicModel *model = [[WHTopicModel alloc] init];
        model.creater = [[WHMemberModel alloc] init];
        model.node = [[WHNodeModel alloc] init];
        //头像
        model.creater.avatar_normal = [[node findChildTag:@"img"] getAttributeNamed:@"src"];
        //回复数量
        model.replies = [node findChildOfClass:@"count_livid"].contents;
        
        NSArray *spanNodes = [node findChildTags:@"span"];
        for (HTMLNode *node in spanNodes) {

            if([node.rawContents rangeOfString:@"item_title"].location != NSNotFound){
                HTMLNode *aNode = [node findChildTag:@"a"];
                model.title = aNode.contents;
                NSString *href = [aNode getAttributeNamed:@"href"];
                NSArray *hrefComponents = [href componentsSeparatedByString:@"#"];
                model.topicId = [hrefComponents.firstObject stringByReplacingOccurrencesOfString:@"/t/" withString:@""];
            }

            if([node.rawContents rangeOfString:@"small fade"].location != NSNotFound){
                if([node.rawContents rangeOfString:@"最后回复"].location != NSNotFound || [node.rawContents rangeOfString:@"前"].location != NSNotFound){
                    //最后回复人
                    HTMLNode *strongNode = [node findChildTag:@"strong"];
                    model.last_modified = [[strongNode findChildTag:@"a"] contents];
                    //时间
                    NSArray *components = [node.allContents componentsSeparatedByString:@"•"];
                    NSString *dateString;
                    dateString = components[0];
                    dateString = [dateString stringByReplacingOccurrencesOfString:@" " withString:@""];
                    model.last_touched = dateString;
                }else{
                    //节点
                    HTMLNode *aNode = [node findChildTag:@"a"];
                    model.node.name = aNode.contents;
                    model.node.url = [aNode getAttributeNamed:@"href"];
                    //作者
                    HTMLNode *createrNode = [[node findChildTag:@"strong"] findChildTag:@"a"];
                    model.creater.username = createrNode.contents;
                }
            }
            
        }
        [models addObject:model];
    }];
    return models;
}

- (NSString *)created
{
    NSDate *timesp = [NSDate dateWithTimeIntervalSince1970:[_created floatValue]];
    NSDateFormatter *utcDateFormatter = [[NSDateFormatter alloc] init];
    [utcDateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSString *dateFormat = @"yyyy-MM-dd HH:mm:ss";
    [utcDateFormatter setDateFormat:dateFormat];
    NSString *dateString = [utcDateFormatter stringFromDate:timesp];

    return [NSString dateDescWithDate:dateString DateFormat:dateFormat];
}

//- (NSString *)last_modified
//{
//    NSDate *timesp = [NSDate dateWithTimeIntervalSince1970:[_created floatValue]];
//    NSDateFormatter *utcDateFormatter = [[NSDateFormatter alloc] init];
//    [utcDateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
//    NSString *dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    [utcDateFormatter setDateFormat:dateFormat];
//    NSString *dateString = [utcDateFormatter stringFromDate:timesp];
//    
//    return [NSString dateDescWithDate:dateString DateFormat:dateFormat];
//}

@end
