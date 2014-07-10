package br.com.instore.core.orm;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Environment {
    
    public static enum Env {
        DEVELOPMENT,
        PRODUCTION
    }
    
    private static InetAddress run() {
        try {
            return InetAddress.getLocalHost();
        } catch (UnknownHostException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public static Env env() {
        InetAddress ia = run();
        if(ia != null) {
            if("192.168.156".equals(ia.getHostAddress())) {
                return Env.PRODUCTION;
            }
        }
        return Env.DEVELOPMENT;
    }
    
    public static String getIp() {
        InetAddress ia = run();
        if(ia != null) {
            return ia.getHostAddress();
        }
        return "other";
    }
    
    public static String getHostName() {
        InetAddress ia = run();
        if(ia != null) {
            return ia.getHostName();
        }
        return "other";
    }    
}
