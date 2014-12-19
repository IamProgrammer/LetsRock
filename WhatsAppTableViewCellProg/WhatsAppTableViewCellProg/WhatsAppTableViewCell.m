//
//  MailTableViewCell.m
//  MailTableViewCell
//
//  Created by Chandu on 09/12/14.
//  Copyright (c) 2014 com. All rights reserved.
//

#import "WhatsAppTableViewCell.h"

@interface WhatsAppTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *moreOptionsView;
@property (weak, nonatomic) IBOutlet UIView *trashView;
@property (weak, nonatomic) IBOutlet UIView *flagView;
@property (weak, nonatomic) IBOutlet UIView *moreView;
@property (strong, nonatomic) UITapGestureRecognizer *tapGestureRecognizer;

@property (weak, nonatomic) IBOutlet UIView *markAsReadUnReadView;
@property (weak, nonatomic) IBOutlet UIView *mailTextView;

@property (nonatomic,assign) BOOL showMoreOptions;

@end

@implementation WhatsAppTableViewCell

#pragma mark - TableViewCell methods -

- (void)awakeFromNib {

    [self initialization];
}

- (void) initialization
{
    [self addRequiredGestureRecognizers];
    self.showMoreOptions = NO;
    
    NSArray *gestureRecognizers = [self.contentView gestureRecognizers];
    NSLog(@"The gestureRecognizers are %@",gestureRecognizers);
    
}

- (void) prepareForReuse
{
    [super prepareForReuse];
    [self setUpPrepareForReUse];
}

- (void) dealloc
{
    [self removeAddedGestureRecognizers];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}


- (void) setUpPrepareForReUse
{
    self.showMoreOptions = NO;
    
    CGFloat width = CGRectGetWidth(self.bounds);
    
    CGRect frame = self.moreOptionsView.frame;
    frame.origin.x = width;
    self.moreOptionsView.frame = frame;
    
    CGRect mailTextViewFrame = self.mailTextView.frame;
    mailTextViewFrame.origin.x = 0;
    self.mailTextView.frame = mailTextViewFrame;
    
}

#pragma mark - Swipe helper methods implementation -

- (void) swipeLeftSide:(UISwipeGestureRecognizer*) leftSwipeGestureRecognizer
{

    CGPoint location =  [leftSwipeGestureRecognizer locationInView:self.contentView];
    CGFloat pointX = location.x;
    
    NSLog(@"The swipteLeftSide pointX is %f",pointX);
    
    if (self.showMoreOptions) {
        
        [self resetViewsInTableViewCell];
        return;
    }
    
    else
    {
 
        CGPoint point = [leftSwipeGestureRecognizer locationInView:self.contentView];
        NSInteger recognizerState = leftSwipeGestureRecognizer.state;
        
        switch (recognizerState) {

            case UIGestureRecognizerStateChanged:
            {
                [self updateViewsWithPointForLeftSideGestureRecognizer:point];
                break;
            }
                
            case UIGestureRecognizerStateEnded:
            {
                [self showViewsWithPointForLeftSideGestureRecognizer:point];
                break;
            }
                
            default:
                break;
        }

        

    }
}

- (void) swipeRightSide:(UISwipeGestureRecognizer*) rightSwipeGestureRecognizer
{
    CGPoint location =  [rightSwipeGestureRecognizer locationInView:self.contentView];
    CGFloat pointX = location.x;
    
    NSLog(@"The swipeRightSide pointX is %f",pointX);
    
    if (self.showMoreOptions) {
        
        [self resetViewsInTableViewCell];
        return;
    }
    
    
}

- (void) updateViewsWithPointForLeftSideGestureRecognizer:(CGPoint) point
{
    CGFloat pointX = point.x;
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    
    CGFloat moreOptionsCheck = fabs(pointX);
    CGFloat moreOptionsViewWidth = CGRectGetWidth(self.moreOptionsView.frame);
    
    if (moreOptionsCheck > moreOptionsViewWidth/2) {
        
        CGRect frame = self.moreOptionsView.frame;
        frame.origin.x = width - moreOptionsViewWidth;
        self.moreOptionsView.frame = frame;
    }
    
    else
    {
        CGRect frame = self.moreOptionsView.frame;
        frame.origin.x = width + pointX;
        self.moreOptionsView.frame = frame;
        
    }
    
    CGRect mailTextViewFrame = self.mailTextView.frame;
    mailTextViewFrame.origin.x = pointX;
    self.mailTextView.frame = mailTextViewFrame;
    
}

