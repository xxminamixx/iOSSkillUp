//
//  ViewController.m
//  iOS Education
//
//  Created by Minami Kyohei on 2016/07/13.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "ViewController.h"
#import "Square.h"
#import "Reak.h"
#import "ModalViewController.h"
#import "Fetcher.h"
#import "WikipediaEntity.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@property NSMutableArray *watchAtrribute;

- (IBAction)pushedSendSynchronousButton:(id)sender;
- (IBAction)pushedWikipediaButton:(id)sender;

- (IBAction)pushedSendAsynchronousButton:(id)sender;
- (IBAction)pushedModalButton:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*** NavigationController add button***/
    
    //Itemの色を黒に設定
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]
                            initWithTitle:@"left"
                            style:UIBarButtonItemStylePlain
                            target:self
                            action:@selector(leftItem)];
    // 左にボタンを追加
    // self.navigationItem.leftBarButtonItem = leftBtn;
    
    // 用意されたボタンスタイルを用いる
    //style は Stop,Undo, Play, Organize,Camera,Bookmarksなどがある
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemPlay
                                   target:self
                                   action:@selector(rightItem)];
    
    // 右にボタン追加
    // self.navigationItem.rightBarButtonItem = rightBtn;
    
    // 複数のアイテムを追加する
    UIBarButtonItem *otherRightBtn = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks
                                      target:self
                                      action:@selector(rightItem)];
    // 右側に2つのアイテムを追加
    self.navigationItem.rightBarButtonItems = @[rightBtn, otherRightBtn];
    
    UIButton *printImage = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    // buttonにimageセット
    [printImage setBackgroundImage:[UIImage imageNamed:@"Print-50.png"] forState:UIControlStateNormal];
    [printImage addTarget:self action:@selector(leftItem) forControlEvents:UIControlEventTouchUpInside];
    
    //作成したボタンをNavigationItemとしてセット
    UIBarButtonItem *othreLeftBtn = [[UIBarButtonItem alloc] initWithCustomView: printImage];
    
    // 左に2つのアイテムを追加
    self.navigationItem.leftBarButtonItems = @[leftBtn, othreLeftBtn];
    
    
    /*** init ***/
    Square *square = [[Square alloc ]init];
    NSLog(@"%f", square.width);
    self.label.text = [NSString stringWithFormat:@"%f", square.width];
    
    /*** strong, weak***/
    // こんにちはを元から持ったstrongStrを生成
    __strong NSString *strongStr1 = [[NSString alloc] initWithFormat:@"こんにちは"];
    // strongStrのポインタを代入
    __weak NSString *weakStr1 = strongStr1;
    NSLog(@"strong:%@ / weak:%@", strongStr1, weakStr1);
    
    // 新たにポインタをセット
    strongStr1 = [[NSString alloc] initWithFormat:@"こんばんは"];
    // 解放される
    NSLog(@"strong:%@ / weak:%@", strongStr1, weakStr1);
    
    // リファレンスカウンタがカウントされる
    __strong NSString *strongStr2 = @"こんにちは";
    // ”こんにちは"のポインタを代入
    __weak NSString *weakStr2 = strongStr2;
    NSLog(@"storng:%@ / weak:%@", strongStr2, weakStr2);
    
    strongStr2 = @"こんばんは";
    // weakは"こんにちは"のポインタを参照している
    NSLog(@"storng:%@ / weak:%@", strongStr2, weakStr2);
    
    // メモリリーク発生参照の循環
    Reak *friend1 = [Reak new];
    Reak *friend2 = [Reak new];
    [friend1 setFriend: friend2];
    [friend2 setFriend: friend1];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    // 通知の受信
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(dismissModalCall) name:@"Call" object:nil];
}

//通知を受信したときに呼び出されるメソッド
- (void)dismissModalCall
{
    NSLog(@"通知を受信しました");
}

- (IBAction)pushedSendSynchronousButton:(id)sender {
    Fetcher *fetcher = [Fetcher new];
    [fetcher sendSynchronousFoodFetcher];
}

- (IBAction)pushedWikipediaButton:(id)sender {
    Fetcher *fetcher = [Fetcher new];
    [fetcher wikipediaAPIFetcher:^(NSMutableArray *array){
        // 配列を受け取る
        self.watchAtrribute = array;
//        WikipediaEntity *entity = [WikipediaEntity new];
//        entity = self.watchAtrribute[0];
//        self.label.text = entity.contents;
    }];
}

- (IBAction)pushedSendAsynchronousButton:(id)sender {
    Fetcher *fetcher = [Fetcher new];
    [fetcher sendAsynchronousFoodFetcher];
}


- (IBAction)pushedModalButton:(id)sender {
    [self showModalView];
}


//　Modalで遷移
-(void)showModalView{
     ModalViewController *modalViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ModalViewController"];
    [self presentViewController:modalViewController animated:YES completion:nil];
}

- (void)leftItem
{
    NSLog(@"NavigationLeftItem is Pushing!");
}

- (void)rightItem
{
    NSLog(@"NavigationRightItem is Pushing!");
}
@end
