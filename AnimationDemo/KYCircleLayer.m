//
//  KYCircleLayer.m
//  AnimationDemo
//
//  Created by Coco on 15/10/19.
//  Copyright © 2015年 Pszertlek. All rights reserved.
//

#import "KYCircleLayer.h"

#define kCornerRadius 45
#define outsideRectSize 90

@interface KYCircleLayer ()
{
    CGPoint pointA;
    CGPoint pointB;
    CGPoint pointC;
    CGPoint pointD;
    CGPoint c1;
    CGPoint c2;
    CGPoint c3;
    CGPoint c4;
    CGPoint c5;
    CGPoint c6;
    CGPoint c7;
    CGPoint c8;
    NSInteger movePoint;
    CGRect outsideRect;
    CGFloat offset;
}

@end

@implementation KYCircleLayer

- (instancetype)init
{
    if (self = [super init]) {
        offset = kCornerRadius / 1.8;
        self.progress = 0.5;
    }
    return self;
}
- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    movePoint = progress <= 0.5 ?0:1;
    CGFloat x = self.position.x - kCornerRadius + (progress - 0.5) * (self.frame.size.width - 2 *kCornerRadius);
    CGFloat y = self.position.y - kCornerRadius  ;
    outsideRect = CGRectMake(x, y, 2 * kCornerRadius,2 * kCornerRadius);
    CGPoint rectCenter = CGPointMake(x + kCornerRadius, y + kCornerRadius);
    
    CGFloat movedDistance = kCornerRadius / 3 * fabs(self.progress - 0.5) * 2;
    
    pointA = CGPointMake(rectCenter.x ,outsideRect.origin.y + movedDistance);
    pointB = CGPointMake(movePoint == 0 ? rectCenter.x + outsideRect.size.width/2 : rectCenter.x + outsideRect.size.width/2 + movedDistance*2 ,rectCenter.y);
    pointC = CGPointMake(rectCenter.x ,rectCenter.y + outsideRect.size.height/2 - movedDistance);
    pointD = CGPointMake(movePoint == 0 ? outsideRect.origin.x - movedDistance*2 : outsideRect.origin.x, rectCenter.y);
    
    c1 = CGPointMake(pointA.x + offset, pointA.y);
    c2 = CGPointMake(pointB.x, movePoint == 0 ? pointB.y - offset : pointB.y - offset + movedDistance);
    
    c3 = CGPointMake(pointB.x, movePoint == 0 ? pointB.y + offset : pointB.y + offset - movedDistance);
    c4 = CGPointMake(pointC.x + offset, pointC.y);
    
    c5 = CGPointMake(pointC.x - offset, pointC.y);
    c6 = CGPointMake(pointD.x, movePoint == 0 ? pointD.y + offset - movedDistance : pointD.y + offset);
    
    c7 = CGPointMake(pointD.x, movePoint == 0 ? pointD.y - offset + movedDistance : pointD.y - offset);
    c8 = CGPointMake(pointA.x - offset, pointA.y);
    
    [self setNeedsDisplay];
}

- (void)drawInContext:(CGContextRef)ctx
{
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:outsideRect];
    CGContextAddPath(ctx, path.CGPath);
    CGContextSetStrokeColorWithColor(ctx, [UIColor purpleColor].CGColor);
    CGFloat dash[] = {5.0,5.0};
    CGContextSetLineDash(ctx, 0, dash, 2);
    CGContextSetLineWidth(ctx, 1.0);
    CGContextStrokePath(ctx);
    
    path = [UIBezierPath bezierPath];
    [path moveToPoint:pointA];
    [path addCurveToPoint:pointB controlPoint1:c1 controlPoint2:c2];
    [path addCurveToPoint:pointC controlPoint1:c3 controlPoint2:c4];
    [path addCurveToPoint:pointD controlPoint1:c5 controlPoint2:c6];
    [path addCurveToPoint:pointA controlPoint1:c7 controlPoint2:c8];
    [path closePath];
    CGContextAddPath(ctx, path.CGPath);
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextFillPath(ctx);
    CGContextSetLineDash(ctx, 0, NULL, 0);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextStrokePath(ctx);
    
}

- (void)drawPoints:(NSArray *)points withContext:(CGContextRef)ctx{
    for (NSValue *pointValue in points) {
        CGPoint point = [pointValue CGPointValue];
        CGContextFillRect(ctx, CGRectMake(point.x - 2, point.y - 2, 2, 2));
    }
}

@end
