# helpcommand
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mkyong.model;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 *
 * @author khatn
 */
public class FlexibleExcelWriter {

    public void writeExcel(List<CheckingTranxResult> listBook, String tranxType, String excelFilePath) throws IOException {
        Workbook workbook = getWorkbook(excelFilePath);
        Sheet sheet = workbook.createSheet();

        int rowCount = 0;

        Row rowHeader = sheet.createRow(rowCount);
        writeHeader(tranxType, rowHeader, sheet);
        for (CheckingTranxResult aBook : listBook) {
            Row row = sheet.createRow(++rowCount);
            writeBody(aBook, tranxType, row, rowCount);
        }

        try (FileOutputStream outputStream = new FileOutputStream(excelFilePath)) {
            workbook.write(outputStream);
        }
    }

    private void writeBody(CheckingTranxResult aBook, String tranxType, Row row, int rowCount) {
        CellStyle dateStyle = row.getSheet().getWorkbook().createCellStyle();
        CellStyle numberStyle = row.getSheet().getWorkbook().createCellStyle();
        //Date format
        CreationHelper createHelper = row.getSheet().getWorkbook().getCreationHelper();
        short dateFormat = createHelper.createDataFormat().getFormat("dd/MM/yyyy HH:mm:ss");
        dateStyle.setDataFormat(dateFormat);

        Cell cell = row.createCell(0);
        cell.setCellValue(rowCount);
        cell = row.createCell(1);
        cell.setCellValue(aBook.getMerchantCode());
        cell = row.createCell(2);
        cell.setCellValue(aBook.getTransactionDate());
        cell.setCellStyle(dateStyle);

        //Number format
        DataFormat format = row.getSheet().getWorkbook().createDataFormat();
        numberStyle.setDataFormat(format.getFormat("###,###,###,###"));

        String cardNumber = aBook.getCardNumber();

        if (cardNumber != null && !"".equals(cardNumber)) {
            cardNumber = cardNumber.substring(0, 6) + "xxxx" + cardNumber.substring(cardNumber.length() - 4, cardNumber.length());
        }

        if (tranxType != null) {
            switch (tranxType) {
                case "DomesticEcom":
                    cell = row.createCell(3);
                    cell.setCellValue(aBook.getAcqBankCode());
                    cell = row.createCell(4);
                    cell.setCellValue(aBook.getIssuerBankCode());
                    cell = row.createCell(5);
                    cell.setCellValue(aBook.getTransactionRef());
                    cell = row.createCell(6);
                    cell.setCellValue(aBook.getTransactionInfo());
                    cell = row.createCell(7);
                    cell.setCellValue(aBook.getTransactionCode());
                    cell = row.createCell(8);
                    cell.setCellValue(aBook.getAmount());
                    cell.setCellStyle(numberStyle);
                    
                    cell = row.createCell(9);
                    cell.setCellValue(aBook.getResponseCode());
                    cell = row.createCell(10);
                    cell.setCellValue(aBook.getResponseDesc());
                    
                    cell = row.createCell(11);
                    cell.setCellValue(cardNumber);
                    cell = row.createCell(12);
                    cell.setCellValue(aBook.getCardHolderName());
                    cell = row.createCell(13);
                    cell.setCellValue("Domestic Ecom");
                    cell = row.createCell(14);
                    cell.setCellValue(aBook.getTransactionType());
                    cell = row.createCell(15);
                    cell.setCellValue(aBook.getIpAddress());
                    cell = row.createCell(16);
                    cell.setCellValue(aBook.getRuleTriggered());
                    break;
                case "DomesticToken":
                    cell = row.createCell(3);
                    cell.setCellValue(aBook.getOrderId());
                    cell = row.createCell(4);
                    cell.setCellValue(aBook.getTransactionCode());
                    cell = row.createCell(5);
                    cell.setCellValue(aBook.getTransactionInfo());
                    cell = row.createCell(6);
                    cell.setCellValue(aBook.getGatewayTranxid());
                    cell = row.createCell(7);
                    cell.setCellValue(aBook.getAmount());
                    cell.setCellStyle(numberStyle);
                    
                    cell = row.createCell(8);
                    cell.setCellValue(aBook.getResponseCode());
                    cell = row.createCell(9);
                    cell.setCellValue(aBook.getResponseDesc());
                    
                    cell = row.createCell(10);
                    cell.setCellValue(aBook.getToken());
                    cell = row.createCell(11);
                    cell.setCellValue(aBook.getCardHolderName());
                    cell = row.createCell(12);
                    cell.setCellValue("Dometic Token");
                    cell = row.createCell(13);
                    cell.setCellValue(aBook.getTransactionType());
                    cell = row.createCell(14);
                    cell.setCellValue(aBook.getIpAddress());
                    cell = row.createCell(15);
                    cell.setCellValue(aBook.getRuleTriggered());
                    break;
                case "InternationalEcom":
                    cell = row.createCell(3);
                    cell.setCellValue(aBook.getAcqBankCode());
                    cell = row.createCell(4);
                    cell.setCellValue(aBook.getIssuerBankCode());
                    cell = row.createCell(5);
                    cell.setCellValue(aBook.getOrderRef());
                    cell = row.createCell(6);
                    cell.setCellValue(aBook.getTransactionInfo());
                    cell = row.createCell(7);
                    cell.setCellValue(aBook.getTransactionCode());
                    cell = row.createCell(8);
                    cell.setCellValue(aBook.getAmount());
                    cell.setCellStyle(numberStyle);
                    
                    cell = row.createCell(9);
                    cell.setCellValue(aBook.getResponseCode());
                    cell = row.createCell(10);
                    cell.setCellValue(aBook.getResponseDesc());
                    
                    cell = row.createCell(11);
                    cell.setCellValue(cardNumber);
                    cell = row.createCell(12);
                    cell.setCellValue(aBook.getCardHolderName());
                    cell = row.createCell(13);
                    cell.setCellValue("International Ecom");
                    cell = row.createCell(14);
                    cell.setCellValue(aBook.getTransactionType());
                    cell = row.createCell(15);
                    cell.setCellValue(aBook.getIpAddress());
                    cell = row.createCell(16);
                    cell.setCellValue(aBook.getRuleTriggered());
                    break;
                case "InternationalToken":
                    cell = row.createCell(3);
                    cell.setCellValue(aBook.getOrderId());
                    cell = row.createCell(4);
                    cell.setCellValue(aBook.getOrderRef());
                    cell = row.createCell(5);
                    cell.setCellValue(aBook.getTransactionCode());
                    cell = row.createCell(6);
                    cell.setCellValue(aBook.getGatewayTranxid());
                    cell = row.createCell(7);
                    cell.setCellValue(aBook.getAmount());
                    cell.setCellStyle(numberStyle);
                    
                    cell = row.createCell(8);
                    cell.setCellValue(aBook.getResponseCode());
                    cell = row.createCell(9);
                    cell.setCellValue(aBook.getResponseDesc());
                    
                    cell = row.createCell(10);
                    cell.setCellValue(aBook.getToken());
                    cell = row.createCell(11);
                    cell.setCellValue(aBook.getCardHolderName());
                    cell = row.createCell(12);
                    cell.setCellValue("International Token");
                    cell = row.createCell(13);
                    cell.setCellValue(aBook.getTransactionType());
                    cell = row.createCell(14);
                    cell.setCellValue(aBook.getIpAddress());
                    cell = row.createCell(15);
                    cell.setCellValue(aBook.getRuleTriggered());
                    break;
                default:
                    break;
            }
        }
    }

