//
//  CustomTableViewCell.h
//  iOS Education
//
//  Created by Minami Kyohei on 2016/07/20.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;

- (CGFloat)height;
- (void)setTextToLabel:(NSString *)str;

@end
