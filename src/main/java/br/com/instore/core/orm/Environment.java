package br.com.instore.core.orm;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Environment {

    public static enum Env {
        DEVELOPMENT,
        PRODUCTION,
        TEST,
    }
    private static Env env;
    
    public static void main(String[] args) {
        System.out.println(Environment.ambient());;
    }

    private static InetAddress run() {
        try {
            return InetAddress.getLocalHost();
        } catch (UnknownHostException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static Properties config() {
        File environmentFile = new File(rootDirectoryPath() + System.getProperty("file.separator") + "env.config");
        Properties p = new Properties();
        try {
            BufferedReader bufferedReader = new BufferedReader(new FileReader(environmentFile));
            String readLine = null;
            List<String> lines = new ArrayList<String>();
            while (null != (readLine = bufferedReader.readLine())) {
                lines.add(readLine);
            }

            for (String line : lines) {
                String [] nameValue = line.split("=");
                if(nameValue.length > 1) {
                    p.put(nameValue[0].trim(), nameValue[1].trim());
                }
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException ex) {
            Logger.getLogger(Environment.class.getName()).log(Level.SEVERE, null, ex);
        }
        return p;
    }

    public static Env ambient() {
        if("PRODUCTION".equals(config().get("webapp.settings.env"))) {
            env = env.PRODUCTION;
        }
        
        if("DEVELOPMENT".equals(config().get("webapp.settings.env"))) {
            env = env.DEVELOPMENT;
        }
        
        if("TEST".equals(config().get("webapp.settings.env"))) {
            env = env.TEST;
        }
        return env;
    }

    public static String rootDirectoryPath() {
        return System.getProperty("user.home");
    }

    public static String getIp() {
        InetAddress ia = run();
        if (ia != null) {
            return ia.getHostAddress();
        }
        return "other";
    }

    public static String getHostName() {
        InetAddress ia = run();
        if (ia != null) {
            return ia.getHostName();
        }
        return "other";
    }
}
