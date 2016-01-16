//
//  lookingAnimationView.m
//  UBERGuide
//
//  Created by 叔 陈 on 16/1/16.
//  Copyright © 2016年 hACKbUSTER. All rights reserved.
//

#import "lookingAnimationView.h"
#import "UIView+ViewFrameGeometry.h"
#import "circleLoadingView.h"

@interface lookingAnimationView()
{
    circleLoadingView *_circleLoading;
}

@end

@implementation lookingAnimationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _circleLoading = [[circleLoadingView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.width, 20.0f)];
        [self addSubview:_circleLoading];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, _circleLoading.bottom + 10.0f, self.width, 21.0f)];
        _titleLabel.text = @"Looking for rides";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithRed:0.29f green:0.73f blue:0.89f alpha:1.0f];;
        _titleLabel.font = [UIFont systemFontOfSize:18.0f];
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void)animate
{
    _titleLabel.text = @"Looking for rides";
    [_circleLoading animate];
}
@end
