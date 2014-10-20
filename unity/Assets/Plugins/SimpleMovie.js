#pragma strict

// Simple Movie Player integration plug-in for Unity iOS.
// Torques Inc.

import System.Runtime.InteropServices;

#if UNITY_EDITOR
// Unity Editor implementation.

static function PlayMovie(
	pathname : String, filename : String, filetype : String )
{
	// not implemented.
}

static function PlayMovieURL( urlMovie : String )
{
	// not implemented.
}


#elif UNITY_IPHONE
// iOS platform implementation.

@DllImportAttribute("__Internal") static private function _SimpleMoviePluginPlayMovie(pathname : String, filename : String, filetype : String) {}
@DllImportAttribute("__Internal") static private function _SimpleMoviePluginPlayMovieURL( urlMovie : String ) {}

// for use from bundle.
// @param pathname (/Assets/StreamingAssets/)pathname(/filename.mp4)
// @param filename (path/)filename(.mp4)
// @param filetype (filename).mp4
static function PlayMovie(
	pathname : String, filename : String, filetype : String )
{
	Debug.Log( "PlayMovie" );
	
	_SimpleMoviePluginPlayMovie("Data/Raw/"+pathname, filename, filetype);
}

// for use from bundle.
// @param urlMovie ex. "http://example.com/movies/example.mp4"
static function PlayMovieURL( urlMovie : String )
{
	Debug.Log( "PlayMovieURL" );
	
	_SimpleMoviePluginPlayMovieURL(urlMovie);
}

#elif UNITY_ANDROID
// Android platform implementation.

static function PlayMovie(
	pathname : String, filename : String, filetype : String )
{
	// not implemented.
}

static function PlayMovieURL( urlMovie : String )
{
	// not implemented.
}

#endif
