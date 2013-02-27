import com.bugsnag.Client;

public class App {
    public static void main( String[] args ) {
        Client c = new Client("8f5c0ec341d974b5e6fbdf16cb5cca3f");
        c.addToTab("User", "name", "james");
        c.addToTab("User", "email", "james@loopj.com");
        c.addToTab("Custom", "password", "secretsecret");
        c.addToTab("Custom", "credit_card", "1234567890");
        // c.notify(new RuntimeException("Something broke"));

        throw new RuntimeException("Should be auto handled!");
    }
}
