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
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;
import oracle.jdbc.OracleTypes;
import utils.ConnectionUtils;

/**
 *
 * @author Lenovo
 */
public class BranchForm extends javax.swing.JFrame {

    public BranchForm() {
        initComponents();
        loadData(null, null, null);
        resetData();
    }
                  

    private void btnEditActionPerformed(java.awt.event.ActionEvent evt) {                                        
        // TODO add your handling code here:
        CallableStatement call;
        String sql;
        try {
            if (tblData.getSelectedRow() == -1) {
                lblInfo.setText("Please choose record to edit");
                return;
            }

            if ("".equals(txtBranchCode.getText())) {
                lblInfo.setText("Please input branch code");
                return;
            }
            if ("".equals(txtBranchName.getText())) {
                lblInfo.setText("Please input branch code");
                return;
            }
            if ("".equals(txtParentBranch.getText())) {
                lblInfo.setText("Please input branch code");
                return;
            }

            sql = "{ call DEMO.UPDATE_BRANCH(?,?,?,?)}";
            call = ConnectionUtils.callStatement(sql);
            call.setInt(1, Integer.parseInt(lblID.getText()));
            call.setString(2, txtBranchCode.getText());
            call.setString(3, txtBranchName.getText());
            call.setString(4, txtParentBranch.getText());
            call.execute();
            loadData(null, null, null);
            resetData();
            lblInfo.setText("Update successfully");
        } catch (Exception e) {
            try {
                lblInfo.setText("Error:" + e.getMessage());
                ConnectionUtils.closeConnection();
            } catch (SQLException ex) {
                Logger.getLogger(BranchForm.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }                                       

    private void btnAddActionPerformed(java.awt.event.ActionEvent evt) {                                       
        // TODO add your handling code here:
        CallableStatement call;
        String sql;
        try {
            if ("".equals(txtBranchCode.getText())) {
                lblInfo.setText("Please input branch code");
                return;
            }
            if ("".equals(txtBranchName.getText())) {
                lblInfo.setText("Please input branch code");
                return;
            }
            if ("".equals(txtParentBranch.getText())) {
                lblInfo.setText("Please input parent branch code");
                return;
            }

            sql = "{ call DEMO.INSERT_BRANCH(?,?,?)}";
            call = ConnectionUtils.callStatement(sql);
            call.setString(1, txtBranchCode.getText());
            call.setString(2, txtBranchName.getText());
            call.setString(3, txtParentBranch.getText());
            call.execute();
            loadData(null, null, null);
            //resetData();
            lblInfo.setText("Insert successfully");

        } catch (Exception e) {
            try {
                lblInfo.setText("Error:" + e.getMessage());
                ConnectionUtils.closeConnection();
            } catch (SQLException ex) {
                Logger.getLogger(BranchForm.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }                                      

    private void btnSearchActionPerformed(java.awt.event.ActionEvent evt) {                                          
        // TODO add your handling code here:
        loadData(txtBranchCode.getText(), txtBranchName.getText(), txtParentBranch.getText());
    }                                         

    private void resetData() {
        txtBranchCode.setText("");
        txtBranchName.setText("");
        txtParentBranch.setText("");
        lblID.setText("");
        lblInfo.setText("");
    }

    private void loadData(String branchCode, String branchName, String parentBranchCode) {
        CallableStatement call;
        ResultSet rs;
        String sql;
        try {
            sql = "{call DEMO.GET_ALL_BRANCH(?,?,?,?,?)}";
            call = ConnectionUtils.callStatement(sql);
            call.setString(1, branchCode == "" ? null : branchCode);
            call.setString(2, branchName == "" ? null : branchName);
            call.setString(3, parentBranchCode == "" ? null : parentBranchCode);

            call.registerOutParameter(4, OracleTypes.NUMBER);
            call.registerOutParameter(5, OracleTypes.CURSOR);

            call.execute();

            rs = (ResultSet) call.getObject(5);
            if (!rs.isBeforeFirst()) {
                lblInfo.setText("No data found");
                return;
            }

            DefaultTableModel model = (DefaultTableModel) tblData.getModel();
            model.setRowCount(0);
            Vector row;
            while (rs.next()) {
                row = new Vector();
                //row.add(rs.getString("STT"));
                row.add(rs.getString("ID"));
                row.add(rs.getString("BRANCH_CODE"));
                row.add(rs.getString("BRANCH_NAME"));
                row.add(rs.getString("PARENT_BRANCH_CODE"));
                model.addRow(row);
            }

        } catch (Exception e) {
            lblInfo.setText("Error: " + e.getMessage());
            try {
                ConnectionUtils.closeConnection();
            } catch (SQLException ex) {
                Logger.getLogger(BranchForm.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    private void btnRefreshActionPerformed(java.awt.event.ActionEvent evt) {                                           
        // TODO add your handling code here:
        resetData();
    }                                          

    private void btnCloseActionPerformed(java.awt.event.ActionEvent evt) {                                         
        // TODO add your handling code here:
        this.setVisible(false);
    }                                        

    private void tblDataMouseClicked(java.awt.event.MouseEvent evt) {                                     
        // TODO add your handling code here:
        DefaultTableModel model = (DefaultTableModel) tblData.getModel();
        lblID.setText(model.getValueAt(tblData.getSelectedRow(), 0).toString());
        txtBranchCode.setText(model.getValueAt(tblData.getSelectedRow(), 1).toString());
        txtBranchName.setText(model.getValueAt(tblData.getSelectedRow(), 2).toString());
        txtParentBranch.setText(model.getValueAt(tblData.getSelectedRow(), 3).toString());
        lblInfo.setText("");
    }                                    

    private void btnDeleteActionPerformed(java.awt.event.ActionEvent evt) {                                          
        // TODO add your handling code here:
        CallableStatement call;
        String sql;
        try {
            if (tblData.getSelectedRow() == -1) {
                lblInfo.setText("Please choose record to delete");
                return;
            }

            int confirm = JOptionPane.showConfirmDialog(this, "Are you sure?", "Confirm", JOptionPane.YES_NO_OPTION);
            if (confirm != JOptionPane.YES_OPTION) {
                return;
            }

            sql = "{ call DEMO.DELETE_BRANCH(?)}";
            call = ConnectionUtils.callStatement(sql);
            call.setInt(1, Integer.parseInt(lblID.getText()));
            call.execute();
            loadData(null, null, null);
            lblInfo.setText("Delete successfully");

        } catch (Exception e) {
            try {
                lblInfo.setText("Error:" + e.getMessage());
                ConnectionUtils.closeConnection();
            } catch (SQLException ex) {
                Logger.getLogger(BranchForm.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }                                                        
}
