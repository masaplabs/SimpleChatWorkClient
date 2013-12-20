//
//  TaskListCell.m
//  SimpleChatWorkClient
//
//  Created by Masafumi Kawamura on 2013/12/06.
//  Copyright (c) 2013年 Masafumi Kawamura. All rights reserved.
//

#import "TaskListCell.h"

#define CELLMARGIN 10

@implementation TaskListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (!self) {
        return nil;
    }
    
    // タスク本文
    self.bodyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.bodyLabel.font = [UIFont systemFontOfSize:14.0f];
    self.bodyLabel.textColor = [UIColor blackColor];
    self.bodyLabel.highlightedTextColor = [UIColor whiteColor];
    self.bodyLabel.numberOfLines = 0; // 行数無制限
    self.bodyLabel.lineBreakMode = NSLineBreakByWordWrapping; // 折り返し
    
    // 期限
    self.limitLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.limitLabel.font = [UIFont systemFontOfSize:12.0f];
    self.limitLabel.textColor = [UIColor grayColor];
    self.limitLabel.highlightedTextColor = [UIColor whiteColor];
    
    // UIImageView の作成 (placeholder使用)
    UIImage* image = [UIImage imageNamed:@"placeholder.png"];
    self.iconView = [[UIImageView alloc] initWithImage:image];
    
    CGRect rect = CGRectMake(0, 0, 36, 36);
    self.iconView.frame = rect;
    
    // セルに各要素を追加
    [self.contentView addSubview:self.bodyLabel];
    [self.contentView addSubview:self.limitLabel];
    [self.contentView addSubview:self.iconView];
    
    return self;
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - レイアウト

- (CGSize)sizeThatFits:(CGSize)size
{
    return [self sizeThatFits:size withLayout:NO];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect bounds = self.bounds;
    [self sizeThatFits:bounds.size withLayout:YES];
}

#pragma mark - サイズ計算及びレイアウト

- (CGSize)sizeThatFits:(CGSize)size withLayout:(BOOL)withLayout
{
    CGRect iconViewFrame;
    // iconViewのレイアウト
    iconViewFrame.origin.x = 4.0f;
    iconViewFrame.origin.y = 4.0f;
    iconViewFrame.size = self.iconView.frame.size;
    
    if (withLayout) {
        self.iconView.frame = iconViewFrame;
    }
    
    CGFloat minHeight = iconViewFrame.origin.y + iconViewFrame.size.height + CELLMARGIN;
    
    CGRect bodyLabelFrame;
    bodyLabelFrame.origin.x = iconViewFrame.origin.x + iconViewFrame.size.width + CELLMARGIN;
    bodyLabelFrame.origin.y = CELLMARGIN;
    bodyLabelFrame.size.width = size.width - bodyLabelFrame.origin.x - CELLMARGIN;
    bodyLabelFrame.size.height = size.height - bodyLabelFrame.origin.y;
    bodyLabelFrame.size = [self.bodyLabel sizeThatFits:bodyLabelFrame.size];
    
    if (withLayout) {
        self.bodyLabel.frame = bodyLabelFrame;
    }
    
    CGRect limitLabelFrame;
    limitLabelFrame.origin.x = bodyLabelFrame.origin.x;
    limitLabelFrame.origin.y = bodyLabelFrame.origin.y + bodyLabelFrame.size.height + CELLMARGIN;
    limitLabelFrame.size.width = size.width - limitLabelFrame.origin.x - CELLMARGIN;
    limitLabelFrame.size.height = size.height - limitLabelFrame.origin.y + CELLMARGIN;
    limitLabelFrame.size = [self.limitLabel sizeThatFits:limitLabelFrame.size];
    
    if (withLayout) {
        self.limitLabel.frame = limitLabelFrame;
    }
    
    size.height = bodyLabelFrame.size.height + limitLabelFrame.size.height + CELLMARGIN * 2;
    if (size.height < minHeight) {
        size.height = minHeight;
    }
    
    return size;
}

@end
