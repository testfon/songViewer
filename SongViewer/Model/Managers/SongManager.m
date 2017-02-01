//
//  SongManager.m
//  SongViewer
//
//  Created by Михаил on 31.01.17.
//  Copyright © 2017 Михаил. All rights reserved.
//

#import "SongManager.h"
#import "NetworkManager.h"
#import "SongDSerializer.h"

static NSString* const URL_CONECTION  =  @"https://itunes.apple.com/search?term=";

@interface SongManager() <NetworkDelegate>

@property(nonatomic, readwrite) NSString *lastName;

@end

@implementation SongManager

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _lastName = @"";
        _model = [NSArray array];
    }
    return self;
}

-(void) getAllSongsByName:(NSString *) name
{
    self.lastName = name;
    
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_CONECTION,name];
    
    NetworkManager *nManager = [[NetworkManager alloc] init];
    nManager.delegate = self;
    [nManager getDataSongsByUrl:url];
    
}


-(void) setData:(NSData *)data
{
    SongDSerializer *dSerializer = [[SongDSerializer alloc] init];
    
    self.model = [dSerializer getAllSongsByJsonData:data];
    
    [self.delegate lastLoadName:self.lastName];
}

@end
