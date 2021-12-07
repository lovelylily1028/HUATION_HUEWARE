package com.huation.common.util;

import java.io.PrintStream;
import java.security.MessageDigest;
import sun.misc.BASE64Encoder;

public class EncryptUtil
{
  public static String encrypt(String password)
  {
    MessageDigest md = null;
    String format = "MD5";
    String mdPassword = "";
    try
    {
      md = MessageDigest.getInstance(format);
      try
      {
        BASE64Encoder encoder = new BASE64Encoder();
        mdPassword = encoder.encode(md.digest(password.getBytes()));
      } catch (Exception ie) {
        ie.printStackTrace();
      }
    } catch (Exception ee) {
      ee.printStackTrace();
    }

    return mdPassword;
  }

  public static void main(String[] args)
  {
    String password = "huation@2100";

    System.out.println("��� =[" + encrypt(password) + "]");
  }
}