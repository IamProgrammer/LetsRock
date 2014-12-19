//
//  WhatsAppDataObject.m
//  MailTableViewCell
//
//  Created by Chandu on 09/12/14.
//  Copyright (c) 2014 com. All rights reserved.
//

#import "WhatsAppDataObject.h"

@implementation WhatsAppDataObject

- (id) init
{
    self = [super init];
    
    if (self) {
        
        self.mailSubjectText = nil;
        self.mailSubTitleText = nil;
        self.mailBodyText = nil;
    }
    
    return self;
}

@end
