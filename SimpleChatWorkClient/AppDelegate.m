//
//  AppDelegate.m
//  SimpleChatWorkClient
//
//  Created by Masafumi Kawamura on 2013/11/29.
//  Copyright (c) 2013年 Masafumi Kawamura. All rights reserved.
//

#import "AppDelegate.h"
#import "ChatRoomListController.h"
#import "TaskListController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    // tabBarController を生成
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    // 各 Controller を作成する
    ChatRoomListController *chatRoomListController = [[ChatRoomListController alloc] init];
    TaskListController *taskListController = [[TaskListController alloc] init];
    
    // navigationController を作成する
    UINavigationController *chatRoomListNavigationController = [[UINavigationController alloc] initWithRootViewController:chatRoomListController];
    
    UINavigationController *taskListNavigationController = [[UINavigationController alloc] initWithRootViewController:taskListController];
    
    // tabBarController に navigationController を設定する
    [tabBarController setViewControllers:[NSMutableArray arrayWithObjects:
                                        chatRoomListNavigationController,
                                        taskListNavigationController,
                                               nil]];
    
    [self.window setRootViewController:tabBarController];
    [self.window makeKeyAndVisible];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
