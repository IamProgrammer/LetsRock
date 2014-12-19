//
//  WhatsAppOptionsSelectedDelegate.h
//  WhatsAppTableViewCellProg
//
//  Created by Chandu on 19/12/14.
//  Copyright (c) 2014 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WhatsAppOptionsSelectedDelegate <NSObject>

- (void) moreButtonSelectedOfTableViewCell:(id) tableViewCell;
- (void) trashButtonSelectedOfTableViewCell:(id) tableViewCell;

@end
