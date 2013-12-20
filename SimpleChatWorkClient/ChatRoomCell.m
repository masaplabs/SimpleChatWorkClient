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
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.highlightedTextColor = [UIColor whiteColor];
    
    // subtitle ラベルの作成
    self.subtitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.subtitleLabel.font = [UIFont systemFontOfSize:12.0f];
    self.subtitleLabel.textColor = [UIColor grayColor];
    self.subtitleLabel.highlightedTextColor = [UIColor whiteColor];
    
    // UIImageView の作成 (placeholder使用)
    UIImage* image = [UIImage imageNamed:@"placeholder.png"];
    self.roomIconView = [[UIImageView alloc] initWithImage:image];
    
    CGRect rect = CGRectMake(0, 0, 36, 36);
    self.roomIconView.frame = rect;
    
    // セルに各要素を追加
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subtitleLabel];
    [self.contentView addSubview:self.roomIconView];
    
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
    rect.size = self.roomIconView.frame.size;
    self.roomIconView.frame = rect;
    
    // titleLabel のレイアウト
    rect.origin.x = CGRectGetMaxX(self.roomIconView.frame) + 4.0f;
    rect.origin.y = CGRectGetMinY(bounds) + 4.0f;
    rect.size.width = CGRectGetWidth(bounds) - CGRectGetMinX(rect);
    rect.size.height = 22.0f;
    self.titleLabel.frame = rect;
    
    // subtitleLabel のレイアウト
    rect.origin.x = CGRectGetMinX(self.titleLabel.frame);
    rect.origin.y = CGRectGetMaxY(self.titleLabel.frame);
    rect.size.width = CGRectGetWidth(self.titleLabel.frame);
    rect.size.height = 14.0f;
    self.subtitleLabel.frame = rect;
    
}

@end
