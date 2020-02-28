package me.sonics.teacher_app;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "me.sonics.teacher_app/AUDIO";
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);



    // Platform Channel
    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
            new MethodChannel.MethodCallHandler() {
              @java.lang.Override
              public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {

                if(methodCall.method.equals("sendAudio")){
                  String payload = "";
                }
              }
            }
    );
  }
}
