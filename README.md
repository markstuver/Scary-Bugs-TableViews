Scary-Bugs-TableViews
=====================

Table View Challenges from Ray Wenderlich Video Tutorials

Challenge #1: Make a simple table view app that lists the bugs. Images and Model Class are provided.

        1. Create new project

        2. Delete provided VC and create a new subclass of UITableViewController called MASBugsTableViewController

        3. In Storyboard:
            1. Delete  VC
            2. Create a new TableVC
            3. Set Custom Class to UITableVC subclass
            4. Select Prototype Cell and named the Identifier as 'Cell'
            5. Embedded TableViewController into NavigationController

        4. In MASBugsTableViewController:
            1. Create NSArray Property
            2. In ViewDidLoad - Load array with the mutableArray return value of ScaryBug class method 'bugs'
            3. In numberOfRowsInSection method - 
                Set # of rows in section to the count of items on the Array
            4. In cellForRowAtIndexPath method:
                1. Enter reusableCell Identifier
                    that was entered in Storyboard.
                2. Create instance of ScaryBug method and set to the bug item in the array at the current IndexPath.row
                3. Set Cell's textLabel, detailTextLabel and imageView,   
                    equal to the name/howScaryString/Image at the current IndexPath

Challenge #2: Sort the bugs from Challenge #1 into sections in the app's tableView.

	1. Created New Class: BugSection
	     1. In BugSection Header file:
		1. Import ScaryBug header file
	   	2. Create 2 properties:
			1. ScareFactor property that will represent a section
			2. MutableArray property to hold the sections and their contents
	    	3. Declare an initializer method that will be called to initialize the section

	     2. In BugSection Implementation file:
		1. Create initializer method.
	
	2. In MASBugsTableViewController:
	    1. Import BugSection header file
	    2. Rename the mutableArray instance bugs to bugSections.
	    3. Add setupBugs helper method:
		1. Create Sections and added them to the bugSections array
		2. Sort bugs into section:
			1. Create instance of mutableArray called bugs and set to the bugs array in ScaryBug
			2. Iterate through each bugs:
				1. Create a BugSection instance and set it to the current bug's howScary value/section
				2. Put the bug into the array under it's section
	    4. In viewDidLoad:
		1. call the helper method setupBugs

	    5. Call method numberOfSectionsInTableView:
		1. return the count of items on the bugSections array

	    6. Call method titleForHeaderInSection:
		1. Create instance of BugSection and set it to the current section
		2. return string value that is returned from calling the scaryFactorToString method.

	    7. Change numberOfRowsInSection:
		1. Create instance of BugSection and set to the current section
		2. return count of items in the current section object in the bugSection array

	    8. Change cellForRowAtIndexPath:
		1. Create instance of BugSection and set to the current indexPath.section
		2. Edit ScaryBug instance to set it to the current row in the current section
			

		

