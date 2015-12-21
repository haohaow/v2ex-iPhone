//
//  WHTopicCell.m
//  
//
//  Created by hhw on 15/11/10.
//
//

#import "WHTopicCell.h"
#import <WHMacros.h>
#import "UIView+Extension.h"
#import <UIImageView+WebCache.h>
#import "WHMemberModel.h"
#import "WHNodeModel.h"
#import "NSString+Extension.h"


static CGFloat const kAvatarHeight          = 25.0f;
static CGFloat const kTitleFontSize         = 15.0f;
static CGFloat const kOtherFontSize = 12.0f;

static CGFloat const kGapHeight = 5.0f;
static CGFloat const kGapWidth = 5.0f;

@implementation WHTopicCell
{
    /** 头像 */
    UIImageView *_avatarImageView;
    UILabel *_titleLabel;
    UILabel *_nodeLabel;
    UILabel *_memberLabel;
    UILabel *_lastReplyTimeLabel;
    UILabel *_lastReplyMemberLabel;
    UILabel *_repliesLabel;
    /**cell分割线*/
    UIView *_topLineView;
    UIView *_bottomLineView;
    /** 标题高度*/
    NSInteger _titleHeight;

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
    
    [super layoutSubviews];
    _avatarImageView.frame = CGRectMake(5,10, kAvatarHeight, kAvatarHeight);
    _nodeLabel.origin =  CGPointMake(CGRectGetMaxY(_avatarImageView.frame)+kGapWidth, 10);
    _memberLabel.origin = CGPointMake(_nodeLabel.x + _nodeLabel.width + kGapWidth, _nodeLabel.y);
    
    _titleLabel.frame = CGRectMake(_nodeLabel.x, CGRectGetMaxY(_nodeLabel.frame) + kGapHeight, kScreenWidth -20 - kAvatarHeight, _titleHeight);

    _repliesLabel.origin = CGPointMake(kScreenWidth - 10 - _repliesLabel.width,_nodeLabel.y);
    
    _lastReplyTimeLabel.origin = CGPointMake(_titleLabel.x,  _titleLabel.y + _titleHeight + kGapHeight );
    
    _lastReplyMemberLabel.origin = CGPointMake(CGRectGetMaxX(_lastReplyTimeLabel.frame) + 10, _lastReplyTimeLabel.y);
    
    _bottomLineView.frame   = CGRectMake(0, self.height-0.5, kScreenWidth, 0.5);

}

- (void)setupSubviews
{
    
    _avatarImageView = [[UIImageView alloc] init];
    _avatarImageView.layer.masksToBounds = YES;
    _avatarImageView.layer.cornerRadius = 4.0; //设置图片圆角的尺度
    _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    _avatarImageView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_avatarImageView];
    
    _nodeLabel = [[UILabel alloc] init];
    _nodeLabel.backgroundColor = WHColor(245,245,245);
    _nodeLabel.font = [UIFont systemFontOfSize:kOtherFontSize];
    _nodeLabel.textColor = WHColor(162,162,162);
    [self.contentView addSubview:_nodeLabel];
    
    _memberLabel = [[UILabel alloc] init];
    _memberLabel.backgroundColor = [UIColor whiteColor];
    _memberLabel.font = [UIFont boldSystemFontOfSize:kOtherFontSize];
    _memberLabel.textColor = WHColor(119,128,136);
    [self.contentView addSubview:_memberLabel];

    
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.backgroundColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:kTitleFontSize];
    _titleLabel.textColor = WHColor(112,110,103);
    _titleLabel.numberOfLines           = 0;
    _titleLabel.lineBreakMode           = NSLineBreakByTruncatingTail|NSLineBreakByCharWrapping;
    [self.contentView addSubview:_titleLabel];
    
    
    _lastReplyTimeLabel = [[UILabel alloc] init];
    _lastReplyTimeLabel.backgroundColor = [UIColor whiteColor];
    _lastReplyTimeLabel.font = [UIFont systemFontOfSize:kOtherFontSize];
    _lastReplyTimeLabel.textColor = WHColor(162,162,162);
    [self.contentView addSubview:_lastReplyTimeLabel];
    
    _lastReplyMemberLabel = [[UILabel alloc] init];
    _lastReplyMemberLabel.backgroundColor = [UIColor whiteColor];
    _lastReplyMemberLabel.font = [UIFont systemFontOfSize:kOtherFontSize];
    _lastReplyMemberLabel.textColor = WHColor(119,128,136);
    [self.contentView addSubview:_lastReplyMemberLabel];
    
    _repliesLabel = [[UILabel alloc] init];
    _repliesLabel.layer.masksToBounds = YES;
    _repliesLabel.layer.cornerRadius = 6.0; //设置图片圆角的尺度
    _repliesLabel.backgroundColor = WHColor(170,176,197);
    _repliesLabel.font = [UIFont systemFontOfSize:kOtherFontSize];
    _repliesLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_repliesLabel];
    
    _topLineView = [[UIView alloc] init];
    [self.contentView addSubview:_topLineView];
    
    _bottomLineView = [[UIView alloc] init];
    _bottomLineView.backgroundColor = [UIColor grayColor];
    _bottomLineView.alpha = 0.3;
    [self.contentView addSubview:_bottomLineView];
}

- (void)setModel:(WHTopicModel *)model
{
    _model = model;
    
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:[@"http:" stringByAppendingString:model.creater.avatar_normal==NULL?@"":model.creater.avatar_normal]] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    
    _nodeLabel.text = model.node.name;
    _nodeLabel.textAlignment = NSTextAlignmentCenter;
    [_nodeLabel sizeToFit];
    _nodeLabel.width += 10;
    
    _memberLabel.text = model.creater.username;
    [_memberLabel sizeToFit];
    
    _titleLabel.text = model.title;

    //最后回复时间未取到
    _lastReplyTimeLabel.text =model.last_touched;
    [_lastReplyTimeLabel sizeToFit];
    
    if(model.last_modified){
        _lastReplyMemberLabel.text = [NSString stringWithFormat:@"最后回复 %@",model.last_modified];
        [_lastReplyMemberLabel sizeToFit];    
    }
    
    _repliesLabel.text = model.replies;
    _repliesLabel.textAlignment = NSTextAlignmentCenter;
    [_repliesLabel sizeToFit];
    _repliesLabel.width += 20;
    
    _titleHeight = ceil(model.titleHeight);
}

+ (CGFloat)heighWithModel:(WHTopicModel *)model
{
    CGFloat titleHeight = [NSString textHeighWithString:model.title Font:[UIFont systemFontOfSize:kTitleFontSize] Width:kScreenWidth -20 - kAvatarHeight];
    //cell上部分高度，以node为标准来计算
    CGFloat topHeight = [NSString textHeighWithString:model.node.name Font:[UIFont systemFontOfSize:kOtherFontSize]];
    
    model.titleHeight = titleHeight;
    CGFloat cellHeight = titleHeight + topHeight * 2 + kGapHeight * 4;
    return cellHeight+10;
}
























@end
