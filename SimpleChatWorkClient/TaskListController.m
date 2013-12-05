//
//  TaskListController.m
//  SimpleChatWorkClient
//
//  Created by Masafumi Kawamura on 2013/12/04.
//  Copyright (c) 2013年 Masafumi Kawamura. All rights reserved.
//

#import "TaskListController.h"
#import "UIImageView+WebCache.h"
#import "CWClient.h"

@interface TaskListController ()

@property UITableView *tableView;
@property UIRefreshControl *refreshControl;
@property CGRect mainScreen;
@property NSArray *tasks;

@end

@implementation TaskListController

// 初期化処理
- (void)_init
{
    // navigationBar のタイトルを設定
    self.title = NSLocalizedString(@"AllTask", @"すべてのタスク");
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

- (void)viewDidLoad
{
    [super viewDidLoad];

    // メインスクリーン
    self.mainScreen = [[UIScreen mainScreen] applicationFrame];
    
    //テーブルビューを作成
    self.tableView = [[UITableView alloc]
                  initWithFrame:CGRectMake(0, 0, self.mainScreen.size.width, self.mainScreen.size.height)
                  style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    // リフレッシュコントロールを作成
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:_refreshControl];
    
    // チャットルームリスト読み込み
    [self getTasks];
}

#pragma mark - チャットルームリスト取得

- (void)getTasks
{
    CWClient *client = [CWClient sharedInstance];
    
    NSDictionary *params = @{@"status": @"open"};
    
    // タスクリスト読み込み
    [client getMyTasks:params completionHandler:^(NSArray *json) {
        // 取得完了
        self.tasks = json;
        [self.tableView reloadData];
        // リフレッシュ完了
        [_refreshControl endRefreshing];
        DLog(@"タスクリスト取得成功");
    } errorHandler:^(NSError *error) {
        // リフレッシュ完了
        [_refreshControl endRefreshing];
        // エラー表示
        DLog("%@", error);
    }];
}

#pragma mark - テーブルリフレッシュ処理

// リフレッシュ処理
- (void)refresh
{
    [NSTimer scheduledTimerWithTimeInterval:0.f target:self selector:@selector(getTasks) userInfo:nil repeats:NO];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    // セルを取得する
    UITableViewCell *cell = (UITableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // 使いまわせるセルがあったらそれを使用する
    if (!cell) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // セルの値を更新する
    [self updateCell:cell atIndexPath:indexPath];
    
    return cell;
}

# pragma mark - TableViewCell の更新

// TableViewCell 更新
- (void)updateCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath
{
    // 指定された行のタスクを取得
//    NSDictionary *task= [self.tasks objectAtIndex:indexPath.row];
//
//    // タイトルの設定
//    NSString *body = task[@"body"];
//    UIColor *titleColor = [UIColor blackColor];
//    
//    // サブタイトルの設定
//    NSString *subtitle = task[@"subname"];
//    
//    if ([subtitle length] == 0) {
//        subtitle = @" ";
//    }
//    
//    // アイコンの設定
//    NSString *roomIconPath = task[@"icon_path"];
//    
//    // セルのキャスト
//    ChatRoomCell *chatroomCell = (ChatRoomCell*)cell;
//    
//    // セルの要素を埋める
//    chatroomCell.titleLabel.text = title;
//    chatroomCell.titleLabel.textColor = titleColor;
//    chatroomCell.subtitleLabel.text = subtitle;
//    
//    // TODO: URL を指定するパターンとローカルファイルを指定するパターンが存在するため処理を分ける
//    [chatroomCell.roomIconView setImageWithURL:[NSURL URLWithString:roomIconPath]
//                              placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
//    
//    // アクセサリの設定
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
