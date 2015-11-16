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

@implementation WHTopicModel

+ (NSArray *)topicModelsFromResponseObject:(id)responseObject
{
    NSMutableArray *models = [NSMutableArray array];
    
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

- (NSString *)last_modified
{
    NSDate *timesp = [NSDate dateWithTimeIntervalSince1970:[_created floatValue]];
    NSDateFormatter *utcDateFormatter = [[NSDateFormatter alloc] init];
    [utcDateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSString *dateFormat = @"yyyy-MM-dd HH:mm:ss";
    [utcDateFormatter setDateFormat:dateFormat];
    NSString *dateString = [utcDateFormatter stringFromDate:timesp];
    
    return [NSString dateDescWithDate:dateString DateFormat:dateFormat];
}

@end
