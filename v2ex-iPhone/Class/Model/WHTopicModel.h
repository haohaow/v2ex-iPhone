//
//  WHTopicModel.h
//  
//
//  Created by hhw on 15/11/9.
//
//

#import <Foundation/Foundation.h>
#import "WHMemberModel.h"
#import "WHNodeModel.h"
#import <UIKit/UIKit.h>
@interface WHTopicModel : NSObject

@property (nonatomic,copy) NSString *topicId;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *content_rendered;
@property (nonatomic,copy) NSString *replies;
@property (nonatomic,copy) NSString *created;
@property (nonatomic,copy) NSString *last_modified;
@property (nonatomic,copy) NSString *last_touched;

@property (nonatomic,strong) WHMemberModel *creater;
@property (nonatomic,strong) WHNodeModel *node;

@property (nonatomic,assign) CGFloat titleHeight;
+ (NSArray *)topicRecentFromResponseObject:(id)responseObject;

@end
