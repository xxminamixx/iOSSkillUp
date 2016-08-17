//
//  Tab1ViewController.m
//  iOS Education
//
//  Created by Minami Kyohei on 2016/07/21.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "Tab1ViewController.h"
#import "FMDatabase.h"

@interface Tab1ViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *idTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *selectTableNamePicker;

@property NSString *tableName;

- (IBAction)pushedChangeTab2Button:(id)sender;
- (IBAction)pushedCreateTableButton:(id)sender;
- (IBAction)pushedInsertButton:(id)sender;
- (IBAction)pushedSelectButton:(id)sender;
- (IBAction)pushedDropButton:(id)sender;

@property BOOL alreadyDB;

@end

@implementation Tab1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.alreadyDB = NO;
    self.selectTableNamePicker.delegate = self;
    self.selectTableNamePicker.dataSource = self;
//    [self selectTableList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)pushedChangeTab2Button:(id)sender
{
    self.tabBarController.selectedIndex = 1;
}

# pragma -mark - FMDB Method
- (IBAction)pushedCreateTableButton:(id)sender
{
    FMDatabase *db = [self connectingDB: self.tableName];

    //　テーブル作成
    NSString *sql = @"CREATE TABLE TEST_TABLE (name TEXT, id INTEGER);";
    
    [db open];
    [db executeUpdate:sql];
    [db close];
}

- (IBAction)pushedInsertButton:(id)sender
{
    FMDatabase *db = [self connectingDB: self.tableName];
    
    NSMutableString *sql = [NSMutableString string];
    [sql appendString:[NSString stringWithFormat:@"INSERT INTO %@ (name, id) VALUES ('%@', %@)", self.tableName, self.nameTextField.text, self.idTextField.text]];
    
    [db open];
    [db executeUpdate:sql];
    [db close];
}

- (IBAction)pushedSelectButton:(id)sender
{
    FMDatabase *db = [self connectingDB: self.tableName];
    [db open];
    FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"select name,id from %@", self.tableName]];
   
        while ([rs next]){
           NSInteger identifer = [rs intForColumn:@"id"];
           NSString *name = [rs stringForColumn:@"name"];
           NSLog(@"%ld", identifer);
           NSLog(@"%@", name);
       }
    [db close];
    [rs close];
}

- (IBAction)pushedDropButton:(id)sender {
    FMDatabase *db = [self connectingDB: self.tableName];
        NSString *sql = [NSString stringWithFormat:@"DROP TABLE %@", self.tableName];
        [db open];
        [db executeUpdate:sql];
        [db close];
}

-(FMDatabase *)connectingDB:(NSString *)tableName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString *dir = [paths objectAtIndex:0];
    FMDatabase *db = [FMDatabase databaseWithPath: [dir stringByAppendingPathComponent:tableName]];
    return db;
}

#pragma -mark - PickerView Delegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 5;
}

-(NSString*)pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
       return [NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"table%ld", row + 1]];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.tableName = [NSString stringWithFormat:@"table%ld", row + 1];
}


@end
