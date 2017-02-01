//
//  Song.m
//  SongViewer
//
//  Created by Михаил on 31.01.17.
//  Copyright © 2017 Михаил. All rights reserved.
//

#import "Song.h"

@implementation Song

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.releaseDate = [decoder decodeObjectForKey:@"releaseDate"];
        self.nameSong = [decoder decodeObjectForKey:@"nameSong"];
        self.autorSong = [decoder decodeObjectForKey:@"autorSong"];
        self.urlSemplSong = [decoder decodeObjectForKey:@"urlSemplSong"];
        self.urlImageSong = [decoder decodeObjectForKey:@"urlImageSong"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:self.releaseDate forKey:@"releaseDate"];
    [encoder encodeObject:self.nameSong forKey:@"nameSong"];
    [encoder encodeObject:self.autorSong forKey:@"autorSong"];
    [encoder encodeObject:self.urlSemplSong forKey:@"urlSemplSong"];
    [encoder encodeObject:self.urlImageSong forKey:@"urlImageSong"];
}

@end
