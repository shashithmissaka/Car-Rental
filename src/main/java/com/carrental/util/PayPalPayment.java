package com.carrental.util;

import java.math.BigDecimal;

public class PayPalPayment {
    public static String processPayment(BigDecimal amount) {
        // Integration with PayPal API would go here
        // For now, returning a dummy transaction ID
        return "PAYPAL_TXN_" + System.currentTimeMillis();
    }
}
