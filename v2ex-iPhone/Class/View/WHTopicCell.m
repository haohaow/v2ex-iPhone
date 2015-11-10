//
//  WHTopicCell.m
//  
//
//  Created by hhw on 15/11/10.
//
//

#import "WHTopicCell.h"
#import <WHMacros.h>

@implementation WHTopicCell
{
    /** 头像 */
    UIImageView *_avatarImageView;
    UILabel *_titleLabel;
    UILabel *_nodeLabel;
    UILabel *_memberLabel;
    UILabel *_lastReplyTimeLabel;
    UILabel *_lastReplyMemberLabel;
    UILabel *_replyCountLabel;
    /**cell顶部分割线*/
    UIView *_topLineView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubviews];
    }
    return self;
}

- (void)layoutSubviews
{
    
}

- (void)setupSubviews
{
    _avatarImageView = [[UIImageView alloc] init];
    _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_avatarImageView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.backgroundColor = nil;
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textColor = WHColor(112,110,103);
    [self.contentView addSubview:_titleLabel];
    
    _nodeLabel = [[UILabel alloc] init];
    _nodeLabel.backgroundColor = WHColor(245,245,245);
    _nodeLabel.font = [UIFont systemFontOfSize:12];
    _nodeLabel.textColor = WHColor(162,162,162);
    [self.contentView addSubview:_nodeLabel];
    
    _memberLabel = [[UILabel alloc] init];
    _memberLabel.backgroundColor = nil;
    _memberLabel.font = [UIFont systemFontOfSize:12];
    _memberLabel.textColor = WHColor(119,128,136);
    [self.contentView addSubview:_nodeLabel];

    _lastReplyTimeLabel = [[UILabel alloc] init];
    _lastReplyTimeLabel.backgroundColor = nil;
    _lastReplyTimeLabel.font = [UIFont systemFontOfSize:12];
    _lastReplyTimeLabel.textColor = WHColor(245,245,245);
    [self.contentView addSubview:_lastReplyTimeLabel];
    
    _lastReplyMemberLabel = [[UILabel alloc] init];
    _lastReplyMemberLabel.backgroundColor = nil;
    _lastReplyMemberLabel.font = [UIFont systemFontOfSize:12];
    _lastReplyMemberLabel.textColor = WHColor(112,110,103);
    [self.contentView addSubview:_lastReplyMemberLabel];
    
    _replyCountLabel = [[UILabel alloc] init];
    _replyCountLabel.backgroundColor = WHColor(112,110,103);
    _replyCountLabel.font = [UIFont systemFontOfSize:12];
    _replyCountLabel.textColor = [UIColor whiteColor];
    
}

- (void)setModel:(WHTopicModel *)model
{
    
}


























@end
