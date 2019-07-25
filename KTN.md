create or replace PACKAGE BODY DEMO AS

  PROCEDURE INSERT_BRANCH(
        p_branchCode    NVARCHAR2,
        p_branchName    NVARCHAR2,
        p_parentBranch  NVARCHAR2        
  )
  AS
  BEGIN
    INSERT INTO branch (
        id,
        branch_code,
        branch_name,
        parent_branch_code
    ) VALUES (
        BRANCH_SEQ.NEXTVAL,
        p_branchCode,
        p_branchName,
        p_parentBranch
    );
    
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT('Error');
  END;
  
  PROCEDURE UPDATE_BRANCH(
        p_id            NUMBER,
        p_branchCode    NVARCHAR2,
        p_branchName    NVARCHAR2,
        p_parentBranch  NVARCHAR2    
  )AS
  BEGIN
    UPDATE branch
    SET
        BRANCH_CODE = p_branchCode,
        BRANCH_NAME = p_branchName,
        PARENT_BRANCH_CODE = p_parentBranch
    WHERE
        id = p_id;
        
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT('Error');
  END;
  
  PROCEDURE DELETE_BRANCH(
        p_id            NUMBER
  )
  AS
  BEGIN
    DELETE FROM BRANCH 
    WHERE id = p_id;
    
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT('Error');
  END;
  
  PROCEDURE GET_ALL_BRANCH(
        p_branchCode    NVARCHAR2,
        p_branchName    NVARCHAR2,
        p_parentBranch  NVARCHAR2,    
        p_count         OUT NUMBER,
        p_result        OUT SYS_REFCURSOR
  )
  AS
  BEGIN 
        SELECT COUNT(*) INTO p_count
        FROM BRANCH a
        WHERE p_branchCode IS NULL OR a.BRANCH_CODE = p_branchCode
        AND (p_branchName IS NULL OR a.BRANCH_NAME = p_branchName)
        AND (p_parentBranch IS NULL OR a.PARENT_BRANCH_CODE = p_parentBranch)
        ;
        
        OPEN p_result FOR
        SELECT rownum as STT, a.id, a.BRANCH_CODE, a.BRANCH_NAME, a.PARENT_BRANCH_CODE
        FROM BRANCH a
        WHERE p_branchCode IS NULL OR a.BRANCH_CODE = p_branchCode
        AND (p_branchName IS NULL OR a.BRANCH_NAME = p_branchName)
        AND (p_parentBranch IS NULL OR a.PARENT_BRANCH_CODE = p_parentBranch)
        ;
  END;   


