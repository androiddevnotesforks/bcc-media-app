package tv.brunstad.app

import android.annotation.SuppressLint
import android.content.res.Configuration
import android.os.Bundle
import android.os.PersistableBundle
import android.os.StrictMode
import android.view.View
import android.view.Window
import android.widget.FrameLayout
import io.flutter.embedding.android.FlutterFragmentActivity
import media.bcc.bccm_player.BccmPlayerPlugin
import media.bcc.bccm_player.views.FullscreenPlayerView

class MainActivity : FlutterFragmentActivity() {

    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        if (BuildConfig.DEBUG)
            StrictMode.enableDefaults();
        super.onCreate(savedInstanceState, persistentState)
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        requestWindowFeature(Window.FEATURE_ACTIVITY_TRANSITIONS);
    }

    @SuppressLint("MissingSuperCall")
    override fun onPictureInPictureModeChanged(
        isInPictureInPictureMode: Boolean,
        newConfig: Configuration
    ) {
        super.onPictureInPictureModeChanged(isInPictureInPictureMode, newConfig)
        val bccmPlayerPlugin = flutterEngine?.plugins?.get(BccmPlayerPlugin::class.javaObjectType)
        (bccmPlayerPlugin as? BccmPlayerPlugin)?.onPictureInPictureModeChanged(
            isInPictureInPictureMode
        );
    }

    override fun onStop() {
        val bccmPlayerPlugin = flutterEngine?.plugins?.get(BccmPlayerPlugin::class.javaObjectType)
        (bccmPlayerPlugin as? BccmPlayerPlugin)?.onStop();
        super.onStop()
    }

    override fun onBackPressed() {
        val rootLayout: FrameLayout =
            window.decorView.findViewById<View>(android.R.id.content) as FrameLayout;
        val view: View? = rootLayout.getChildAt(rootLayout.childCount - 1);
        if (view is FullscreenPlayerView) {
            view.exit();
        } else {
            super.onBackPressed();
        }
    }
}