    private void writeHeader(String tranxType, Row row, Sheet sheet) {
        CellStyle cellStyle = sheet.getWorkbook().createCellStyle();
        Font font = sheet.getWorkbook().createFont();
        font.setBold(true);
        font.setFontHeightInPoints((short) 12);
        cellStyle.setFont(font);

        Cell cell = row.createCell(0);
        cell.setCellValue("#.");
        cell.setCellStyle(cellStyle);
        cell = row.createCell(1);
        cell.setCellValue("MERCHANT_CODE");
        cell.setCellStyle(cellStyle);
        cell = row.createCell(2);
        cell.setCellValue("TRANSACTION_DATE");
        cell.setCellStyle(cellStyle);
        if (null != tranxType) {
            switch (tranxType) {
                case "DomesticEcom":
                    cell = row.createCell(3);
                    cell.setCellValue("ACQ_BANK_CODE");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(4);
                    cell.setCellValue("ISSUER_BANK_CODE");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(5);
                    cell.setCellValue("TRANSACTION_REF");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(6);
                    cell.setCellValue("TRANSACTION_INFO");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(7);
                    cell.setCellValue("TRANSACTION_CODE");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(8);
                    cell.setCellValue("AMOUNT");
                    cell.setCellStyle(cellStyle);
                    
                    cell = row.createCell(9);
                    cell.setCellValue("RESPONSE_CODE");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(10);
                    cell.setCellValue("TRANSACTION_STATUS");
                    cell.setCellStyle(cellStyle);
                    
                    cell = row.createCell(11);
                    cell.setCellValue("CARD_NUMBER");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(12);
                    cell.setCellValue("CARD_HOLDER_NAME");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(13);
                    cell.setCellValue("SERVICE");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(14);
                    cell.setCellValue("TRANSACTION_TYPE");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(15);
                    cell.setCellValue("IP_ADDRESS");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(16);
                    cell.setCellValue("RULE_TRIGGER");
                    cell.setCellStyle(cellStyle);
                    break;
                case "DomesticToken":
                    cell = row.createCell(3);
                    cell.setCellValue("ORDER_ID");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(4);
                    cell.setCellValue("TRANSACTION_CODE");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(5);
                    cell.setCellValue("TRANSACTION_INFO");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(6);
                    cell.setCellValue("GATEWAY_TRANX_ID");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(7);
                    cell.setCellValue("AMOUNT");
                    cell.setCellStyle(cellStyle);
                    
                    cell = row.createCell(8);
                    cell.setCellValue("RESPONSE_CODE");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(9);
                    cell.setCellValue("TRANSACTION_STATUS");
                    cell.setCellStyle(cellStyle);
                    
                    cell = row.createCell(10);
                    cell.setCellValue("TOKEN");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(11);
                    cell.setCellValue("CARD_HOLDER_NAME");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(12);
                    cell.setCellValue("SERVICE");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(13);
                    cell.setCellValue("TRANSACTION_TYPE");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(14);
                    cell.setCellValue("IP_ADDRESS");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(15);
                    cell.setCellValue("RULE_TRIGGER");
                    cell.setCellStyle(cellStyle);
                    break;
                case "InternationalEcom":
                    cell = row.createCell(3);
                    cell.setCellValue("ACQ_BANK_CODE");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(4);
                    cell.setCellValue("ISSUER_BANK_CODE");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(5);
                    cell.setCellValue("ORDER_REF");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(6);
                    cell.setCellValue("TRANSACTION_CODE");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(7);
                    cell.setCellValue("TRANSACTION_INFO");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(8);
                    cell.setCellValue("AMOUNT");
                    cell.setCellStyle(cellStyle);
                    
                    cell = row.createCell(9);
                    cell.setCellValue("RESPONSE_CODE");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(10);
                    cell.setCellValue("TRANSACTION_STATUS");
                    cell.setCellStyle(cellStyle);
                    
                    cell = row.createCell(11);
                    cell.setCellValue("CARD_NUMBER");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(12);
                    cell.setCellValue("CARD_HOLDER_NAME");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(13);
                    cell.setCellValue("SERVICE");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(14);
                    cell.setCellValue("TRANSACTION_TYPE");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(15);
                    cell.setCellValue("IP_ADDRESS");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(16);
                    cell.setCellValue("RULE_TRIGGER");
                    cell.setCellStyle(cellStyle);
                    break;
                case "InternationalToken":
                    cell = row.createCell(3);
                    cell.setCellValue("ORDER_ID");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(4);
                    cell.setCellValue("ORDER_REF");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(5);
                    cell.setCellValue("TRANSACTION_CODE");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(6);
                    cell.setCellValue("GATEWAY_TRANX_ID");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(7);
                    cell.setCellValue("AMOUNT");
                    cell.setCellStyle(cellStyle);
                    
                    cell = row.createCell(8);
                    cell.setCellValue("RESPONSE_CODE");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(9);
                    cell.setCellValue("TRANSACTION_STATUS");
                    cell.setCellStyle(cellStyle);
                    
                    cell = row.createCell(10);
                    cell.setCellValue("TOKEN");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(11);
                    cell.setCellValue("CARD_HOLDER_NAME");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(12);
                    cell.setCellValue("SERVICE");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(13);
                    cell.setCellValue("TRANSACTION_TYPE");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(14);
                    cell.setCellValue("IP_ADDRESS");
                    cell.setCellStyle(cellStyle);
                    cell = row.createCell(15);
                    cell.setCellValue("RULE_TRIGGER");
                    cell.setCellStyle(cellStyle);
                    break;
                default:
                    break;
            }
        }
    }

    private Workbook getWorkbook(String excelFilePath) throws IOException {
        Workbook workbook = null;

        if (excelFilePath.endsWith("xlsx")) {
            workbook = new XSSFWorkbook();
        } else if (excelFilePath.endsWith("xls")) {
            workbook = new HSSFWorkbook();
        } else {
            throw new IllegalArgumentException("The specified file is not Excel file");
        }

        return workbook;
    }
}
