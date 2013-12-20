//
//  TimeLineController.m
//  SimpleChatWorkClient
//
//  Created by Masafumi Kawamura on 2013/12/19.
//  Copyright (c) 2013年 Masafumi Kawamura. All rights reserved.
//

#import "TimeLineController.h"
#import "CWClient.h"


@interface TimeLineController ()

@property NSMutableArray *messages;
@property NSMutableArray *timestamps;
@property NSMutableArray *subtitles;
@property NSDictionary *avatars;
@property NSNumber *roomId;
@property NSString *roomName;

@end

@implementation TimeLineController

- (id)initWithChatRoom:(NSDictionary *) room
{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _roomId = room[@"room_id"];
    _roomName = room[@"name"];
    
    return self;
}

- (void)viewDidLoad
{
    self.delegate = self;
    self.dataSource = self;
    [super viewDidLoad];
    
    [[JSBubbleView appearance] setFont:[UIFont systemFontOfSize:16.0f]];
    
    self.title = _roomName;
    
    self.messageInputView.textView.placeHolder = @"ここにメッセージ内容を入力";
    
    [self setBackgroundColor:[UIColor whiteColor]];
    
    self.messages = [@[@"書き込みは実際に反映されるのでご注意ください"] mutableCopy];
    
    self.timestamps = [@[[NSDate date]] mutableCopy];
    
    self.subtitles = [@[@"発言者の名前が入ります"] mutableCopy];
    
    self.avatars = @{};
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFastForward                                                                                           target:self                                                                                          action:@selector(buttonPressed:)];
}

- (void)buttonPressed:(UIButton *)sender
{
    // TODO: sendTaskController を作成する
//    TimeLineController *vc = [[TimeLineController alloc] initWithNibName:nil bundle:nil];
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _messages.count;
}

#pragma mark - Messages view delegate: REQUIRED

// 送信ボタンを押したときの処理
- (void)didSendText:(NSString *)text
{
    CWClient *client = [CWClient sharedInstance];
    
    // メッセージ送信
    [client postMessage:_roomId body:text completionHandler:^(NSDictionary *json) {
        [_messages addObject:text];
        
        [_timestamps addObject:[NSDate date]];
        
        [JSMessageSoundEffect playMessageReceivedSound];
        
        [_subtitles addObject:@"名称未設定"];
        
        [self finishSend];
        [self scrollToBottomAnimated:YES];
    } errorHandler:^(NSError *error) {
        DLog(@"%@", error);
    }];
}

// どちらから吹き出しを表示するか
- (JSBubbleMessageType)messageTypeForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // JSBubbleMessageTypeIncoming (左から吹き出し) or JSBubbleMessageTypeOutgoing (右から吹き出し)
    return JSBubbleMessageTypeIncoming;
}

// 吹き出しの色
- (UIImageView *)bubbleImageViewWithType:(JSBubbleMessageType)type
                       forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return [JSBubbleImageViewFactory bubbleImageViewForType:type
//                                                          color:[UIColor js_bubbleLightGrayColor]];
    
    return [JSBubbleImageViewFactory bubbleImageViewForType:type
                                                      color:[UIColor js_bubbleBlueColor]];
}

- (JSMessagesViewTimestampPolicy)timestampPolicy
{
    return JSMessagesViewTimestampPolicyEveryThree;
}

- (JSMessagesViewAvatarPolicy)avatarPolicy
{
    return JSMessagesViewAvatarPolicyAll;
}

- (JSMessagesViewSubtitlePolicy)subtitlePolicy
{
    return JSMessagesViewSubtitlePolicyAll;
}

- (JSMessageInputViewStyle)inputViewStyle
{
    return JSMessageInputViewStyleFlat;
}

#pragma mark - Messages view delegate: OPTIONAL

//
//  *** Implement to customize cell further
//
- (void)configureCell:(JSBubbleMessageCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    if([cell messageType] == JSBubbleMessageTypeOutgoing) {
        cell.bubbleView.textView.textColor = [UIColor whiteColor];
        
        if([cell.bubbleView.textView respondsToSelector:@selector(linkTextAttributes)]) {
            NSMutableDictionary *attrs = [cell.bubbleView.textView.linkTextAttributes mutableCopy];
            [attrs setValue:[UIColor blueColor] forKey:NSForegroundColorAttributeName];
            
            cell.bubbleView.textView.linkTextAttributes = attrs;
        }
    }
    
    if(cell.timestampLabel) {
        cell.timestampLabel.textColor = [UIColor lightGrayColor];
        cell.timestampLabel.shadowOffset = CGSizeZero;
    }
    
    if(cell.subtitleLabel) {
        cell.subtitleLabel.textColor = [UIColor lightGrayColor];
    }
}


//  *** Required if using `JSMessagesViewTimestampPolicyCustom`
//
//  - (BOOL)hasTimestampForRowAtIndexPath:(NSIndexPath *)indexPath
//

//  *** Implement to use a custom send button
//
//  The button's frame is set automatically for you
//
//  - (UIButton *)sendButtonForInputView
//

//  *** Implement to prevent auto-scrolling when message is added
//
- (BOOL)shouldPreventScrollToBottomWhileUserScrolling
{
    return YES;
}

#pragma mark - Messages view data source: REQUIRED

- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_messages objectAtIndex:indexPath.row];
}

- (NSDate *)timestampForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_timestamps objectAtIndex:indexPath.row];
}

- (UIImageView *)avatarImageViewForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *subtitle = [_subtitles objectAtIndex:indexPath.row];
    UIImage *image = [_avatars objectForKey:subtitle];
    return [[UIImageView alloc] initWithImage:image];
}

- (NSString *)subtitleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_subtitles objectAtIndex:indexPath.row];
}

@end
