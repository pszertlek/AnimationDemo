//
//  CustomViewController.m
//  AnimationDemo
//
//  Created by apple on 2017/2/10.
//  Copyright © 2017年 Pszertlek. All rights reserved.
//

#import "CustomViewController.h"
#import "BLSensorBubbleView.h"

@interface CustomViewController ()

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    BLSensorBubbleView *view = [[BLSensorBubbleView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
    [self.view addSubview:view];
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

@end
