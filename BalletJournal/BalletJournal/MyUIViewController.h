//
//  MyUIViewController.h
//  BalletJournal
//
//  Created by Dawn E. Walker on 9/1/17.
//  Copyright © 2017 Dawn E. Walker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DWHandlesMOC.h"
#import "DWHandlesBalletJournalEntity.h"

@interface MyUIViewController : UIViewController <DWHandlesMOC,DWHandlesBalletJournalEntity>

-(void) receiveMOC:(NSManagedObjectContext *)incomingMOC;
-(void) receiveBalletJournalEntity:(BalletJournalEntity *)incomingBalletJournalEntity;

@end
