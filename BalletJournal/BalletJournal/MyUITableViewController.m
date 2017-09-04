//
//  MyUITableViewController.m
//  BalletJournal
//
//  Created by Dawn E. Walker on 9/1/17.
//  Copyright © 2017 Dawn E. Walker. All rights reserved.
//


#import <CoreData/CoreData.h>
#import "MyUITableViewController.h"
#import "BalletJournalEntity.h"
#import "MyUITableViewCell.h"
#import "DWHandlesMOC.h"
#import "DWHandlesBalletJournalEntity.h"

@interface MyUITableViewController () <UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) NSFetchedResultsController *resultsController;



@end

@implementation MyUITableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeNSFetchedResultsControllerDelegate];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger) numberOfSectionsInTableView: (UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView: (UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultsController.sections[section].numberOfObjects;
}


- (UITableViewCell *)tableView:(UITableView *) tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    BalletJournalEntity *item = self.resultsController.sections[indexPath.section].objects[indexPath.row];
    
    MyUITableViewCell *cell = (MyUITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TableCellIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    
    [cell setInternalFields:item];
    
    return cell;
}


#pragma mark - NSFetchedResultsControllerDelegate

-(void) initializeNSFetchedResultsControllerDelegate{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    fetchRequest.entity = [NSEntityDescription entityForName:@"BalletJournalEntity" inManagedObjectContext:self.managedObjectContext];
    
    //use truepredicate is constant used when we want no grouping. If we had sections would define them here
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"TRUEPREDICATE"];
    
    fetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"journalEntryDate" ascending:YES]];
    
    self.resultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    self.resultsController.delegate = self;
    
    NSError *err;
    BOOL fetchSucceeded = [self.resultsController performFetch:&err];
    if(!fetchSucceeded){
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Could not fetch" userInfo:nil];
    }
    
}


-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [[self tableView] insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate: {
            MyUITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            BalletJournalEntity *item = [controller objectAtIndexPath:indexPath];
            [cell setInternalFields:item];
            break;
        }
        case NSFetchedResultsChangeMove:
            [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [[self tableView] insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    id<DWHandlesMOC,DWHandlesBalletJournalEntity> child = (id<DWHandlesMOC,DWHandlesBalletJournalEntity>)[segue destinationViewController];
    [child receiveMOC:self.managedObjectContext];
    
    BalletJournalEntity *item;
    if([sender isMemberOfClass:[UIBarButtonItem class]]){
        item = [NSEntityDescription insertNewObjectForEntityForName:@"BalletJournalEntity" inManagedObjectContext:self.managedObjectContext];
    }
    else{
        MyUITableViewCell *source = (MyUITableViewCell *) sender;
        item = source.localBalletJournalEntity;
    }
    
    [child receiveBalletJournalEntity:item];
 
}

-(void) receiveMOC:(NSManagedObjectContext *)incomingMOC{
    self.managedObjectContext = incomingMOC;
    
}



@end
