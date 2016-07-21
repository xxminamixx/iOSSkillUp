//
//  Tab2ViewController.m
//  iOS Education
//
//  Created by Minami Kyohei on 2016/07/21.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "Tab2ViewController.h"

@interface Tab2ViewController ()
- (IBAction)pushedChangeTab1Button:(id)sender;

@end

@implementation Tab2ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)pushedChangeTab1Button:(id)sender {
    self.tabBarController.selectedIndex = 0;
}
@end
