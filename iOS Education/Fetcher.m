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
#import "ActerRelationshipEntity.h"
#import "GTMSessionFetcher.h"
#import "GTMSessionFetcherService.h"

// 土偶と関連する記事のURL
NSString *acterStr = @"https://ja.wikipedia.org/w/api.php?format=xml&action=query&list=search&srsearch=%E3%82%A8%E3%83%9E%E3%83%BB%E3%83%AF%E3%83%88%E3%82%BD%E3%83%B3&srlimit=";

@implementation Fetcher

- (void) GTMsessionFetcher
{
    GTMSessionFetcherService *fetcherService = [[GTMSessionFetcherService alloc] init];
    
    GTMSessionFetcher *myFetcher = [fetcherService fetcherWithURLString:acterStr];
    myFetcher.retryEnabled = YES;
    myFetcher.comment = @"First profile image";
    
    // Optionally specify a file URL or NSData for the request body to upload.
    myFetcher.bodyData = [@"https://www.google.co.jp" dataUsingEncoding:NSUTF8StringEncoding];
    
    [myFetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (error != nil) {
            // Server status code or network error.
            //
            // If the domain is kGTMSessionFetcherStatusDomain then the error code
            // is a failure status from the server.
        } else {
            // Fetch succeeded.
            NSLog(@"成功しました");
            NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
            //デリゲートの設定
            parser.delegate = self;
            [parser parse];
        }
    }];
}

//デリゲートメソッド(解析開始時)
-(void) parserDidStartDocument:(NSXMLParser *)parser{
    
    NSLog(@"解析開始");
}

//デリゲートメソッド(要素の開始タグを読み込んだ時)
- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"要素の開始タグを読み込んだ:%@",elementName);
}

//デリゲートメソッド(タグ以外のテキストを読み込んだ時)
- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    NSLog(@"タグ以外のテキストを読み込んだ:%@", string);
}

//デリゲートメソッド(要素の終了タグを読み込んだ時)
- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    NSLog(@"要素の終了タグを読み込んだ:%@",elementName);
}

//デリゲートメソッド(解析終了時)
-(void) parserDidEndDocument:(NSXMLParser *)parser{
    
    NSLog(@"解析終了");
}


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



- (void)requestDidComplete
{
    NSLog(@"Completed");
}
@end
