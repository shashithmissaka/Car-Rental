package com.carrental.util;

import java.math.BigDecimal;

public class StripePayment {
    public static String processPayment(BigDecimal amount) {
        // Integration with Stripe API would go here
        // For now, returning a dummy transaction ID
        return "STRIPE_TXN_" + System.currentTimeMillis();
    }
}
