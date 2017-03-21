//
//  ReactiveViewController.m
//  AnimationDemo
//
//  Created by apple on 2017/2/6.
//  Copyright © 2017年 Pszertlek. All rights reserved.
//

#import "ReactiveViewController.h"
#import "ReactiveCocoa.h"

@interface ReactiveViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArr;
@end

@implementation ReactiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleArr = @[@"concat",@"then",@"merge",@"zip",@"combineLastest",@"doNext"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            //concat:按一定顺序拼接信号，当多个信号发出的时候，有顺序的接收信号。
            RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [subscriber sendNext:@1];
                // 注意：第一个信号必须发送完成，第二个信号才会被激活
                [subscriber sendCompleted];
                return nil;
            }];
            RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [subscriber sendNext:@2];
                return nil;
            }];
            RACSignal *concatSignal = [signalA concat:signalB];
            [concatSignal subscribeNext:^(id x) {
                NSLog(@"%@",x);
            }];
        }
            break;
        case 1:{
            //then:用于连接两个信号，当第一个信号完成，才会连接then返回的信号。
            RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [subscriber sendNext:@1];
                // 注意：第一个信号必须发送完成，第二个信号才会被激活
                [subscriber sendCompleted];
                return nil;
            }];
            RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [subscriber sendNext:@2];
                return nil;
            }];
            [[signalA then:^RACSignal *{
                return signalB;
            }]subscribeNext:^(id x) {
                NSLog(@"%@",x);
            }];
        }
            
            break;
        case 2: {//merge:把多个信号合并为一个信号，任何一个信号有新值的时候就会调用
            RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [subscriber sendNext:@1];
                return nil;
            }];
            
            RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [subscriber sendNext:@2];
                return nil;
            }];
            [[signalA merge:signalB]subscribeNext:^(id x) {
                NSLog(@"%@",x);
            }];
            [[RACSignal merge:@[signalA,signalB]]subscribeNext:^(id x) {
                NSLog(@"%@",x);
            }];
        }
            break;
        case 3: {//zipWith:把两个信号压缩成一个信号，只有当两个信号同时发出信号内容时，并且把两个信号的内容合并成一个元组，才会触发压缩流的next事件。
            RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [subscriber sendNext:@1];
                [subscriber sendNext:@3];
                return nil;
            }];
            RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [subscriber sendNext:@2];
                [subscriber sendNext:@4];
                return nil;
            }];
            RACSignal *signalC = [RACSignal empty];
            RACSignal *zipSignal = [RACSignal zip:@[signalA,signalB]];
            [zipSignal subscribeNext:^(RACTuple *x) {
                NSLog(@"%@",x);
            }];
            [[RACSignal zip:@[signalB,signalC]]subscribeNext:^(id x) {
                //signalC 无输出，所以没有结果
                NSLog(@"%@",x);
            }];
            
        }
            break;
        case 4: {
            //combineLatest:将多个信号合并起来，并且拿到各个信号的最新的值,必须每个合并的signal至少都有过一次sendNext，才会触发合并的信号。
            RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                [subscriber sendNext:@1];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [subscriber sendNext:@5];
                });

                return nil;
            }];
            
            RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                [subscriber sendNext:@2];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [subscriber sendNext:@5];
                });
                return nil;
            }];
            [[signalA combineLatestWith:signalB]subscribeNext:^(id x) {
                NSLog(@"%@",x);
            }];
        }
            break;
        case 5:{
            /*
             doNext: 执行Next之前，会先执行这个Block
             doCompleted: 执行sendCompleted之前，会先执行这个Block
             
             */
            [[[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [subscriber sendNext:@1];
                [subscriber sendCompleted];
                return nil;
            }] doNext:^(id x) {
                // 执行[subscriber sendNext:@1];之前会调用这个Block
                NSLog(@"doNext");;
            }] doCompleted:^{
                // 执行[subscriber sendCompleted];之前会调用这个Block
                NSLog(@"doCompleted");;
                
            }] subscribeNext:^(id x) {
                
                NSLog(@"%@",x);
            }];
        }/*throttle节流:当某个信号发送比较频繁时，可以使用节流，在某一段时间不发送信号内容，过了一段时间获取信号的最新内容发出。
          replay重放：当一个信号被多次订阅,反复播放内容
          retry重试 ：只要失败，就会重新执行创建信号中的block,直到成功.
          delay 延迟发送next。
          interval 定时：每隔一段时间发出信号
          timeout：超时，可以让一个信号在一定的时间后，自动报错。
          deliverOn: 内容传递切换到制定线程中，副作用在原来线程中,把在创建信号时block中的代码称之为副作用。
          
          subscribeOn: 内容传递和副作用都会切换到制定线程中。
          */

            break;
        default:
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.titleArr[indexPath.row];
    return cell;
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