---------------------------------------------------------
  PROCEDURE INSERT_CUSTOMER(
        p_branchCode    NVARCHAR2,
        p_customerName  NVARCHAR2,
        p_identifyNo    NVARCHAR2,
        p_cifNo         NVARCHAR2
  ) AS
  BEGIN
    -- TODO: Implementation required for PROCEDURE DEMO.INSERT_CUSTOMER
    INSERT INTO CUSTOMER(
        ID,
        BRANCH_CODE,
        CUSTOMER_NAME,
        IDENTIFY_NO,
        CIF
    )
    VALUES (
        CUSTOMER_SEQ.NEXTVAL,
        p_branchCode,
        p_customerName,
        p_identifyNo,
        p_cifNo  
    );
    
    COMMIT; 
    
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error when insert customer');
        ROLLBACK;
  END INSERT_CUSTOMER;
  
  PROCEDURE UPDATE_CUSTOMER(
        p_id            NUMBER,
        p_branchCode    NVARCHAR2,
        p_customerName  NVARCHAR2,
        p_identifyNo    NVARCHAR2,
        p_cifNo         NVARCHAR2
  ) 
  AS
  BEGIN
    UPDATE CUSTOMER a
    SET branch_code = p_branchCode, 
        CUSTOMER_NAME = p_customerName,
        IDENTIFY_NO = p_identifyNo,
        CIF = p_cifNo
        WHERE a.ID = p_id;
    COMMIT;    
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error when update customer');
        ROLLBACK;
  END UPDATE_CUSTOMER;
  
   PROCEDURE DELETE_CUSTOMER(
        p_id            NUMBER,
        p_result        OUT NVARCHAR2
  )
  AS
  BEGIN
    DELETE FROM CUSTOMER a WHERE a.ID = p_id;
    p_result := '1';
    COMMIT;
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error when delete customer');
        p_result := '0';
        ROLLBACK;
  END DELETE_CUSTOMER;
  
  PROCEDURE GET_ALL_CUSTOMER(
        p_branchCode    NVARCHAR2,
        p_customerName  NVARCHAR2,
        p_identifyNo    NVARCHAR2,
        p_cifNo         NVARCHAR2,
        p_count         OUT NUMBER,
        p_result        OUT SYS_REFCURSOR
  )
  AS
  BEGIN
        SELECT COUNT(*) INTO p_count
        FROM CUSTOMER a
        WHERE (p_branchCode IS NULL OR branch_Code = p_branchCode)
        AND (p_customerName IS NULL OR customer_name = p_customerName)
        AND (p_identifyNo IS NULL OR identify_no = p_identifyNo)
        AND (p_cifNo IS NULL OR cif = p_cifNo);
        
        OPEN p_result FOR
        SELECT 
            ROWNUM AS STT,a.*
        FROM CUSTOMER a
        WHERE (p_branchCode IS NULL OR branch_Code = p_branchCode)
        AND (p_customerName IS NULL OR customer_name = p_customerName)
        AND (p_identifyNo IS NULL OR identify_no = p_identifyNo)
        AND (p_cifNo IS NULL OR cif = p_cifNo);
  END GET_ALL_CUSTOMER;    
  
  ------------------------------------
  
  /* TODO enter package declarations (types, exceptions, methods etc) here */ 
  PROCEDURE INSERT_ACCOUNT(
        p_accountNo         NVARCHAR2,
        p_accountType       NVARCHAR2,
        p_originalAmout     NUMBER,
        p_currentAmount     NUMBER,
        p_cif               NVARCHAR2,
        p_branchCode        NVARCHAR2,
        p_status            NUMBER
  )AS
  BEGIN
    INSERT INTO account (
        id,
        account_no,
        account_type,
        original_amount,
        current_amount,
        cif,
        branch_code,
        status
    ) VALUES (
        ACCOUNT_SEQ.NEXTVAL,
        p_accountNo,
        p_accountType,
        p_originalAmout,
        p_currentAmount,
        p_cif,
        p_branchCode,
        p_status            
    );
  END;
  
  PROCEDURE UPDATE_ACCOUNT(
        p_id                NUMBER,
        p_accountNo         NVARCHAR2,
        p_accountType       NVARCHAR2,
        p_originalAmout     NUMBER,
        p_currentAmount     NUMBER,
        p_cif               NVARCHAR2,
        p_branchCode        NVARCHAR2,
        p_status            NUMBER
  )AS
  BEGIN
    UPDATE account a
        SET
            a.ACCOUNT_NO = p_accountNo, 
            a.ACCOUNT_TYPE = p_accountType, 
            a.BRANCH_CODE = p_branchCode,
            a.CIF =  p_cif, 
            a.CURRENT_AMOUNT = p_currentAmount, 
            a.ORIGINAL_AMOUNT = p_originalAmout, 
            a.STATUS = p_status
    WHERE
            id = p_id
        ;
      
  END;
  
  PROCEDURE DELETE_ACCOUNT(
        p_id            NUMBER
  )as
  BEGIN 
    DELETE FROM ACCOUNT a WHERE a.ID = p_id;
    COMMIT;
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error when delete account');
        ROLLBACK;
  END
  ;
  
  PROCEDURE GET_ALL_ACCOUNT(
        p_accountNo         NVARCHAR2,
        p_accountType       NVARCHAR2,
        p_cif               NVARCHAR2,
        p_branchCode        NVARCHAR2,
        p_status            NUMBER,
        p_count             OUT NUMBER,
        p_result            OUT SYS_REFCURSOR
  )AS
  BEGIN
    SELECT COUNT(*) INTO p_count
        FROM ACCOUNT a
        WHERE 
        (p_accountNo IS NULL OR account_no = p_accountNo)
        AND (p_accountType IS NULL OR account_type = p_accountType)
        AND (p_branchCode IS NULL OR branch_code = p_branchCode)
        AND (p_status IS NULL OR status = p_status);
        
        OPEN p_result FOR
        SELECT 
            ROWNUM AS STT,a.*
        FROM ACCOUNT a
        WHERE (p_accountNo IS NULL OR account_no = p_accountNo)
        AND (p_accountType IS NULL OR account_type = p_accountType)
        AND (p_branchCode IS NULL OR branch_code = p_branchCode)
        AND (p_status IS NULL OR status = p_status);
  END; 

END DEMO;
