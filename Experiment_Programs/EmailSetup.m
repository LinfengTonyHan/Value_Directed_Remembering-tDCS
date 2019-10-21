%% This is the script to shoot out an email 

setpref('Internet','SMTP_Server','smtp.gmail.com');
setpref('Internet','E_mail','myemailaddress@gmail.com');
setpref('Internet','SMTP_Username','tdcs.vdr.group@gmail.com');
setpref('Internet','SMTP_Password','rissmanlab');
props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','465');

