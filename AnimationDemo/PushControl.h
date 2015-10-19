//
//  PushControl.h
//  AnimationDemo
//
//  Created by Coco on 15/10/16.
//  Copyright © 2015年 Pszertlek. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIViewController;
@interface PushControl : NSObject

+ (instancetype)shared;
- (void)ssss:(UIViewController *)vc;
- (void)dismiss;
@end
