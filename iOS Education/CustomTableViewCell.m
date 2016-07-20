//
//  CustomTableViewCell.m
//  iOS Education
//
//  Created by Minami Kyohei on 2016/07/20.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setTextToLabel:(NSString *)str
{
    self.label.text = str;
}

- (CGFloat)height
{
    CGFloat margin = 10;
    CGFloat bodyLabelW = self.label.bounds.size.width;
    CGSize bodySize = [self.label.attributedText boundingRectWithSize:CGSizeMake(bodyLabelW, MAXFLOAT)
                                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                                                  context:nil].size;
    NSLog(@"%f", MAXFLOAT);
    return bodySize.height + margin;
}

@end
