//
//  TableSectionTableViewCell.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "ChatCell.h"



@interface ChatCell ()
@property (nonatomic, strong) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageTextView;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;

@property int userId;

@end

@implementation ChatCell

- (void)loadWithData:(ChatData *)chatData
{
    self.usernameLabel.text = chatData.username;
    self.messageTextView.text = chatData.message;
    self.userId = chatData.user_id;
    self.userImage.image = [self getUserImage:self.userId];
}

- (UIImage*) getUserImage:(int)usernameID
{
    NSArray *images = [self imageNameArray];
    return [UIImage imageNamed:images[usernameID - 1]];
}

- (NSArray*) imageNameArray
{
    NSArray *imageNames = @[@"user1_DerrickXu", @"user2_GregGuidone", @"user3_JustinLeClair", @"user4_DrewJohnson"];
    return imageNames;
}

@end
