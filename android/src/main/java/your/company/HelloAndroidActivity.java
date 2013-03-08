package your.company;

import android.app.Activity;
import android.os.Bundle;
import android.os.StrictMode;
import android.util.Log;
import android.view.View;

import com.bugsnag.android.Bugsnag;
import com.bugsnag.android.BugsnagActivity;

public class HelloAndroidActivity extends BugsnagActivity {

    private static String TAG = "android";

    /**
     * Called when the activity is first created.
     * @param savedInstanceState If the activity is being re-initialized after 
     * previously being shut down then this Bundle contains the data it most 
     * recently supplied in onSaveInstanceState(Bundle). <b>Note: Otherwise it is null.</b>
     */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

        StrictMode.setThreadPolicy(new StrictMode.ThreadPolicy.Builder()
            .detectAll()
            .penaltyLog()
            .build());

        StrictMode.setVmPolicy(new StrictMode.VmPolicy.Builder()
            .detectAll()
            .penaltyLog()
            .build());

        Bugsnag.register(this, "8f5c0ec341d974b5e6fbdf16cb5cca3f", true);
    }

    public void notify(View view) {
        Bugsnag.notify(new RuntimeException("Shit broke in android"));
    }

    public void crash(View view) {
        throw new RuntimeException("Shit broke and caused a crash");
    }
}