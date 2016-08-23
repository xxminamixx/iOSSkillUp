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
#import "Human.h"
#import "LUKeychainAccess.h"
#import "AlertViewWithBlock.h"
#import "Fetcher+sendAsynchronousFoodFetcherOverride.h"
#import "XibFirstViewController.h"

//NSString * const kToViewController = @"ViewController";
NSString * const kKeyDic = @"KEY_CHAIN_SHARING_KEY_DIC";

@interface ViewController ()

typedef void (^UIAlertViewBlock) (UIAlertView *alertView);
typedef void (^UIAlertViewCompletionBlock) (UIAlertView *alertView, NSInteger buttonIndex);

@property (copy, nonatomic) UIAlertViewCompletionBlock tapBlock;
@property (copy, nonatomic) UIAlertViewCompletionBlock willDismissBlock;
@property (copy, nonatomic) UIAlertViewCompletionBlock didDismissBlock;

@property (copy, nonatomic) UIAlertViewBlock willPresentBlock;
@property (copy, nonatomic) UIAlertViewBlock didPresentBlock;
@property (copy, nonatomic) UIAlertViewBlock cancelBlock;

@property (copy, nonatomic) BOOL(^shouldEnableFirstOtherButtonBlock)(UIAlertView *alertView);

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property NSMutableArray *watchAtrribute;

- (IBAction)pushedSendSynchronousButton:(id)sender;
- (IBAction)pushedWikipediaButton:(id)sender;
- (IBAction)pushedSegueButton:(id)sender;
- (IBAction)pushedSendAsynchronousButton:(id)sender;
- (IBAction)pushedModalButton:(id)sender;
- (IBAction)pushedCollectionButton:(id)sender;
- (IBAction)pushedAleartViewButton:(id)sender;
- (IBAction)pushedSaveKeychain:(id)sender;
- (IBAction)pushedLoadKeychain:(id)sender;
- (IBAction)pushedXibButton:(id)sender;

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
    NSLog(@"%f", square.height);
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
//    Reak *friend1 = [Reak new];
//    Reak *friend2 = [Reak new];
//    [friend1 setFriend: friend2];
//    [friend2 setFriend: friend1];
    
    Human *human = [Human new];
    human.name = @"jack";
    human.tall = 2;
    human.weight = 65;
    
    Human *newHuman = [human copy];
    NSLog(@"name :%@", newHuman.name);
    
    // タップジェスチャ検知
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture)];
    [self.view addGestureRecognizer:tapGesture];
    
    //　ダブルタップジェスチャ検知
    UITapGestureRecognizer* doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTapGesture)];
    // デフォルトでnumberOfTapsRequiredが1になっている
    doubleTapGesture.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTapGesture];
    
    // 左へスワイプ
    UISwipeGestureRecognizer* swipeLeftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeftGesture)];
    swipeLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeftGesture];
    
    // 右へスワイプ
    UISwipeGestureRecognizer* swipeRightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRightGesture)];
    swipeRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRightGesture];
    
    Fetcher *fetcher = [Fetcher new];
    [fetcher GTMsessionFetcher];
    
    // dispatch_get_global_queueで優先度別のキューを取得
    // dispatch_syncは同期的に実行され他の処理が止まる
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSLog(@"バッググラウンド");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"優先度:低");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"優先度:中");
    });
    
    // メインスレッドで実行
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"メインスレッドで実行");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSLog(@"優先度:高");
    });
    
    // メインスレッドで実行
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"メインスレッドで実行");
    });
    
//    // blocksの循環参照
//    self.block = ^{
//        self.alertViewBackText = @"leak";
//    };
    
    void(^completed)(void) = ^(void){
        NSLog(@"log");
    };
    
    __block NSInteger number = 10;
    void (^completedBlock)(void) = ^(void){
        number = 20;
        NSLog(@"キャプチャテスト%ld", number);
    };
    completedBlock();
    
    /*
     
    //エラーとなる
     NSInteger number = 10;
     void (^completedBlock)(void) = ^(void){
         number = 20;
         NSLog(@"キャプチャテスト%ld", number);
     };
     completedBlock();
     
    */
    
    // 条件つきコンパイル
    NSInteger num = 1;
    
