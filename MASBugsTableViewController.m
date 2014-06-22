//
//  MASBugsTableViewController.m
//  Scary Bugs
//
//  Created by Mark Stuver on 6/21/14.
//  Copyright (c) 2014 Halo International Corp. All rights reserved.
//

#import "MASBugsTableViewController.h"

/// import the ScaryBug Class Header
#import "ScaryBug.h"

@interface MASBugsTableViewController ()

/// Create private property NSArray to hold mutableArray of bugs
@property (nonatomic, strong) NSArray *bugs;

@end

@implementation MASBugsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /// Load the Array with the mutableArray that is returned from calling the ScaryBug Class Method 'bugs'.
    self.bugs = [ScaryBug bugs];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    /// Return the number of sections as 1
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    /// Returing the number of rows based on the the count of items in the bugs array
    return [self.bugs count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /// Change the reusableCellWithIdentifier to match the Indetifier that the prototype cell was named in the Storyboard
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    /// Create Instance of ScaryBug Class and set it to the current ScaryBug object at the current indexPath's row
    ScaryBug *currentBug = [self.bugs objectAtIndex:indexPath.row];
    
    /// Make Cell's textLabel equal to the name of the currentBug a the current indexPath
    cell.textLabel.text = currentBug.name;
    
    /// Make Cell's detailLabel equal to the howScaryString of the currentBug at the current indexPath
    cell.detailTextLabel.text = currentBug.howScaryString;
    
    /// Set the Cell's imageView to equal the image of the currentBug at current indexPath
    cell.imageView.image = currentBug.image;
    
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
