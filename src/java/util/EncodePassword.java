/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.security.MessageDigest;
import java.util.Base64;

/**
 *
 * @author Admin
 */
public class EncodePassword {
    public static String encodeToSHA1(String str){
        String salt = "Adsj@!kjied;acfa/aft45";
        String rs = "";
        str = str + salt;
        try{
            byte[] dataBytes = str.getBytes("UTF-8");
            MessageDigest md = MessageDigest.getInstance("SHA-1");
            rs = Base64.getEncoder().encodeToString(md.digest(dataBytes));
        }catch(Exception e){
            e.printStackTrace();
        }
        return rs;
    }
    public static void main(String[] args) {
        System.out.println(encodeToSHA1("Group3swp"));
    }
}
