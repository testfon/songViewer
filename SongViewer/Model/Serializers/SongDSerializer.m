//
//  SongDSerializer.m
//  SongViewer
//
//  Created by Михаил on 31.01.17.
//  Copyright © 2017 Михаил. All rights reserved.
//

#import "SongDSerializer.h"
#import "Song.h"

@implementation SongDSerializer

-(NSArray*) getAllSongsByJsonData:(NSData *) jsonData
{
    NSMutableArray *allSongsArray = [NSMutableArray array];
    
    id jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    NSArray *dicArray = [jsonDic valueForKey:@"results"];
    
    for (int i = 0; i < dicArray.count; i++)
    {
        Song *st = [[Song alloc] init];
        st.nameSong = [dicArray[i] valueForKey:@"trackName"];
        st.autorSong = [dicArray[i] valueForKey:@"artistName"];
        st.urlImageSong = [dicArray[i] valueForKey:@"artworkUrl100"];
        st.urlSemplSong = [dicArray[i] valueForKey:@"previewUrl"];
        
        NSString *str = [dicArray[i] valueForKey:@"releaseDate"];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm.ssZ"];
        [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];

        NSDate *result = [formatter dateFromString:str];
        
        st.releaseDate = result;
        
         [allSongsArray addObject:st];
    }
    
    return allSongsArray;
}

@end
