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

/// import the BugCell for the customCell
#import "MASBugCell.h"


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
    
    // Add Edit button to NavBar for Deleting. This is for users who don't know to swipe and delete
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Turn on allowsSelectionDuringEditing so that the user can select the row to add (not just the little green plus)
    self.tableView.allowsSelectionDuringEditing = YES;
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
    [self.bugSections addObject:[[BugSection alloc] initWithHowScary:ScaryFactorALittleScary]];
    [self.bugSections addObject:[[BugSection alloc] initWithHowScary:ScaryFactorAverageScary]];
    [self.bugSections addObject:[[BugSection alloc] initWithHowScary:ScaryFactorQuiteScary]];
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


#pragma mark - Table view - data source methods


/* What is the NUMBER OF SECTIONS - TABLEVIEW ***OPTIONAL*** */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the count of objects in the bugSections
    return self.bugSections.count;
}


/* What is the TITLE FOR HEADER IN SECTION - TABLEVIEW ***OPTIONAL*** */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    // Create instance of BugSection and set to the current bug's section at current indexPath.section
    BugSection *bugSection = self.bugSections[section];
    
    // Call the ScaryBug method, passing the current section. Return the returned string value for the header.
    return [ScaryBug scaryFactorToString:bugSection.howScary];
}

/// Call Method to set the height of the current row
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /// Create instance of BugSection and set to the current indexPath section
    BugSection *bugSection = self.bugSections[indexPath.section];
    
    /// Determine what kind of prototype cell the current row is
    if (indexPath.row >= bugSection.bugs.count && [self isEditing]) {
        
        /// New Bug Row
        return 40;
        
    } else {
        
        /// exsisting Bug Row
        return 80;
    }
}


/* What is the NUMBER OF ROWS IN SECTION - TABLEVIEW  ***REQUIRED*** */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Determine if TableView is in editing mode
        // If Editing is ON add 1 .... if not add 0
    int adjustment = [self isEditing] ? 1 : 0;
    
    // Returning the number of rows based on the the count of items in the bugs array
    // Create instance of BugSection and set to the current bug's section at current indexPath.section
    BugSection *bugSection = self.bugSections[section];

    // Return the count of the number of rows for the current bugSection
        // Add value of adjustment to the row count (if Editing is on add 1... if not add 0)
    int returnAmountOfRows = bugSection.bugs.count + adjustment;
    return  returnAmountOfRows;
}

/* Configure the CELL FOR ROW AT INDEX PATH - TABLEVIEW  ***REQUIRED*** */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    /// Set UITableViewCell equal to nil
    UITableViewCell *cell = nil;
    
//    /// Create instance of BugSection class and set it to the current section of the indexPath
//    BugSection *bug = self.bugSections[indexPath.section];
    
    /// Create instance of BugSection and set to the current bug's section at current indexPath.section
    BugSection *bugSection = self.bugSections[indexPath.section];

    /// DETERMINE WHICH PROTOTYPE CELL TO USE
    /// Create if/else to determine if the current indexPath row is greater/equal to the count of bugSection
    if (indexPath.row >= bugSection.bugs.count && [self isEditing]) {
        
    // Change the reusableCellWithIdentifier to match the Indetifier that the prototype cell was named in the Storyboard
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewBugCell" forIndexPath:indexPath];
   
//    // Check to see if indexPath.row is greater or equal to the count of the bugSection.bugs and is the TableView in editing mode
//    if (indexPath.row >= bugSection.bugs.count && [self isEditing]) {
        // if valid... Setup new cell
        cell.textLabel.text = @"Add Bug";
        cell.detailTextLabel.text = nil;
        cell.imageView.image = nil;
        
        return cell;
        
    } else {
        
        /// Make sure that the cellIdentifier is what we want
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BugCell" forIndexPath:indexPath];
        
        /// Create instance of MASBugCell and cast it as a MASBugCell
        MASBugCell *bugCell = (MASBugCell *)cell;
        
        /// Create Instance of ScaryBug Class and set it to the current ScaryBug object at the current indexPath's row
        ScaryBug *currentBug = bugSection.bugs[indexPath.row];
        
        /// Create Instance of NSString and set it equal to the howScaryString of the current row
        NSString *howScaryIsIt = currentBug.howScaryString;

        /// Set Label and Image of current bug.
        bugCell.bugLabel.text = currentBug.name;
        bugCell.bugImage.image = currentBug.image;

        /// If the currentBug's ScareFactor is equal to Aiiiieeeee or QuiteScary...
        if ([howScaryIsIt isEqualToString: [ScaryBug scaryFactorToString:ScaryFactorAiiiiieeeee]] || [howScaryIsIt isEqualToString: [ScaryBug scaryFactorToString:ScaryFactorQuiteScary]]) {
    
            /// ... Use this image
            bugCell.favoriteBug.image = [UIImage imageNamed:@"shockedface2_full.png"];
            
        } else {
            /// else... use this image
            bugCell.favoriteBug.image = [UIImage imageNamed:@"shockedface2_empty"];
        }
    return cell;
    }
}


