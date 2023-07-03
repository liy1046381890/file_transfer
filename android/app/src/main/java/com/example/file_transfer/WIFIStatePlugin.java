package com.example.file_transfer;

import android.app.Service;
import android.content.Context;
import android.net.wifi.WifiManager;
import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;

public class WIFIStatePlugin implements FlutterPlugin {

    private EventChannel eventChannel;
    private WIFIStateBroadcastReceiver receiver;

    private static volatile WIFIStatePlugin instance;

    public static WIFIStatePlugin getInstance() {
        if (instance == null) {
            synchronized (WIFIStatePlugin.class) {
                if (instance == null) {
                    instance = new WIFIStatePlugin();
                }
            }
        }
        return instance;
    }

    @Override
    public void onAttachedToEngine(FlutterPluginBinding binding) {
        BinaryMessenger messenger = binding.getBinaryMessenger();
        Context context = binding.getApplicationContext();

        this.eventChannel = new EventChannel(messenger, "com.example.file_transfer/wifiState");
        WifiManager wifiManager = (WifiManager) context.getSystemService(Service.WIFI);
        this.receiver = new WIFIStateBroadcastReceiver(context, wifiManager);
        this.eventChannel.setStreamHandler(this.receiver);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        this.eventChannel.setStreamHandler(null);
        this.receiver.onCancel(null);
        this.eventChannel = null;
        this.receiver = null;
    }
}