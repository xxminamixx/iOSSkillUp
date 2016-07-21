//
//  Tab1ViewController.m
//  iOS Education
//
//  Created by Minami Kyohei on 2016/07/21.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "Tab1ViewController.h"
#import "FMDatabase.h"

@interface Tab1ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *idTextField;

- (IBAction)pushedChangeTab2Button:(id)sender;
- (IBAction)pushedCreateTableButton:(id)sender;
- (IBAction)pushedInsertButton:(id)sender;
- (IBAction)pushedSelectButton:(id)sender;

@property BOOL alreadyDB;

@end

@implementation Tab1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.alreadyDB = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)pushedChangeTab2Button:(id)sender
{
    self.tabBarController.selectedIndex = 1;
}

- (IBAction)pushedCreateTableButton:(id)sender
{
    //　初回だけデータベースを作る
    FMDatabase *db;
    if (self.alreadyDB == NO) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
        NSString *dir = [paths objectAtIndex:0];
        db = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"test.db"]];
        
        [db open];
        [db close];
        self.alreadyDB = YES;
    }
    
    //　テーブル作成
    NSString *sql = @"CREATE TABLE TEST_TABLE (name TEXT, id INTEGER);";
    
    [db open];
    [db executeUpdate:sql];
    [db close];
}

- (IBAction)pushedInsertButton:(id)sender
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString *dir = [paths objectAtIndex:0];
    FMDatabase *db = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"test.db"]];

    NSMutableString *sql = [NSMutableString string];
    [sql appendString:[NSString stringWithFormat:@"INSERT INTO TEST_TABLE (name, id) VALUES ('%@', %@)", self.nameTextField.text, self.idTextField.text]];
    
    [db open];
    [db executeUpdate:sql];
    [db close];
}

- (IBAction)pushedSelectButton:(id)sender
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString *dir = [paths objectAtIndex:0];
    FMDatabase *db = [FMDatabase databaseWithPath: [dir stringByAppendingPathComponent:@"test.db"]];
    
    [db open];
    FMResultSet *rs = [db executeQuery:@"select name,id from TEST_TABLE"];
   
        while ([rs next]){
           NSInteger identifer = [rs intForColumn:@"id"];
           NSString *name = [rs stringForColumn:@"name"];
           NSLog(@"%ld", identifer);
           NSLog(@"%@", name);
       }
    [db close];
    [rs close];
}

@end
