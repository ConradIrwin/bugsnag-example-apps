package your.company;

import android.app.Activity;
import android.os.Bundle;
import android.os.StrictMode;
import android.util.Log;
import android.view.View;
import java.io.IOException;

import com.bugsnag.android.Bugsnag;
import com.bugsnag.android.activity.BugsnagActivity;
import com.bugsnag.MetaData;

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
        StrictMode.setThreadPolicy(new StrictMode.ThreadPolicy.Builder()
                 .detectDiskReads()
                 .detectDiskWrites()
                 .detectAll()   // or .detectAll() for all detectable problems
                 .penaltyDeath()
                 .build());
         StrictMode.setVmPolicy(new StrictMode.VmPolicy.Builder()
                 .detectLeakedSqlLiteObjects()
                 .detectLeakedClosableObjects()
                 .penaltyLog()
                 .penaltyDeath()
                 .build());
        
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

        findViewById(R.id.notify).setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                MetaData meta = new MetaData();
                meta.addToTab("User", "key2", "value2");
                Bugsnag.notify(new RuntimeException("Stuff broke in android"), meta);
            }
        });

        findViewById(R.id.crash).setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                throw new RuntimeException("Stuff broke and caused a crash");
            }
        });

        Bugsnag.register(this, "6796ac4207703a9c343bf7777587a4dd");
        Bugsnag.setUser("id", "email", "name");
        Bugsnag.addToTab("User", "key1", "value1");
        Bugsnag.setEndpoint("192.168.1.130:8000");
    }
}