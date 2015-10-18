// Simple Movie integration plug-in for Unity iOS.

#import <Foundation/Foundation.h>
#import "SimpleMovieViewController.h"

extern UIViewController *UnityGetGLViewController(); // Root view controller of Unity screen.

#pragma mark Plug-in Functions


// configure player.
// @param orientation	0:All, 1:Portrait only, 2:Landscape only
extern "C" void _SimpleMoviePluginPlayMovieCore( SimpleMovieViewController* playervc,
																								const char* movieFinishedTargetName = NULL,
																								const char* movieFinishedMethodName = NULL,
																								const int orientation = 0)
{
	if( playervc ){
		UIViewController *rootVC = UnityGetGLViewController();

		// setup for supported orientations
		switch (orientation) {
			case 1:
				playervc.supportedOrientationMask	= UIInterfaceOrientationMaskPortrait;
				break;
			case 2:
				playervc.supportedOrientationMask	= UIInterfaceOrientationMaskLandscape;
				break;
			default:
				playervc.supportedOrientationMask	= UIInterfaceOrientationMaskAll;
				break;
		}
		
		[playervc setupCallbackTarget:movieFinishedTargetName withMethod:movieFinishedMethodName];
		
		//	[playervc.moviePlayer setControlStyle:MPMovieControlStyleDefault];
		//	[playervc.moviePlayer setShouldAutoplay:YES];
		//	[playervc.moviePlayer setFullscreen:YES];
		//	[playervc.moviePlayer setMovieSourceType:MPMovieSourceTypeStreaming];
		[rootVC presentViewController:playervc animated:YES completion:nil];
	}
}

// for use from bundle.
// @param pathname (/Assets/StreamingAssets/)pathname(/filename.mp4)
// @param filename (path/)filename(.mp4)
// @param filetype (filename).mp4
// @param orientation	0:All, 1:Portrait only, 2:Landscape only
extern "C" void _SimpleMoviePluginPlayMovie(
																						const char* pathname, const char* filename, const char* filetype,
																						const char* movieFinishedTargetName = NULL,
																						const char* movieFinishedMethodName = NULL,
																						const int orientation = 0 )
{
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

	_SimpleMoviePluginPlayMovieCore( playervc, movieFinishedTargetName, movieFinishedMethodName, orientation );
}

// for use from bundle.
// @param urlMovie ex. "http://example.com/movies/example.mp4"
// @param orientation	0:All, 1:Portrait only, 2:Landscape only
extern "C" void _SimpleMoviePluginPlayMovieURL( const char* urlMovie,
																							 const char* movieFinishedTargetName = NULL,
																							 const char* movieFinishedMethodName = NULL,
																							 const int orientation = 0 )
{
	NSString*	strUrlMovie	= [NSString stringWithCString:urlMovie encoding:NSUTF8StringEncoding];
	NSURL* nsurlMovie = [NSURL URLWithString:strUrlMovie];
	
	// load.
	SimpleMovieViewController*	playervc = [[SimpleMovieViewController alloc] initWithContentURL:nsurlMovie];
	
	_SimpleMoviePluginPlayMovieCore( playervc, movieFinishedTargetName, movieFinishedMethodName, orientation );
}


#pragma mark --- Test Code ---

extern "C" void _SimpleMoviePluginTest()
{
	// Do some stuff, then
	UnitySendMessage("MyGameObject", "MyCallbackFunc", "It is working man!");
}


