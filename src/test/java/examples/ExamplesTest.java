package examples;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;

import cucumber.api.CucumberOptions;
import org.junit.jupiter.api.Test;
@CucumberOptions(
        features = {"src/test/java/examples/users/SpotifyUIChallenge.feature"},
        plugin = {
                "summary", "pretty","html:Reports/CucumberReport/Reports.html",
                "json:Reports/CucmberReport/Report",
                "com.evenstack.extentreports.cucumber.adapter.ExtentcucumberAdapter:"
        }
)
class ExamplesTest {

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:examples")
                .tags("~@ignore")
                //.outputCucumberJson(true)
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

}
