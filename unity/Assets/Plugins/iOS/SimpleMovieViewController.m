//
//  SimpleMovieViewController.m
//
//  Created by Torques Inc. on 14/10/20.
//
//

#import "SimpleMovieViewController.h"


@interface SimpleMovieViewController()

@property	(nonatomic, copy) NSString*	movieFinishedTargetName;
@property	(nonatomic, copy) NSString*	movieFinishedMethodName;

@end


@implementation SimpleMovieViewController


-(BOOL)shouldAutorotate
{
	return YES;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
	return self.supportedOrientationMask;
}

- (void) viewDidLoad
{
	[super viewDidLoad];
	
//	self.movieFinishedTargetName	= nil;
//	self.movieFinishedMethodName	= nil;
	
	// Remove the movie player view controller from the "playback did finish" notification observers
	[[NSNotificationCenter defaultCenter] removeObserver:self
																									name:MPMoviePlayerPlaybackDidFinishNotification
																								object:self.moviePlayer];
	
	// Register this class as an observer instead
	[[NSNotificationCenter defaultCenter] addObserver:self
																					 selector:@selector(movieFinishedCallback:)
																							 name:MPMoviePlayerPlaybackDidFinishNotification
																						 object:self.moviePlayer];
	
}

- (void)movieFinishedCallback:(NSNotification*)aNotification
{
	NSLog(@"!! %s", __PRETTY_FUNCTION__);
	
	// Obtain the reason why the movie playback finished
	NSNumber *finishReason = [[aNotification userInfo] objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
	
	// Dismiss the view controller ONLY when the reason is not "playback ended"
	if ([finishReason intValue] == MPMovieFinishReasonPlaybackEnded)
	{
		NSLog(@"REASON: END");
	}
	else
	{
		NSLog(@"REASON: UNKNOWN");
	}
	
	[self dismissViewControllerAnimated:YES
													 completion:^(){
														 if( self.movieFinishedTargetName && self.movieFinishedMethodName ){
															 NSString* strReason	= [NSString stringWithFormat:@"%@", finishReason];
															 
															 NSLog(@"%@ - %@ [%@]", self.movieFinishedTargetName, self.movieFinishedMethodName, strReason);
															 UnitySendMessage([self.movieFinishedTargetName UTF8String],
																								[self.movieFinishedMethodName UTF8String],
																								[strReason UTF8String]);
														 }
														 else{
															 NSLog(@"skip movieFinished");
														 }
													 }];
}

- (void) setupCallbackTarget:(const char*)movieFinishedTargetName
									withMethod:(const char*)movieFinishedMethodName
{
	NSLog(@"setupCallbackTarget:withMethod:");
	NSLog(@"  target: %s", movieFinishedTargetName);
	NSLog(@"  method: %s", movieFinishedMethodName);
	
	if( movieFinishedTargetName ){
		self.movieFinishedTargetName	= [NSString stringWithCString:movieFinishedTargetName
																											encoding:NSUTF8StringEncoding];
	}
	else{
		self.movieFinishedTargetName	= nil;
	}
	
	if( movieFinishedMethodName ){
		self.movieFinishedMethodName	= [NSString stringWithCString:movieFinishedMethodName
																											encoding:NSUTF8StringEncoding];
	}
	else{
		self.movieFinishedMethodName	= nil;
	}
}


@end
