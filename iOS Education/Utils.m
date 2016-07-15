//
//  Utils.m
//  iOS Education
//
//  Created by Minami Kyohei on 2016/07/15.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (NSString *)decodeJSONString:(NSString *)input
{
    
    NSString *esc1 = [input stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *esc2 = [esc1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *quoted = [[@"\"" stringByAppendingString:esc2] stringByAppendingString:@"\""];
    NSData *data = [quoted dataUsingEncoding:NSUTF8StringEncoding];
    NSString *unesc = [NSPropertyListSerialization propertyListFromData:data
                                                       mutabilityOption:NSPropertyListImmutable format:NULL
                                                       errorDescription:NULL];
    assert([unesc isKindOfClass:[NSString class]]);
    return unesc;
}

@end
