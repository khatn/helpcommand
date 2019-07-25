# helpcommand
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package bidv;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;
import oracle.jdbc.OracleTypes;

/**
 *
 * @author Administrator
 */
public class BIDV_CustomerForm extends javax.swing.JFrame {
    private Connection connect = null;
    /**
     * Creates new form BIDV_CustomerForm
     */
    public BIDV_CustomerForm() {
        initComponents();
        
        try {
            reloadTable();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    

    private void btnDongActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnDongActionPerformed
        // TODO add your handling code here:
        this.setVisible(false);
    }

    private void btnLamMoiActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnLamMoiActionPerformed
        // TODO add your handling code here:
        txtMaChiNhanh.setText("");
        txtTenKhachHang.setText("");
        txtSoCMND.setText("");
        txtSoCIF.setText("");
    }

    private void btnTimKiemActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnTimKiemActionPerformed
        // TODO add your handling code here:
        txtInfor.setText("");
        Statement st = null;
        ResultSet rs = null;
        try {
            connectSQL();
            String sql = "select * from KHACH_HANG where 1=1 ";


            if (!"".equals(txtMaChiNhanh.getText().trim())) {
                sql = sql + " and MA_CHI_NHANH like '%" + txtMaChiNhanh.getText().trim() + "%'";
            }
            if (!"".equals(txtTenKhachHang.getText().trim())) {
                sql = sql + " and TEN_KHACH_HANG like '%" + txtTenKhachHang.getText().trim() + "%'";
            }
            if (!"".equals(txtSoCMND.getText().trim())) {
                sql = sql + " and SO_CMND like '%" + txtSoCMND.getText().trim() + "%'";
            }
            if (!"".equals(txtSoCIF.getText().trim())) {
                sql = sql + " and SO_CIF like '%" + txtSoCIF.getText().trim() + "%'";
            }
            
            st = connect.createStatement();
            rs = st.executeQuery(sql);
            Vector data = null;
            DefaultTableModel model = (DefaultTableModel) tblData.getModel();
            model.setRowCount(0);
            
            if(rs.isBeforeFirst() == false){
                txtInfor.setText("Không có b?n ghi nào !");
                return;
            }
            
            while (rs.next()) {
                data = new Vector();
                data.add(rs.getString("MA_CHI_NHANH"));
                data.add(rs.getString("TEN_KHACH_HANG"));
                data.add(rs.getString("SO_CMND"));
                data.add(rs.getString("SO_CIF"));
                
                model.addRow(data);
                txtInfor.setText("Tìm ki?m thành công !");
                
            }
           
        } catch (Exception e) {
            e.printStackTrace();
        }
    }//GEN-LAST:event_btnTimKiemActionPerformed
    public void reloadTable() throws SQLException {
        Statement st = null;
        ResultSet rs = null;
        try {
            
            txtMaChiNhanh.setText("");
            txtTenKhachHang.setText("");
            txtSoCMND.setText("");
            txtSoCIF.setText("");
            connectSQL();
     
            String sql = "select * from KHACH_HANG";


            st = connect.createStatement();
            rs = st.executeQuery(sql);
            Vector data = null;
            DefaultTableModel model = (DefaultTableModel) tblData.getModel();
            model.setRowCount(0);
            
            if(rs.isBeforeFirst() == false){
                txtInfor.setText("Không có b?n ghi nào !");
                return;
            }
            
            while (rs.next()) {
                data = new Vector();
                data.add(rs.getString("MA_CHI_NHANH"));
                data.add(rs.getString("TEN_KHACH_HANG"));
                data.add(rs.getString("SO_CMND"));
                data.add(rs.getString("SO_CIF"));
                
                model.addRow(data);
                txtInfor.setText("Tìm ki?m thành công !");
                
            }


        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (connect != null) {
                    connect.close();
                }
                if (st != null) {
                    st.close();
                }
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
    private void btnThemMoiActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnThemMoiActionPerformed
        // TODO add your handling code here:
        try {
            txtInfor.setText("");
            
            if ("".equals(txtSoCIF.getText().trim())) {
            txtInfor.setText("S? CIF không du?c d? tr?ng !");
            return;
            }
            
            int ret = JOptionPane.showConfirmDialog(this, "B?n có ch?c ch?n mu?n thêm m?i không ?", "Confirm", JOptionPane.YES_OPTION);
            if(ret != JOptionPane.YES_OPTION){
                return;
            }
            
            String insert = "insert into KHACH_HANG (MA_CHI_NHANH,TEN_KHACH_HANG,SO_CMND,SO_CIF) values (?,?,?,?)";
            System.out.println(insert);
            
            PreparedStatement ps = null;
            
            try {
                connectSQL();
                ps = connect.prepareStatement(insert);
                ps.setString(1, txtMaChiNhanh.getText());
                ps.setString(2, txtTenKhachHang.getText());
                ps.setString(3, txtSoCMND.getText());
                ps.setString(4, txtSoCIF.getText());
                
                ret = ps.executeUpdate();
                
                if(ret != -1){
                    txtInfor.setText("Thêm m?i thành công !");
                }
                reloadTable();
            } catch (Exception ex) {
                ex.printStackTrace();
            }finally{
                try {
                    if (connect != null){
                        connect.close();
                    }
                    
                    if(ps != null){
                        ps.close();
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }//GEN-LAST:event_btnThemMoiActionPerformed

    private void btnSuaActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnSuaActionPerformed
        // TODO add your handling code here:
        
        try {
            txtInfor.setText("");
            if("".equals(txtSoCIF.getText().trim())){
                txtInfor.setText("S? CIF không du?c b? tr?ng !");
            }
            int ret = JOptionPane.showConfirmDialog(this, "B?n có ch?c ch?n mu?n c?p nh?t thông tin không ?", "Confirm", JOptionPane.YES_OPTION);
            
            if(ret != JOptionPane.YES_OPTION){
                return;
            }
            
            String update = "update KHACH_HANG set MA_CHI_NHANH = ?, TEN_KHACH_HANG = ? , SO_CMND = ? Where SO_CIF =?";
            System.out.println(update);
            
            PreparedStatement ps = null;
            
            try {
                connectSQL();
                ps = connect.prepareStatement(update);
                ps.setString(1, txtMaChiNhanh.getText().trim());
                ps.setString(2, txtTenKhachHang.getText().trim());
                ps.setString(3, txtSoCMND.getText().trim());
                ps.setString(4, txtSoCIF.getText().trim());
               
                ret = ps.executeUpdate();
                
                if (ret != -1){
                    txtInfor.setText("C?p nh?t thành công !");
                }
                reloadTable();
            } catch (Exception e) {
                e.printStackTrace();
            }finally{
                if (connect != null){
                    connect.close();
                }
                
                if (ps != null){
                    ps.close();
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
    }//GEN-LAST:event_btnSuaActionPerformed

    private void tblDataMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_tblDataMouseClicked
        // TODO add your handling code here:
        DefaultTableModel model = (DefaultTableModel) tblData.getModel();
        txtMaChiNhanh.setText(model.getValueAt(tblData.getSelectedRow(), 0).toString());
        txtTenKhachHang.setText(model.getValueAt(tblData.getSelectedRow(), 1).toString());
        txtSoCMND.setText(model.getValueAt(tblData.getSelectedRow(), 2).toString());
        txtSoCIF.setText(model.getValueAt(tblData.getSelectedRow(), 3).toString());
    }//GEN-LAST:event_tblDataMouseClicked

    private void btnXoaActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnXoaActionPerformed
        // TODO add your handling code here:
        txtInfor.setText("");

        int ret = JOptionPane.showConfirmDialog(this, "B?n có mu?n xóa thông tin không ?", "Confirm", JOptionPane.YES_NO_OPTION);

        if (ret != JOptionPane.YES_OPTION) {
            return; 
        }
        
        String call = ("{call KHACH_HANG_PKG.XOA_KHACH_HANG(?,?)}");
        
        CallableStatement stmt = null;
        
        try {
            connectSQL();
            String p_ket_qua = "";
            stmt = connect.prepareCall(call);
            stmt.setString(1, txtSoCIF.getText().trim());
            stmt.registerOutParameter(2, OracleTypes.NVARCHAR);
            stmt.executeQuery();
            
            p_ket_qua = stmt.getString(2);
            if("1".equals(p_ket_qua)){
                txtInfor.setText("Xóa thành công !");
            }else{
                txtInfor.setText("Xóa không thành công !");
            }
            reloadTable();
           
            
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            try {
                if (connect != null) {
                    connect.close();
                }

                if (stmt != null) {
                    stmt.close();
                }
            } catch (Exception ex2) {
                ex2.printStackTrace();
            }
        }
    }//GEN-LAST:event_btnXoaActionPerformed

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(BIDV_CustomerForm.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(BIDV_CustomerForm.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(BIDV_CustomerForm.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(BIDV_CustomerForm.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new BIDV_CustomerForm().setVisible(true);
            }
        });
    }
    
    public void connectSQL() throws SQLException {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            String url = new String ("jdbc:oracle:thin:@192.168.1.68:1521:alktech");
            
            try {
                connect = DriverManager.getConnection(url,"BIDV","BIDV");
                System.out.println("K?t n?i thành công !");
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    
}