#pragma mark - Table view - delegate methods

/* For COMMIT EDITING STYLE FOR ROW - TABLEVIEW - ***REQUIRED FOR EDITING MODE*** **/
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
// DELETING ROWS
    // Make sure we are grabbing the EditingStyleDELETE
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Create instance of BugSection and set to current bug section
        BugSection *section = self.bugSections[indexPath.section];
        
        // Remove the current row from the Array
        [section.bugs removeObjectAtIndex:indexPath.row];
        
        // Delete the current row with animation.
        [tableView deleteRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
// INSERTING ROWS
    // Make sure we are grabbing the EditingStyleINSERT
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
        // Create instance of BugSection and set to the current section
        BugSection *section = self.bugSections[indexPath.section];
        
        // Create instance of the bug and use the class initializer
            // for howScary: set to match the current sections scare factor
        ScaryBug *newBug = [[ScaryBug alloc] initWithName:@"New Data" image:nil howScary:section.howScary];
        
        // Add new row object to the array
        [section.bugs addObject:newBug];
        
        // Animate the row and insert
        [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


/* Tell TableView SET EDITING: ANIMATED: - TABLEVIEW - **Tells TableView what you want to change**  */

-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    // Call super class to overide
    [super setEditing:editing animated:animated];
    
    // If entering Editing mode - add placeholder "add new" row
    if (editing) {
        
        // When adding or removing a bunch of rows from tableView it is good practice to use beginUpdates/endUpdates
        [self.tableView beginUpdates];
        
        // iterate through array of sections to add a new row for every section
        for (int i = 0 ; i < _bugSections.count; ++i) {
            
        // Create instance of BugSection and set to current bugSection
           BugSection *section = _bugSections[i];
           
        // Call method on tableView to notfiy that a new row is being insterted
           [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:section.bugs.count inSection:i]] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        
        // Calling endUpdates on TableView
        [self.tableView endUpdates];
        
    // Else - when exiting editing mode - remove placeholder "add new" rows
    }else {
        
        [self.tableView beginUpdates];
        
        // iterate through array of sections to remove the "add new" row in every section
        for (int i=0; i <_bugSections.count; ++i) {
            
            // Create instance of BugSection and set to current bugSection
            BugSection *section = _bugSections[i];
            
            // Call method on tableView to notfiy that a the "add new" row is being deleted
            [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:section.bugs.count inSection:i]] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        
        // Calling endUpdates on TableView
        [self.tableView endUpdates];
    }
}


/* Set EDITING STYLE FOR ROW AT INDEXPATH - TableView **To show a green plus in row for user to add row** */
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Create instance of BugSection and set to current bugSection
    BugSection *section = self.bugSections[indexPath.section];
    
    //If Row is greater or equal to the count of the bugSections array
    if (indexPath.row >= section.bugs.count) {
        // Show style/plus icon for inserting row
        return UITableViewCellEditingStyleInsert;
    } else {
        // else - show style/negative icon for deleting row
        return UITableViewCellEditingStyleDelete;
    }
}


