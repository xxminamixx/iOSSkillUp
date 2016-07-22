//
//  Fetcher.m
//  iOS Education
//
//  Created by Minami Kyohei on 2016/07/15.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "Fetcher.h"
#import "WikipediaEntity.h"
#import "Utils.h"
#import "DDXMLElement+Dictionary.h"
#import "ActerRelationshipEntity.h"
#import "GTMHTTPFetcher.h"
#import "GTMMIMEDocument.h"
#import "GTMHTTPFetcherLogging.h"

// 土偶と関連する記事のURL
NSString *acterStr = @"https://ja.wikipedia.org/w/api.php?format=xml&action=query&list=search&srsearch=%E3%82%A8%E3%83%9E%E3%83%BB%E3%83%AF%E3%83%88%E3%82%BD%E3%83%B3&srlimit=";

@implementation Fetcher

- (void) sendSynchronousFoodFetcher
{
    NSURL *url = [NSURL URLWithString:@"https://webservice.recruit.co.jp/hotpepper/food/v1/?key=4554e737d0d5ce93"];
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    NSHTTPURLResponse *response;
    NSError *error;
    
    // 同期通信
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}

- (void) sendAsynchronousFoodFetcher
{
    NSURL *url = [NSURL URLWithString:@"https://webservice.recruit.co.jp/hotpepper/food/v1/?key=4554e737d0d5ce93"];
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    
    NSOperationQueue *queue = [NSOperationQueue new];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *res, NSData *data, NSError *error) {
        NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }];
}

- (void) wikipediaAPIFetcher:(completedBlocks)blocks
{
    NSURL *url = [NSURL URLWithString:@"https://ja.wikipedia.org/w/api.php?format=json&action=query&prop=revisions&titles=%E6%99%82%E8%A8%88&rvprop=content"];
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    // Entity格納用の配列
    NSMutableArray *watchAtrribute = [NSMutableArray array];
    
    NSOperationQueue *queue = [NSOperationQueue new];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *res, NSData *data, NSError *error) {
        
        // JSONを配列に格納
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        //最上階層を指定する
        NSDictionary *dict = [array valueForKey:@"query"];
        
        // Entityに格納
        WikipediaEntity *entity = [WikipediaEntity new];
        entity.title = [dict valueForKeyPath:@"pages.7525.title"];
        entity.contents = [dict valueForKeyPath:@"pages.7525.revisions.*"];
        [watchAtrribute addObject:entity];
        blocks(watchAtrribute);
     }];
//    return watchAtrribute;
}

- (NSMutableArray *)acterRelationRequest:(NSInteger)num
{
    NSMutableString *acterURL = [NSMutableString string];
    [acterURL setString: acterStr];
    NSString *castNum = [NSString stringWithFormat:@"%ld", num];
    [acterURL appendString: castNum];
    NSURL *url = [NSURL URLWithString: acterStr];
    //xmlファイルの場所の設定
    NSData *data=[NSData dataWithContentsOfURL:url];
    
    NSMutableArray *resultArray = [NSMutableArray array];
    
    //xmlファイルを取得
    DDXMLDocument *doc = [[DDXMLDocument alloc]initWithData:data options:0 error:nil];
    
    //要素を抜き出す時のルートパスの設定
    NSDictionary *xml = [[doc rootElement] convertDictionary];
    NSDictionary *dict = [xml valueForKeyPath:@"api.query.search"];
    
    for (NSDictionary *elements in dict) {
        ActerRelationshipEntity *entity = [ActerRelationshipEntity new];
        entity.title = [elements valueForKey:@"title"];
        entity.text = [elements valueForKey:@"snippet"];
        
        [resultArray addObject: entity];
    }
    
    return resultArray;
}

- (void)http{
    GTMHTTPFetcher* fetcher = [GTMHTTPFetcher fetcherWithURLString:@"http://www.google.com"];
    [fetcher beginFetchWithDelegate:self
                  didFinishSelector:@selector(requestDidComplete)];
}

- (void)requestDidComplete
{
    NSLog(@"Completed");
}
@end
