package com.qst.finance.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import com.qst.finance.common.BizException;

/**
 * 密码 MD5 加盐加密(对应《数据库设计》6.2 用户帐号密码的加密方法)
 */
public final class Md5Util {

    private Md5Util() {
    }

    public static String md5Hex(String text) {
        try {
            MessageDigest digest = MessageDigest.getInstance("MD5");
            byte[] bytes = digest.digest(text.getBytes("UTF-8"));
            StringBuilder sb = new StringBuilder(bytes.length * 2);
            for (byte b : bytes) {
                int v = b & 0xFF;
                if (v < 16) {
                    sb.append('0');
                }
                sb.append(Integer.toHexString(v));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new BizException("MD5 算法不可用");
        } catch (java.io.UnsupportedEncodingException e) {
            throw new BizException("字符编码异常");
        }
    }

    /**
     * 账号 + 密码 + 盐值 混合加密
     */
    public static String encrypt(String accountName, String password, String salt) {
        return md5Hex(accountName + ":" + password + ":" + salt);
    }

    public static boolean matches(String accountName, String password, String salt, String encrypted) {
        return encrypted != null && encrypted.equals(encrypt(accountName, password, salt));
    }
}
