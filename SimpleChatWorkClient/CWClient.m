//
//  CWClient.m
//  SimpleChatWorkClient
//
//  Created by Masafumi Kawamura on 2013/11/29.
//  Copyright (c) 2013年 masaplabs. All rights reserved.
//

#import "CWClient.h"

@implementation CWClient

// ChatWork API Token Here
static NSString * const API_TOKEN = @"YOUR CHATWORK API TOKEN";

#pragma mark - 初期化

+ (CWClient*)sharedInstance
{
    static CWClient *client;
    static dispatch_once_t onceToken;
    
    // インスタンスを作成する
    dispatch_once(&onceToken, ^{
        client = [CWClient new];
    });
    
    return client;
}

- (id)init {
    NSString *apiToken = API_TOKEN;
    if(self = [super initWithHostName:@"api.chatwork.com/v1" customHeaderFields:@{@"X-ChatWorkToken": apiToken, @"User-Agent": @"NCW iOS Client/1.0.0"}]) {
        
    }
    return self;
}

#pragma mark - GET APIs

#pragma mark - /rooms

// getRooms
- (MKNetworkOperation*)getRooms:(IDBlock)success errorHandler:(MKNKErrorBlock)error {
    MKNetworkOperation *op = [self operationWithPath:@"rooms" params:@{} httpMethod:@"GET" ssl:YES];
    [op setFreezable:YES];
    [op addCompletionHandler:^(MKNetworkOperation* completedOperation) {
        
        NSArray *json = [completedOperation responseJSON];
        
        success(json);
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* err) {
        error(err);
    }];
    
    [self enqueueOperation:op];
    
    return op;
}

// getTasks
- (MKNetworkOperation*)getTasks:(NSNumber *)roomId completionHandler:(IDBlock)success errorHandler:(MKNKErrorBlock)error {
    NSString *pathBase = @"rooms/";
    NSString *roomIdString = [NSString stringWithFormat:@"%@", roomId];
    NSString *pathTasks = @"/tasks";
    
    NSString *operationPath = [[pathBase stringByAppendingString:roomIdString] stringByAppendingString:pathTasks];
    
    
    MKNetworkOperation *op = [self operationWithPath:operationPath params:@{} httpMethod:@"GET" ssl:YES];
    [op setFreezable:YES];
    [op addCompletionHandler:^(MKNetworkOperation* completedOperation) {
        
        NSArray *json = [completedOperation responseJSON];
        
        success(json);
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* err) {
        error(err);
    }];
    
    [self enqueueOperation:op];
    
    return op;
}

// getTasks
- (MKNetworkOperation*)getFiles:(NSNumber *)roomId completionHandler:(IDBlock)success errorHandler:(MKNKErrorBlock)error {
    NSString *pathBase = @"rooms/";
    NSString *roomIdString = [NSString stringWithFormat:@"%@", roomId];
    NSString *pathFiles = @"/files";
    
    NSString *operationPath = [[pathBase stringByAppendingString:roomIdString] stringByAppendingString:pathFiles];
    
    
    MKNetworkOperation *op = [self operationWithPath:operationPath params:@{} httpMethod:@"GET" ssl:YES];
    [op setFreezable:YES];
    [op addCompletionHandler:^(MKNetworkOperation* completedOperation) {
        
        NSArray *json = [completedOperation responseJSON];
        
        success(json);
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* err) {
        error(err);
    }];
    
    [self enqueueOperation:op];
    
    return op;
}

// getMembers
- (MKNetworkOperation*)getMembers:(NSNumber *)roomId completionHandler:(IDBlock)success errorHandler:(MKNKErrorBlock)error {
    NSString *pathBase = @"rooms/";
    NSString *roomIdString = [NSString stringWithFormat:@"%@", roomId];
    NSString *pathMembers = @"/members";
    
    NSString *operationPath = [[pathBase stringByAppendingString:roomIdString] stringByAppendingString:pathMembers];
    
    
    MKNetworkOperation *op = [self operationWithPath:operationPath params:@{} httpMethod:@"GET" ssl:YES];
    [op setFreezable:YES];
    [op addCompletionHandler:^(MKNetworkOperation* completedOperation) {
        
        NSArray *json = [completedOperation responseJSON];
        
        success(json);
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* err) {
        error(err);
    }];
    
    [self enqueueOperation:op];
    
    return op;
}

