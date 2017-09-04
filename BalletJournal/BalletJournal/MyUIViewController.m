//
//  MyUIViewController.m
//  BalletJournal
//
//  Created by Dawn E. Walker on 9/1/17.
//  Copyright © 2017 Dawn E. Walker. All rights reserved.
//

#import "MyUIViewController.h"


@interface MyUIViewController ()

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) BalletJournalEntity *localBalletJournalEntity;

@property (weak, nonatomic) IBOutlet UIDatePicker *classDateField;

@property (weak, nonatomic) IBOutlet UITextField *classLevelTeacherField;

@property (weak, nonatomic) IBOutlet UITextView *combinationsField;
@property (weak, nonatomic) IBOutlet UITextView *correctionsField;

@property (weak, nonatomic) IBOutlet UITextView *classNotesField;

@property (nonatomic, assign) BOOL wasDeleted;


@end

@implementation MyUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void) viewWillAppear:(BOOL)animated{
    //set up delete state
    self.wasDeleted = NO;
    
    //setup form to match whatever entity is passed
    self.classLevelTeacherField.text = self.localBalletJournalEntity.journalEntryClassLevelTeacher;
    self.combinationsField.text = self.localBalletJournalEntity.journalEntryCombinations;
    self.correctionsField.text = self.localBalletJournalEntity.journalEntryCorrections;
    self.classNotesField.text = self.localBalletJournalEntity.journalEntryClassNotes;
    
    NSDate *classDate = self.localBalletJournalEntity.journalEntryDate;
    if(classDate != nil){
        [self.classDateField setDate:classDate];
    }
    
    //Detect edit ends
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) saveMyBalletJournalEntity{
    
    NSError *err;
    BOOL saveSuccess = [self.managedObjectContext save:&err];
    
    if(!saveSuccess){
        @throw [NSException exceptionWithName:NSGenericException reason:@"Could not save" userInfo:@{NSUnderlyingErrorKey:err}];
    }
}

//-(void) textViewDidEndEditing:(NSNotification *)notification{
//    
//    if ([notification object] == self)
//    {
//        self.localBalletJournalEntity.journalEntryCombinations = self.combinationsField.text;
//        [self saveMyBalletJournalEntity];
//    }
//    
//    
//    {
//        self.localBalletJournalEntity.journalEntryCorrections = self.correctionsField.text;
//        [self saveMyBalletJournalEntity];
//    }
//    
//    {
//        self.localBalletJournalEntity.journalEntryClassNotes = self.classNotesField.text;
//        [self saveMyBalletJournalEntity];
//    }
//}




-(void) textViewDidEndEditing:(NSNotification *)notification{
    if ([notification object] == self)
    self.localBalletJournalEntity.journalEntryCombinations = self.combinationsField.text;
    self.localBalletJournalEntity.journalEntryCorrections = self.correctionsField.text;
    self.localBalletJournalEntity.journalEntryClassNotes = self.classNotesField.text;
    [self saveMyBalletJournalEntity];

}



- (IBAction)trashTapped:(id)sender {
    self.wasDeleted = YES;
    [self.managedObjectContext deleteObject:self.localBalletJournalEntity];
    [self saveMyBalletJournalEntity];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


-(void) viewWillDisappear:(BOOL)animated{
    
    if(self.wasDeleted == NO){
    
        //save everything
        self.localBalletJournalEntity.journalEntryDate = self.classDateField.date;
        self.localBalletJournalEntity.journalEntryClassLevelTeacher = self.classLevelTeacherField.text;
        self.localBalletJournalEntity.journalEntryCombinations = self.combinationsField.text;
        self.localBalletJournalEntity.journalEntryCorrections = self.correctionsField.text;
        self.localBalletJournalEntity.journalEntryClassNotes = self.classNotesField.text;
        [self saveMyBalletJournalEntity];
    }
    
    //remove detection - stop notifying me
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidEndEditingNotification object:self];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)classDateFieldEdited:(id)sender {
    self.localBalletJournalEntity.journalEntryDate = self.classDateField.date;
    
    [self saveMyBalletJournalEntity];

}

- (IBAction)classLevelTeacherFieldEdited:(id)sender {
    self.localBalletJournalEntity.journalEntryClassLevelTeacher = self.classLevelTeacherField.text;
    [self saveMyBalletJournalEntity];
}


-(void) receiveMOC:(NSManagedObjectContext *)incomingMOC{
    self.managedObjectContext = incomingMOC;
    
}

-(void) receiveBalletJournalEntity:(BalletJournalEntity *)incomingBalletJournalEntity{
    self.localBalletJournalEntity = incomingBalletJournalEntity;
}

@end
