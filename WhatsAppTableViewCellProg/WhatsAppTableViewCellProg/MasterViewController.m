//
//  MasterViewController.m
//  MailTableViewCell
//
//  Created by Chandu on 09/12/14.
//  Copyright (c) 2014 com. All rights reserved.
//

#import "MasterViewController.h"
#import "WhatsAppDataObject.h"
#import "WhatsAppTableViewCell.h"
#import "DetailViewController.h"
#import "WhatsAppOptionsSelectedDelegate.h"

@interface MasterViewController () <WhatsAppOptionsSelectedDelegate,UIActionSheetDelegate>

@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    [self createTableViewDataSource];
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self createTableViewDataSource];
    }
    
    return self;
}

- (void) createTableViewDataSource
{

    if (self.objects == nil) {
        self.objects = [[NSMutableArray alloc]init];
    }
    
    [self.objects removeAllObjects];
    
    
    [self createTemporaryMailData];
    
}


- (void) createTemporaryMailData
{
    
    WhatsAppDataObject *object = [[WhatsAppDataObject alloc]init];
    
    object.mailSubjectText = @"Hi Purnachandra rao obulas";
    object.mailSubTitleText = @"How are You";
    object.mailBodyText = @"Bye Dude";
    
    [self.objects addObject:object];
    
    object = [[WhatsAppDataObject alloc]init];
    
    object.mailSubjectText = @"Hi Hero Purnachandra ";
    object.mailSubTitleText = @"How are You";
    object.mailBodyText = @"Bye Dude";
    
    [self.objects addObject:object];
    
    object = [[WhatsAppDataObject alloc]init];
    
    object.mailSubjectText = @"Hi TechMahindra hero";
    object.mailSubTitleText = @"How are You";
    object.mailBodyText = @"Bye Dude";

    [self.objects addObject:object];
    
    object = [[WhatsAppDataObject alloc]init];
    
    object.mailSubjectText = @"Hi H1B Visa";
    object.mailSubTitleText = @"How are You";
    object.mailBodyText = @"Bye Dude";

    [self.objects addObject:object];
    
    object = [[WhatsAppDataObject alloc]init];
    
    object.mailSubjectText = @"Hi L1B Visa";
    object.mailSubTitleText = @"How are You";
    object.mailBodyText = @"Bye Dude";

    [self.objects addObject:object];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WhatsAppTableViewCell *whatsAppTableViewCell = (WhatsAppTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"whatsAppTableViewCell" forIndexPath:indexPath];
    whatsAppTableViewCell.contentMode = UIViewContentModeLeft;
    whatsAppTableViewCell.whatsAppOptionsSelectedDelegate = self;

    WhatsAppDataObject *object = self.objects[indexPath.row];
    
    whatsAppTableViewCell.mailSubjectLabel.text = [object mailSubjectText];
    whatsAppTableViewCell.mailSubTitleLabel.text = [object mailSubTitleText];
    whatsAppTableViewCell.mailTextLabel.text = [object mailBodyText];
    
    return whatsAppTableViewCell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    UIStoryboard *storyBoard = [self storyboard];
    DetailViewController *detailViewController = [storyBoard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    [self.navigationController pushViewController:detailViewController animated:YES];

    NSLog(@"tableview selected");

}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

#pragma mark - WhatsAppOptionsSelectedDelegate methods implementation -

- (void) moreButtonSelectedOfTableViewCell:(id) tableViewCell
{
    [self showMoreOptionsActionSheet];
}

- (void) trashButtonSelectedOfTableViewCell:(id) tableViewCell
{
    
    WhatsAppTableViewCell *whatsAppCell = (WhatsAppTableViewCell*) tableViewCell;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:whatsAppCell];

    [self.objects removeObjectAtIndex:indexPath.row];

    [self.tableView beginUpdates];
    
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self.tableView endUpdates];
}

#pragma mark - Helper methods -

- (void) showMoreOptionsActionSheet
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Archive",@"Contact info",@"Email Conversation",@"Clear Conversation", nil];
    
    [actionSheet showFromRect:CGRectZero inView:self.view animated:YES];
    
}

#pragma mark - UIActionSheetDelegate methods implementation


@end
