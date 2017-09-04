//
//  MyUINavigationController.m
//  BalletJournal
//
//  Created by Dawn E. Walker on 9/1/17.
//  Copyright © 2017 Dawn E. Walker. All rights reserved.
//

#import "MyUINavigationController.h"

@interface MyUINavigationController ()

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

@implementation MyUINavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//we are passing this view here instead of in the segue way b/c as of ios9, navigation controller no longer uses segue to load a table view, it just loads it.

-(void) receiveMOC:(NSManagedObjectContext *)incomingMOC{
    self.managedObjectContext = incomingMOC;
    id<DWHandlesMOC> child = (id<DWHandlesMOC>) self.viewControllers[0];
    [child receiveMOC:self.managedObjectContext];
    
}






@end
