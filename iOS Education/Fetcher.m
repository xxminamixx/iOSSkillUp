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

// 土偶と関連する記事のURL
NSString * const kClayFigureStr = @"https://ja.wikipedia.org/w/api.php?format=xml&action=query&list=search&srsearch=%E5%9C%9F%E5%81%B6";

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

- (void)ClayFigureRelationRequest
{
    NSURL *url = [NSURL URLWithString: kClayFigureStr];
}

@end
