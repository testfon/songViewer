//
//  UISongScreenVC.m
//  SongViewer
//
//  Created by Михаил on 01.02.17.
//  Copyright © 2017 Михаил. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

#import "UISongScreenVC.h"
#import "UISongScreenCell.h"

static NSString* kSongCellID = @"itemCell";

static NSString*  kCellIDKey = @"CellIDKey";

static NSString*  kCellDataKey = @"kCellDataKey";

static NSString*  kCellNameKey = @"kCellNameKey";
static NSString*  kCellAutorKey = @"kCellAutorKey";


static NSString*  kSectionTitleKey = @"kSectionTitleKey";
static NSString*  kSectionContentKey = @"kSectionContentKey";

@interface UISongScreenVC () <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic)NSArray* dataSource;

@property(nonatomic)AVAudioPlayer *audioPlayer;
@property(nonatomic)AVPlayer *player;

@end

@implementation UISongScreenVC

{
    IBOutlet UIImageView *imageSong;
    IBOutlet UITableView *table;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *imageUrl = self.model.urlImageSong;

    NSURL *imageURL = [NSURL URLWithString:imageUrl];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            imageSong.image = [UIImage imageWithData:imageData];
            [imageSong setContentMode:UIViewContentModeCenter];
        });
    });
    
    self.navigationItem.title = NSLocalizedString(@"IDS_TITLE_SONG_SCREEN", @"");
    
    NSString* resourcePath = self.model.urlSemplSong; //your url
    NSData *_objectData = [NSData dataWithContentsOfURL:[NSURL URLWithString:resourcePath]];
    NSError *error;
    
    self.audioPlayer = [[AVAudioPlayer alloc] initWithData:_objectData error:&error];
    self.audioPlayer.numberOfLoops = 0;
    self.audioPlayer.volume = 1.0f;
    
    [self updateDataSource];
    [table reloadData];
    
}

- (void)updateDataSource
{
    
    NSMutableArray* ds = [NSMutableArray array];
    
        NSMutableArray *arr = [NSMutableArray array];
    
        [arr addObject:@{kCellIDKey  : kSongCellID,
                         kCellDataKey  : [NSString stringWithFormat:@"Название: %@",self.model.nameSong]}];
        [arr addObject:@{kCellIDKey  : kSongCellID,
                         kCellDataKey  : [NSString stringWithFormat:@"Артист: %@",self.model.autorSong]}];
        [arr addObject:@{kCellIDKey  : kSongCellID,
                         kCellDataKey  : [NSString stringWithFormat:@"Дата выхода: %@",[NSDateFormatter localizedStringFromDate:self.model.releaseDate
                                                                                                                       dateStyle:NSDateFormatterShortStyle
                                                                                                                       timeStyle:NSDateFormatterShortStyle]]}];
        
        [ds addObject:@{kSectionTitleKey:NSLocalizedString(@"", @""),
                        kSectionContentKey:arr}];
        self.dataSource =ds;
}

#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  [self.dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[self.dataSource objectAtIndex:section] objectForKey:kSectionContentKey] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary* dict = [[[self.dataSource objectAtIndex:indexPath.section] objectForKey:kSectionContentKey] objectAtIndex:indexPath.row];
    
    static NSString *cellIdentifier = @"uiSongScreenCell";
    
    UISongScreenCell* cell  = nil;
    
    if([[dict objectForKey:kCellIDKey] isEqualToString:kSongCellID])
    {
        cell = (UISongScreenCell *)[table dequeueReusableCellWithIdentifier:cellIdentifier];
        cell.dataSong.text = [dict objectForKey:kCellDataKey];
    }
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (IBAction)playSong:(id)sender
{
    
    [self.audioPlayer play];
}
- (IBAction)stopPlaySong:(id)sender
{
    [self.audioPlayer stop];
}

@end
