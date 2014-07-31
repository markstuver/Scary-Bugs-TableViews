Scary-Bugs-TableViews
=====================

Table View Challenges from Ray Wenderlich Video Tutorials

Challenge #1: Make a simple table view app that lists the bugs. Images and Model Class are provided.

        When creating a TableView, you must implement 2 Protocols
        
            1. UITableViewDataSource: (What's your data?)
                - Number of sections
                - Number of rows per section
                - tableView cell for a row

            2. UITableViewDelegate: (events & customization)
                - Row got tapped
                - Variable height support
                - Custom header/footer support
                
        * Most important method:
                tableView:cellForRowAtIndexPath: {
                // Create the cell (based on prototype)
                // Populate cell's subview with your data
                return cell;
                }

        ** When accessing an item from an Array based on the current cell, use the following:

            ClassName *DataAtCurrentCell = [self.localArrayName objectAtIndex: indexPath.row];


Challenge #2: Sort the bugs from Challenge #1 into sections in the app's tableView.


        How to group your data into Sections. (can also create footers and custom views)

        Implement 2 new delegate methods:

            1. numberOfSectionsInTableView:
            2. tableView:titleForHeaderInSection:


        TableView Styles
            There are two tableView Section styles to choose from:

            1. plain: As a tableView is scrolled through, the header stays visible on the screen until the last row of that section moves off screen. Then the header moves off screen.

            2. grouped: When the header does not stay on the screen, as the user scrolls through. The header is at the top of the rows in the section and as the tableView is scrolled, the header moves off screen.

        * The tableView Section style is set in the Storyboard with the TableViewController selected.

        How to implement TableView Sections:

            Instead of creating an Array of specificData, create an Array of specificDataSets.

            1. Create a new class for organizing the specificData into sections.
                • Create property representing how the data will be put into sections. ie: @property (assign) DataSet dataDetail

                • Create property representing the mutableArray of specificData.

                • Declare a simple initializer for organizing the specific data.
                    ie: -(instancetype)initWithDataDetail:(DataSet)dataDetail.

            2. Implement the new initializer in the .m file
                    ie: if ((self = [super init]));
                        _dataDetail = dataDetail;
                        _specificData = [NSMutableArray array];
                            }
                        return self;
                        }

        Implement the two methods that are need:

            1. numberOfSectionsInTableView:
                • return the number of sets/groups by calling the 'count' method on the Array of specificDataSets.

            2. tableView:titleForHeaderInSection:
                • create an instance of the dataSet and make the instance equal to the section of the current dataSets. ie: DataSet *set = self.dataSets[section];

                • the return the name of the set. ie: return set.name;

        Adjust the code in numberOfRowsInSection: method
            1. create an instance of the dataSet and make the instance equal to the section of the current dataSets. ie: DataSet *set = self.dataSets[section];

            2. change the return statement to return the rows in the current section. ie: return set.dataSet.count;

        Adjust the code in cellForRowAtIndexPath:

            1. create an instance of the dataSet and make the instance equal to the section of the current dataSets. ie: DataSet *set = self.dataSets[indexPath.section];


Challenge #3: Add ability to delete rows in the app's tableView
		
        Ways to Delete Rows

            1. Swipe left to reveal delete button

            Must implement -
                tableView:commitEditingStyle:forRowAtIndexPath:
                    • Delete the row from the model
                    • Tell tableView that the model has changes (row was deleted)
                    
                2 ways to update the tableView:
                    • Call tableView Reload (not best way, will reset all the loads)
                    • Call method deleteRowAtIndexPath (best way, animates deletion of row that is being swiped)

            2. Edit Button that shows delete option (for users not familiar to swiping to delete)
	
            There is a special built-in item to put on the nav bar:
                self.editButtonItem
                    • button calls setEditing:animated: on the viewController
                        *turns itself into editing mode
                    • UITableView overrides the editing method and tells the tableView to go into editing mode as well.


        How to implement TableView Deleting Row:

            1. Implement the commitEditingStyle:forRowAtIndexPath:
                • Check editing style:
                    if (editingStyle == UITableViewCellEditingStyleDelete) {

                // Create instance of dataSet and set to the current dataSet(Section)
                    DataSet *set = self.dataSets[indexPath.section];

                // Remove the current row object from the data array
                    [set.dataSets removeObjectAtIndex:indexPath.row];

                // bad way to reload table
                    [self.tableView reload.tableView];

                // Better way that will animate the row and delete
                    [tableView deleteRowsAtIndexPath:@[indexPath]
                    withRowAnimation:UITableViewRowAnimationAutomatic];
                    }

            2. Add Edit button to Nav Bar:
                • In viewDidLoad:
                // Add button to navigationBar (navigationController takes care of the rest)
                    self.navigationItem.rightBarButtonItem = self.editButtonItem;
                    
                    
