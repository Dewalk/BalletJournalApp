//
//  MyUITableViewCell.h
//  BalletJournal
//
//  Created by Dawn E. Walker on 9/1/17.
//  Copyright © 2017 Dawn E. Walker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BalletJournalEntity.h"


@interface MyUITableViewCell : UITableViewCell

@property (strong, nonatomic) BalletJournalEntity *localBalletJournalEntity;
@property (weak, nonatomic) IBOutlet UILabel *classLevelTeacherLabel;

@property (weak, nonatomic) IBOutlet UILabel *classDateLabel;


-(void) setInternalFields:(BalletJournalEntity *)incomingBalletJournalEntity;

@end