// デバッグする箇所に条件を付けるなど
//#define DEBUG 1
    
#if 0
    num = 1;
#elif num > 1
    NSLog(@"numの値は1より大きいです");
#elif num == 1
    NSLog(@"numは1です");
#elif num < 1
    NSLog(@"numの値は1より小さいです");
#else
    NSLog("どの条件にも当てはまりません");
#endif
    
#ifdef DEBUG
    NSLog(@"デバッグの時だけ出力されます");
#else
#endif

#define HOGE
#ifdef DEBUG
    NSLog(@"定義済みのとき出力されます");
#else
    NSLog(@"未定義のとき出力されます");
#endif
    
#ifndef DEBUG
     NSLog(@"未定義のとき出力されます");
#else
    NSLog(@"定義済みのとき出力されます");
#endif
    
    NSDictionary *userDic = @{
                              @"userName":@"mike",
                              @"password":@"123456"
                              };

     // NSDictionaryを保存
    [[LUKeychainAccess standardKeychainAccess] setObject:userDic forKey:kKeyDic];
    
    // 取得
    userDic = [[LUKeychainAccess standardKeychainAccess] objectForKey:kKeyDic];
    
#ifdef DEBUG
    NSLog(@"%@",userDic);
#endif

    self.viewControllerProperty = @"可視性のテスト";
    NSLog(@"%@", self.viewControllerProperty);
    
    // 保存したいtoken
    NSString *tokenString = @"saveToken";
    NSData *data = [tokenString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *query = @{
                            (__bridge id)kSecClass      : (__bridge id)kSecClassGenericPassword,
                            (__bridge id)kSecAttrAccount: @"Account",
                            (__bridge id)kSecAttrService: @"APP_NAME",
                            (__bridge id)kSecValueData  : data
                            };
    
    OSStatus err = SecItemAdd((__bridge CFDictionaryRef)query, NULL);
    
    // success
    if (err == errSecSuccess) {
        NSLog(@"キーチェーンの保存が完了しました。");
    }
    // error
    else {
        NSLog(@"保存に失敗しました。");
    }
    
    void (^myBlock)(int) = ^(int i){
        NSLog(@"%d",i);
    };
    
    myBlock(10);
}

- (void)hoge{}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    // 通知の受信
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(dismissModalCall) name:@"Call" object:nil];
}

//通知を受信したときに呼び出されるメソッド
- (void)dismissModalCall
{
    NSLog(@"通知を受信しました");
    [[NSNotificationCenter defaultCenter] removeObserver:self];

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

    }];
}

- (IBAction)pushedSendAsynchronousButton:(id)sender {
    Fetcher *fetcher = [Fetcher new];
    [fetcher sendAsynchronousFoodFetcher];
}


- (IBAction)pushedModalButton:(id)sender {
    [self showModalView];
}

- (IBAction)pushedCollectionButton:(id)sender {
    
}

- (IBAction)pushedAleartViewButton:(id)sender {
    
    __weak typeof(self) weakSelf = self;
    self.alertViewNextText = @"進むボタンが押されました";
    self.alertViewBackText = @"戻るボタンが押されました";
    
    AlertViewWithBlock* alert = [[AlertViewWithBlock alloc] initWithTitle:@"Blocksで実装" message:@"DelegateをBlocksで実装しました" cancelHandler:^(UIAlertView* alertView){
        __strong typeof(self) strongSelf = weakSelf;
        if (!strongSelf) return ;
        else {
            NSLog(@"Cancel");
        }
    } buttonHandler:^(UIAlertView* alertView, NSInteger buttonIndex){
        __strong typeof(self) strongSelf = weakSelf;
        if (!strongSelf) return;
        else {
            switch (buttonIndex) {
                case 0:
                    NSLog(@"%@", self.alertViewBackText);
                    break;
                case 1:
                    NSLog(@"%@", self.alertViewNextText);
                    break;
                default:
                    break;
            }
        }
    } buttonTitles:@"戻る",@"進む", nil];
    [alert show];

}

