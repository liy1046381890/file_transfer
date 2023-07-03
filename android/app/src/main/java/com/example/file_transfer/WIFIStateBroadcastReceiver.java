package com.example.file_transfer;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.NetworkInfo;
import android.net.wifi.WifiManager;
import android.os.Handler;
import android.os.Looper;
import android.os.Parcelable;
import android.util.Log;
import io.flutter.plugin.common.EventChannel;

import java.net.Inet4Address;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.util.*;


public class WIFIStateBroadcastReceiver extends BroadcastReceiver implements EventChannel.StreamHandler {
    private final Context context;
    private final WifiManager wifiManager;
    private EventChannel.EventSink events;

    private final Handler mainHandler = new Handler(Looper.getMainLooper());

    private final String WIFI_AP_STATE_CHANGED_ACTION = "android.net.wifi.WIFI_AP_STATE_CHANGED";
    private final String TAG = "flutter";

    private HashMap<String, String> map = new HashMap();
    private final String WIFI_KEY = "wifi";
    private final String WIFI_AP_KEY = "wifiAP";

    public WIFIStateBroadcastReceiver(Context context, WifiManager wifiManager) {
        this.context = context;
        this.wifiManager = wifiManager;
    }

    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        this.events = events;
        IntentFilter filter = new IntentFilter();
        filter.addAction(WifiManager.WIFI_AP_STATE_CHANGED_ACTION);
        filter.addAction(WifiManager.NETWORK_STATE_CHANGED_ACTION);
        filter.addAction(WIFI_AP_STATE_CHANGED_ACTION);
        this.context.registerReceiver(this, filter);
    }

    @Override
    public void onCancel(Object arguments) {
        try {
            this.context.unregisterReceiver(this);
        } catch (Exception e) {
        }
    }

    @Override
    public void onReceive(Context context, Intent intent) {
        String action = intent.getAction();
        if (action.equals(WifiManager.WIFI_AP_STATE_CHANGED_ACTION)) {
            //WIFI服务状态
            int state = intent.getIntExtra(WifiManager.EXTRA_WIFI_STATE, WifiManager.WIFI_STATE_DISABLED);
            if (state == WifiManager.WIFI_STATE_DISABLED) {
                Log.d(TAG, "系统关闭wifi");
            } else if (state == WifiManager.WIFI_STATE_ENABLED) {
                Log.d(TAG, "系统开启wifi");
            }
        } else if (action.equals(WifiManager.NETWORK_STATE_CHANGED_ACTION)) {
            //WIFI网络连接状态
            Parcelable parcelableExtra = intent.getParcelableExtra(WifiManager.EXTRA_NETWORK_INFO);
            if (parcelableExtra != null) {
                NetworkInfo networkInfo = (NetworkInfo) parcelableExtra;
                NetworkInfo.State state2 = networkInfo.getState();
                if (state2.equals(NetworkInfo.State.DISCONNECTED)) {
                    Log.d(TAG, "wifi网络连接断开");
                    this.map.put(WIFI_KEY, "");
                    sendEventData(this.map);
                } else if (state2.equals(NetworkInfo.State.CONNECTED)) {
                    int ipAddress = this.wifiManager.getConnectionInfo().getIpAddress();
                    String ip = String.format(Locale.SIMPLIFIED_CHINESE, "%d.%d.%d.%d", ipAddress & 255,
                            (ipAddress >> 8) & 255, (ipAddress >> 16) & 255, (ipAddress >> 24) & 255);
                    Log.d(TAG, "wifi网络连接已连接, ip: " + ip);
                    this.map.put(WIFI_KEY, ip);
                    sendEventData(this.map);
                }
            }
        } else if (WIFI_AP_STATE_CHANGED_ACTION.equals(action)) {
            // 便携式热点状态
            // 10:关闭中, 11:已关闭, 12:开启中, 13:已开启, 14:操作失败
            int state3 = intent.getIntExtra("wifi_state", 0);
            if (state3 == 13) {
                // WifiManager.WIFI_AP_STATE_ENABLED
                this.mainHandler.postDelayed(() -> {
                    try {
                        flag:
                        {
                            for (NetworkInterface networkInterface : Collections.list(NetworkInterface.getNetworkInterfaces())) {
                                if (networkInterface.getName().toLowerCase().contains("wlan")) {
                                    for (InetAddress inetAddress : Collections.list(networkInterface.getInetAddresses())) {
                                        if (inetAddress instanceof Inet4Address) {
                                            String ipAddress = inetAddress.getHostAddress();
                                            if (ipAddress != null && ipAddress.startsWith("192.168.")) {
                                                Log.d(TAG, "热点已开启, ip: " + ipAddress);
                                                this.map.put(WIFI_AP_KEY, ipAddress);
                                                sendEventData(this.map);
                                                break flag;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    } catch (SocketException e7) {
                        e7.printStackTrace();
                    }
                }, 500);
            } else if (state3 == 11) {
                // WifiManager.WIFI_AP_STATE_DISABLED
                Log.d(TAG, "热点已关闭");
                this.map.put(WIFI_AP_KEY, "");
                sendEventData(this.map);
            }
        }
    }

    private void sendEventData(Object data) {
        if (this.events != null) {
            this.events.success(data);
        }
    }
}