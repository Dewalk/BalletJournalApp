//
//  DWHandlesMOC.h
//  BalletJournal
//
//  Created by Dawn E. Walker on 9/1/17.
//  Copyright © 2017 Dawn E. Walker. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DWHandlesMOC <NSObject>

-(void) receiveMOC:(NSManagedObjectContext *)incomingMOC;

@end
