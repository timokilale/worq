package africa.shulesoft.attendance;

import android.Manifest;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.*;
import android.provider.Settings;
import android.util.Log;
import android.widget.Toast;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import com.hfteco.finger.*;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

import java.io.ByteArrayOutputStream;
import java.util.List;

public class MainActivity extends FlutterActivity {

    private static final String TAG = MainActivity.class.getSimpleName();
    private static final String CHANNEL = "africa.shulesoft.attendance/device-sdk";
    private FingerSDK fingerSDK;
    public static String ACCOUNT = "SZBOSWSBKJ";
    public static String PASSWORD = "a399a5499964ec102bbbcd8531fc7a1a";
    List<FingerSDK.TEMPLEATES> templeatesList = FingerSDK.TEMPLEATES.getTempleatesList();
    boolean requstPermission = false;
    boolean requestStorage = false;
    private boolean deviceModelNameCheck = false;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler((call, result) -> {
            if (call.method.equals("initFingerprintDevice")) {
                Log.i(TAG, "Invoked - initFingerprintDevice()");
                fingerSDK = new FingerSDK(getApplicationContext());
                fingerSDK.init(new OnSdkInitListener() {
                    @Override
                    public void initResult(int i, String s) {
                        Log.i(TAG, "Invoked - initResult()");
                        new Handler(Looper.getMainLooper()).post(new Runnable() {
                            @Override
                            public void run() {
                                Log.i(TAG, "Invoked - Runnable() => run()");
                                if (i != FingerSDK.RESULT_OK) {
                                    Log.i(TAG, "Could not initialize device");
                                } else {
                                    Log.i(TAG, "Everything is working just fine");
                                }
                            }
                        });
                    }
                }, ACCOUNT, PASSWORD);
            }

            if (call.method.equals("enrollFingerprint") && deviceModelNameCheck) {
                Log.i(TAG, "Invoked - enrollFingerprint()");
                String userId = call.argument("userId");
                Log.i(TAG, "User ID: " + userId);

                // Add more robust error handling
                if (fingerSDK == null) {
                    Log.e(TAG, "FingerSDK not initialized");
                    result.error("SDK_NOT_INITIALIZED", "Fingerprint SDK is not initialized", null);
                    return;
                }

                fingerSDK.enroll(userId, new OnEnrollListener() {
                    @Override
                    public void enroll(int resultCode, Bitmap bitmap, String errorMsg) {
                        Log.i(TAG, "Enrollment Result Code: " + resultCode);
                        Log.i(TAG, "Error Message: " + errorMsg);

                        switch (resultCode) {
                            case FingerSDK.RESULT_OK:
                                // Success case
                                updateFingerBitmap(bitmap);
                                ByteArrayOutputStream stream = new ByteArrayOutputStream();
                                bitmap.compress(Bitmap.CompressFormat.PNG, 100, stream);
                                byte[] byteArray = stream.toByteArray();
                                result.success(byteArray);
                                bitmap.recycle();
                                Log.i(TAG, "Enrollment success. User ID: " + userId);
                                break;
                            default:
                                result.error("ENROLLMENT_FAILED", "Fingerprint enrollment failed. Code: " + resultCode, null);
                                break;
                        }
                    }
                }, FingerSDK.TEMPLEATES.GAT_1012_2019);
            }

            if (call.method.equals("verifyFingerprint") && deviceModelNameCheck) {
                Log.i(TAG, "Invoked - verifyFingerprint");
                fingerSDK.search(new OnSearchListener() {
                    @Override
                    public void search(String userId, Bitmap bitmap) {
                        if (userId != null) {
                            updateFingerBitmap(bitmap);
                            Log.i(TAG, "User found " + userId);
                            result.success(userId);
                        } else {
                            Log.i(TAG, "User NOT found");
                            result.success("NOT_FOUND");
                            if (bitmap != null) {
                                updateFingerBitmap(bitmap);
                            }
                        }
                    }
                }, FingerSDK.TEMPLEATES.GAT_1012_2019);
            }
        });
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        deviceModelNameCheck = FingerSDK.licenceDevice();
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (checkSelfPermission(Manifest.permission.READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED || checkSelfPermission(Manifest.permission.WRITE_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED || checkSelfPermission(Manifest.permission.READ_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED) {
                requestPermissions(new String[]{Manifest.permission.CAMERA, Manifest.permission.READ_PHONE_STATE, Manifest.permission.READ_EXTERNAL_STORAGE, Manifest.permission.WRITE_EXTERNAL_STORAGE}, 0);
                return;
            }
        }
        requstPermission = true;

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            boolean manage = Environment.isExternalStorageManager();
            if (!manage) {
                try {
                    Intent intent = new Intent(Settings.ACTION_MANAGE_APP_ALL_FILES_ACCESS_PERMISSION);
                    intent.addCategory("android.intent.category.DEFAULT");
                    intent.setData(Uri.parse("package:" + getPackageName()));
                    startActivity(intent);
                } catch (Exception e) {
                    Intent intent = new Intent();
                    intent.setAction(Settings.ACTION_MANAGE_ALL_FILES_ACCESS_PERMISSION);
                    startActivity(intent);
                }
                return;
            }
        }
        requestStorage = true;
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        for (int grantResult : grantResults) {
            if (grantResult != PackageManager.PERMISSION_GRANTED) {
                new AlertDialog.Builder(this).setTitle("Sorry !").setMessage("We can't run without those permissions !").setPositiveButton("Exit", (dialog, which) -> finish()).setCancelable(false).show();
                return;
            }
        }

        requstPermission = true;

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            boolean manage = Environment.isExternalStorageManager();
            if (!manage) {
                try {
                    Intent intent = new Intent(Settings.ACTION_MANAGE_APP_ALL_FILES_ACCESS_PERMISSION);
                    intent.addCategory("android.intent.category.DEFAULT");
                    intent.setData(Uri.parse("package:" + getPackageName()));
                    startActivity(intent);
                } catch (Exception e) {
                    Intent intent = new Intent();
                    intent.setAction(Settings.ACTION_MANAGE_ALL_FILES_ACCESS_PERMISSION);
                    startActivity(intent);
                }
                return;
            }
        }
        requestStorage = true;
        buildSdk();
    }

    private void buildSdk() {
        if (requestStorage && requstPermission) {
            initSDK();
        }
    }

    public void initSDK() {
        fingerSDK = new FingerSDK(getApplicationContext());
        initFunction();
    }

    private void initFunction() {
        if (fingerSDK == null) {
            fingerSDK = new FingerSDK(getApplicationContext());
        }

        fingerSDK.init(new OnSdkInitListener() {
            @Override
            public void initResult(int resultCode, String message) {
                runOnUiThread(() -> {
                    Log.d(TAG, "SDK Init Result: " + resultCode + " - " + message);

                    if (resultCode != FingerSDK.RESULT_OK) {
                        // More detailed logging
                        Log.e(TAG, "SDK Initialization Failed. Code: " + resultCode + ", Message: " + message);

                        AlertDialog retryDialog = new AlertDialog.Builder(MainActivity.this)
                                .setCancelable(false)
                                .setTitle("SDK Initialization")
                                .setMessage("Failed to initialize fingerprint SDK. Error: " + message)
                                .setPositiveButton("Try Again", (dialog, which) -> {
                                    dialog.dismiss();
                                    initFunction();
                                })
                                .setNegativeButton("Cancel", (dialog, which) -> finish())
                                .create();
                        retryDialog.show();
                    } else {
                        Log.i(TAG, "SDK Initialized Successfully");
                    }
                });
            }
        }, ACCOUNT, PASSWORD);
    }

    private void updateFingerBitmap(Bitmap bitmap) {
        Log.i(TAG, "Invoked - updateFingerBitmap()");
        if (bitmap == null) return;

        new Handler(Looper.getMainLooper()).post(new Runnable() {
            @Override
            public void run() {
            }
        });
    }

    @Override
    protected void onResume() {
        super.onResume();

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            boolean manage = Environment.isExternalStorageManager();
            if (!manage) {
                try {
                    Intent intent = new Intent(Settings.ACTION_MANAGE_APP_ALL_FILES_ACCESS_PERMISSION);
                    intent.addCategory("android.intent.category.DEFAULT");
                    intent.setData(Uri.parse("package:" + getPackageName()));
                    startActivity(intent);
                } catch (Exception e) {
                    Intent intent = new Intent();
                    intent.setAction(Settings.ACTION_MANAGE_ALL_FILES_ACCESS_PERMISSION);
                    startActivity(intent);
                }
                return;
            }
        }
        requestStorage = true;
        buildSdk();
    }

    @Override
    protected void onPause() {
        super.onPause();
    }

    @Override
    protected void onDestroy() {
        fingerSDK.release();
        super.onDestroy();
    }

}
