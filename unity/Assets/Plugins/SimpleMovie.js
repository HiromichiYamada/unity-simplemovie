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

#elif UNITY_IPHONE
// iOS platform implementation.

@DllImportAttribute("__Internal") static private function _SimpleMoviePluginPlayMovie(pathname : String, filename : String, filetype : String) {}

// for easy using (from bundle).
// @param pathname (/Assets/StreamingAssets/)pathname(/filename.html)
// @param filename (path/)filename(.html)
// @param filetype (filename).html
static function PlayMovie(
	pathname : String, filename : String, filetype : String )
{
	Debug.Log( "PlayMovie" );
	
	_SimpleMoviePluginPlayMovie("Data/Raw/"+pathname, filename, filetype);
}

#elif UNITY_ANDROID
// Android platform implementation.

static function PlayMovie(
	pathname : String, filename : String, filetype : String )
{
	// not implemented.
}

#endif
