package com.carrental.util;

import com.carrental.model.Booking;
import com.carrental.model.Driver;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;

public class PDFGenerator {

    public static ByteArrayOutputStream generateReceipt(Booking booking, Driver driver, String transactionId) throws DocumentException, IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        Document document = new Document();
        PdfWriter.getInstance(document, baos);
        document.open();

        // Add Company Logo (Using Absolute Path for Testing)
        try {
            Image logo = Image.getInstance("C:\\Users\\Shashith Missaka\\eclipse-workspace\\ColomboCarRental\\src\\main\\resources\\static\\images\\1.png");
            logo.scaleAbsolute(100, 100);
            logo.setAlignment(Element.ALIGN_CENTER);
            document.add(logo);
        } catch (Exception e) {
            System.out.println("Error loading logo: " + e.getMessage());
        }

        // Receipt Header
        Font headerFont = new Font(Font.FontFamily.HELVETICA, 22, Font.BOLD, BaseColor.BLUE);
        Paragraph header = new Paragraph("RECEIPT", headerFont);
        header.setAlignment(Element.ALIGN_CENTER);
        header.setSpacingAfter(10f);
        document.add(header);

        // Add Booking Details Table
        PdfPTable table = new PdfPTable(2);
        table.setWidthPercentage(100);
        table.setSpacingBefore(10f);
        table.setSpacingAfter(10f);
        table.setWidths(new float[]{3, 7});

        // Styling Table Header
        Font tableHeaderFont = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD, BaseColor.WHITE);
        PdfPCell headerCell;

        headerCell = new PdfPCell(new Phrase("Details", tableHeaderFont));
        headerCell.setBackgroundColor(BaseColor.DARK_GRAY);
        headerCell.setColspan(2);
        headerCell.setHorizontalAlignment(Element.ALIGN_CENTER);
        headerCell.setPadding(5);
        table.addCell(headerCell);

        // Adding Booking Data
        addTableRow(table, "Booking ID", String.valueOf(booking.getId()));
        addTableRow(table, "Customer", booking.getUsername());
        addTableRow(table, "Total Amount Paid", "Rs. " + booking.getFinalPrice());
        addTableRow(table, "Transaction ID", transactionId);
        addTableRow(table, "Payment Status", booking.getPaymentStatus());
        addTableRow(table, "Driver Assigned", driver.getDriverName() + " (" + driver.getPhone() + ")");

        document.add(table);

        // Add QR Code
        Image qrCode = generateQRCode(transactionId);
        if (qrCode != null) {
            qrCode.scaleAbsolute(120, 120);
            qrCode.setAlignment(Element.ALIGN_CENTER);
            document.add(qrCode);
        }

        // Footer with Thank You Message
        Font footerFont = new Font(Font.FontFamily.HELVETICA, 12, Font.ITALIC, BaseColor.DARK_GRAY);
        Paragraph footer = new Paragraph("\nThank you for choosing Colombo Car Rental!", footerFont);
        footer.setAlignment(Element.ALIGN_CENTER);
        document.add(footer);

        // Signature Line
        Paragraph signature = new Paragraph("\nAuthorized Signature: ______________________");
        signature.setAlignment(Element.ALIGN_RIGHT);
        document.add(signature);

        // Add Social Media Icons and Links
        addSocialMediaFooter(document);

        document.close();
        return baos;
    }

    // Helper method for adding rows to the table
    private static void addTableRow(PdfPTable table, String column1, String column2) {
        Font cellFont = new Font(Font.FontFamily.HELVETICA, 12);
        PdfPCell cell1 = new PdfPCell(new Phrase(column1, cellFont));
        cell1.setPadding(5);
        cell1.setBackgroundColor(BaseColor.LIGHT_GRAY);
        PdfPCell cell2 = new PdfPCell(new Phrase(column2, cellFont));
        cell2.setPadding(5);
        table.addCell(cell1);
        table.addCell(cell2);
    }

    // Method to generate a QR Code
    private static Image generateQRCode(String data) throws DocumentException, IOException {
        try {
            QRCodeWriter qrCodeWriter = new QRCodeWriter();
            BitMatrix bitMatrix = qrCodeWriter.encode(data, BarcodeFormat.QR_CODE, 150, 150);
            BufferedImage bufferedImage = new BufferedImage(150, 150, BufferedImage.TYPE_INT_RGB);

            for (int x = 0; x < 150; x++) {
                for (int y = 0; y < 150; y++) {
                    bufferedImage.setRGB(x, y, bitMatrix.get(x, y) ? 0x000000 : 0xFFFFFF);
                }
            }

            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            ImageIO.write(bufferedImage, "png", baos);
            return Image.getInstance(baos.toByteArray());
        } catch (WriterException e) {
            System.out.println("Error generating QR Code: " + e.getMessage());
            return null;
        }
    }
 // Method to add centered social media icons and links
    private static void addSocialMediaFooter(Document document) throws DocumentException, IOException {
        PdfPTable socialMediaTable = new PdfPTable(4);
        socialMediaTable.setWidthPercentage(80); // Reduce width for better centering
        socialMediaTable.setHorizontalAlignment(Element.ALIGN_CENTER);
        socialMediaTable.setSpacingBefore(20f);
        socialMediaTable.setSpacingAfter(10f);

        // Add social media icons and links
        addSocialMediaIcon(socialMediaTable, "C:\\Users\\Shashith Missaka\\eclipse-workspace\\ColomboCarRental\\src\\main\\resources\\static\\images\\youtube.png", "YouTube", "ColomboCarRental");
        addSocialMediaIcon(socialMediaTable, "C:\\Users\\Shashith Missaka\\eclipse-workspace\\ColomboCarRental\\src\\main\\resources\\static\\images\\facebook.png", "Facebook", "ColomboCarRental");
        addSocialMediaIcon(socialMediaTable, "C:\\Users\\Shashith Missaka\\eclipse-workspace\\ColomboCarRental\\src\\main\\resources\\static\\images\\whatsapp.png", "WhatsApp", "0773953578");
        addSocialMediaIcon(socialMediaTable, "C:\\Users\\Shashith Missaka\\eclipse-workspace\\ColomboCarRental\\src\\main\\resources\\static\\images\\instagram.png", "Instagram", "ColomboCarRental");

        document.add(socialMediaTable);
    }


    // Helper method to add social media icons and links
    private static void addSocialMediaIcon(PdfPTable table, String iconPath, String altText, String link) throws DocumentException, IOException {
        try {
            Image icon = Image.getInstance(iconPath);
            icon.scaleAbsolute(20, 20);
            PdfPCell iconCell = new PdfPCell(icon);
            iconCell.setHorizontalAlignment(Element.ALIGN_CENTER);
            iconCell.setBorder(PdfPCell.NO_BORDER);
            iconCell.setPadding(5);

            // Add the link as a phrase below the icon
            Font linkFont = new Font(Font.FontFamily.HELVETICA, 10, Font.NORMAL, BaseColor.BLUE);
            Phrase linkPhrase = new Phrase(altText + "\n" + link, linkFont);
            PdfPCell linkCell = new PdfPCell(linkPhrase);
            linkCell.setHorizontalAlignment(Element.ALIGN_CENTER);
            linkCell.setBorder(PdfPCell.NO_BORDER);
            linkCell.setPadding(5);

            // Add both cells to the table
            table.addCell(iconCell);
            table.addCell(linkCell);
        } catch (Exception e) {
            System.out.println("Error loading social media icon: " + e.getMessage());
        }
    }
}