//
//  KYCircleLayer.m
//  AnimationDemo
//
//  Created by Coco on 15/10/19.
//  Copyright © 2015年 Pszertlek. All rights reserved.
//

#import "KYCircleLayer.h"

#define kCornerRadius 90
@interface KYCircleLayer ()
{
    CGPoint pointA;
    CGPoint pointB;
    CGPoint pointC;
    CGPoint pointD;
    CGPoint movePoint;
    CGRect outsideRect;
}

@end

@implementation KYCircleLayer

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    movePoint = progress <= 0.5 ?0:1;
    CGPoint x = self.position.x - kCornerRadius /2 + (progress - 0.5);
    [self setNeedsDisplay];
}

- (void)drawInContext:(CGContextRef)ctx
{
    
}


@end
