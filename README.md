Scary-Bugs-TableViews
=====================

Table View Challenges from Ray Wenderlich Video Tutorials

    - The following are my notes based on the video instructions. Each Challenge Commit will have detailed notes commented throughout the code explaining what I have done for each challenge.

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

Challenge #5 - Move Rows


2 Ways to rearrange cells in a TableView

	• Via Built-in UI - (Apple Method)
		* Tap Edit button and three line icon appear to right of cell that can be tapped and dragged around.

			Can get built-in UI with edit button
				Just implement two methods:

					• tableView:canMoveRowAtIndexPath:
						* allows us to decide which rows will have the 3 line icon and can be moved (wont want 'add new' row to be movable)

					• tableView:moveRowAtIndexPath:toIndexPath:
						* Called when a row is moved, it tells the tableView where the row is being moved to so that the tableView can move row currently at the destination.

	• Via Long Press - (Non Built-in way)
		• Without entering Edit mode, user does a long press on a row and then it becomes active and can be moved around.

			Upon long press of row:
		
				* Take snapshot of the row - the current state of the row
				* White out cell - so it looks blank and doesn't distract the user
				* Make new view baed on the snapshot
			
			Upon finger move:
			
				* Move old cell -> cell underneath finger
					• rearranging and moving cells as the old cell is being moved in the tableView
				
			Upon finger lift:

				* Restore old cell - remove white out
				* Remove snapshot view

	**Gesture Recognizer Quick Start
		A recognizer can look for different gestures: a tap, double tap, swipe, pan, rotation, a pinch... etc. They all work in similar ways.

		* Create and add to view (with callback)
				• Based on the type of gesture you are looking for. Initialize with a target and selector. In other words a Class and a Method to call back when the gesture is detected.
			UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] 
				initWithTarget: self action: @selector(longPressGestureRecognized:)];

				• Then call the addGestureRecognizer method on the view that you want to watch for the gestures, passing the GestureRecognizer into the method.
			[self.tableView addGestureRecognizer:longPress];

		* Get the current location of the touch in the view
				• The gesture recognizer calls the locationInView: method and passes its view as a parameter. This will give the location inside the view where the tap is.
			CGPoint location = [longPress locationInView: self.tableView];
			NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];

		* Different states: Began, Changed, Cancelled, Done


Implementing Moving Rows:

