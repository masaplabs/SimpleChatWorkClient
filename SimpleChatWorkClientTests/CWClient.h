//
//  CWClient.h
//  SimpleChatWorkClient
//
//  Created by Masafumi Kawamura on 2013/11/29.
//  Copyright (c) 2013年 masaplabs. All rights reserved.
//

#import "MKNetworkEngine.h"

typedef void (^IDBlock)(id object);

@interface CWClient : MKNetworkEngine

// 初期化
+(CWClient*)sharedInstance;

-(MKNetworkOperation*)getRooms:(IDBlock) success
                  errorHandler:(MKNKErrorBlock) error;

-(MKNetworkOperation*)getTasks:(NSNumber *) roomId
             completionHandler:(IDBlock) success
                  errorHandler:(MKNKErrorBlock) error;

-(MKNetworkOperation*)getFiles:(NSNumber *) roomId
             completionHandler:(IDBlock) success
                  errorHandler:(MKNKErrorBlock) error;

-(MKNetworkOperation*)getMembers:(NSNumber *) roomId
               completionHandler:(IDBlock) success
                    errorHandler:(MKNKErrorBlock) error;

-(MKNetworkOperation*)getRoomById:(NSNumber *) roomId
                completionHandler:(IDBlock) success
                     errorHandler:(MKNKErrorBlock) error;

-(MKNetworkOperation*)getTaskById:(NSNumber *) roomId
                           taskId:(NSNumber *) taskId
                completionHandler:(IDBlock) success
                     errorHandler:(MKNKErrorBlock) error;

-(MKNetworkOperation*)getFileById:(NSNumber *) roomId
                           fileId:(NSNumber *) fileId
                completionHandler:(IDBlock) success
                     errorHandler:(MKNKErrorBlock) error;

-(MKNetworkOperation*)getContacts:(IDBlock) success
                     errorHandler:(MKNKErrorBlock) error;

-(MKNetworkOperation*)getMyStatus:(IDBlock) success
                     errorHandler:(MKNKErrorBlock) error;

-(MKNetworkOperation*)getMyTasks:(NSDictionary *) params
               completionHandler:(IDBlock) success
                    errorHandler:(MKNKErrorBlock) error;

-(MKNetworkOperation*)getMe:(IDBlock) success
               errorHandler:(MKNKErrorBlock) error;

-(MKNetworkOperation*)postRooms:(NSDictionary *) params
              completionHandler:(IDBlock) success
                   errorHandler:(MKNKErrorBlock) error;

-(MKNetworkOperation*)postMessage:(NSNumber *) roomId
                             body:(NSString *) body
                completionHandler:(IDBlock) success
                     errorHandler:(MKNKErrorBlock) error;

-(MKNetworkOperation*)postTask:(NSNumber *) roomId
                        params:(NSDictionary *) params
             completionHandler:(IDBlock) success
                  errorHandler:(MKNKErrorBlock) error;

-(MKNetworkOperation*)deleteRoomById:(NSNumber *) roomId
                                type:(NSString *) type;


@end
