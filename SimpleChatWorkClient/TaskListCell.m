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
    _bodyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _bodyLabel.font = [UIFont systemFontOfSize:14.0f];
    _bodyLabel.textColor = [UIColor blackColor];
    _bodyLabel.highlightedTextColor = [UIColor whiteColor];
    _bodyLabel.numberOfLines = 0; // 行数無制限
    _bodyLabel.lineBreakMode = NSLineBreakByWordWrapping; // 折り返し
    
    // 期限
    _limitLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _limitLabel.font = [UIFont systemFontOfSize:12.0f];
    _limitLabel.textColor = [UIColor grayColor];
    _limitLabel.highlightedTextColor = [UIColor whiteColor];
    
    // UIImageView の作成 (placeholder使用)
    UIImage* image = [UIImage imageNamed:@"placeholder.png"];
    _iconView = [[UIImageView alloc] initWithImage:image];
    
    CGRect rect = CGRectMake(0, 0, 36, 36);
    _iconView.frame = rect;
    
    // セルに各要素を追加
    [self.contentView addSubview:_bodyLabel];
    [self.contentView addSubview:_limitLabel];
    [self.contentView addSubview:_iconView];
    
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
    iconViewFrame.size = _iconView.frame.size;
    
    if (withLayout) {
        _iconView.frame = iconViewFrame;
    }
    
    CGFloat minHeight = iconViewFrame.origin.y + iconViewFrame.size.height + CELLMARGIN;
    
    CGRect bodyLabelFrame;
    bodyLabelFrame.origin.x = iconViewFrame.origin.x + iconViewFrame.size.width + CELLMARGIN;
    bodyLabelFrame.origin.y = CELLMARGIN;
    bodyLabelFrame.size.width = size.width - bodyLabelFrame.origin.x - CELLMARGIN;
    bodyLabelFrame.size.height = size.height - bodyLabelFrame.origin.y;
    bodyLabelFrame.size = [_bodyLabel sizeThatFits:bodyLabelFrame.size];
    
    if (withLayout) {
        _bodyLabel.frame = bodyLabelFrame;
    }
    
    CGRect limitLabelFrame;
    limitLabelFrame.origin.x = bodyLabelFrame.origin.x;
    limitLabelFrame.origin.y = bodyLabelFrame.origin.y + bodyLabelFrame.size.height + CELLMARGIN;
    limitLabelFrame.size.width = size.width - limitLabelFrame.origin.x - CELLMARGIN;
    limitLabelFrame.size.height = size.height - limitLabelFrame.origin.y + CELLMARGIN;
    limitLabelFrame.size = [_limitLabel sizeThatFits:limitLabelFrame.size];
    
    if (withLayout) {
        _limitLabel.frame = limitLabelFrame;
    }
    
    size.height = bodyLabelFrame.size.height + limitLabelFrame.size.height + CELLMARGIN * 2;
    if (size.height < minHeight) {
        size.height = minHeight;
    }
    
    return size;
}

@end
