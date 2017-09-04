//
//  BalletJournalEntity+CoreDataProperties.h
//  BalletJournal
//
//  Created by Dawn E. Walker on 9/3/17.
//  Copyright © 2017 Dawn E. Walker. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BalletJournalEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface BalletJournalEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *journalEntryClassLevelTeacher;
@property (nullable, nonatomic, retain) NSString *journalEntryClassNotes;
@property (nullable, nonatomic, retain) NSString *journalEntryCombinations;
@property (nullable, nonatomic, retain) NSString *journalEntryCorrections;
@property (nullable, nonatomic, retain) NSDate *journalEntryDate;

@end

NS_ASSUME_NONNULL_END
