//
//  KYCircleAnimationViewController.m
//  AnimationDemo
//
//  Created by Coco on 15/10/20.
//  Copyright © 2015年 Pszertlek. All rights reserved.
//

#import "KYCircleAnimationViewController.h"
#import "KYCircleView.h"


@interface KYCircleAnimationViewController ()
- (IBAction)sliderChanged:(UISlider *)sender;
@property (weak, nonatomic) IBOutlet KYCircleView *circleView;

@end

@implementation KYCircleAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sliderChanged:(UISlider *)sender {
    self.circleView.progress = sender.value;
}
@end
