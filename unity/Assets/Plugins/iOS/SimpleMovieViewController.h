//
//  SimpleMovieViewController.h
//
//  Created by Torques Inc. on 14/10/20.
//
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface SimpleMovieViewController : MPMoviePlayerViewController

@property UIInterfaceOrientationMask supportedOrientationMask;

- (void) setupCallbackTarget:(const char*)movieFinishedTargetName
									withMethod:(const char*)movieFinishedMethodName;

@end
