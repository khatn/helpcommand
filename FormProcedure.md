# helpcommand
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package formappdemo;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.table.DefaultTableModel;
import oracle.jdbc.internal.OracleTypes;
import utils.ConnectionUtils;

/**
 *
 * @author Lenovo
 */
public class CustomerForm extends javax.swing.JFrame {

    /**
     * Creates new form Customer
     *
     * @throws java.sql.SQLException
     */
    public CustomerForm() throws SQLException {
        initComponents();
        loadData(null, null, null, null);
    }

                        

    private void btnAddActionPerformed(java.awt.event.ActionEvent evt) {                                       
        // TODO add your handling code here:
        String sql;
        CallableStatement stm = null;
        try {
            if ("".equals(txtBranchCode.getText())) {
                lblInfo.setText("Please input branch code");
                return;
            }
            if ("".equals(txtCustomerName.getText())) {
                lblInfo.setText("Please input customer name");
                return;
            }
            if ("".equals(txtIdentifyCard.getText())) {
                lblInfo.setText("Please input identify card no");
                return;
            }
            if ("".equals(txtCifNo.getText())) {
                lblInfo.setText("Please input Cif no");
                return;
            }
            sql = "{call DEMO.INSERT_CUSTOMER(?,?,?,?)}";
            ConnectionUtils.connectDB();
            stm = ConnectionUtils.callStatement(sql);
            stm.setString(1, txtBranchCode.getText());
            stm.setString(2, txtCustomerName.getText());
            stm.setString(3, txtIdentifyCard.getText());
            stm.setString(4, txtCifNo.getText());
            stm.execute();
            lblInfo.setText("Insert customer successfully");

        } catch (Exception e) {
            lblInfo.setText("Error");
            e.printStackTrace();
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                    ConnectionUtils.closeConnection();
                } catch (SQLException ex) {
                    Logger.getLogger(CustomerForm.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

    }                                      

    private void btnSearchActionPerformed(java.awt.event.ActionEvent evt) {                                          
        // TODO add your handling code here:
        ResultSet rs;
        Statement st;
        String sql;
        CallableStatement stm;
        try {
            sql = "SELECT branch_code, customer_name, identify_card, cif FROM CUSTOMER  WHERE 1=1 ";
            if (txtBranchCode.getText() != null) {
                sql += "AND branch_code like '%" + txtBranchCode.getText() + "%'";
            }
            if (txtBranchCode.getText() != null) {
                sql += "AND customer_name like '%" + txtCustomerName.getText() + "%'";
            }
            if (txtBranchCode.getText() != null) {
                sql += "AND identify_card like '%" + txtIdentifyCard.getText() + "%'";
            }
            if (txtBranchCode.getText() != null) {
                sql += "AND cif like '%" + txtCifNo.getText() + "%'";
            }

            ConnectionUtils.connectDB();
            //st = ConnectionUtils.connect.createStatement();
            //rs = st.executeQuery(sql);

//            if (!rs.isBeforeFirst()) {
//                lblInfo.setText("No data found");
//            }
//            Vector row;
//            DefaultTableModel model = (DefaultTableModel) tblData.getModel();
//            while (rs.next()) {
//                row = new Vector();
//                row.add(rs.getString("id"));
//                row.add(rs.getString("branch_code"));
//                row.add(rs.getString("customer_name"));
//                row.add(rs.getString("identify_no"));
//                row.add(rs.getString("cif"));
//                model.addRow(row);
//            }
            //New
            Vector data;
            CallableStatement cs;
            DefaultTableModel model = (DefaultTableModel) tblData.getModel();
            model.setRowCount(0);
            sql = "{ call DEMO.GET_ALL_CUSTOMER(?,?,?,?,?,?)}";
            cs = ConnectionUtils.callStatement(sql);
            cs.setString(1, "" == txtBranchCode.getText() ? null : txtBranchCode.getText());
            cs.setString(2, "" == txtCustomerName.getText() ? null : txtCustomerName.getText());
            cs.setString(3, "" == txtIdentifyCard.getText() ? null : txtIdentifyCard.getText());
            cs.setString(4, "" == txtCifNo.getText() ? null : txtCifNo.getText());
            cs.registerOutParameter(5, OracleTypes.NUMBER);
            cs.registerOutParameter(6, OracleTypes.CURSOR);

            cs.execute();
            rs = (ResultSet) cs.getObject(6);
            if (!rs.isBeforeFirst()) {
                lblInfo.setText("No data found");
            }

            while (rs.next()) {
                data = new Vector();
                data.add(rs.getString("STT"));
                data.add(rs.getString("ID"));
                data.add(rs.getString("BRANCH_CODE"));
                data.add(rs.getString("CUSTOMER_NAME"));
                data.add(rs.getString("IDENTIFY_NO"));
                data.add(rs.getString("CIF"));
                model.addRow(data);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }                                         

    private void loadData(String branchCode, String customerName, String identifyNo, String cif) throws SQLException {
        ResultSet rs;
        CallableStatement cs;
        try {
            ConnectionUtils.connectDB();
            String sql = "{call DEMO.GET_ALL_CUSTOMER(?,?,?,?,?,?)}";
            cs = ConnectionUtils.callStatement(sql);

            cs.setString(1, branchCode == "" ? null : branchCode);
            cs.setString(2, customerName == "" ? null : customerName);
            cs.setString(3, identifyNo == "" ? null : identifyNo);
            cs.setString(4, cif == "" ? null : cif);
            cs.registerOutParameter(5, OracleTypes.NUMBER);
            cs.registerOutParameter(6, OracleTypes.CURSOR);

            cs.execute();
            rs = (ResultSet) cs.getObject(6);

            if (!rs.isBeforeFirst()) {
                lblInfo.setText("No data found");
            }

            DefaultTableModel model = (DefaultTableModel) tblData.getModel();
            model.setRowCount(0);
            Vector data;
            while (rs.next()) {
                data = new Vector();
                data.add(rs.getString("STT"));
                data.add(rs.getString("ID"));
                data.add(rs.getString("BRANCH_CODE"));
                data.add(rs.getString("CUSTOMER_NAME"));
                data.add(rs.getString("IDENTIFY_NO"));
                data.add(rs.getString("CIF"));
                model.addRow(data);
            }

        } catch (Exception e) {
            ConnectionUtils.closeConnection();
            e.printStackTrace();
        }
    }

    private void resetData() {
        txtBranchCode.setText("");
        txtCustomerName.setText("");
        txtIdentifyCard.setText("");
        txtCifNo.setText("");
        lblID.setText("");
    }

    private void btnRefreshActionPerformed(java.awt.event.ActionEvent evt) {                                           
        // TODO add your handling code here:
        txtBranchCode.setText("");
        txtCustomerName.setText("");
        txtIdentifyCard.setText("");
        txtCifNo.setText("");
    }                                          

    private void btnEditActionPerformed(java.awt.event.ActionEvent evt) {                                        
        // TODO add your handling code here:
        ResultSet rs = null;
        CallableStatement st = null;
        try {
            if (tblData.getSelectedRow() == -1) {
                lblInfo.setText("Please select row to edit");
                return;
            }
            if ("".equals(txtBranchCode.getText())) {
                lblInfo.setText("Please input branch code");
                return;
            }
            if ("".equals(txtCustomerName.getText())) {
                lblInfo.setText("Please input customer name");
                return;
            }
            if ("".equals(txtIdentifyCard.getText())) {
                lblInfo.setText("Please input identify number");
                return;
            }
            if ("".equals(txtCifNo.getText())) {
                lblInfo.setText("Please input cif no");
                return;
            }

            String sql = "{ call DEMO.UPDATE_CUSTOMER(?,?,?,?,?)}";

            ConnectionUtils.connectDB();
            st = ConnectionUtils.callStatement(sql);
            st.setInt(1, Integer.parseInt(lblID.getText()));
            st.setString(2, txtBranchCode.getText());
            st.setString(3, txtCustomerName.getText());
            st.setString(4, txtIdentifyCard.getText());
            st.setString(5, txtCifNo.getText());
            st.execute(sql);
            lblInfo.setText("Update successfully!");
            resetData();
            loadData(null, null, null, null);

        } catch (Exception e) {
            lblInfo.setText("An error occur.");
            e.printStackTrace();

        } finally {
            try {
                ConnectionUtils.closeConnection();
            } catch (SQLException ex) {
                Logger.getLogger(CustomerForm.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }                                       

    private void tblDataMouseClicked(java.awt.event.MouseEvent evt) {                                     
        // TODO add your handling code here:
        DefaultTableModel model = (DefaultTableModel) tblData.getModel();
        lblID.setText(model.getValueAt(tblData.getSelectedRow(), 1).toString());
        txtBranchCode.setText(model.getValueAt(tblData.getSelectedRow(), 2).toString());
        txtCustomerName.setText(model.getValueAt(tblData.getSelectedRow(), 3).toString());
        txtIdentifyCard.setText(model.getValueAt(tblData.getSelectedRow(), 4).toString());
        txtCifNo.setText(model.getValueAt(tblData.getSelectedRow(), 5).toString());
    }                                    

    private void btnDeleteActionPerformed(java.awt.event.ActionEvent evt) {                                          
        // TODO add your handling code here:
        CallableStatement cs;
        try {
            if (tblData.getSelectedRow() == -1) {
                lblInfo.setText("Please choose a record to edit");
                return;
            }
            String sql = "{ call DEMO.DELETE_CUSTOMER(?)}";
            cs = ConnectionUtils.callStatement(sql);
            cs.setInt(1, Integer.parseInt(lblID.getText()));
            cs.execute();
            loadData(null, null, null, null);
            resetData();
            lblInfo.setText("Delete successfully");

        } catch (Exception e) {
            lblInfo.setText("Error");
        }

    }                                         

               
}
