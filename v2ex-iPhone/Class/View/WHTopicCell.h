//
//  WHTopicCell.h
//  
//
//  Created by hhw on 15/11/10.
//
//

#import <UIKit/UIKit.h>
#import "WHTopicModel.h"
#import <Foundation/Foundation.h>
@interface WHTopicCell : UITableViewCell
@property (nonatomic,strong) WHTopicModel *model;

+ (CGFloat)heighWithModel:(WHTopicModel *)model;

@end
