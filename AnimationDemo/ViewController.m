//
//  ViewController.m
//  AnimationDemo
//
//  Created by Coco on 15/10/14.
//  Copyright © 2015年 Pszertlek. All rights reserved.
//

#import "ViewController.h"
#import "PushControl.h"
#import <JSONModel/JSONModel.h>


@interface MyModel : JSONModel

@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) int number;
@end

@implementation MyModel



@end

@interface ViewController ()
- (IBAction)oneClick:(id)sender;
- (IBAction)twoClick:(UIButton *)sender;
@property (nonatomic, strong) NSString *name;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor yellowColor];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"hahhaahah" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    
}

- (void)btnClick
{
    [[PushControl shared]dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"@%",NSStringFromSelector(_cmd));
}
- (IBAction)oneClick:(id)sender {
    MyModel *model = [[MyModel alloc]init];
    model.name = @"sss";
    model.image = @"";
    self.name = [model toJSONString];
}

- (IBAction)twoClick:(UIButton *)sender {
    MyModel *model = [[MyModel alloc]initWithString:self.name error:nil];
    NSMutableDictionary *dic = [[model toDictionary]mutableCopy];
    dic[@"number"] = @"10";
    MyModel *m = [[MyModel alloc]initWithDictionary:dic error:nil];
    
    
}
@end
