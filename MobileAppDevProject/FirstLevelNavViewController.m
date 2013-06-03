//
//  FirstLevelNavViewController.m
//  MobileAppDevProject
//
//  Created by Nicholas Pantola on 5/28/13.
//  Copyright (c) 2013 Pantola. All rights reserved.
//

#import "FirstLevelNavViewController.h"
#import "TaskDetailViewController.h"

@interface FirstLevelNavViewController ()

@property (strong, nonatomic) TaskDetailViewController *childController;

@end

@implementation FirstLevelNavViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Test", @"Test");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    int x = 0;
    
    self.title = @"All Tasks";
    
    
    /*
    while (x < 4) {
        
        TaskDetailViewController *taskDetail = [[TaskDetailViewController alloc] initWithNibName:@"TaskDetailViewController" bundle:nil];
        taskDetail.title = [NSString stringWithFormat:@"Task number %d", x];
    
        x++;

        [tempArray addObject:taskDetail];
     
    }
        self.theControllers = tempArray;
     */

    //load database
    NSString *docsDir;
    NSArray *dirPaths;
    
    const char *dbPath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:@"tasks.db"]];
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    if ([fileMgr fileExistsAtPath: databasePath] == YES){
        const char *dbPath = [databasePath UTF8String];
        
        if (sqlite3_open(dbPath, &contactDB) == SQLITE_OK){
            
            NSString *querySQL = [NSString stringWithFormat: @"SELECT name FROM tasks"];
            const char *query_stmt = [querySQL UTF8String];
            
            if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK){
                NSMutableArray *tempArray = [NSMutableArray array];
                
                while (sqlite3_step(statement) == SQLITE_ROW){
                    NSString *name = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                    
                    TaskDetailViewController *taskDetail = [[TaskDetailViewController alloc] initWithNibName:@"TaskDetailViewController" bundle:nil];
                    taskDetail.title = [NSString stringWithFormat:@"%@", name];
                    
                    x++;
                    
                    [tempArray addObject:taskDetail];
                }
                self.theControllers = tempArray;
                sqlite3_finalize(statement);
            
            } else {
                NSLog(@"Error preparing statement");
            }
            sqlite3_close(contactDB);
            
        } else {
            NSLog(@"Error Statement: %s", sqlite3_errmsg(contactDB));
        }
        //NSLog(@"Error Statement: %s", sqlite3_errmsg(contactDB));
        
    }
    
    
    [super viewDidLoad];
    [super viewDidAppear:YES];
    //}
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.theControllers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];//forIndexPath:indexPath];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    
    NSUInteger row = [indexPath row];
        
    TaskDetailViewController *controller = [self.theControllers objectAtIndex:row];
    controller.theLabel = [NSString stringWithFormat:@"You pressed %@", [[self.theControllers objectAtIndex:row] title]];
    controller.message = [NSString stringWithFormat:@"You pressed %@", [[self.theControllers objectAtIndex:row] title]];
    
    cell.textLabel.text = controller.title;
    //cell.imageView.image = controller.rowImage;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
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
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];

    TaskDetailViewController *controller = [self.theControllers objectAtIndex:row];
    [self.navigationController pushViewController:controller animated:YES];
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath: (NSIndexPath *)indexPath
{
    if (_childController == nil) {
        _childController = [[TaskDetailViewController alloc] initWithNibName:@"TaskDetailViewController" bundle:nil];
    }
    _childController.title = @"Task Button Pressed";
    NSUInteger row = [indexPath row];
    NSString *selected = [_theControllers objectAtIndex:row];
    NSString *detailMessage = [[NSString alloc]initWithFormat:@"You pressed...%@", selected];
    _childController.message = detailMessage;
    _childController.title = selected;
    [self.navigationController pushViewController:_childController animated:YES];
}

@end