- (IBAction)pushedSaveKeychain:(id)sender {
    // 更新用のtoken
    NSString *tokenStrinig = @"updateToken";
    NSData *data = [tokenStrinig dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *query = @{
                            (__bridge id)kSecClass      : (__bridge id)kSecClassGenericPassword,
                            (__bridge id)kSecAttrAccount: @"Account",
                            (__bridge id)kSecAttrService: @"APP_NAME"
                            };
    
    OSStatus err = SecItemCopyMatching((__bridge CFDictionaryRef)query, NULL);
    
    // success
    if (err == errSecSuccess) {
        //存在したら上書き処理
        
        // update
        NSDictionary *attr = @{(__bridge id)kSecValueData           : data,
                               (__bridge id)kSecAttrModificationDate: [NSDate date]};
        
        OSStatus status = SecItemUpdate((__bridge CFDictionaryRef)query,
                                        (__bridge CFDictionaryRef)attr);
        
        if (status == errSecSuccess) {
            NSLog(@"アップデートに成功しました。");
        }
        else {
            NSLog(@"アップデートに失敗しました。");
        }
    }
    // not found
    else if (err == errSecItemNotFound) {
        
        // なかったら新規追加
        //
        NSLog(@"トークンが存在しません");
    }
}

- (IBAction)pushedLoadKeychain:(id)sender {
    NSDictionary *query = @{
                            (__bridge id)kSecClass      : (__bridge id)kSecClassGenericPassword,
                            (__bridge id)kSecAttrAccount: @"Account",
                            (__bridge id)kSecAttrService: @"APP_NAME",
                            (__bridge id)kSecReturnData : (__bridge id)kCFBooleanTrue
                            };
    
    CFDataRef token = nil;
    OSStatus err = SecItemCopyMatching((__bridge CFDictionaryRef)query,(CFTypeRef *)&token);
    NSData *tokenData = (__bridge_transfer NSData *)token;
    NSString *accessToken = nil;
    
    if (err == errSecSuccess) {
        // 成功
        NSLog(@"キーチェン取得に成功しました。");
        
        accessToken = [[NSString alloc] initWithData:tokenData
                                            encoding:NSUTF8StringEncoding];
    }
    else if (err == errSecItemNotFound) {
        // NotFound
        NSLog(@"トークンが存在しません");
    }
    else {
        // Error
        NSLog(@"取得に失敗しました。");
    }    
}

- (IBAction)pushedXibButton:(id)sender
{
    XibFirstViewController *xibFirstViewController;
    xibFirstViewController = [[XibFirstViewController alloc] initWithNibName:@"XibFirstViewController" bundle:nil];
    [self presentViewController:xibFirstViewController animated:YES completion:nil];
}


// アラートのボタンが押された時に呼ばれるデリゲート
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            NSLog(@"キャンセルされました");
            break;
        case 1:
            NSLog(@"確定されました");
            break;
    }
    
}


//　Modalで遷移
-(void)showModalView{
     ModalViewController *modalViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ModalViewController"];
    [self presentViewController:modalViewController animated:YES completion:nil];
}

- (void)leftItem
{
    
    NSLog(@"NavigationLeftItem is Pushing!");
    
    // 例外を発生させcatchで処理を行う
    @try {
        
        [NSException raise:@"error" format:@"left button pushed"];
        
    }
    @catch (NSException *exception) {
       
        NSLog(@"exception = %@", exception.description);
        
    }
    @finally {
        NSLog(@"例外処理を通過しました");
    }
   
}

- (void)rightItem
{
    NSLog(@"NavigationRightItem is Pushing!");
}

- (IBAction)pushedSegueButton:(id)sender {
    
    if ([self.textField.text isEqualToString:@"a"]) {
        [self performSegueWithIdentifier:@"Segue2" sender:self];
    } else {
        [self performSegueWithIdentifier:@"toTableView" sender:self];
    }
}

- (void)handleTapGesture
{
    NSLog(@"タップされました");
}

- (void)handleDoubleTapGesture
{
    NSLog(@"ダブルタップされました");
}

- (void)handleSwipeLeftGesture
{
    NSLog(@"左へスワイプしました");
}

- (void)handleSwipeRightGesture
{
    NSLog(@"右へスワイプしました");
}

@end

