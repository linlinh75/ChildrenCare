/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author Admin
 */
public class VerifyPassword {
    public static boolean verify(String password){
        // Password must be between 8-24 characters, include at least one uppercase letter and one number.
         Pattern pattern = Pattern.compile("^(?=.*[A-Z])(?=.*\\d).+$");
        Matcher matcher = pattern.matcher(password);
        if(password.length()>=8&&password.length()<=24&&matcher.find()){
            return true;
        }else{
            return false;
        }  
    } public static void main(String[] args) {
            System.out.println(verify("Nanh2311"));
    }
}
