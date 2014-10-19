// Simple Movie integration plug-in for Unity iOS.

#import <Foundation/Foundation.h>
#import "SimpleMovieViewController.h"

extern UIViewController *UnityGetGLViewController(); // Root view controller of Unity screen.

#pragma mark Plug-in Functions

// for easy using (from bundle).
//extern "C" void _WebViewPluginAddBundleWebRect(
extern "C" void _SimpleMoviePluginPlayMovie(
		const char* pathname, const char* filename, const char* filetype )
{
	UIViewController *rootVC = UnityGetGLViewController();
	
	// set the frame.
	NSString*	strPathname	= [NSString stringWithCString:pathname encoding:NSUTF8StringEncoding];
	NSString*	strFilename	= [NSString stringWithCString:filename encoding:NSUTF8StringEncoding];
	NSString*	strFiletype	= [NSString stringWithCString:filetype encoding:NSUTF8StringEncoding];
	NSString* path	= [[NSBundle mainBundle] pathForResource:strFilename
											ofType:strFiletype
											inDirectory:strPathname];

	NSURL* urlMovie = [NSURL fileURLWithPath:path];
	
	// load.
	SimpleMovieViewController*	playervc = [[SimpleMovieViewController alloc] initWithContentURL:urlMovie];

	// setup for supported orientations
	playervc.supportedOrientationMask	= UIInterfaceOrientationMaskAll;	//UIInterfaceOrientationMaskLandscape;
	
	//	[playervc.moviePlayer setControlStyle:MPMovieControlStyleDefault];
	//	[playervc.moviePlayer setShouldAutoplay:YES];
	//	[playervc.moviePlayer setFullscreen:YES];
	//	[playervc.moviePlayer setMovieSourceType:MPMovieSourceTypeStreaming];
	[rootVC presentViewController:playervc animated:YES completion:nil];
}
