package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionFactory {

    public static Connection getConnection() throws Exception {

        String url = "jdbc:sqlserver://localhost\\DESKTOP-MKJ2ERC:1433;"
                + "databaseName=AGIS;"
                + "encrypt=true;"
                + "trustServerCertificate=true";

        String user = "Beans";
        String password = "123";

        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

        return DriverManager.getConnection(url, user, password);
    }
}