- (void) showViewsWithPointForLeftSideGestureRecognizer:(CGPoint) point
{
    CGFloat pointX = point.x;
    
    NSLog(@"UIGestureRecognizerStateEnded called and pointX is %f",pointX);
    
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    
    CGFloat moreOptionsCheck = fabs(pointX);
    CGFloat moreOptionsViewWidth = CGRectGetWidth(self.moreOptionsView.frame);
    
    if (self.showMoreOptions) {
        
        [self resetViewsInTableViewCell];
        return;
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    
    if (moreOptionsCheck > moreOptionsViewWidth/2) {
        
        CGRect frame = self.moreOptionsView.frame;
        frame.origin.x = width - moreOptionsViewWidth;
        self.moreOptionsView.frame = frame;
        
        if (self.showMoreOptions == NO) {
            
            self.showMoreOptions = YES;
            [self addTapGestureRecognizer];
        }
        
        CGRect mailTextViewFrame = self.mailTextView.frame;
        mailTextViewFrame.origin.x = -moreOptionsViewWidth;
        self.mailTextView.frame = mailTextViewFrame;
        
    }
    
    else
    {
        CGRect frame = self.moreOptionsView.frame;
        frame.origin.x = width;
        self.moreOptionsView.frame = frame;
        
        self.showMoreOptions = NO;
        
        CGRect mailTextViewFrame = self.mailTextView.frame;
        mailTextViewFrame.origin.x = 0;
        self.mailTextView.frame = mailTextViewFrame;
        
    }
    
    [UIView commitAnimations];
}

- (void) tableViewCellSelected:(UITapGestureRecognizer*) tapGestureRecognizer
{
    if (self.showMoreOptions) {

        [self resetViewsInTableViewCell];
        
    }
}
- (void) resetViewsInTableViewCell
{
    
    CGFloat width = CGRectGetWidth(self.bounds);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    
    CGRect frame = self.moreOptionsView.frame;
    frame.origin.x = width;
    self.moreOptionsView.frame = frame;
    
    self.showMoreOptions = NO;
    
    CGRect mailTextViewFrame = self.mailTextView.frame;
    mailTextViewFrame.origin.x = 0;
    self.mailTextView.frame = mailTextViewFrame;
    
    [UIView commitAnimations];
    
    [self removeTapGestureRecognizer];

}

#pragma mark - UIGestureRecognizer methods -

- (void) addRequiredGestureRecognizers
{
    UISwipeGestureRecognizer *leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLeftSide:)];
    leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.contentView addGestureRecognizer:leftSwipeGestureRecognizer];
    
    UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRightSide:)];
    rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.contentView addGestureRecognizer:rightSwipeGestureRecognizer];
    
    
}

- (void) removeAddedGestureRecognizers
{
    NSArray *gestureRecognizers = [self.contentView gestureRecognizers];
    
    for (UISwipeGestureRecognizer *swipeGestureRecognizer in gestureRecognizers) {
        
        if ([swipeGestureRecognizer class] == [UISwipeGestureRecognizer class]) {
            
            [self.contentView removeGestureRecognizer:swipeGestureRecognizer];
            
        }
        
    }
}

- (void) addTapGestureRecognizer
{
    
    if (self.tapGestureRecognizer == nil) {
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewCellSelected:)];
        tapGestureRecognizer.numberOfTapsRequired = 1;
        self.tapGestureRecognizer = tapGestureRecognizer;
        
    }
    
    [self.contentView addGestureRecognizer:self.tapGestureRecognizer];
    
}

- (void) removeTapGestureRecognizer
{
    NSArray *gestureRecongnizers = [self.contentView gestureRecognizers];
    
    for (UITapGestureRecognizer *tapGestureRecognizer in gestureRecongnizers) {
        
        if ([tapGestureRecognizer class] == [UITapGestureRecognizer class]) {
            
            [self.contentView removeGestureRecognizer:tapGestureRecognizer];
            break;
        }
    }
    
    self.tapGestureRecognizer = nil;
}

#pragma mark - IBAction methods implementation

- (IBAction)moreButtonAction:(id)sender
{
    if ([self.whatsAppOptionsSelectedDelegate respondsToSelector:@selector(moreButtonSelectedOfTableViewCell:)]) {
        
        [self.whatsAppOptionsSelectedDelegate moreButtonSelectedOfTableViewCell:self];
        
    }
}

- (IBAction)trashButtonAction:(id)sender
{
    
    if ([self.whatsAppOptionsSelectedDelegate respondsToSelector:@selector(trashButtonSelectedOfTableViewCell:)]) {
        
        [self.whatsAppOptionsSelectedDelegate trashButtonSelectedOfTableViewCell:self];
    }
    
}


#pragma mark - Unused methods -

@end
