//
//  AnimationSectionViewController.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "AnimationSectionViewController.h"
#import "MainMenuViewController.h"
#import "UIView+draggable.h"


@interface AnimationSectionViewController ()

@property (weak, nonatomic) IBOutlet UIView *spinView;
@property (weak, nonatomic) IBOutlet UIImageView *spinImage;

@end

@implementation AnimationSectionViewController

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (IBAction)spinImage:(id)sender {
    
    if (animating) {
        [self stopSpin];
        animating = false;
    } else {
        [self startSpin];
        animating = true;
    }
}

///////////////////////////////////////////////////////////////////////

/// Code from stackoverflow.com by stackoverflow user: Nate
// http://stackoverflow.com/questions/9844925/uiview-infinite-360-degree-rotation-animation

BOOL animating = true;

- (void) spinWithOptions: (UIViewAnimationOptions) options {
    // this spin completes 360 degrees every 2 seconds
    [UIView animateWithDuration: 0.5f
                          delay: 0.0f
                        options: options | UIViewAnimationOptionAllowUserInteraction
                     animations: ^{
                         self.spinImage.transform = CGAffineTransformRotate(self.spinImage.transform, M_PI / 2);
                     }
                     completion: ^(BOOL finished) {
                         if (finished) {
                             if (animating) {
                                 // if flag still set, keep spinning with constant speed
                                 [self spinWithOptions: UIViewAnimationOptionCurveLinear];
                             } else if (options != UIViewAnimationOptionCurveEaseOut) {
                                 // one last spin, with deceleration
                                 [self spinWithOptions: UIViewAnimationOptionCurveEaseOut];
                             }
                         }
                     }];
}

- (void) startSpin {
    if (!animating) {
        animating = YES;
        [self spinWithOptions: UIViewAnimationOptionCurveEaseIn];
    }
}

- (void) stopSpin {
    // set the flag to stop spinning after one last 90 degree increment
    animating = NO;
}

///////////////////////////////////////////////////////////////////////


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.spinView enableDragging];
}

- (IBAction)backAction:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
