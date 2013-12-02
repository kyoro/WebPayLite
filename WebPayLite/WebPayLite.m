//
//  WebPayLite.m
//  WebPayLite
//
//  Created by Kyosuke INOUE on 2013/12/01.
//  Copyright (c) 2013 OpenSwipe. All rights reserved.
//

#import "WebPayLite.h"

@implementation WebPayLite

-(id)init{
    self.apiBase = @"https://api.webpay.jp";
    self.secretKey = @"";
    return self;
}


-(void)createToken:(NSDictionary*)params {
    NSString* url =  [NSString stringWithFormat:@"%@/v1/tokens",self.apiBase ];
    [self postRequest:url sendParams:params];
}

-(void)createCharge:(NSDictionary*)params {
    NSString* url =  [NSString stringWithFormat:@"%@/v1/charges",self.apiBase ];
    [self postRequest:url sendParams:params];
}


- (void) postRequest:(NSString*)endpoint sendParams:(NSDictionary*)params
{
    NSLog(@"AAA");
    NSURL *url = [NSURL URLWithString:endpoint];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];

    NSString *encodedCredentials = [Base64Encorder base64String:[NSString stringWithFormat:@"%@:",self.secretKey]];
    NSString *basic = [NSString stringWithFormat:@"Basic %@",encodedCredentials];
    [request addValue:basic forHTTPHeaderField:@"Authorization"];

    [request setHTTPMethod: @"POST"];
    NSString *requestStr = [self makeQuerystringFromDict:params];

    [request setHTTPBody:[requestStr dataUsingEncoding:NSUTF8StringEncoding]];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection    sendAsynchronousRequest:request
                                          queue:queue
                              completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
NSLog(@"DDD");
                                  if(error){
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          [self.delegate WebPayLiteDelegateError:error ];
                                      });
                                  }else{
                                      int httpStatusCode = ((NSHTTPURLResponse *)response).statusCode;
                                      NSString *responseText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                      if (httpStatusCode == 200) {
                                          NSLog(@"STATUS:%d",httpStatusCode);
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              [self.delegate WebPayLiteDelegateCompleted:responseText];
                                          });
                                      } else {
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              [self.delegate WebPayLiteDelegateFailed:responseText statusCode:httpStatusCode];
                                          });
                                      }
                                  }
                              }];
}

- (NSString *) urlEncode: (id)obj {
    NSString *string = [NSString stringWithFormat: @"%@", obj];
    return [string stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
}

- (NSString *) makeQuerystringFromDict: (NSDictionary *)dict {
    NSMutableArray *parts = [NSMutableArray array];
    for (id key in dict) {
        id value = [dict objectForKey: key];
        NSString *part = [NSString stringWithFormat: @"%@=%@",
                          [self urlEncode: key], [self urlEncode: value]];
        [parts addObject: part];
    }
    return [parts componentsJoinedByString: @"&"];
}

@end


@implementation Base64Encorder

+ (NSString *)base64String:(NSString *)str
{
    NSData *theData = [str dataUsingEncoding: NSASCIIStringEncoding];
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];

    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";

    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;

    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;

            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }

        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }

    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

+ (NSString *)base64StringFromData:(NSData *)theData
{
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];

    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";

    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;

    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;

            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }

        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }

    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

@end



