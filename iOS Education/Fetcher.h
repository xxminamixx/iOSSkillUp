//
//  Fetcher.h
//  iOS Education
//
//  Created by Minami Kyohei on 2016/07/15.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDXMLDocument.h"

// コントローラに配列を受け渡す
typedef void (^completedBlocks)(NSMutableArray *);

@interface Fetcher : NSObject

- (void) sendSynchronousFoodFetcher;
- (void) sendAsynchronousFoodFetcher;
- (void) wikipediaAPIFetcher:(completedBlocks)blocks;

@end
