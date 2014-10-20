unity-simplemovie
=================

* Alternative to Handheld.PlayFullScreenMovie for support of rotating screen.
* iOS only.

Usage
=================

* The source to open the movie at "/StreamingAssets/mymovie/dyson360eye.mp4" (Bundle)

```
var callbackTargetName = "hud";	// callback target (GameObject), (default:null)
var callbackMethodName = "OnDoneSimpleMovie";	// calback method name for the target (default:null)

SimpleMovie.PlayMovie("mymovie", "dyson360eye", "mp4", callbackTargetName, callbackMethodName);
```

* The source to open the movie at "http://example.com/movies/example.mp4"

```
var callbackTargetName = "hud";	// callback target (GameObject), (default:null)
var callbackMethodName = "OnDoneSimpleMovie";	// calback method name for the target (default:null)

SimpleMovie.PlayMovieURL("http://example.com/movies/example.mp4", callbackTargetName, callbackMethodName;
```

Customize
=================

Orientations
-----------------

* iOS/SimpleMovie.mm

```
playervc.supportedOrientationMask	= UIInterfaceOrientationMaskAll;	// UIInterfaceOrientationMaskLandscape;
```



about the sample movie - dyson360eye.mp4
=================

* [James Dyson unveils Dyson 360 Eye robot in Japan #DysonRobot](https://www.youtube.com/watch?v=4y_9V7O1pac)
