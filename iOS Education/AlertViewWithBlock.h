//
//  AlertViewWithBlock.h
//  iOS Education
//
//  Created by Minami Kyohei on 2016/07/29.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertViewWithBlock : UIAlertView<UIAlertViewDelegate>

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelHandler:(void (^)(UIAlertView* view))cancelHandler buttonHandler:(void (^)(UIAlertView* view, NSInteger index))buttonHandler buttonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@end