1. Via Built-in UI

	1. Call method: tableView:canMoveRowAtIndexPath: to tell the TableView which rows can move.
		ie: tableView:canMoveRowAtIndexPath: {

			• Create instance of DataSets and set to the current section
			DataSet *dataSet = self.dataSets[indexPath.section];

			• If Statement - if the row is greater or equal to the count of icons in the array and the tableView is in editing mode...
			if (indexPath.row >= dataSet.icons.count && [self isEditing]) {

			• ... return NO so that that row will not be movable
			  return NO; }

			• else - return yes - let the row move
			else { return YES; }}

	2. Call method: tableView:moveRowAtIndexPath:toIndexPath: to tell TableView where the row is going.
		
		ie: tableView:moveRowAtIndexPath:toIndexPath: {

			• Create instance of DataSet and set to the dataSet at the source row (row that will be moved)
			DataSet *sourceSet = self.dataSets[sourceIndexPath.section];

			• Create instance of DataSet and set to the dataSet at the destination row (row that the cell is being moved to).
			DataSet *destSet = self.dataSets[destinationIndexPath.section];

			•Create instance of Data and set to the data at the source row
			Data *dataToMove = sourceSet.data[sourceIndexPath.row];

			• Check to see if the source dataSet equals the destination dataSet
			if (sourceSet == destSet) {
			
				• If the source and destination dataSets are the same, we will just be moving the data around in the same array using a mutableArray method.
				[destSet.icons exchangeObjectAtIndex: destinationIndexPath.row withObjectAtIndex: sourceIndexPath.row]; }

			•else - they are not the same we will be moving the data from one array to another array.
			else {

				• Add data to the destinationSet array
				 [destSet.icons insertObject:dataToMove atIndex: destinationIndexPath.row];
				
				• Remove the data from the sourceSet array
				[sourceSet.icons removeObjectAtIndex:sourceIndexPath.row];
				}
		
	3. To keep a row from being moved to the bottom row of the section, override using tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath: - this is called before the row is moved to check and make sure that the proposed indexPath row that the data is being moved is allowed to move there.

		ie: -targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath: {

			• Create instance of DataSet and set to the proposed destination IndexPath.section
			DataSet *set = self.dataSets[proposedDestinationIndexPath.section]};

			• if proposed row is greater or equal to the count of the data array, then we know that the user is trying to put the data in row that it can not go.
			if (proposedDestinationIndexPath.row >= data.icons.count {

				• Instead of letting the user put the row where it is not allowed, return the row right before it
				return [NSIndexPath indexPathForRow:set.icons.count-1 inSection:proposedDestinationIndexPath.section]; }

			• else - allow row to go to the propose destination
			else { return proposedDestionationIndexPath;}}
			

	
2. Via Long Press -  Code

	1. In viewDidLoad:

		* Add the longPress gesture recognizer.
				UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] 
				initWithTarget: self action: @selector(longPressGestureRecognized:)];

		* Call the addGestureRecognizer method on the tableView.
			[self.tableView addGestureRecognizer:longPress];

	2. Implement the method that was passed into the gesture recognizer.
		-(IBAction) longPressGestureRecognized: (UILongGestureRecognizer *)longPress {

				• Get the indexPath from the current location of the gesture 
					CGPoint location = [longPress locationInView: self.tableView];
					NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];

				• Get current state of the gesture recognizer
					UIGestureRecognizerState state = longpress.state;

				• Create 2 static variables - static means almost global variables. Will stick around across times when the method is called.

					1) One will be used to keep track of the snap shot.
						static UIView *snapshot = nil;
			
					2) One will be keep track of the indexPath we are moving (source)
						static NSIndexPath *sourceIndexPath = nil;

				• Use Switch Function to switch on the gesture recognizer
						switch (state) {
						
						• if (state) is ....StateBegan...
							case UIGestureRecognizerStateBegan: {
						
							• check to make sure we have an indexPath at all (it is possible that the 
								user did a longPress somewhere in the tableView but not on a row)	
							if (indexPath) {
			
								• set sourceIndexPath variable to the current indexPath
									sourceIndexPath = indexPath;

								• Look up cell that we are going to use
									UITableViewCell *cell = [self.tableView 
										cellForRowAtIndexPath:indexPath];
							
								**SEE STEP 3 BELOW FOR SETTING UP HELPER METHOD					
		
								• Set snapshot variable equal to the view that is returned when calling the helper method. (we are passing in the current cell to the helper method to be customized and have a snapshot view created)
									snapshot = [self customSnapshotFromView:cell];


								• Create a block variable to be used in the animation method.
									_block CGPoint center = cell.center;
			
								• Set snapshot properties to prepare for animating as it added as a subview.
									• set the snapshot center equal to the current cell's center
										snapshot.center = cell.center;

									• set the opacity of the snapshot to 0 so we can fade it into the subview.
										snapshot.alpha = 0;

								• Add as a subview of the tableView
									[self.tableView addSubview:snapshot];

								• Fade in the new snapshot while fading out the cell using animation
									[UIView animateWithDuration:0.25 animations:^{

									
									*Setting parameters that will be used when animating
									• set block variable's y location equal to location of the user's touch								
										center.y = location.y;

									• set snapshot's center equal to the block variable's center
										snapshot.center = center;

									• apply a scale transformation to the snapshot making it lightly bigger when it is moved by the user.
										snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05);

									• set snapshot's alpha to almost 100% opaque.
										snapshot.alpha = 0.98;

									* while snapshot is animating, the old cell will be whited out.
										
										• Change background to white
											[cell.backgroundColor = [UIColor whiteColor];
			
										• Change textLabel, detailTextLabel and imageView's opacity to 0.
											cell.textLabel.alpha = 0;
											cell.detailTextLabel.alpha = 0;
											cell.imageView.alpha = 0;
								}
				}
				break;
				
					• if (state) is ....StateChanged...
						case UIGestureRecognizerStateChanged: {

						• Store the old center, 
							CGPoint center = snapshot.center;

						• update the y to current touch position
							center.y = location.y	
							
						• set the center to the current center position	
							snapshot.center = center;

				Juggle the rows around, rearrange rows when the selected row is moved.
						• Create instance of DataSet and set it to the indexPath.section using the objectAtIndex: method on the dataSets array.
							DataSet *destSet = [self.dataSets objectAtIndex:indexPath.section];

						• Check if indexPath is valid and that make sure it is not equal to the source and that the user is not trying to move below the row at the bottom that it is not allowed to move to.
							if(indexPath && ![indexPath isEqual:sourceIndexPath] && indexPath.row < destSet.icons.count) {


						• Create instance of DataSet and set to the dataSet at the source row (row that will be moved)
			DataSet *sourceSet = self.dataSets[sourceIndexPath.section];

			• Create instance of DataSet and set to the dataSet at the destination row (row that the cell is being moved to).
			DataSet *destSet = self.dataSets[indexPath.section];

			•Create instance of Data and set to the data at the source row
			Data *dataToMove = sourceSet.data[sourceIndexPath.row];

			• Check to see if the source dataSet equals the destination dataSet
			if {sourceSet == destSet) {
			
				• If the source and destination dataSets are the same, we will just be moving the data around in the same array using a mutableArray method.
				[destSet.icons exchangeObjectAtIndex: indexPath.row withObjectAtIndex: sourceIndexPath.row]; }

			•else - they are not the same we will be moving the data from one array to another array.
			else {

				• Add data to the destinationSet array
				 [destSet.icons insertObject:dataToMove atIndex: indexPath.row];
				
				• Remove the data from the sourceSet array
				[sourceSet.icons removeObjectAtIndex:sourceIndexPath.row];
				}

			• Tell TableView that something has been moved
				[self.tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:indexPath];

			• update the source indexPath to the indexPath
				sourceIndexPath = indexPath;
				} 
			break;
			default: {

			• Create instance of UITableViewCell and set to the source IndexPath
			UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:sourceIndexPath];
			[UIView animateWithDuration:0.35 animation:^{

			• Get rid of snapshot and move it out of the way - with animation
				• center snapshot to the center of the cell
					snapshot.center = cell.center;

				• scale the snapshot back to normal size
					snapshot.transform = CGAffineTransformMakeScale(1.0, 10);

				• fade the opacity of the snapshot to 0
					snapshot.alpha = 0.0;

			• Restore original cell's content
				• background color
					cell.backgroundColor = [UIColor whiteColor];

				• set opacity of the text label, detail label and imageView to 1
					cell.textLabel.alpha = 1;
					cell.detailTextLabel.alpha = 1;
					cell.imageView.alpha = 1;


			}	
				• Call animation with duration's completion method to remove the snapshot from the view.
				 	completion:^(BOOL finished) {
					[snapshot removeFromSuperview];
					snapshot = nil;	
				
				];
				
				• Set the source indexPath to nil
				sourceIndexPath = nil;
		}

		break;
}
}

	3. Create Helper Method for taking snapshot of the selected row
		-(UIView *)customSnapshotFromView:(UIView *)inputView  {
			
			• Call new apple method that will take snapshot view after screen updates
				UIView *snapshot = [inputView snapshotViewAfterScreenUpdate:YES];

			• Configure UIView using it's CALayer  (CALayer has several handy properties)

			• Do not what to clip to the layer bounds
				snapshot.layer.masksToBounds = NO;
			• Set corner radius of view to 0.0 (no radius)
				snapshot.layer.cornerRadius = 0.0;

			• Set shadow offset - this will make the cell look a little different as while the user is longPressing and moving the row. (-5.0 on x axis and 0 on y axis)
				snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0);

			• Set shadow radius - this will add to the shadow effect.
				snapshot.layer.shadowRadius = 5.0;
				
			• Set shadow Opacity - this will also add to the shadow effect.
				snapshot.layer.shadowOpacity = 0.4;

				return snapshot;
				}
