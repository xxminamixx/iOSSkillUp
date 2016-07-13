//
//  Rectangle.m
//  iOS Education
//
//  Created by Minami Kyohei on 2016/07/13.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Rectangle.h"

@implementation Rectangle

- (id) initWithWidth:(float)width height:(float)height {
    if (self = [super init]) {
        self.width = width;
        self.height = height;
    }
    return self;
}

- (id) init {
    return [self initWithWidth:1 height:2];    //指定イニシャライザを通す
}

- (id) initWithSize:(CGSize) size {
    self = [self initWithWidth:size.width  height:size.height];   //これも指定イニシャライザを通す
    if (self) {}
    return self;
}

@end
