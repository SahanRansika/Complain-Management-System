package org.example.db;

import org.apache.commons.dbcp2.BasicDataSource;

public class DataSource {

    private static BasicDataSource dataSource;

    static {
        dataSource = new BasicDataSource();
        dataSource.setUrl("jdbc:mysql://localhost:3306/complaintdb");
        dataSource.setUsername("root");
        dataSource.setPassword("Ijse@1234");
        dataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
        dataSource.setInitialSize(5);
        dataSource.setMaxTotal(10);
    }

    public static javax.sql.DataSource getDataSource() {
        return dataSource;
    }
}
