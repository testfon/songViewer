//
//  UIMainScreenVC.m
//  SongViewer
//
//  Created by Михаил on 31.01.17.
//  Copyright © 2017 Михаил. All rights reserved.
//

#import "UIMainScreenVC.h"
#import "UISongScreenVC.h"
#import "UIMainScreenCell.h"
#import "SongManager.h"
#import "Song.h"

static NSString* kMainCellID = @"itemCell";

static NSString*  kCellIDKey = @"CellIDKey";
static NSString*  kCellNameKey = @"kCellNameKey";
static NSString*  kCellAutorKey = @"kCellAutorKey";
static NSString*  kCellItemKey = @"kCellItemKey";
static NSString*  kActionKey = @"ActionKey";

static NSString*  kSectionTitleKey = @"kSectionTitleKey";
static NSString*  kSectionContentKey = @"kSectionContentKey";

@interface UIMainScreenVC () <UITableViewDelegate,UITableViewDataSource,SongManagerDelegate>

@property(nonatomic)NSArray* dataSource;
@property (nonatomic, strong) SongManager *sManager;

@end

@implementation UIMainScreenVC

{
    IBOutlet UITableView * table;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.sManager = [[SongManager alloc] init];
    self.sManager.delegate = self;
    
    self.navigationItem.title = NSLocalizedString(@"IDS_TITLE_MAIN_SCREEN", @"");
    
    [self updateDataSource];
    [table reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)updateDataSource
{
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableArray* ds = [NSMutableArray array];
    
    
    if ([self.sManager.model count] > 0)
    {
        NSMutableArray *noSortedArr = [NSMutableArray array];
        
        for (Song *item in self.sManager.model)
        {
            [noSortedArr addObject:@{kCellIDKey  : kMainCellID,
                                     kCellNameKey : item.nameSong,
                                     kCellAutorKey: item.autorSong,
                                     kCellItemKey: item,
                                     kActionKey  : ^{ [weakSelf presentSongVCByModel:item withIdVC:@"uiSongScreenVC"]; }}];
        }
        

        
        
        NSArray *sortedArray;
        sortedArray = [noSortedArr sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
            NSDictionary *dict = a;
            Song* song1 = [dict objectForKey:kCellItemKey];
            NSDate *first = song1.releaseDate;
            
            NSDictionary *dict1 = b;
            Song* song2 = [dict1 objectForKey:kCellItemKey];
            NSDate *second = song2.releaseDate;
            return [first compare:second];
        }];
        
        
        [ds addObject:@{kSectionTitleKey:NSLocalizedString(@"", @""),
                        kSectionContentKey:sortedArray}];
        self.dataSource =ds;
    }
    else
    {
        Song *item = [[Song alloc] init];
        NSMutableArray *s0rows = [NSMutableArray array];
        [s0rows addObject:@{kCellIDKey  : kMainCellID,
                            kCellNameKey : NSLocalizedString(@"IDS_MAIN_SCREEN_DEFAULT_NAME", @""),
                            kCellAutorKey: NSLocalizedString(@"IDS_MAIN_SCREEN_DEFAULT_ARTIST", @""),
                            kCellItemKey: item,
                            kActionKey  : ^{ }}];
        [ds addObject:@{kSectionTitleKey:NSLocalizedString(@"", @""),
                        kSectionContentKey:s0rows}];
        self.dataSource =ds;
        
    }
    
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
    
    static NSString *cellIdentifier = @"uiMainScreenCell";
    
    UIMainScreenCell* cell  = nil;
    
    if([[dict objectForKey:kCellIDKey] isEqualToString:kMainCellID])
    {
        
        Song *item = [dict objectForKey:kCellItemKey];
        
        cell = (UIMainScreenCell *)[table dequeueReusableCellWithIdentifier:cellIdentifier];
        cell.nameSong.text = [dict objectForKey:kCellNameKey];
        cell.autorSong.text = [dict objectForKey:kCellAutorKey];

#warning  Be careful! Next is the pattern addict

        if(![item.urlImageSong isEqualToString:@""])
        {
        NSString *imageUrl = item.urlImageSong;
        
        NSURL *imageURL = [NSURL URLWithString:imageUrl];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.imageSong.image = [UIImage imageWithData:imageData];
                [cell.imageSong setContentMode:UIViewContentModeScaleAspectFit];
            });
        });
        }
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary* dict = [[[self.dataSource objectAtIndex:indexPath.section] objectForKey:kSectionContentKey] objectAtIndex:indexPath.row];
    
    void(^block)() = dict[kActionKey];
    
    if (block) {
        block();
    }
    [self.view endEditing:YES];
}

-(void) presentSongVCByModel:(Song*) model withIdVC:(NSString *) idVC
{
    
     UISongScreenVC* svc = [self.storyboard instantiateViewControllerWithIdentifier:idVC];
     svc.model = model;
    
    [self.navigationController pushViewController:svc animated:YES];
}

#pragma mark - UISearchDisplayController delegate methods

-(BOOL)searchDisplayController:(UISearchController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    if (![searchString isEqualToString:@""])
    {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [self.sManager getAllSongsByName:searchString];
    }
    
    return YES;
}

-(void) lastLoadName:(NSString *)name
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self updateDataSource];
    [table reloadData];
}

@end
