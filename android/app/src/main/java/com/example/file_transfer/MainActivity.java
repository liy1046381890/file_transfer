package com.example.file_transfer;

import android.os.Bundle;
import android.util.Log;
import androidx.annotation.Nullable;
import io.flutter.embedding.android.FlutterActivity;


public class MainActivity extends FlutterActivity {
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Log.d("android", "WIFI State");
        WIFIStatePlugin plugin = WIFIStatePlugin.getInstance();
        getFlutterEngine().getPlugins().add(plugin);
    }
}
