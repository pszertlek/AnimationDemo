//
//  KYCircleView.m
//  AnimationDemo
//
//  Created by Coco on 15/10/19.
//  Copyright © 2015年 Pszertlek. All rights reserved.
//

#import "KYCircleView.h"
#import "KYCircleLayer.h"

@interface KYCircleView ()


@end
@implementation KYCircleView

+ (Class)layerClass{
    return [KYCircleLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.circleLayer = [[KYCircleLayer alloc]init];
        _circleLayer.frame = self.bounds;
        [self.layer addSublayer:_circleLayer];
    }
    return self;
}

- (void)awakeFromNib
{
    self.circleLayer = [[KYCircleLayer alloc]init];
    _circleLayer.frame = self.bounds;
    _circleLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.layer addSublayer:_circleLayer];
}

- (void)setProgress:(CGFloat)progress
{
    _circleLayer.progress = progress;
}

@end