Challenge #4: Insert Rows - Adding a new row at the end of each section


        Implement the following 4 methods:
            • tableView:numberOfRowsInSection: (Update the number of rows)
            • tableView:cellForRowAtIndexPath: (Update the current cell)
            • setEditing:animated: (Override this method to notify the tableView that more rows are being added)
            • tableView:editingStyleForRowAtIndexPath: (optional that will show a icon that will correspond with the editingStyle that is being used. ie: green plus for add  or red dash for delete)

        Handle "insert row" event

            Implement the following:
                • tableView:commitEditingStyle:forRowAtIndexPath: (handles the touch event when an edit button us touched. ie: when the green plus is pressed)
                • and/or tableView:didSelectRowAtIndexPath: (detects when the tableCell has been touched)


        Alternative Methods

            How to add new item?

                1. Row only visible in edit mode (Current)
                2. Button in upper right (Instead of Edit, a plus)
                3. Permanent row (an "Add Row" row that is always shown at the bottom of the table)
                4. Gestures (Use a special gesture to add a new row)

            What happens upon new item?

                1. Create placeholder item (current)
                2. Immediately edit a new item (in a new viewController)


    How to implement TableView Adding Rows

            1. In numberOfRowsInSection:
                * Add an int and determine if tableView is in editing mode
                    • if it is: add a row
                    • if it is not: do not add a row
                        ie: int adjustment = [self isEditing] ? 1 : 0;

                * Adjust the return statement by adding the int to the count
                        ie: return set.icon.count + adjustment;


            2. In cellForRowAtIndexPath:
                * Add if condition to check:
                    • if the indexPath.row is greater or equal to the count of the set.icons array.
                    • and if the tableView is in editing mode
                        ie: if (indexPath.row >= set.icons.count && [self isEditing])

                * If the condition is valid:
                    • Setup the new cell
                        ie: cell.textLabel.text = @"Add Icon";
                            cell.detailTextLabel = nil;
                            cell.imageView.image = nil;
		
                * else:
                    • The normal code for creating a cell.


            3. Override setEditing:animated:

                * Call the super class (because the tableView will override with this method and to set the tableView's editing mode correctly)
                        ie: [super setEditing:editing animated:animated];

                * If in editing mode - (when entering edit, add placeholder "add new" rows)
                    • Call beginUpdates method on the tableView (when adding or removing a bunch of rows from the tableView, its good practice to use the beginUpdates endUpdates methods)
                        ie: [self.tableView beginUpdates];

                    • Create a new row for every section by loop through all sections using for statemen						
                        ie: for (int i = 0; i < _iconSets.count; ++i) {
                            IconSet *set = _iconSets[i];

                    • Call method on the tableView to notify that we are inserting a new row
                        ie: self.tableView insertRowsAtIndexPaths:withRowAnimation:

                    • Call the endUpdates method on the tableView.
                        ie: [self.tableView endUpdates];

                * else exit editing mode - (remove placeholder "add new" rows when exiting edit)
                    • Same as "if in edit mode" but: replace insertRowsAtIndexPaths with deleteRowsAtIndexPaths

            4. Implement tableView:editingStyleForRowAtIndexPath: for adding add icon to row

                * Using if/else statement
                    • if, the indexPath.row is greater than or equal to the count of the set.icon array
                        return UITableViewCellEditingStyleInsert

                    • else (if not), return UITableViewCellEditingStyleDelete


            5. In the commitEditingStyle:forRowAtIndexPath:

                * In order for the new row to be added when the user touches it, we must add code to the commitEditingStyle:forRowAtIndexPath:

                    • Check editing style:
                        ie: if (editingStyle == UITableViewCellEditingStyleInsert) {
                    • Create instance of dataSet and set to the current dataSet(Section)
                        ie: DataSet *set = self.dataSets[indexPath.section];

                    • Create instance of the data and use the class initializer
                        ie: Data *newData = [[Data alloc] initWithTitle:@"New Data" subtitle:@"" imageName:nil];

                    • Add new row object to the data array
                        ie: [set.dataSets addObject:newData];

                    • Animate the row and insert
                        ie: [tableView insertRowsAtIndexPaths:@[indexPath]
                            withRowAnimation:UITableViewRowAnimationAutomatic];
                        }

            6. In ViewDidLoad:
                * Turn allowsSelectionDuringEditing on so that the user can select the row to add not just the little icon.
                    ie: self.tableView.allowsSelectionDuringEditing = YES;

            7. Insert method, willSelectRowAtIndexPath:
                * To make sure that only the "add new" row is able to be selected. If any other cell is selected, a nil will be returned that will not let the user select the row.

                    • Create instance of DataSets
                        ie: DataSet *set = self.dataSets[indexPath.section];

                    • Create if statement ...
                        if the isEditing is on and the indexPath.row is less then the count of rows in the section...
                            return nil.
				
                    • else... return the indexPath.
                        ie: if {[self isEditing] && indexPath.row < set.icons.count) {
                            return nil;
						}else { return indexPath;
                            }
                        }

            8. Insert method, shouldPerformSegueWithIndentifier:
                * A way to make the segue not take control with the "add new" row is tapped.
			
                    • Check the identifier (the identifier that is assigned to the segue in the storyboard)
                    • If the identifier isEqualToString:@"GoToDetail && we are in editing mode...
                        return No; so that the segue is not called
                    • If it doesn't, then return YES.

                        ie: if([identifier isEqualToString:@"GoToDetail"] && [self isEditing]) {
                        return NO; }
                            return YES; }

            9. Insert method, didSelectRowAtIndexPath:
                * Method is called when a row is tapped. We can now tell the tableView to insert the new row when the "add new" row is tapped.

                    • Remove the highlight feature when the row is tapped.
                        ie: [self.tableView deselectRowAtIndexPath:indexPath animated:YES]

                    • Create instance of the DataSet and set to the current set
                        ie: DataSet *set = self.dataSets[indexPath.section];

                    • Create an if statement... if editing is on and the indexPath.row is greater or equal to the count of the rows in section, commitEditingStyle: ...EditingStyleInsert.

                        ie: if (indexPath.row >= set.icons.count && [self isEditing]) {
                                [self tableView:tableView commitEditingStyle: UITableViewCellEditingStyleInsert
                                    forRowAtIndexPath: indexPath];
                            }



