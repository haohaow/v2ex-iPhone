//
//  WHViewPageIndicator.m
//  v2ex-iPhone
//
//  Created by hhw on 15/10/22.
//  Copyright (c) 2015年 wuhao. All rights reserved.
//

#import "WHViewPageIndicator.h"
#import "WHMacros.h"

@implementation WHViewPageIndicator
{
    UIView *_indicatorView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        _indicatorView = [[UIView alloc] initWithFrame:frame];
//        _indicatorView.backgroundColor = WHColor(104, 104, 104);
        _indicatorView.backgroundColor = [UIColor redColor];
        [self addSubview:_indicatorView];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    [_indicatorView setNeedsDisplay];
//}


@end