// getRoomById
- (MKNetworkOperation*)getRoomById:(NSNumber *)roomId completionHandler:(IDBlock)success errorHandler:(MKNKErrorBlock)error {
    NSString *pathBase = @"rooms/";
    NSString *roomIdString = [NSString stringWithFormat:@"%@", roomId];
    
    NSString *operationPath = [pathBase stringByAppendingString:roomIdString];
    
    
    MKNetworkOperation *op = [self operationWithPath:operationPath params:@{} httpMethod:@"GET" ssl:YES];
    [op setFreezable:YES];
    [op addCompletionHandler:^(MKNetworkOperation* completedOperation) {
        
        NSDictionary *json = [completedOperation responseJSON];
        
        success(json);
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* err) {
        error(err);
    }];
    
    [self enqueueOperation:op];
    
    return op;
}

// getTaskById
- (MKNetworkOperation*)getTaskById:(NSNumber *)roomId taskId:(NSNumber *)taskId completionHandler:(IDBlock)success errorHandler:(MKNKErrorBlock)error {
    NSString *pathBase = @"rooms/";
    NSString *roomIdString = [NSString stringWithFormat:@"%@", roomId];
    NSString *pathTasks = @"/tasks/";
    NSString *taskIdString = [NSString stringWithFormat:@"%@", taskId];
    
    NSString *operationPath = [[[pathBase stringByAppendingString:roomIdString] stringByAppendingString:pathTasks] stringByAppendingString:taskIdString];
    
    
    MKNetworkOperation *op = [self operationWithPath:operationPath params:@{} httpMethod:@"GET" ssl:YES];
    [op setFreezable:YES];
    [op addCompletionHandler:^(MKNetworkOperation* completedOperation) {
        
        NSDictionary *json = [completedOperation responseJSON];
        
        success(json);
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* err) {
        error(err);
    }];
    
    [self enqueueOperation:op];
    
    return op;
}

// getFileById
- (MKNetworkOperation*)getFileById:(NSNumber *)roomId fileId:(NSNumber *)fileId completionHandler:(IDBlock)success errorHandler:(MKNKErrorBlock)error {
    NSString *pathBase = @"rooms/";
    NSString *roomIdString = [NSString stringWithFormat:@"%@", roomId];
    NSString *pathFiles = @"/files/";
    NSString *fileIdString = [NSString stringWithFormat:@"%@", fileId];
    
    NSString *operationPath = [[[pathBase stringByAppendingString:roomIdString] stringByAppendingString:pathFiles] stringByAppendingString:fileIdString];
    
    
    MKNetworkOperation *op = [self operationWithPath:operationPath params:@{} httpMethod:@"GET" ssl:YES];
    [op setFreezable:YES];
    [op addCompletionHandler:^(MKNetworkOperation* completedOperation) {
        
        NSDictionary *json = [completedOperation responseJSON];
        
        success(json);
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* err) {
        error(err);
    }];
    
    [self enqueueOperation:op];
    
    return op;
}


#pragma mark - /contacts

// getContacts
- (MKNetworkOperation*)getContacts:(IDBlock)success errorHandler:(MKNKErrorBlock)error {
    MKNetworkOperation *op = [self operationWithPath:@"contacts" params:@{} httpMethod:@"GET" ssl:YES];
    [op setFreezable:YES];
    [op addCompletionHandler:^(MKNetworkOperation* completedOperation) {
        
        NSArray *json = [completedOperation responseJSON];
        
        success(json);
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* err) {
        error(err);
    }];
    
    [self enqueueOperation:op];
    
    return op;
}

#pragma mark - /my

// getMyStatus
- (MKNetworkOperation*)getMyStatus:(IDBlock)success errorHandler:(MKNKErrorBlock)error {
    MKNetworkOperation *op = [self operationWithPath:@"my/status" params:@{} httpMethod:@"GET" ssl:YES];
    [op setFreezable:YES];
    [op addCompletionHandler:^(MKNetworkOperation* completedOperation) {
        
        NSDictionary *json = [completedOperation responseJSON];
        
        success(json);
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* err) {
        error(err);
    }];
    
    [self enqueueOperation:op];
    
    return op;
}

