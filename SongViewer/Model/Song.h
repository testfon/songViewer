//
//  Song.h
//  SongViewer
//
//  Created by Михаил on 31.01.17.
//  Copyright © 2017 Михаил. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Song : NSObject

@property(nonatomic, readwrite) NSDate* releaseDate;
@property(nonatomic, readwrite) NSString* nameSong;
@property(nonatomic, readwrite) NSString* autorSong;
@property(nonatomic, readwrite) NSString* urlSemplSong;
@property(nonatomic, readwrite) NSString* urlImageSong;

@end
