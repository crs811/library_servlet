package com.crs811.library.util;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.Random;

public class CaptchaUtil {

    private static final int WIDTH = 120;
    private static final int HEIGHT = 40;
    private static final int CHAR_COUNT = 5;
    private static final String CHAR_STRING = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

    /**
     * 生成随机验证码及图片
     */
    public static Object[] createImage() {
        BufferedImage image = new BufferedImage(WIDTH, HEIGHT, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = image.createGraphics();
        StringBuilder sb = new StringBuilder();
        // 背景色
        g.setColor(Color.WHITE);
        g.fillRect(0, 0, WIDTH, HEIGHT);

        Random rand = new Random();

        // 干扰线
        for (int i = 0; i < 10; i++) {
            g.setColor(getRandomColor(rand));
            int x1 = rand.nextInt(WIDTH);
            int y1 = rand.nextInt(HEIGHT);
            int x2 = rand.nextInt(WIDTH);
            int y2 = rand.nextInt(HEIGHT);
            g.drawLine(x1, y1, x2, y2);
        }

        // 干扰字符背景噪声
        g.setFont(new Font("Arial", Font.PLAIN, 16));
        for (int i = 0; i < 30; i++) {
            g.setColor(getRandomColor(rand, 120, 220));
            char c = CHAR_STRING.charAt(rand.nextInt(CHAR_STRING.length()));
            int x = rand.nextInt(WIDTH);
            int y = rand.nextInt(HEIGHT);
            g.drawString(String.valueOf(c), x, y);
        }

        // 验证码字符
        g.setFont(new Font("Arial", Font.BOLD | Font.ITALIC, 28));

        for (int i = 0; i < CHAR_COUNT; i++) {
            g.setColor(getRandomColor(rand, 20, 200));
            char c = CHAR_STRING.charAt(rand.nextInt(CHAR_STRING.length()));
            int x = 20 * i + 10;
            int y = 30;
            double angle = (rand.nextInt(60) - 30) * Math.PI / 180;
            g.rotate(angle, x, y);
            g.drawString(String.valueOf(c), x, y);
            g.rotate(-angle, x, y);
            // 记录字符
            sb.append(c);
        }
        g.dispose();
        return new Object[]{sb.toString(), image};
    }

    private static Color getRandomColor(Random rand) {
        return new Color(rand.nextInt(256), rand.nextInt(256), rand.nextInt(256));
    }

    private static Color getRandomColor(Random rand, int min, int max) {
        if (min > 255) min = 255;
        if (max > 255) max = 255;
        int r = min + rand.nextInt(max - min);
        int g = min + rand.nextInt(max - min);
        int b = min + rand.nextInt(max - min);
        return new Color(r, g, b);
    }

//    public static void main(String[] args) throws IOException {
//        Object[] objs = createImage();
//        BufferedImage image = (BufferedImage) objs[1];
//        ImageIO.write(image, "png", new File("d:/1.png"));
//
//        System.out.println("验证码图片生成成功！"+objs[0]);
//    }
}

