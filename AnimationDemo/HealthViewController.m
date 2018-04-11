//
//  HealthViewController.m
//  AnimationDemo
//
//  Created by Coco on 15/10/25.
//  Copyright © 2015年 Pszertlek. All rights reserved.
//

#import "HealthViewController.h"
#import <HealthKit/HealthKit.h>

static HKHealthStore *healthStore;

@interface HealthViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (nonatomic, strong) UIAlertController *alertController;
@property (weak, nonatomic) IBOutlet UILabel *currentStepLabel;

- (IBAction)click:(id)sender;

@end

@implementation HealthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    if ([HKHealthStore isHealthDataAvailable]) {
        NSSet *writeSet = [NSSet setWithObject:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount]];
        NSSet *readSet =[NSSet setWithObject:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount]];
        [healthStore requestAuthorizationToShareTypes:writeSet readTypes:readSet completion:^(BOOL success, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!success) {
                    self.alertController = [UIAlertController alertControllerWithTitle:@"失败" message:@"请选择支持当前选择" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
                    [self.alertController addAction:okAction];
                    [self presentViewController:self.alertController animated:YES completion:nil];
                }
            });
        }];
    }
    else{
        self.alertController = [UIAlertController alertControllerWithTitle:@"失败" message:@"设备不支持健康数据" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [self.alertController addAction:okAction];
        [self presentViewController:self.alertController animated:YES completion:nil];

    }
    [self readTodayStepCount];
}

- (void)awakeFromNib
{
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        healthStore = [[HKHealthStore alloc]init];
    });
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

- (void)readTodayStepCount
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *conponents = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    NSDate *startDate = [calendar dateFromComponents:conponents];
    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    HKQuantityType *sampleType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
    HKStatisticsQuery *query = [[HKStatisticsQuery alloc]initWithQuantityType:sampleType quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum completionHandler:^(HKStatisticsQuery * _Nonnull query, HKStatistics * _Nullable result, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (result) {
                double totalStep = [result.sumQuantity doubleValueForUnit:[HKUnit countUnit]];
                self.currentStepLabel.text = [NSString stringWithFormat:@"%lf",totalStep];
            }
            else{
                self.alertController = [UIAlertController alertControllerWithTitle:@"错咯" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
                [self.alertController addAction:okAction];
                [self presentViewController:self.alertController animated:YES completion:nil];
            }
        });

    }];
    [healthStore executeQuery:query];
}

- (void)writeStepCount
{
    double value = [self.textField.text doubleValue];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *conponents = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    NSDate *startDate = [calendar dateFromComponents:conponents];
    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];

    
    HKQuantityType *type = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKQuantitySample *sample = [HKQuantitySample quantitySampleWithType:type quantity:[HKQuantity quantityWithUnit:[HKUnit countUnit] doubleValue:value] startDate:startDate endDate:endDate];
    [healthStore saveObject:sample withCompletion:^(BOOL success, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                self.alertController = [UIAlertController alertControllerWithTitle:@"成功咯" message:@"成功咯" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
                [self.alertController addAction:okAction];
                [self presentViewController:self.alertController animated:YES completion:nil];
                [self readTodayStepCount];
            }
            else{
                self.alertController = [UIAlertController alertControllerWithTitle:@"失败" message:@"写入失败" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
                [self.alertController addAction:okAction];
                [self presentViewController:self.alertController animated:YES completion:nil];

            }
        });

    }];
}

- (IBAction)click:(id)sender {
    [self writeStepCount];
    
}
@end
