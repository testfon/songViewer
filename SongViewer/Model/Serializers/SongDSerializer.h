//
//  SongDSerializer.h
//  SongViewer
//
//  Created by Михаил on 31.01.17.
//  Copyright © 2017 Михаил. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SongDSerializer : NSObject

-(NSArray*) getAllSongsByJsonData:(NSData *) jsonData;

@end
