package com.example.blue;

import android.Manifest;
import android.os.Build;
import android.content.pm.PackageManager;
import androidx.annotation.NonNull;
//import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
//
//class MainActivity: FlutterActivity() {
//    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//        GeneratedPluginRegistrant.registerWith(flutterEngine);
//
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
//            if (checkSelfPermission(Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
//                requestPermissions(arrayOf(Manifest.permission.ACCESS_FINE_LOCATION), 0);
//            }
//        }
//    }
//}
import com.klipwallet.app2app.api.Klip
import com.klipwallet.app2app.api.KlipCallback
import com.klipwallet.app2app.api.response.KlipErrorResponse
import com.klipwallet.app2app.api.response.KlipResponse
import com.klipwallet.app2app.exception.KlipRequestException
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel


class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.blue/klip"
    override fun configureFlutterEngine(@NonNull flutterEngine: io.flutter.embedding.engine.FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler { call, result ->
                    val klip: Klip = Klip.getInstance(this)
                    if (call.method.equals("getUserPermission")) {
                        try {
                            getUserPermission(klip, call.argument("requestKey"))
                            result.success("success permission")
                        } catch (e: KlipRequestException) {
                            e.printStackTrace()
                            result.error("UNAVAILABLE", "User address not available.", null)
                        }
                    } else {
                        result.notImplemented()
                    }
                }
    }

    @kotlin.Throws(KlipRequestException::class)
    fun getUserPermission(klip: Klip, requestKey: String?) {
        klip.request(requestKey)
    } /*
    public String getUserAddress(Klip klip, String requestKey) throws KlipRequestException {
        //final String[] requestKey = new String[1];
        final String[] result = new String[1];
        KlipCallback getResultCallback = new KlipCallback<KlipResponse>() {
            @Override
            public void onSuccess(final KlipResponse res) {
                if (res.getResult() != null) {
                    try {
                        result[0] = res.getResult().toJson().get("klaytn_address").toString();
                        System.out.println("################################################");
                        System.out.println("getResult onSuccess : " + result[0]);
                        System.out.println("################################################");
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }
                } else {
                    //System.out.println("################################################");
                    //System.out.println("################# getResult : result is null !!!");
                    //System.out.println("################################################");
                }
            }
            @Override
            public void onFail(final KlipErrorResponse res) {
                //System.out.println("################################################");
                //System.out.println("get result error: " + res.getErrorMsg());
                //System.out.println("################################################");
            }
        };
        klip.getResult(requestKey, getResultCallback);
        System.out.println("################################################");
        System.out.println("getResult return value : " + result[0]);
        System.out.println("################################################");
        return result[0];
    }
    */

    companion object {
        private const val CHANNEL = "com.example.blue/klip"
    }
}
