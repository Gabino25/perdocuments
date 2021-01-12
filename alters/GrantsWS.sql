begin
  dbms_java.grant_permission( 'APPS', 'SYS:java.net.SocketPermission', 'www.indiciumsolutions-test.com:80', 'connect, resolve');
  dbms_java.grant_permission('APPS','SYS:java.util.PropertyPermission','*','read,write');
  dbms_java.grant_permission( 'APPS', 'SYS:java.lang.RuntimePermission', 'getClassLoader', '' ) ;
  dbms_java.grant_permission( 'APPS', 'SYS:java.lang.RuntimePermission', 'accessDeclaredMembers', '' );
end;