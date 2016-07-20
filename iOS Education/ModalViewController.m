//
//  ModalViewController.m
//  iOS Education
//
//  Created by Minami Kyohei on 2016/07/13.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "ModalViewController.h"

NSInteger oneDay = 86400;

//NSString * const kToModalViewController = @"toModalViewController";

@interface ModalViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *CoutDownTimer;

- (IBAction)dismissModalAction:(id)sender;

@end

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*** DatePicker ***/
    
    // DatePickerの変更を受ける
    [self.datePicker addTarget:self action:@selector(pickerDidChange) forControlEvents:UIControlEventValueChanged];
    
    // 分刻みの指定をする
    self.datePicker.minuteInterval = 10;
    
    // 指定できる最小の値を設定
    self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:oneDay * (-7)];
    
    //　指定できる最大の値を設定
    self.datePicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:oneDay * 7];
    
    // DatePickerの変更を受ける
    [self.CoutDownTimer addTarget:self action:@selector(countChange) forControlEvents:UIControlEventValueChanged];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// ModalViewを消す
- (void)dismissModalView {
    // 通知作成
    NSNotification *notification = [NSNotification notificationWithName:@"Call" object:self];
    //　通知送信
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)dismissModalAction:(id)sender {
    [self dismissModalView];
}

- (void)pickerDidChange
{
    NSLog(@"%@", self.datePicker.date);
}

- (void)countChange
{
    NSLog(@"%f", self.CoutDownTimer.countDownDuration);
}

@end
