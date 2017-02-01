//
//  SongManager.h
//  SongViewer
//
//  Created by Михаил on 31.01.17.
//  Copyright © 2017 Михаил. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SongManagerDelegate <NSObject>

-(void) lastLoadName:(NSString *) name;

@end

@interface SongManager : NSObject

@property (nonatomic) NSArray *model;

@property (nonatomic, weak) id<SongManagerDelegate> delegate;

-(void) getAllSongsByName:(NSString *) name;

@end
