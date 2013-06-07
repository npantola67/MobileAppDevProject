//
//  MyTasksNavViewController.m
//  MobileAppDevProject
//
//  Created by Nicholas Pantola on 6/5/13.
//  Copyright (c) 2013 Pantola. All rights reserved.
//

#import "MyTasksNavViewController.h"
#import "TaskDetailViewController.h"

@interface MyTasksNavViewController ()

@property (strong, nonatomic) TaskDetailViewController *childController;
@end

@implementation MyTasksNavViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = NSLocalizedString(@"My Tasks", @"My Tasks");
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated{
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    sqlite3_stmt *statement;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:@"TaskTaker.db"]];
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    if([fileMgr fileExistsAtPath:databasePath] == YES){
        const char *dbPath = [databasePath UTF8String];
        
        if (sqlite3_open(dbPath, &contactDB) == SQLITE_OK){
            NSString *querySQL = [NSString stringWithFormat:@"Select id, name, datedue, description FROM tasks WHERE istaken = 1"];
            const char *query_stmt = [querySQL UTF8String];
            
            if(sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK){
                NSMutableArray *tempArray = [NSMutableArray array];
                
                while (sqlite3_step(statement) == SQLITE_ROW) {
                    NSString *recID = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                    
                    NSString *name = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                    
                    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                    [dateFormat setDateFormat:@"yy-MM-dd HH:mm:ss"];
                    
                    //NSDate *dateDue = [dateFormat dateFromString:[NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 2)]];
                    
                    //NSString *dateDue = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                    NSString *dateDue = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                    
                    NSString *desc = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                    
                    TaskDetailViewController *taskDetail = [[TaskDetailViewController alloc] initWithNibName:@"TaskDetailViewController" bundle:nil];
                    
                    //set values for the task detail
                    taskDetail.title = [NSString stringWithFormat:@"%@", name];
                    taskDetail.recordID = [NSString stringWithFormat:@"%@", recID];
                    //taskDetail.theDateDue = [NSString stringWithFormat:@"%@", [dateFormat stringFromDate:dateDue]];
                    taskDetail.theDateDue = [NSString stringWithFormat:@"%@", dateDue];
                    taskDetail.description = [NSString stringWithFormat:@"%@", desc];
                                        
                    [tempArray addObject:taskDetail];
                    
                }
                self.theControllers = tempArray;
                sqlite3_finalize(statement);
                
            } else {
                NSLog(@"Error Preparing Statement");
            }
            sqlite3_close(contactDB);
            
        } else {
            NSLog(@"Error Statement: %s", sqlite3_errmsg(contactDB));
        }
        
    }

    [self.tableView reloadData];
    [super viewWillAppear:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    NSUInteger row = [indexPath row];
    
    TaskDetailViewController *controller = [self.theControllers objectAtIndex:row];
    controller.theLabel = [NSString stringWithFormat:@"%@", [[self.theControllers objectAtIndex:row] title]];
    controller.message = [NSString stringWithFormat:@"%@", [[self.theControllers objectAtIndex:row] title]];
    
    cell.textLabel.text = controller.title;
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
