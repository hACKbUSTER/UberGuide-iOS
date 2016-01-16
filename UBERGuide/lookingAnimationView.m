//
//  lookingAnimationView.m
//  UBERGuide
//
//  Created by 叔 陈 on 16/1/16.
//  Copyright © 2016年 hACKbUSTER. All rights reserved.
//

#import "lookingAnimationView.h"
#import "UIView+ViewFrameGeometry.h"

@interface lookingAnimationView()
{
    UIView *_leftCircle;
    UIView *_centerCircle;
    UIView *_rightCircle;
    UILabel *_titleLabel;
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
        [self initSubView];
    }
    return self;
}

- (void)initSubView
{
    CGFloat width = 10.0f;
    _leftCircle = [[UIView alloc]initWithFrame:CGRectMake((self.width - 7*width)/2.0f, 0.0f, width, width)];
    _leftCircle.layer.cornerRadius = width/2.0f;
    _leftCircle.backgroundColor = [UIColor blueColor];
    
    _centerCircle = [[UIView alloc]initWithFrame:CGRectMake(_leftCircle.right + width * 2.0f, 0.0f, width, width)];
    _centerCircle.layer.cornerRadius = width/2.0f;
    _centerCircle.backgroundColor = [UIColor blueColor];
    
    _rightCircle = [[UIView alloc]initWithFrame:CGRectMake(_centerCircle.right + width * 2.0f, 0.0f, width, width)];
    
    _rightCircle.layer.cornerRadius = width/2.0f;
    _rightCircle.backgroundColor = [UIColor blueColor];
    
    [self addSubview:_leftCircle];
    [self addSubview:_centerCircle];
    [self addSubview:_rightCircle];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, _centerCircle.bottom + 10.0f, self.width, 21.0f)];
    _titleLabel.text = @"Looking for rides";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor blueColor];
    _titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [self addSubview:_titleLabel];
}

@end
