//
//  NCWChatRoomListCell.m
//  NextChatWork
//
//  Created by Masafumi Kawamura on 13/04/10.
//  Copyright (c) 2013年 masaplabs. All rights reserved.
//

#import "ChatRoomCell.h"

@implementation ChatRoomCell

#pragma mark - 初期化

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    // 親クラスの初期化メソッドを呼び出す
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (!self) {
       return nil;
    }
    
    // title ラベルの作成
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.highlightedTextColor = [UIColor whiteColor];
    
    // subtitle ラベルの作成
    _subtitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _subtitleLabel.font = [UIFont systemFontOfSize:12.0f];
    _subtitleLabel.textColor = [UIColor grayColor];
    _subtitleLabel.highlightedTextColor = [UIColor whiteColor];
    
    // UIImageView の作成 (placeholder使用)
    UIImage* image = [UIImage imageNamed:@"placeholder.png"];
    _roomIconView = [[UIImageView alloc] initWithImage:image];
    
    CGRect rect = CGRectMake(0, 0, 36, 36);
    _roomIconView.frame = rect;
    
    // セルに各要素を追加
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_subtitleLabel];
    [self.contentView addSubview:_roomIconView];
    
    return self;
}

- (void)setupRowData:(NSDictionary *)rowData
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - レイアウト

- (void)layoutSubviews
{
    CGRect  rect;
    
    // 親クラスの layoutSubviews を呼び出す
    [super layoutSubviews];
    
    // contentView の大きさを取得する
    CGRect bounds = self.contentView.bounds;
    
    // imageViewのレイアウト
    rect.origin.x = 4.0f;
    rect.origin.y = 4.0f;
    rect.size = _roomIconView.frame.size;
    _roomIconView.frame = rect;
    
    // titleLabel のレイアウト
    rect.origin.x = CGRectGetMaxX(_roomIconView.frame) + 4.0f;
    rect.origin.y = CGRectGetMinY(bounds) + 4.0f;
    rect.size.width = CGRectGetWidth(bounds) - CGRectGetMinX(rect);
    rect.size.height = 22.0f;
    _titleLabel.frame = rect;
    
    // subtitleLabel のレイアウト
    rect.origin.x = CGRectGetMinX(_titleLabel.frame);
    rect.origin.y = CGRectGetMaxY(_titleLabel.frame);
    rect.size.width = CGRectGetWidth(_titleLabel.frame);
    rect.size.height = 14.0f;
    _subtitleLabel.frame = rect;
    
}

@end
