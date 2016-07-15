//
//  Fetcher.m
//  iOS Education
//
//  Created by Minami Kyohei on 2016/07/15.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "Fetcher.h"
#import "WikipediaEntity.h"

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

- (void) wikipediaAPIFetcher
{
    NSURL *url = [NSURL URLWithString:@"https://ja.wikipedia.org/w/api.php?format=json&action=query&prop=revisions&titles=%E6%99%82%E8%A8%88&rvprop=content"];
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    
    NSOperationQueue *queue = [NSOperationQueue new];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *res, NSData *data, NSError *error) {
//        NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//        NSLog(@"本文:%@", [array valueForKeyPath:@"query.pages"]);
        NSDictionary *dict = [array valueForKey:@"query"];
        
        WikipediaEntity *entity = [WikipediaEntity new];
        entity.title = [dict valueForKeyPath:@"pages.7525.title"];
        entity.contents = [dict valueForKeyPath:@"pages.7525.revisions.*"];
        NSLog(@"%@", entity.title);
        NSLog(@"%@", entity.contents);
     }];

}

@end
