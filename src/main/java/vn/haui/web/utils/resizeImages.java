package vn.haui.web.utils;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;


public class resizeImages {
    private String pathUrl = "/upload/images/";
    private String urlImages = File.separatorChar + "ROOT" + File.separatorChar + "upload" + File.separatorChar + "images" + File.separatorChar;

    public static BufferedImage resizeImage(final Image image, int width, int height) {
        final BufferedImage bufferedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        final Graphics2D graphics2D = bufferedImage.createGraphics();
        graphics2D.setComposite(AlphaComposite.Src);
        //below three lines are for RenderingHints for better image quality at cost of higher processing time
//        graphics2D.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
//        graphics2D.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
//        graphics2D.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);

        graphics2D.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BICUBIC);
        graphics2D.setRenderingHint(RenderingHints.KEY_ALPHA_INTERPOLATION, RenderingHints.VALUE_ALPHA_INTERPOLATION_QUALITY);
        graphics2D.setRenderingHint(RenderingHints.KEY_COLOR_RENDERING, RenderingHints.VALUE_COLOR_RENDER_QUALITY);
        graphics2D.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
        graphics2D.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
        graphics2D.drawImage(image, 0, 0, width, height, null);
        graphics2D.dispose();
        return bufferedImage;
    }

    private Boolean checkImg(File[] listOfFiles, String nameFile) {
        for (int i = 0; i < listOfFiles.length; i++) {
            for (ImageWH imageWH : imageWHList()) {
                nameFile = nameFile + "-" + imageWH.getWidth() + "x" + imageWH.getHeight();
                if (nameFile.contains(listOfFiles[i].getName())) {
                    return true;
                }
            }
        }
        return false;
    }

    public void AutoResezi(String path) throws IOException {
        File folder = new File(path);
        File[] listOfFiles = folder.listFiles();
        System.out.println("Total No of Files:" + listOfFiles.length);
        Image img = null;
        BufferedImage tempPNG = null;
        BufferedImage tempJPG = null;
        File newFile = null;
        for (int i = 0; i < listOfFiles.length; i++) {
            if (listOfFiles[i].isFile()) {
                String name = searchName(listOfFiles[i].getName());
                String extend = searchExtend(listOfFiles[i].getName());
                String pathIO = path + "\\" + listOfFiles[i].getName();
                if (!checkImg(listOfFiles, name)) {
                    int check = 0;
                    for (ImageWH imageWH : imageWHList()) {
                        String resizeImg = "-" + imageWH.getWidth() + "x" + imageWH.getHeight();
                        if (name.contains(resizeImg)) {
                            check = 1;
                            break;
                        }
                    }
                    if (check == 0) {
                        img = ImageIO.read(new File(pathIO));
                        //tempJPG=ImageIO.read(new File(pathIO));
                        for (ImageWH hwList : imageWHList()) {
                            tempJPG = resizeImage(img, hwList.getWidth(), hwList.getHeight());
                            //tempJPG= Scalr.resize((BufferedImage) img, Scalr.Method.ULTRA_QUALITY,hwList.getWidth(), hwList.getHeight());
                            newFile = new File(path + "/" + name + "-" + hwList.getWidth() + "x" + hwList.getHeight() + "." + extend);
                            ImageIO.write(tempJPG, extend, newFile);
                        }
                    }
                }
            }
        }
    }

    private ArrayList<ImageWH> imageWHList() {
        ArrayList<ImageWH> imageWHS = new ArrayList<>();
        imageWHS.add(new ImageWH(104, 69));
        imageWHS.add(new ImageWH(150, 150));
        imageWHS.add(new ImageWH(163, 102));
        imageWHS.add(new ImageWH(214, 140));
        imageWHS.add(new ImageWH(300, 200));
        imageWHS.add(new ImageWH(336, 200));
        imageWHS.add(new ImageWH(474, 240));
        imageWHS.add(new ImageWH(235, 216));
        imageWHS.add(new ImageWH(600, 460));
        imageWHS.add(new ImageWH(666, 1000));
        imageWHS.add(new ImageWH(702, 459));
        imageWHS.add(new ImageWH(1000, 667));
        return imageWHS;
    }

    private String searchName(String nameFile) {
        if (nameFile.contains(".jpg") || nameFile.contains(".png"))
            return nameFile.replace(".png", "").replace(".jpg", "");
        return nameFile;
    }

    private String searchExtend(String nameFile) {
        if (nameFile.contains(".jpg"))
            return "jpg";
        if (nameFile.contains(".png"))
            return "png";
        return "jpg";
    }

    public String getPath() throws UnsupportedEncodingException {
        String path = this.getClass().getClassLoader().getResource("").getPath();
        String fullPath = URLDecoder.decode(path, "UTF-8");
        // String pathArr[] = fullPath.split("/upload/");
        //System.out.println(fullPath);
        System.out.println(fullPath.replace("target/classes/", ""));
        //System.out.println(pathArr[0]);
        //fullPath = pathArr[0];
        String reponsePath = "";
        // to read a file from webcontent
        reponsePath = new File(fullPath.replace("target/classes/", "")).getPath() + urlImages;
        return reponsePath;
    }
}

class ImageWH {
    private int height;
    private int width;

    public ImageWH(int width, int height) {
        this.height = height;
        this.width = width;
    }

    public ImageWH() {

    }

    public int getHeight() {
        return height;
    }

    public void setHeight(int height) {
        this.height = height;
    }

    public int getWidth() {
        return width;
    }

    public void setWidth(int width) {
        this.width = width;
    }
}

