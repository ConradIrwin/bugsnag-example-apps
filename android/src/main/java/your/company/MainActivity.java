package your.company;

import android.os.Bundle;

import com.bugsnag.android.Bugsnag;
import com.bugsnag.android.BugsnagActivity;

public class MainActivity extends BugsnagActivity {
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        Bugsnag.register(this, "903392d99d316e945ece620507c06835");
        int i = 1 / 0;
    }
}