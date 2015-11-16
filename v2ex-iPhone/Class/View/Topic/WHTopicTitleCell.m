//
//  WHTopicTitleCell.m
//  v2ex-iPhone
//
//  Created by hhw on 15/11/16.
//  Copyright © 2015年 wuhao. All rights reserved.
//

#import "WHTopicTitleCell.h"

static CGFloat const kTitleFontSize         = 15.0f;

@implementation WHTopicTitleCell
{
    UILabel *_titleLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:kTitleFontSize];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

















@end
