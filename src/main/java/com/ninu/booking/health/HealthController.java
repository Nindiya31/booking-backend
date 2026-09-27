package com.ninu.booking.health;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.Instant;
import java.util.Map;

/**
 * Phase 1 sanity check: proves the backend is up and the frontend can reach it.
 */
@RestController
public class HealthController {

    @GetMapping("/api/health")
    public Map<String, Object> health() {
        return Map.of(
                "status", "UP",
                "service", "booking-backend",
                "timestamp", Instant.now().toString()
        );
    }
}
