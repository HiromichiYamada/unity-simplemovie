#pragma strict

private var screenScale : float;
private var myMessage : String;

function Start () {
	// for scaling.
	screenScale		= Screen.width / 320.0f;
	var sh : float	= Screen.height / screenScale;
	
	// Set AD : 320x50 from web.
//	EasyWebview.AddWebRect("http://www.torques.jp/banner/bannerTorquesPics.html", 0, 200, 320, 50, "Banner0");
	// Set AD : 320x50 from Bundle.
//EasyWebview.AddBundleWebRect("myhtml", "mybanner", "html", 0, 200, 320, 50, "Banner0");

	myMessage = "Start.";
}

function Update () {

}

function OnGUI() {
	if( GUI.Button ( Rect(0,70*screenScale, Screen.width,100*screenScale),
			"Simple Movie" ) )
	{
		var callbackTargetName = "hud";	// callback target (GameObject), (default:null)
		var callbackMethodName = "OnDoneSimpleMovie";	// calback method name for the target (default:null)
		
		SimpleMovie.PlayMovie("mymovie", "dyson360eye", "mp4", callbackTargetName, callbackMethodName, 2 );
		
//		SimpleMovie.PlayMovieURL("http://example.com/movies/example.mp4", callbackTargetName, callbackMethodName);
	}
	
	GUI.Label (new Rect (0, 0, Screen.width, 50*screenScale), myMessage);
}

function OnDoneSimpleMovie( reason : String ) {
	// reason : "0" movie finished at the end, "2" movie quited by "Done" button. 
	myMessage = "Movie Done .. reason"+ reason;
}
