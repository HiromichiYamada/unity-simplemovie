// Simple Movie integration plug-in for Unity iOS.

#import <Foundation/Foundation.h>
#import "SimpleMovieViewController.h"

extern UIViewController *UnityGetGLViewController(); // Root view controller of Unity screen.

#pragma mark Plug-in Functions

// for use from bundle.
// @param pathname (/Assets/StreamingAssets/)pathname(/filename.mp4)
// @param filename (path/)filename(.mp4)
// @param filetype (filename).mp4
extern "C" void _SimpleMoviePluginPlayMovie(
		const char* pathname, const char* filename, const char* filetype )
{
	UIViewController *rootVC = UnityGetGLViewController();
	
	// set the url.
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

// for use from bundle.
// @param urlMovie ex. "http://example.com/movies/example.mp4"
extern "C" void _SimpleMoviePluginPlayMovieURL( const char* urlMovie )
{
	UIViewController *rootVC = UnityGetGLViewController();
	
	NSString*	strUrlMovie	= [NSString stringWithCString:urlMovie encoding:NSUTF8StringEncoding];
	NSURL* nsurlMovie = [NSURL URLWithString:strUrlMovie];
	
	// load.
	SimpleMovieViewController*	playervc = [[SimpleMovieViewController alloc] initWithContentURL:nsurlMovie];
	
	// setup for supported orientations
	playervc.supportedOrientationMask	= UIInterfaceOrientationMaskAll;	//UIInterfaceOrientationMaskLandscape;
	
	//	[playervc.moviePlayer setControlStyle:MPMovieControlStyleDefault];
	//	[playervc.moviePlayer setShouldAutoplay:YES];
	//	[playervc.moviePlayer setFullscreen:YES];
	//	[playervc.moviePlayer setMovieSourceType:MPMovieSourceTypeStreaming];
	[rootVC presentViewController:playervc animated:YES completion:nil];
}
