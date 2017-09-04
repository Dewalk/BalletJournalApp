//
//  DWHandlesBalletJournalEntity.h
//  BalletJournal
//
//  Created by Dawn E. Walker on 9/1/17.
//  Copyright © 2017 Dawn E. Walker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BalletJournalEntity.h"

//Protocol for passing variables between ViewControllers

@protocol DWHandlesBalletJournalEntity <NSObject>

-(void) receiveBalletJournalEntity:(BalletJournalEntity *)incomingBalletJournalEntity;

@end
