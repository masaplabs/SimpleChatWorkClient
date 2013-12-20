//
//  TaskListController.m
//  SimpleChatWorkClient
//
//  Created by Masafumi Kawamura on 2013/12/04.
//  Copyright (c) 2013年 Masafumi Kawamura. All rights reserved.
//

#import "TaskListController.h"
#import "UIImageView+WebCache.h"
#import "TaskListCell.h"
#import "CWClient.h"

@interface TaskListController ()

@property UITableView *tableView;
@property UIRefreshControl *refreshControl;
@property CGRect mainScreen;
@property NSArray *tasks;
@property TaskListCell *cellForHeight;

@end

@implementation TaskListController

#pragma mark - 初期化

- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)bundle
{
    self = [super initWithNibName:nibName bundle:nil];
    
    if (!self) {
        return nil;
    }
    
    // navigationBar のタイトルを設定
    self.title = NSLocalizedString(@"AllTask", @"すべてのタスク");
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // メインスクリーン
    self.mainScreen = [[UIScreen mainScreen] applicationFrame];
    
    //テーブルビューを作成
    self.tableView = [[UITableView alloc]
                  initWithFrame:CGRectMake(0, 0, self.mainScreen.size.width, self.mainScreen.size.height + 20)
                  style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    // リフレッシュコントロールを作成
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    // タスクリスト読み込み
    [self getTasks];
    
    // セルが可変なため高さ計算用のセルを用意
    _cellForHeight = [[TaskListCell alloc] initWithFrame:CGRectZero];
}

#pragma mark - タスクリスト取得

- (void)getTasks
{
    CWClient *client = [CWClient sharedInstance];
    
    NSDictionary *params = @{@"status": @"open"};
    
    // タスクリスト読み込み
    [client getMyTasks:params completionHandler:^(NSArray *json) {
        // 取得完了時処理
        self.tasks = json;
        
        [self.tableView reloadData];
        
        // リフレッシュ完了
        [self.refreshControl endRefreshing];
        
        DLog(@"タスクリスト取得成功");
    } errorHandler:^(NSError *error) {
        // リフレッシュ完了
        [self.refreshControl endRefreshing];
        
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

#pragma mark - TableView の基本設定

// テーブルビューに何行表示させるか
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// テーブルビューに何行表示させるか
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tasks count];
}

// テーブルビューセル作成
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    // セル取得
    TaskListCell *cell = (TaskListCell*)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[TaskListCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // セルの値を更新
    [self updateCell:cell atIndexPath:indexPath];
    
    return cell;
}

// テーブルビューセルが選択された場合の処理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

// テーブルビューセルの高さを取得
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    
    CGSize size;
    size.width = self.tableView.frame.size.width;
    size.height = 2000.0f;
    
    size = [cell sizeThatFits:size];
    
    return size.height + 10;
}

# pragma mark - TableViewCell の更新

- (void)updateCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath
{
    // 指定された行のタスクを取得
    NSDictionary *task= [self.tasks objectAtIndex:indexPath.row];

    // タスク本文の設定
    NSString *bodyLabel = task[@"body"];
    UIColor *titleColor = [UIColor blackColor];
    
    // 期限の設定
    NSString *limitLabel = [task[@"limit_time"] stringValue];
    if ([limitLabel  isEqual: @"0"]) {
        limitLabel = @" ";
    }else{
        double timestampValue = [task[@"limit_time"] doubleValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestampValue];
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
        NSString *limitTag = @"期限: ";
        limitLabel = [limitTag stringByAppendingString:[dateFormatter stringFromDate:date]];
    }
    
    // アイコンの設定
    NSString *iconPath = task[@"assigned_by_account"][@"avatar_image_url"];
    
    TaskListCell *taskCell = (TaskListCell*)cell;
    
    // セルの要素を埋める
    taskCell.bodyLabel.text = bodyLabel;
    taskCell.bodyLabel.textColor = titleColor;
    taskCell.limitLabel.text = limitLabel;
    
    // TODO: placeholder.png を用意する
    [taskCell.iconView setImageWithURL:[NSURL URLWithString:iconPath]
                              placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
}

#pragma mark - 例外処理

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
