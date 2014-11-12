
package br.com.instore.core.orm;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Main {

    public static void main(String[] args) {
        int day = Integer.parseInt(new SimpleDateFormat("dd").format(new Date()).trim());
        int month = Integer.parseInt(new SimpleDateFormat("MM").format(new Date()).trim());
        int year = Integer.parseInt(new SimpleDateFormat("yyyy").format(new Date()).trim());
        int hour = Integer.parseInt(new SimpleDateFormat("hh").format(new Date()).trim());
        int minute = Integer.parseInt(new SimpleDateFormat("mm").format(new Date()).trim());
        int second = Integer.parseInt(new SimpleDateFormat("ss").format(new Date()).trim());
        
        for (int i = 0; i < 100; i++) {
            try {
                Random random = new Random(System.nanoTime());
                int r = day + month + year + hour + minute + second;
                r = r / (second + 10);
                
                int ranger = 8 + r;
                System.out.println(random.nextInt(ranger) );
                Thread.sleep(1000l);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}
