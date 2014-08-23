//
//  MASBugCell.h
//  Scary Bugs
//
//  Created by Mark Stuver on 8/17/14.
//  Copyright (c) 2014 Halo International Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MASBugCell : UITableViewCell


/// Create Properties to be linked with the items in the Custom Cell
/// * *always remember to use UBOutlet

@property (weak, nonatomic) IBOutlet UILabel *bugLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bugImage;
@property (weak, nonatomic) IBOutlet UIImageView *favoriteBug;



@end

