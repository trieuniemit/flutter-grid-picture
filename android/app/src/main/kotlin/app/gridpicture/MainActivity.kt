package app.gridpicture

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        ImageCrop.registerWith(this, flutterEngine!!.dartExecutor.binaryMessenger);
    }
}
