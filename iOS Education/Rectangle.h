//
//  Rectangle.h
//  iOS Education
//
//  Created by Minami Kyohei on 2016/07/13.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Rectangle.h"



@interface Rectangle : NSObject
@property float width;
@property float height;
- (id) initWithWidth:(float)width height:(float)height;
- (id)initWithHeight:(int)height;
@end
