//
//  TaskDetailViewController.m
//  MobileAppDevProject
//
//  Created by Nicholas Pantola on 5/29/13.
//  Copyright (c) 2013 Pantola. All rights reserved.
//

#import "TaskDetailViewController.h"

@interface TaskDetailViewController ()


@end

@implementation TaskDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    self.theLabel.text = self.message;
    self.recID.text = self.recordID;
    self.dateDue.text = self.theDateDue;
    self.recordDesc.text = self.description;
    [super viewWillAppear:animated];
}
- (void)viewDidUnload {
    self.theLabel = nil;
    self.message = nil;
    [super viewDidUnload];
}



- (IBAction)takeTask:(id)sender {
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
            NSString *querySQL = [NSString stringWithFormat:@"Update tasks set istaken=1 WHERE id = %@", self.recordID];
            const char *query_stmt = [querySQL UTF8String];
            
            if(sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK){
                
                if(sqlite3_step(statement) == SQLITE_DONE){
                    //Successfully updated record
                } else {
                    NSLog(@"Error executing sql statement");
                }
                sqlite3_finalize(statement);
                
            } else {
                NSLog(@"Error Preparing Statement");
            }
            sqlite3_close(contactDB);
            
        } else {
            NSLog(@"Error Statement: %s", sqlite3_errmsg(contactDB));
        }
        
    }
    
}
@end
