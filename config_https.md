# helpcommand
1. Create Keystore and Self-signed Certificate

Open command prompt and go to %JAVA_HOME%\bin. Use keytool to create JKS (Java KeyStore) format keystore and a self-signed certificate.

	
C:\jdk\bin>keytool -genkey -alias srccodes -keyalg RSA -keystore c:\tomcat7\conf\srccodes.jks
Enter keystore password:
Re-enter new password:
What is your first and last name?
  [Unknown]:  SrcCodes Dot Com
What is the name of your organizational unit?
  [Unknown]:  SrcCodes.com
What is the name of your organization?
  [Unknown]:  SrcCodes Pvt. Ltd.
What is the name of your City or Locality?
  [Unknown]:  Kolkata
What is the name of your State or Province?
  [Unknown]:  WB
What is the two-letter country code for this unit?
  [Unknown]:  IN
Is CN=SrcCodes Dot Com, OU=SrcCodes.com, O=SrcCodes Pvt. Ltd., L=Kolkata, ST=WB, C=IN correct?
  [no]:  yes
 
Enter key password for <srccodes>
        (RETURN if same as keystore password):
Re-enter new password:

-keystore
    Filepath (say "c:\tomcat7\conf\srccodes.jks") where keystore file will be generated.

keystore password
    Password of the keystore to be used by Tomcat. If not provided, then default is "changeit".

key password
    Password of the self-signed certificate generated in the keystore. If not provided, then it'll be same as keystore password.

 
2. Configure Tomcat

    Open <tomcat-installation-directory>/conf/server.xml in a text editor.

    Search for "Define a SSL HTTP/1.1 Connector on port 8443". Connector configuration will be commented there. Uncomment it.
    
    	
    <!-- Define a SSL HTTP/1.1 Connector on port 8443
         This connector uses the JSSE configuration, when using APR, the
         connector should be using the OpenSSL style configuration
         described in the APR documentation -->
    <!--
    <Connector port="8443" protocol="HTTP/1.1" SSLEnabled="true"
               maxThreads="150" scheme="https" secure="true"
               clientAuth="false" sslProtocol="TLS" />
    -->

    Provide keystoreFile, keystorePass and keyPass values as given in Step #1.
    
    	
    <Connector port="8443" protocol="HTTP/1.1" SSLEnabled="true"
               maxThreads="150" scheme="https" secure="true"
               clientAuth="false" sslProtocol="TLS"
               keystoreFile="conf/srccodes.jks"
               keystoreType="JKS"
               keystorePass="pass4keystore"
               keyPass="pass4key" />

 
3. Check SSL / HTTPS setup

    Start the Tomcat server. Otherwise restart if already started.

    Open https://localhost:8443 in browser.

    In Firefox browser, you will get "This Connection is Untrusted" message.
