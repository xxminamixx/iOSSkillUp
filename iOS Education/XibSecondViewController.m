//
//  XibSecondViewController.m
//  iOS Education
//
//  Created by 南　京兵 on 2016/08/23.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "XibSecondViewController.h"
#import "XibFirstViewController.h"

@interface XibSecondViewController ()

- (IBAction)pushedToXibFirstViewController:(id)sender;

@end

@implementation XibSecondViewController

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

- (IBAction)pushedToXibFirstViewController:(id)sender
{
    XibFirstViewController * xibFirstViewController;
    xibFirstViewController = [[XibFirstViewController alloc] initWithNibName:@"XibFirstViewController" bundle:nil];
    [self presentViewController:xibFirstViewController animated:YES completion:nil];
}
@end