/* Call - WILL SELECT ROW AT INDEXPATH - TableView ** To make sure that only the "add row" is able to be selected.
                                    If any other cell is selected, a nil will be returned not letting the user select the row. */
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Create instance of BugSection and set to current section
    BugSection *section = self.bugSections[indexPath.section];
    
    // if Editing is on and current row is less then the count of rows in section... return nil
    if ([self isEditing] && indexPath.row < section.bugs.count) {
        
        return  nil;
    
    // else... return indexPath
    } else {
        return indexPath;
    }
}

/* Call - DID SELECT ROW AT INDEXPATH - TableView ** Is called when row was tapped. Here we are telling the tableView
                                        to insert a new row when the "add new" row is tapped. */

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Remove the highlight row feature
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Create instance of BugSection and set to current section
    BugSection *section = self.bugSections[indexPath.section];
    
    // if editing is on and indexPath.row is greater or equal to the count of rows in section...
    if (indexPath.row >= section.bugs.count && [self isEditing]) {
        
        // ... call commitEditingStyle and set to ... editingStyleInsert
        [self tableView: tableView commitEditingStyle:UITableViewCellEditingStyleInsert forRowAtIndexPath:indexPath];
    }
}

/* CAN MOVE ROW AT INDEX PATH - To tell the tableView which rows can/cannot move. */
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Create instance of BugSections and set to current section
    BugSection *bugSection = self.bugSections[indexPath.section];
    
        // if the row is greater or equal to the count of bugs in the array and the tableView is in editing mode...
    if (indexPath.row >= bugSection.bugs.count && [self isEditing]) {
        // return No so that row is not movable
        return NO;
    }
        // else return YES
    return YES;
}

/* MOVE ROW AT INDEX PATH - To tell the tableView where the row is going **/
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    //Create instance of BugSection and set the bugSection to the source row
    BugSection *sourceSection = self.bugSections[sourceIndexPath.section];
    
    //Create instance of BugSection and set to the bugSection at the destination row
    BugSection *destSection = self.bugSections[destinationIndexPath.section];
    
    //Create instance of SacryBug and set to the bug at the source row
    ScaryBug *bugToMove = sourceSection.bugs[sourceIndexPath.row];
    
    //Check to see if the source bugSection equals the destination bugSection
    if (sourceSection == destSection) {
        
        //If equal... will just be moving the bug around in the same array using mutableArray method
        [destSection.bugs exchangeObjectAtIndex:destinationIndexPath.row withObjectAtIndex:sourceIndexPath.row];
    }
    
    // else... they are not the same so the bug will be moved from one array to another array
    else {
        //Add bug to the destinationSection array
        [destSection.bugs insertObject:bugToMove atIndex:destinationIndexPath.row];
        
        //Remove the bug from the sourceSection
        [sourceSection.bugs removeObjectAtIndex:sourceIndexPath.row];
    }
}

/* TARGET INDEXPATH FROM ROW AT INDEXPATH TO PROPOSEDINDEXPATH - This will keep the user from moving a row to the bottom row of the section.**/
-(NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    
    //Create instance of BugSection and set to the proposed destination
    BugSection *section = self.bugSections[proposedDestinationIndexPath.section];
    
    //If proposed row is greater or equal to the count of the bugs array...
    if (proposedDestinationIndexPath.row >= section.bugs.count) {
        
        //...instead of letting the user put the row where it is not allowed, return the row right before it.
        return [NSIndexPath indexPathForRow:section.bugs.count-1 inSection:proposedDestinationIndexPath.section];
    }
    
    //else... allow row to go to the proposed destination
    else {
        return proposedDestinationIndexPath;
    }
}


#pragma mark - Navigation

/* Set SHOULD PREFORM SEQUE WITH IDENTIFIER - ** override method so that the segue does not take control when "add new" row is tapped **/

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    // Check to make sure we have the correct segue
    // if the segue identifier is correct and the tableView is in Editing mode...
    if ([identifier isEqualToString:@"ToDetail"] && [self isEditing]) {
        // ... Return No - dont segue to the detail view
        return NO;
    } else {
        return YES;
    }
}



/* // In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
