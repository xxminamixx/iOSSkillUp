//
//  ModalViewController.m
//  iOS Education
//
//  Created by Minami Kyohei on 2016/07/13.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "ModalViewController.h"

@interface ModalViewController ()
- (IBAction)dismissModalAction:(id)sender;

@end

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
@end
