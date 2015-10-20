//
//  KYGooeySlideMenu.h
//  AnimationDemo
//
//  Created by Coco on 15/10/20.
//  Copyright © 2015年 Pszertlek. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MenuButtonClickedBlock)(NSInteger index,NSString *title,NSInteger titleCounts);

@interface KYGooeySlideMenu : UIView

/**
 *  Convenient init method
 *
 *  @param titles Your menu options
 *
 *  @return object
 */

-(id)initWithTitles:(NSArray *)titles;


/**
 *  Custom init method
 *
 *  @param titles Your menu options
 *
 *  @return object
 */
-(id)initWithTitles:(NSArray *)titles withButtonHeight:(CGFloat)height withMenuColor:(UIColor *)menuColor withBackBlurStyle:(UIBlurEffectStyle)style;


/**
 *  Method to trigger the animation
 */
-(void)trigger;




/**
 *  The height of the menu height
 */
@property(nonatomic,assign)CGFloat menuButtonHeight;


/**
 *  The block of menu buttons cliced
 */
@property(nonatomic,copy)MenuButtonClickedBlock menuClickBlock;

@end