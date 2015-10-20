//
//  KYSlideMenuButton.h
//  AnimationDemo
//
//  Created by Coco on 15/10/20.
//  Copyright © 2015年 Pszertlek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KYSlideMenuButton : UIView

@property (nonatomic ,strong) NSString *title;

@property (nonatomic ,strong) UIColor *buttonColor;

@property (nonatomic ,copy) dispatch_block_t block;

@end
