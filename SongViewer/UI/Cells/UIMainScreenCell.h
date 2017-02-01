//
//  UIMainScreenCell.h
//  SongViewer
//
//  Created by Михаил on 31.01.17.
//  Copyright © 2017 Михаил. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIMainScreenCell : UITableViewCell

@property(nonatomic,weak) IBOutlet UILabel* nameSong;
@property(nonatomic,weak) IBOutlet UILabel* autorSong;
@property(nonatomic,weak) IBOutlet UIImageView* imageSong;

@end
