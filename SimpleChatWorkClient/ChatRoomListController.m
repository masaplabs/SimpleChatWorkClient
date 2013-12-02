//
//  ChatRoomListController.m
//  SimpleChatWorkClient
//
//  Created by Masafumi Kawamura on 13/11/29.
//  Copyright (c) 2013年 masaplabs. All rights reserved.
//

#import "ChatRoomListController.h"
#import "UIImageView+WebCache.h"
#import "ChatRoomCell.h"
#import "CWClient.h"

@interface ChatRoomListController ()

@property UITableView *tableView;
@property UIRefreshControl *refreshControl;
@property CGRect mainScreen;
@property NSArray *rooms;

@end

@implementation ChatRoomListController

#pragma mark - 初期化

// 初期化処理
- (void)_init
{
    // navigationBar のタイトルを設定
    self.title = NSLocalizedString(@"AllChat", @"すべてのチャット");
}

// nib ファイルから初期化
- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)bundle
{
    self = [super initWithNibName:nibName bundle:nil];
    
    if (!self) {
        return nil;
    }
    
    [self _init];
    
    return self;
}

#pragma mark - 起動時処理

// テーブルビュー描画
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // メインスクリーン
    _mainScreen = [[UIScreen mainScreen] applicationFrame];
    
    //テーブルビューを作成
    _tableView = [[UITableView alloc]
                          initWithFrame:CGRectMake(0, 0, _mainScreen.size.width, _mainScreen.size.height)
                          style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    // リフレッシュコントロールを作成
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:_refreshControl];
}

// チャットルームリスト表示処理
- (void)viewDidAppear:(BOOL)animated
{
    CWClient *client = [CWClient sharedInstance];
    
    // チャットルームリスト読み込み
    [client getRooms:^(NSArray *json) {
        // 取得完了
        _rooms = json;
        [self.tableView reloadData];
        DLog(@"取得成功");
    } errorHandler:^(NSError *error) {
        // エラー表示
        DLog("%@", error);
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // 親クラスのメソッドを呼び出す
    [super viewWillDisappear:animated];
}

#pragma mark - テーブルリフレッシュ処理

// リフレッシュ処理
- (void)refresh
{
    // 1秒後に endRefresh を動かしているだけ
    [NSTimer scheduledTimerWithTimeInterval:0.f target:self selector:@selector(endRefresh) userInfo:nil repeats:NO];
}

- (void)endRefresh
{
    // リフレッシュ完了
    [_refreshControl endRefreshing];
}

#pragma mark - TableView の基本的な設定

// テーブルビューに何行表示させるか
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.rooms count];
}

// テーブルビューのセクション数はいくつか（通常は1）
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// テーブルビューセルの作成
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    // セルを取得する
    ChatRoomCell* cell = (ChatRoomCell*)[_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // 使いまわせるセルがあったらそれを使用する
    if (!cell) {
        cell = [[ChatRoomCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // セルの値を更新する
    [self updateCell:cell atIndexPath:indexPath];
    
    return cell;
}

// テーブルビューセルが選択された場合の処理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

# pragma mark - TableViewCell の更新

// TableViewCell 更新
- (void)updateCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath
{
    // 指定された行のチャットルームを取得
    NSDictionary *room= [self.rooms objectAtIndex:indexPath.row];
    
    // タイトルの設定
    NSString *title = room[@"name"];
    UIColor *titleColor = [UIColor blackColor];
    
    if ([title length] == 0) {
        title = @"（名称未設定）";
        titleColor = [UIColor grayColor];
    }
    
    // サブタイトルの設定
    NSString *subtitle = room[@"subname"];
    
    if ([subtitle length] == 0) {
        subtitle = @" ";
    }
    
    // アイコンの設定
    NSString *roomIconPath = room[@"icon_path"];
    
    // セルのキャスト
    ChatRoomCell *chatroomCell = (ChatRoomCell*)cell;
    
    // セルの要素を埋める
    chatroomCell.titleLabel.text = title;
    chatroomCell.titleLabel.textColor = titleColor;
    chatroomCell.subtitleLabel.text = subtitle;
    
    // TODO: URL を指定するパターンとローカルファイルを指定するパターンが存在するため処理を分ける
    [chatroomCell.roomIconView setImageWithURL:[NSURL URLWithString:roomIconPath]
                              placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    // アクセサリの設定
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

#pragma mark - 例外処理

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
