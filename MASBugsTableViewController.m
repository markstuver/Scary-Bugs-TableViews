//
//  MASBugsTableViewController.m
//  Scary Bugs
//
//  Created by Mark Stuver on 6/21/14.
//  Copyright (c) 2014 Halo International Corp. All rights reserved.
//

#import "MASBugsTableViewController.h"

// import the ScaryBug Class Header
#import "ScaryBug.h"

// import the BugSection class Header
#import "BugSection.h"


@interface MASBugsTableViewController ()

// Create private property NSArray to hold mutableArray of bugs from ScaryBug class

// Change private property to NSMutableArray to hold mutableArray of bugs from BugSection class
@property (nonatomic, strong) NSMutableArray *bugSections;



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
    
    // mutableArray will now be loaded in the helper method 'setupBugs'
    // Load the mutableArray with the mutableArray that is returned from calling the ScaryBug Class Method 'bugs'.
   // self.bugs  = [ScaryBug bugs];
    
    // Call helper method that will put the bugs into sections and load the sections into an Array.
    [self setupBugs];
    
    /// Add Edit button to NavBar for Deleting. This is for users who don't know to swipe and delete
    self.navigationItem.rightBarButtonItem = self.editButtonItem;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper Method

// Helper Method that will create an array with 5 array objects inside it. Each array object will have a specific section name and will hold the bugs that have that section name. One by one, each bugs will have there section set to the value of their howScary property and then they will be put into the bugSection array, inside the array object that matches the value of the bug's section.

-(void)setupBugs {
    
    // Create Sections
    self.bugSections = [NSMutableArray arrayWithCapacity:5];
    
    [self.bugSections addObject:[[BugSection alloc] initWithHowScary:ScaryFactorNotScary]];
    [self.bugSections addObject:[[BugSection alloc] initWithHowScary:ScaryFactorQuiteScary]];
    [self.bugSections addObject:[[BugSection alloc] initWithHowScary:ScaryFactorAverageScary]];
    [self.bugSections addObject:[[BugSection alloc] initWithHowScary:ScaryFactorALittleScary]];
    [self.bugSections addObject:[[BugSection alloc] initWithHowScary:ScaryFactorAiiiiieeeee]];

    
    // Sort bugs into Sections
    
    // Create instance of NSMutableArray and set to equal the mutableArray from the ScaryBug Class
    NSMutableArray *bugs = [ScaryBug bugs];
    
    // Iterate through each bug in the mutableArray
    for (ScaryBug *bug in bugs) {

        // Create a section instance for the current bug and set it to the value of the current bug's howScary property.
        BugSection *section = self.bugSections[(int) bug.howScary];
        
        // Put the bug into the bugs array based on the bug's section.
        [section.bugs addObject:bug];
    }
    
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections as 1
    
    // Return the count of objects in the bugSections
    return self.bugSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Returning the number of rows based on the the count of items in the bugs array
    
    // Create instance of BugSection and set to the current bug's section at current indexPath.section
    BugSection *bugSection = self.bugSections[section];

    // Return the count of the number of rows for the current bugSection
    return bugSection.bugs.count;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    // Create instance of BugSection and set to the current bug's section at current indexPath.section
    BugSection *bugSection = self.bugSections[section];
    
    // Call the ScaryBug method, passing the current section. Return the returned string value for the header.
    return [ScaryBug scaryFactorToString:bugSection.howScary];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Change the reusableCellWithIdentifier to match the Indetifier that the prototype cell was named in the Storyboard
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Create instance of BugSection and set to the current bug's section at current indexPath.section
    BugSection *bugSection = self.bugSections[indexPath.section];

    // Create Instance of ScaryBug Class and set it to the current ScaryBug object at the current indexPath's ro
     ScaryBug *currentBug = bugSection.bugs[indexPath.row];
    
    // Make Cell's textLabel equal to the name of the currentBug a the current indexPath
    cell.textLabel.text = currentBug.name;
    
    // Make Cell's detailLabel equal to the howScaryString of the currentBug at the current indexPath
    cell.detailTextLabel.text = currentBug.howScaryString;
    
    // Set the Cell's imageView to equal the image of the currentBug at current indexPath
    cell.imageView.image = currentBug.image;
    
    
    return cell;
}


#pragma mark - Table view delegate

/// Delegate Method for CommitingEditingStyle - Setting to delete rows
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /// Make sure we are grabing the EditingStyleDELETE
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        /// Create instance of BugSection and set to current bug section
        BugSection *section = self.bugSections[indexPath.section];
        
        /// Remove the current row from the Array
        [section.bugs removeObjectAtIndex:indexPath.row];
        
        /// Delete the current row with animation.
        [tableView deleteRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
         
    }
    
    
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
