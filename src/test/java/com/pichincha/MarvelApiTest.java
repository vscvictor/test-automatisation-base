package com.pichincha;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class MarvelApiTest {

    @Test
    void testMarvelApi() {
        Results results = Runner.path("classpath:com/pichincha/features/marvel_characters_api")
                .tags("~@ignore")
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}
