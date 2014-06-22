Scary-Bugs-TableViews
=====================

Table View Challenges from Ray Wenderlich Video Tutorials

Challenge #1: Make a simple table view app that lists the bugs. Images and Model Class are provided.

        1. Created new project

        2. Deleted provided VC and created a new subclass of UITableViewController called MASBugsTableViewController

        3. In Storyboard:
            1. Deleted VC
            2. Created a new TableVC
            3. Set Custom Class to UITableVC subclass
            4. Selected Prototype Cell and named the Identifier as 'Cell'
            5. Embedded TableViewContrller into NavigationController

        4. In MASBugsTableViewController:
            1. Create NSArray Property
            2. In ViewDidLoad - Load array with the mutableArray return value of ScaryBug class method 'bugs'
            3. In numberOfRowsInSecton method - 
                Set # of rows in section to the count of items on the Array
            4. In cellForRowAtIndexPath method:
                1. Enter reusableCell Identifier
                    that was entered in Storyboard.
                2. Create instance of ScaryBug method and set to the bug item in the array at the current IndexPath.row
                3. Set Cell's textLabel, detailTextLabel and imageView,   
                    equal to the name/howScaryString/Image at the current IndexPath

