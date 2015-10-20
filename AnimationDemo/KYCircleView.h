//
//  KYCircleView.h
//  AnimationDemo
//
//  Created by Coco on 15/10/19.
//  Copyright © 2015年 Pszertlek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KYCircleLayer.h"
@interface KYCircleView : UIView

@property (nonatomic, strong) KYCircleLayer *circleLayer;

@property (nonatomic ,assign) CGFloat progress;
@end
