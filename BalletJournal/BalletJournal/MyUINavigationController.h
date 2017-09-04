//
//  MyUINavigationController.h
//  BalletJournal
//
//  Created by Dawn E. Walker on 9/1/17.
//  Copyright © 2017 Dawn E. Walker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DWHandlesMOC.h"

@interface MyUINavigationController : UINavigationController <DWHandlesMOC>

-(void) receiveMOC:(NSManagedObjectContext *)incomingMOC;

@end
