#pragma strict

// Simple Movie Player integration plug-in for Unity iOS.
// Torques Inc.

import System.Runtime.InteropServices;

#if UNITY_EDITOR
// Unity Editor implementation.

static function PlayMovie(
	pathname : String, filename : String, filetype : String,
	movieFinishedTargetName : String, movieFinishedMethodName : String,
	orientation : int )
{
	// not implemented.
}

static function PlayMovieURL( urlMovie : String,
	movieFinishedTargetName : String, movieFinishedMethodName : String,
	orientation : int )
{
	// not implemented.
}


#elif UNITY_IPHONE
// iOS platform implementation.

@DllImportAttribute("__Internal") static private function _SimpleMoviePluginPlayMovie(pathname : String, filename : String, filetype : String, movieFinishedTargetName : String, movieFinishedMethodName : String, orientation : int ) {}
@DllImportAttribute("__Internal") static private function _SimpleMoviePluginPlayMovieURL( urlMovie : String, movieFinishedTargetName : String, movieFinishedMethodName : String, orientation : int ) {}

// for use from bundle.
// @param pathname (/Assets/StreamingAssets/)pathname(/filename.mp4)
// @param filename (path/)filename(.mp4)
// @param filetype (filename).mp4
// @param orientation	0:All, 1:Portrait only, 2:Landscape only
static function PlayMovie(
	pathname : String, filename : String, filetype : String,
	movieFinishedTargetName : String,	// default: null
	movieFinishedMethodName : String,	// default: null
	orientation : int )	// default: 0(All)
{
	Debug.Log( "PlayMovie" );
	if( movieFinishedTargetName == null || movieFinishedMethodName == null ){
		_SimpleMoviePluginPlayMovie( "Data/Raw/"+pathname, filename, filetype, null, null, orientation );
	}
	else{
		_SimpleMoviePluginPlayMovie( "Data/Raw/"+pathname, filename, filetype, movieFinishedTargetName, movieFinishedMethodName, orientation );
	}
}

// for use from bundle.
// @param urlMovie ex. "http://example.com/movies/example.mp4"
// @param orientation	0:All, 1:Portrait only, 2:Landscape only
static function PlayMovieURL(
	urlMovie : String,
	movieFinishedTargetName : String,	// default: null
	movieFinishedMethodName : String,	// default: null
	orientation : int )	// default: 0(All)
{
	Debug.Log( "PlayMovieURL" );
	
	if( movieFinishedTargetName == null || movieFinishedMethodName == null ){
		_SimpleMoviePluginPlayMovieURL( urlMovie, null, null, orientation );
	}
	else{
		_SimpleMoviePluginPlayMovieURL( urlMovie, movieFinishedTargetName, movieFinishedMethodName, orientation );
	}
}

#elif UNITY_ANDROID
// Android platform implementation.

static function PlayMovie(
	pathname : String, filename : String, filetype : String,
	movieFinishedTargetName : String, movieFinishedMethodName : String, orientation : int )
{
	// not implemented.
}

static function PlayMovieURL( urlMovie : String,
	movieFinishedTargetName : String, movieFinishedMethodName : String, orientation : int )
{
	// not implemented.
}

#endif
