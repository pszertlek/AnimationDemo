//
//  PushControl.m
//  AnimationDemo
//
//  Created by Coco on 15/10/16.
//  Copyright © 2015年 Pszertlek. All rights reserved.
//

#import "PushControl.h"
#import <UIKit/UIKit.h>
@implementation PushControl

+ (instancetype)shared
{
    static PushControl *control;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        control = [[PushControl alloc]init];
    });
    return control;
}

- (void)ssss:(UIViewController *)vc
{
//    UINavigationController *nv = [[UINavigationController alloc]initWithRootViewController:vc];
//    nv.view.tag = 1000;
//    nv.view.frame = [UIApplication sharedApplication].keyWindow.frame;
    vc.view.tag = 1000;
    [[UIApplication sharedApplication].keyWindow addSubview:vc.view];
}

- (void)dismiss
{
    [[[UIApplication sharedApplication].keyWindow viewWithTag:1000]removeFromSuperview];
}
@end
