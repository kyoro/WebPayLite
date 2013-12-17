//
//  WebPayLite.h
//  WebPayLite
//
//  Created by Kyosuke INOUE on 2013/12/01.
//  Copyright (c) 2013 OpenSwipe. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WebPayLiteDelegate <NSObject>
@optional
-(void)WebPayLiteDelegateCompleted:(NSString*)jsonBody;
-(void)WebPayLiteDelegateFailed:(NSString*)jsonBody statusCode:(int)status;
-(void)WebPayLiteDelegateError:(NSError*)error;
@end

@interface WebPayLite : NSObject

@property (nonatomic, assign) id <WebPayLiteDelegate> delegate;
@property (assign) NSString *apiKey;
@property (assign) NSString *apiBase;
-(id)init;
-(void)createToken:(NSDictionary*)params;
-(void)createCharge:(NSDictionary*)params;
@end

@interface Base64Encorder : NSObject

+(NSString *)base64String:(NSString *)str;
+(NSString *)base64StringFromData:(NSData *)theData;

@end