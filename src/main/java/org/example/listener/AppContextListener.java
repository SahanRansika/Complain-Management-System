package org.example.listener;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import org.example.dao.UserDAO;
import org.example.dao.ComplaintDAO;
import org.example.db.DataSource;

@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {

        UserDAO.setDataSource(DataSource.getDataSource());
        ComplaintDAO.setDataSource(DataSource.getDataSource());
        System.out.println("DataSource set in DAO classes.");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Cleanup code (if any)
    }
}
