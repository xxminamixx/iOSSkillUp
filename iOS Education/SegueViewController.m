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
#import "Fetcher.h"

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

@interface SegueViewController ()

@property NSMutableArray *arrayForCellText;
@property CustomTableViewCell *cellForHeightCalc;

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
    self.cellForHeightCalc = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    //　用意されている編集ボタンをセット
    self.navigationItem.rightBarButtonItem = self.editButtonItem;

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
    return self.arrayForCellText.count + 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"customCell"];
    if (cell == nil) {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"customCell"];
    }
    
    if (indexPath.row < self.arrayForCellText.count) {
        [cell setTextToLabel: self.arrayForCellText[indexPath.row]];
    } else {
        // 最下部のセルの設定
        cell.label.text = @"さらに読み込む";
    }
    
    return cell;
}


-(void)setupCell:(CustomTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    [self readFurther];
}

#pragma mark - UITableView DataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = (CustomTableViewCell*)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    
    return cell.height;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [self setupCell:self.cellForHeightCalc atIndexPath:indexPath];
//    
//    [self.cellForHeightCalc.contentView setNeedsLayout];
//    [self.cellForHeightCalc.contentView layoutIfNeeded];
//    
//    CGSize size = [self.cellForHeightCalc.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    return size.height+1;
//}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.arrayForCellText.count) {
        // 通常のセルがタップされた処理
    } else {
        // さらに読み込む処理
        [self readFurther];
        
        [self.tableView reloadData];
        
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Header"];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Footer"];
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    //一番下までスクロールしたかどうか
//    if(self.tableView.contentOffset.y >= (self.tableView.contentSize.height - self.tableView.bounds.size.height))
//    {
//        [self readFurther];
//        [self.tableView reloadData];
//    }
//}

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
    [self.arrayForCellText addObject:kLongName140];
    [self.arrayForCellText addObject:kLongName130];
    [self.arrayForCellText addObject:kLongName120];
    [self.arrayForCellText addObject:kLongName110];
    [self.arrayForCellText addObject:kLongName100];
    [self.arrayForCellText addObject:kLongName90];
    [self.arrayForCellText addObject:kLongName80];
    [self.arrayForCellText addObject:kLongName70];
    [self.arrayForCellText addObject:kLongName60];
    [self.arrayForCellText addObject:kLongName50];
    [self.arrayForCellText addObject:kLongName40];
}


#pragma mark - TableView Deleagte For Editing
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}

// セルの編集可能状態を管理
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    //　配列の最後のセルを編集不可に設定
     if (indexPath.row < self.arrayForCellText.count) {
        return YES;
    } else {
        return NO;
    }
}

-(void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle) editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [self.arrayForCellText removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }else if(editingStyle == UITableViewCellEditingStyleInsert){
    
    }
}

@end
