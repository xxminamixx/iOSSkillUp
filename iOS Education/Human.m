//
//  Human.m
//  iOS Education
//
//  Created by Minami Kyohei on 2016/07/19.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "Human.h"

@implementation Human

- (id)copyWithZone:(NSZone *)zone {
    
    Human *newHuman =  [[[self class] allocWithZone:zone] init];
    
    if (newHuman) {
        newHuman.name = self.name;
        newHuman.tall = self.tall;
        newHuman.weight = self.weight;
    }
    
    return newHuman;
    
}

@end
