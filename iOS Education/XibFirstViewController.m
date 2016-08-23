//
//  XibFirstViewController.m
//  iOS Education
//
//  Created by 南　京兵 on 2016/08/23.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "XibFirstViewController.h"
#import "XibSecondViewController.h"

@interface XibFirstViewController ()

- (IBAction)pushedToXibSecondViewControllerButton:(id)sender;

@end

@implementation XibFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)pushedToXibSecondViewControllerButton:(id)sender
{
    XibSecondViewController * xibSecondViewController;
    xibSecondViewController = [[XibSecondViewController alloc] initWithNibName:@"XibSecondViewController" bundle:nil];
    [self presentViewController:xibSecondViewController animated:YES completion:nil];
}
@end
