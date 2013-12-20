//
//  TimeLineController.h
//  SimpleChatWorkClient
//
//  Created by Masafumi Kawamura on 2013/12/19.
//  Copyright (c) 2013年 Masafumi Kawamura. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JSMessagesViewController.h"

@interface TimeLineController : JSMessagesViewController <JSMessagesViewDataSource, JSMessagesViewDelegate>

- (id)initWithChatRoom:(NSDictionary *)room;

@end
