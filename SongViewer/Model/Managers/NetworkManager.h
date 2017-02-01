//
//  NetworkManager.h
//  SongViewer
//
//  Created by Михаил on 31.01.17.
//  Copyright © 2017 Михаил. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetworkDelegate <NSObject>

-(void) setData:(NSData *) data;

@end


@interface NetworkManager : NSObject

-(void) getDataSongsByUrl:(NSString *) url;

@property(nonatomic,weak) id<NetworkDelegate> delegate;

@end
