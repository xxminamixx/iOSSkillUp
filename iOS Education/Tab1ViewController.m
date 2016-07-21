//
//  Tab1ViewController.m
//  iOS Education
//
//  Created by Minami Kyohei on 2016/07/21.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "Tab1ViewController.h"

@interface Tab1ViewController ()

- (IBAction)pushedChangeTab2Button:(id)sender;

@end

@implementation Tab1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)pushedChangeTab2Button:(id)sender {
    self.tabBarController.selectedIndex = 1;
}

@end
