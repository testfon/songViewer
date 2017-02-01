//
//  NetworkManager.m
//  SongViewer
//
//  Created by Михаил on 31.01.17.
//  Copyright © 2017 Михаил. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

-(void) getDataSongsByUrl:(NSString *) url
{
    
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      
                                      if (data!=nil)
                                      {
                                          [self.delegate setData:data];
                                          
                                      }
                                  }];
    
    [task resume];
}

@end
