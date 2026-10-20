package com.qst.finance.config;

import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.boot.web.server.WebServerFactoryCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.io.File;

/**
 * IDEA 直接运行 target/classes 时，内嵌 Tomcat 默认不会把 src/main/webapp
 * 作为 JSP 根目录。这里显式指定开发阶段的 webapp 路径，保证 JSP 页面可用。
 */
@Configuration
public class JspWebServerConfig {

    @Bean
    public WebServerFactoryCustomizer<TomcatServletWebServerFactory> jspDocumentRootCustomizer() {
        return factory -> {
            File webapp = locateWebapp();
            if (webapp != null) {
                factory.setDocumentRoot(webapp);
            }
        };
    }

    private File locateWebapp() {
        String userDir = System.getProperty("user.dir", ".");
        File current = new File(userDir).getAbsoluteFile();
        for (int depth = 0; current != null && depth < 6; depth++) {
            String[] candidates = {"src/main/webapp", "backend/src/main/webapp"};
            for (String candidate : candidates) {
                File directory = new File(current, candidate);
                if (new File(directory, "page/admin/jsp/login.jsp").isFile()) {
                    return directory;
                }
            }
            current = current.getParentFile();
        }
        return null;
    }
}
