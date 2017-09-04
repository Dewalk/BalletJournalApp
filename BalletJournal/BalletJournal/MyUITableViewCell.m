//
//  MyUITableViewCell.m
//  BalletJournal
//
//  Created by Dawn E. Walker on 9/1/17.
//  Copyright © 2017 Dawn E. Walker. All rights reserved.
//

#import "MyUITableViewCell.h"

@implementation MyUITableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void) setInternalFields:(BalletJournalEntity *)incomingBalletJournalEntity{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    self.classLevelTeacherLabel.text = incomingBalletJournalEntity.journalEntryClassLevelTeacher;
    
    self.localBalletJournalEntity = incomingBalletJournalEntity;
    
    self.classDateLabel.text = [dateFormatter stringFromDate: incomingBalletJournalEntity.journalEntryDate];
    
    
}


@end
