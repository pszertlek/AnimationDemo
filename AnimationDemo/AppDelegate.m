//
//  AppDelegate.m
//  AnimationDemo
//
//  Created by Coco on 15/10/14.
//  Copyright © 2015年 Pszertlek. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor colorWithRed:128./255 green:0 blue:0 alpha:1];
    UIViewController *navc = self.window.rootViewController;
    //logo mask
    CALayer *maskLayer = [CALayer layer];
    maskLayer.contents = (id)[UIImage imageNamed:@"logo"].CGImage;
    maskLayer.frame = CGRectMake(0, 0, 60, 60);
    maskLayer.position = CGPointMake(self.window.frame.size.width/2, self.window.frame.size.height/2);
    navc.view.layer.mask = maskLayer;
    
    //logo mask background view
    UIView *maskBackgroundView = [[UIView alloc]initWithFrame:navc.view.bounds];
    maskBackgroundView.backgroundColor = [UIColor whiteColor];
    [navc.view addSubview:maskBackgroundView];
    [navc.view bringSubviewToFront:maskBackgroundView];
    
    
    //logo mask animation
    CAKeyframeAnimation *logoMaskAnimaiton = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];
    logoMaskAnimaiton.duration = 1.0f;
    logoMaskAnimaiton.beginTime = CACurrentMediaTime() + 1.0f;//延迟一秒
    
    CGRect initalBounds = maskLayer.bounds;
    CGRect secondBounds = CGRectMake(0, 0, 50, 50);
    CGRect finalBounds  = CGRectMake(0, 0, 2000, 2000);
    logoMaskAnimaiton.values = @[[NSValue valueWithCGRect:initalBounds],[NSValue valueWithCGRect:secondBounds],[NSValue valueWithCGRect:finalBounds]];
    logoMaskAnimaiton.keyTimes = @[@(0),@(0.5),@(1)];
    logoMaskAnimaiton.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    logoMaskAnimaiton.removedOnCompletion = NO;
    logoMaskAnimaiton.fillMode = kCAFillModeForwards;
    [navc.view.layer.mask addAnimation:logoMaskAnimaiton forKey:@"logoMaskAnimaiton"];
    
    
    //maskBackgroundView fade animation
    [UIView animateWithDuration:0.1 delay:1.7 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        maskBackgroundView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [maskBackgroundView removeFromSuperview];
        navc.view.layer.mask = nil;

    }];
    
    
    //navc.view bounce animation
//    [UIView animateWithDuration:0.25 delay:1.3 options:UIViewAnimationOptionTransitionNone animations:^{
//        
//        navc.view.transform = CGAffineTransformMakeScale(1.05, 1.05);
//        
//    } completion:^(BOOL finished) {
//        
//        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//            
//            navc.view.transform = CGAffineTransformMakeScale(1.02, 1.02);
//            
//        } completion:^(BOOL finished) {
//            
//            navc.view.layer.mask = nil;
//            
//        }];
//    }];
    /*
    CALayer *mask = [CALayer layer];
    mask.contents = (id)[UIImage imageNamed:@"logo"].CGImage;
    mask.frame = CGRectMake(0, 0, 60, 60);

    mask.position = vc.view.center;
    vc.view.layer.mask = mask;
    
    UIView *bg = [[UIView alloc]init];
    bg.frame = vc.view.bounds;
    bg.backgroundColor = [UIColor whiteColor];
    [vc.view addSubview:bg];
    
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];
    keyframeAnimation.keyTimes = @[@(0),@(0.5),@(1)];
    CGRect rect1 = mask.bounds;
    CGRect rect2 = CGRectMake(0, 0, 50, 50);
    CGRect rect3 = CGRectMake(0, 0, 2000, 2000);
    keyframeAnimation.values = @[[NSValue valueWithCGRect:rect1],[NSValue valueWithCGRect:rect2],[NSValue valueWithCGRect:rect3]];
    keyframeAnimation.duration = 1.0;
    keyframeAnimation.beginTime = CACurrentMediaTime() + 1.0;
    keyframeAnimation.removedOnCompletion = NO;
    keyframeAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    keyframeAnimation.fillMode = kCAFillModeForwards;
    [vc.view.layer.mask addAnimation:keyframeAnimation forKey:@"boundsMask"];
    
    [UIView animateWithDuration:0.1 delay:1.35 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        bg.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [bg removeFromSuperview];
        
    }];
    
    [UIView animateWithDuration:0.25 delay:1.3 options:UIViewAnimationOptionTransitionNone animations:^{
        vc.view.layer.transform = CATransform3DMakeScale(1.05, 1.05, 1);
//        vc.view.transform = CGAffineTransformMakeScale(1.05, 1.05);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            vc.view.layer.transform = CATransform3DMakeScale(1/1.05, 1/1.05, 1);
            vc.view.layer.transform = CATransform3DIdentity;
//            vc.view.transform = CGAffineTransformMakeScale(1/1.05, 1/1.05);
            
        } completion:^(BOOL finished) {
            
            vc.view.layer.mask = nil;
            
        }];
    }];

//    [UIView animateWithDuration:0.25 delay:1.5 options:UIViewAnimationOptionTransitionNone animations:^{
//        vc.view.transform = CGAffineTransformMakeScale(1.05, 1.05);
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//            vc.view.transform = CGAffineTransformIdentity;
//        } completion:^(BOOL finished) {
//            vc.view.layer.mask = nil;
//        }];
//    }];*/
    
    
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
