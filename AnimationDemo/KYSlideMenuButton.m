//
//  KYSlideMenuButton.m
//  AnimationDemo
//
//  Created by Coco on 15/10/20.
//  Copyright © 2015年 Pszertlek. All rights reserved.
//

#import "KYSlideMenuButton.h"

@implementation KYSlideMenuButton

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    [self.buttonColor setFill];
    [path fill];
    
    path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(1, 1, rect.size.width - 2, rect.size.height - 2) cornerRadius:2];
    [[UIColor whiteColor]setStroke];
    path.lineWidth = 1;
    [path stroke];
    
    NSDictionary *attr = @{NSParagraphStyleAttributeName:[NSParagraphStyle defaultParagraphStyle],NSFontAttributeName:[UIFont systemFontOfSize:24],NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self.title drawInRect:rect withAttributes:attr];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.block();
}
@end
