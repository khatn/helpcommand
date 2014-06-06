Linux
===========
top –c : dùng để xem thông tin hoạt động của server
free –m : dùng để kiểm tra thông tin bộ nhớ
df –h : dùng để kiểm tra dụng lượng ổ cứng
sync; echo 3 > /proc/sys/vm/drop_caches : dùng để giải phóng caches và làm tăng bộ nhớ
zip -r tenthumuc.zip tenthumuc :  nén thư mục 
unzip tenthumuc.zip


Oracle
===========
su – oracle  (dùng để vào oracle)
sqlplus / as sysdba
startup
SHUTDOWN IMMEDIATE

create user HSCV_THA identified by HSCV_THA;
grant dba to HSCV_THA;

CREATE DIRECTORY DMPDIR as '/u02/dmpdir'; //create directory for importdb/exportdb

      
select file_id,file_name from dba_data_files where tablespace_name='USERS';
alter database datafile 4 autoextend on maxsize unlimited;
alter database datafile '/u01/oradata/qlcb/users01.dbf' autoextend on next 5m maxsize 900m;


---import & export---
expdp HSCV_BTP_FINAL/HSCV_BTP_FINAL schemas=HSCV_BTP_FINAL directory=DMPDIR dumpfile=file.dmp logfile=export.log
impdp HSCV_NEW/HSCV_NEW  REMAP_SCHEMA=HSCV_FINAL:HSCV_NEW directory=DMPDIR dumpfile=file.dmp logfile=import.log

-- Xoa limit password, doi password dinh ky, so lan login sai
SELECT profile FROM dba_users where username = 'QLQT';
ALTER PROFILE DEFAULT LIMIT               //DEFAULT là tên profile cần đổi, ở đây profile mặc định của user 'QLQT' là DEFAULT
FAILED_LOGIN_ATTEMPTS UNLIMITED
PASSWORD_LIFE_TIME UNLIMITED;
