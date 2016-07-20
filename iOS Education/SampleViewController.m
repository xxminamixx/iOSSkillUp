//
//  SampleViewController.m
//  iOS Education
//
//  Created by Minami Kyohei on 2016/07/19.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "SampleViewController.h"
#import "ModalViewController.h" // 定数を用いて遷移するため
#import "ViewController.h" // 定数を用いて遷移するため
#import "CustomTableViewCell.h"

NSString * const kLongName40 = @"じゅげむじゅげむごこうのすりきれかいじゃりすいぎょのすいぎょうまつうんらいまつふうらいま";
NSString * const kLongName50 = @"じゅげむじゅげむごこうのすりきれかいじゃりすいぎょのすいぎょうまつうんらいまつふうらいまつくうねるところにす";
NSString * const kLongName60 = @"じゅげむじゅげむごこうのすりきれかいじゃりすいぎょのすいぎょうまつうんらいまつふうらいまつくうねるところにすむところやぶらこうじ";
NSString * const kLongName70 = @"じゅげむじゅげむごこうのすりきれかいじゃりすいぎょのすいぎょうまつうんらいまつふうらいまつくうねるところにすむところやぶらこうじのぶらこうじぱいぽぱい";
NSString * const kLongName80 = @"じゅげむじゅげむごこうのすりきれかいじゃりすいぎょのすいぎょうまつうんらいまつふうらいまつくうねるところにすむところやぶらこうじのぶらこうじぱいぽぱい";
NSString * const kLongName90 = @"じゅげむじゅげむごこうのすりきれかいじゃりすいぎょのすいぎょうまつうんらいまつふうらいまつくうねるところにすむところやぶらこうじのぶらこうじぱいぽぱいぽぱいぽのしゅーりん";
NSString * const kLongName100 = @"じゅげむじゅげむごこうのすりきれかいじゃりすいぎょのすいぎょうまつうんらいまつふうらいまつくうねるところにすむところやぶらこうじのぶらこうじぱいぽぱいぽぱいぽのしゅーりんがんしゅーりんがんの";
NSString * const kLongName110 = @"じゅげむじゅげむごこうのすりきれかいじゃりすいぎょのすいぎょうまつうんらいまつふうらいまつくうねるところにすむところやぶらこうじのぶらこうじぱいぽぱいぽぱいぽのしゅーりんがんしゅーりんがんのぐーりんだいぐーりん";
NSString * const kLongName120 = @"じゅげむじゅげむごこうのすりきれかいじゃりすいぎょのすいぎょうまつうんらいまつふうらいまつくうねるところにすむところやぶらこうじのぶらこうじぱいぽぱいぽぱいぽのしゅーりんがんしゅーりんがんのぐーりんだいぐーりんだいのぽんぽこぴーの";
NSString * const kLongName130 = @"じゅげむじゅげむごこうのすりきれかいじゃりすいぎょのすいぎょうまつうんらいまつふうらいまつくうねるところにすむところやぶらこうじのぶらこうじぱいぽぱいぽぱいぽのしゅーりんがんしゅーりんがんのぐーりんだいぐーりんだいのぽんぽこぴーのぽんぽこなのちょうき";
NSString * const kLongName140 = @"じゅげむじゅげむごこうのすりきれかいじゃりすいぎょのすいぎょうまつうんらいまつふうらいまつくうねるところにすむところやぶらこうじのぶらこうじぱいぽぱいぽぱいぽのしゅーりんがんしゅーりんがんのぐーりんだいぐーりんだいのぽんぽこぴーのぽんぽこなのちょうきゅうめいのちょうすけ";

const NSInteger arrayCount = 11; // 表示する配列の要素が11つのため

@interface SampleViewController ()

@property NSMutableArray *arrayForCellText;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)pushedModalButton:(id)sender;

@end

@implementation SampleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"CustomTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"customCell" ];
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
    return arrayCount;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"customCell"];
    if (cell == nil) {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"customCell"];
    }
    if (indexPath.row) {
        NSMutableArray *array = [self setArrayValue];
        [cell setTextToLabel: array[indexPath.row]];
    }
    return cell;
}

#pragma mark - UITableView DataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = (CustomTableViewCell*)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    
    return cell.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 0) {
        [self performSegueWithIdentifier:@"toModalViewController" sender:self];
    } else {
        [self performSegueWithIdentifier:@"toViewController" sender:self];
    }
}

- (NSMutableArray *)setArrayValue
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
    

    return array;
}



@end
