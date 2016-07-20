//
//  SampleViewController.m
//  iOS Education
//
//  Created by Minami Kyohei on 2016/07/19.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "SegueViewController.h"
#import "ModalViewController.h" // 定数を用いて遷移するため
#import "ViewController.h" // 定数を用いて遷移するため
#import "CustomTableViewCell.h"

NSString * const kLongName40 = @"１２３４５６７８９８７６５４３２１１２３４５６７８９８７６５４３２１１２３４２３★";
NSString * const kLongName50 = @"１２３４５６７８９８７６５４３２１１２３４５６７８９８７６５４３２１１２３４２３１２３４５６７８９０★";
NSString * const kLongName60 = @"１２３４５６７８９８７６５４３２１１２３４５６７８９８７６５４３２１１２３４２３１２３４５６７８９００９８７６５４３２１★";
NSString * const kLongName70 = @"１２３４５６７８９８７６５４３２１１２３４５６７８９８７６５４３２１１２３４２３１２３４５６７８９００９８７６５４３２１１２３４５６７０２１★";
NSString * const kLongName80 = @"１２３４５６７８９８７６５４３２１１２３４５６７８９８７６５４３２１１２３４２３１２３４５６７８９００９８７６５４３２１１２３４５６７０２１９８７６５４３２１０★";
NSString * const kLongName90 = @"１２３４５６７８９８７６５４３２１１２３４５６７８９８７６５４３２１１２３４２３１２３４５６７８９００９８７６５４３２１１２３４５６７０２１９８７６５４３２１０１２３４５６７８９０★";
NSString * const kLongName100 = @"１２３４５６７８９８７６５４３２１１２３４５６７８９８７６５４３２１１２３４２３１２３４５６７８９００９８７６５４３２１１２３４５６７０２１９８７６５４３２１０１２３４５６７８９０１２３４６７８９０５★";
NSString * const kLongName110 = @"１２３４５６７８９８７６５４３２１１２３４５６７８９８７６５４３２１１２３４２３１２３４５６７８９００９８７６５４３２１１２３４５６７０２１９８７６５４３２１０１２３４５６７８９０１２３４６７８９０５１２３４５６７８９０★";
NSString * const kLongName120 = @"１２３４５６７８９８７６５４３２１１２３４５６７８９８７６５４３２１１２３４２３１２３４５６７８９００９８７６５４３２１１２３４５６７０２１９８７６５４３２１０１２３４５６７８９０１２３４６７８９０５１２３４５６７８９０１２３４５６７８９０★";
NSString * const kLongName130 = @"１２３４５６７８９８７６５４３２１１２３４５６７８９８７６５４３２１１２３４２３１２３４５６７８９００９８７６５４３２１１２３４５６７０２１９８７６５４３２１０１２３４５６７８９０１２３４６７８９０５１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０★";
NSString * const kLongName140 = @"１２３４５６７８９８７６５４３２１１２３４５６７８９８７６５４３２１１２３４２３１２３４５６７８９００９８７６５４３２１１２３４５６７０２１９８７６５４３２１０１２３４５６７８９０１２３４６７８９０５１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０★";

const NSInteger arrayCount = 11; // 表示する配列の要素が11つのため

NSInteger pushedReadFurtherCount = 0; //更読みを押した回数をカウント

@interface SegueViewController ()

@property NSMutableArray *arrayForCellText;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)pushedModalButton:(id)sender;

@end

@implementation SegueViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"CustomTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"customCell" ];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self setArrayValue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)pushedModalButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayCount + 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"customCell"];
    if (cell == nil) {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"customCell"];
    }
    
    if (indexPath.row < arrayCount) {
        [cell setTextToLabel: self.arrayForCellText[indexPath.row]];
    } else {
        // 最下部のセルの設定
        cell.label.text = @"さらに読み込む";
    }
    
    return cell;
}

#pragma mark - UITableView DataSource
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    CustomTableViewCell *cell = (CustomTableViewCell*)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
//    
//    return cell.height;
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    // 同一コントローラから複数のセグエに条件分岐
//    if (indexPath.row % 2 == 0) {
//        [self performSegueWithIdentifier:@"toModalViewController" sender:self];
//    } else {
//        [self performSegueWithIdentifier:@"toViewController" sender:self];
//    }
    
    if (indexPath.row < arrayCount) {
        // 通常のセルがタップされた処理
    } else {
        // さらに読み込む処理
        pushedReadFurtherCount++;
        
        if (pushedReadFurtherCount % 2 != 0) {
            [self readFurther];
        } else {
            [self setArrayValue];
        }
        
        [self.tableView reloadData];
        
    }
}

- (void)setArrayValue
{
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:kLongName40];
    [array addObject:kLongName50];
    [array addObject:kLongName60];
    [array addObject:kLongName70];
    [array addObject:kLongName80];
    [array addObject:kLongName90];
    [array addObject:kLongName100];
    [array addObject:kLongName110];
    [array addObject:kLongName120];
    [array addObject:kLongName130];
    [array addObject:kLongName140];
    self.arrayForCellText = array;
}

- (void)readFurther
{
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:kLongName140];
    [array addObject:kLongName130];
    [array addObject:kLongName120];
    [array addObject:kLongName110];
    [array addObject:kLongName100];
    [array addObject:kLongName90];
    [array addObject:kLongName80];
    [array addObject:kLongName70];
    [array addObject:kLongName60];
    [array addObject:kLongName50];
    [array addObject:kLongName40];
    self.arrayForCellText = array;
}



//-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)FromInterfaceOrientation {
//    if(FromInterfaceOrientation == UIInterfaceOrientationPortrait){
//        [self.tableView reloadData];
//    } else {
//        [self.tableView reloadData];
//    }
//}
@end
