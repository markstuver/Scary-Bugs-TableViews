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
			• UITableView overrides the editing method and tells the tableView to go into editing 
				mode as well.

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