// getMyTasks
- (MKNetworkOperation*)getMyTasks:(NSDictionary *)params completionHandler:(IDBlock)success errorHandler:(MKNKErrorBlock)error {
    MKNetworkOperation *op = [self operationWithPath:@"my/tasks" params:params httpMethod:@"GET" ssl:YES];
    [op setFreezable:YES];
    [op addCompletionHandler:^(MKNetworkOperation* completedOperation) {
        
        NSArray *json = [completedOperation responseJSON];
        
        success(json);
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* err) {
        error(err);
    }];
    
    [self enqueueOperation:op];
    
    return op;
}

#pragma mark - /me

// getMyStatus
- (MKNetworkOperation*)getMe:(IDBlock)success errorHandler:(MKNKErrorBlock)error {
    MKNetworkOperation *op = [self operationWithPath:@"me" params:@{} httpMethod:@"GET" ssl:YES];
    [op setFreezable:YES];
    [op addCompletionHandler:^(MKNetworkOperation* completedOperation) {
        
        NSDictionary *json = [completedOperation responseJSON];
        
        success(json);
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* err) {
        error(err);
    }];
    
    [self enqueueOperation:op];
    
    return op;
}

#pragma mark - POST APIs

#pragma mark - /rooms

// postRooms
- (MKNetworkOperation*)postRooms:(NSDictionary *)params completionHandler:(IDBlock)success errorHandler:(MKNKErrorBlock)error {
    MKNetworkOperation *op = [self operationWithPath:@"rooms" params:params httpMethod:@"POST" ssl:YES];
    [op setFreezable:YES];
    [op addCompletionHandler:^(MKNetworkOperation* completedOperation) {
        
        NSDictionary *json = [completedOperation responseJSON];
        
        success(json);
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* err) {
        error(err);
    }];
    
    [self enqueueOperation:op];
    
    return op;
}

// postMessage
- (MKNetworkOperation*)postMessage:(NSNumber *)roomId body:(NSString *)body completionHandler:(IDBlock)success errorHandler:(MKNKErrorBlock)error {
    NSDictionary *params = @{@"body": body};
    
    NSString *pathBase = @"rooms/";
    NSString *roomIdString = [NSString stringWithFormat:@"%@", roomId];
    NSString *pathMessages = @"/messages";
    
    NSString *operationPath = [[pathBase stringByAppendingString:roomIdString] stringByAppendingString:pathMessages];
    MKNetworkOperation *op = [self operationWithPath:operationPath params:params httpMethod:@"POST" ssl:YES];
    [op setFreezable:YES];
    [op addCompletionHandler:^(MKNetworkOperation* completedOperation) {
        
        NSDictionary *json = [completedOperation responseJSON];
        
        success(json);
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* err) {
        error(err);
    }];
    
    [self enqueueOperation:op];
    
    return op;
}

// postTask
- (MKNetworkOperation*)postTask:(NSNumber *)roomId params:(NSDictionary *)params completionHandler:(IDBlock)success errorHandler:(MKNKErrorBlock)error {
    
    NSString *pathBase = @"rooms/";
    NSString *roomIdString = [NSString stringWithFormat:@"%@", roomId];
    NSString *pathTasks = @"/tasks";
    
    NSString *operationPath = [[pathBase stringByAppendingString:roomIdString] stringByAppendingString:pathTasks];
    MKNetworkOperation *op = [self operationWithPath:operationPath params:params httpMethod:@"POST" ssl:YES];
    [op setFreezable:YES];
    [op addCompletionHandler:^(MKNetworkOperation* completedOperation) {
        
        NSDictionary *json = [completedOperation responseJSON];
        
        success(json);
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* err) {
        error(err);
    }];
    
    [self enqueueOperation:op];
    
    return op;
}

#pragma mark - DELETE APIs

#pragma mark - /rooms

// deleteRoomById
- (MKNetworkOperation*)deleteRoomById:(NSNumber *)roomId type:(NSString *)type {
    NSDictionary *params = @{@"action_type": type};
    
    NSString *pathBase = @"rooms/";
    NSString *roomIdString = [NSString stringWithFormat:@"%@", roomId];
    
    NSString *operationPath = [pathBase stringByAppendingString:roomIdString];
    MKNetworkOperation *op = [self operationWithPath:operationPath params:params httpMethod:@"DELETE" ssl:YES];
    [op setFreezable:YES];
    //
    [self enqueueOperation:op];
    
    return op;
}

@end
