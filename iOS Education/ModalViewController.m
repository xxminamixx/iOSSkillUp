//
//  ModalViewController.m
//  iOS Education
//
//  Created by Minami Kyohei on 2016/07/13.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "ModalViewController.h"

@interface ModalViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)dismissModalAction:(id)sender;

@end

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.datePicker addTarget:self action:@selector(pickerDidChange) forControlEvents:UIControlEventValueChanged];
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
    NSLog(@"変更されました。");
}

@end
