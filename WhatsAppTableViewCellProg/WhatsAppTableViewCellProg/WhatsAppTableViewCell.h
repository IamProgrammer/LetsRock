//
//  MailTableViewCell.h
//  MailTableViewCell
//
//  Created by Chandu on 09/12/14.
//  Copyright (c) 2014 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WhatsAppOptionsSelectedDelegate.h"

@interface WhatsAppTableViewCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UILabel *mailSubjectLabel;
@property (nonatomic,weak) IBOutlet UILabel *mailSubTitleLabel;
@property (nonatomic,weak) IBOutlet UILabel *mailTextLabel;

@property (nonatomic,weak) id<WhatsAppOptionsSelectedDelegate> whatsAppOptionsSelectedDelegate;


@end
