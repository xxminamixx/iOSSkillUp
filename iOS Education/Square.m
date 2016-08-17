//
//  Square.m
//  iOS Education
//
//  Created by Minami Kyohei on 2016/07/13.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "Square.h"

@implementation Square

- (id) initWithLength:(float)length {
    self = [super initWithWidth:length height:length];
    if (self) {
    }
    return self;
//    if (self = [super initWithHeight:length]) {
//    }
//    return self;
}

//- (id) init {
//    if (self = [super init]) {
//        self.height = 100;
//        self.width = 120;
//    }
//    return self;
//}

//親クラス指定イニシャライザは必ずオーバーライドする
- (id) initWithWidth:(float)width height:(float)height {
    //今回は幅高さの平均を正方形の大きさとする
    float length = (width + height) / 2;
    return [self initWithLength:length];   //このクラスの指定イニシャライザを通す
}

@end
