package com.wnJava.util;

import java.util.regex.Pattern;

/**
 * String对象操作的辅助类
 * 
 * @author kalor
 * @time 2012-12-17
 */
public class StringUtil {
	/**
	 * 对用户密码进行加密
	 * 
	 * @param password
	 * @return
	 */
	public static String passEncrypt(String password) {
		String temp = EncryptUtil.Encrypt(password, null);
		password = temp + ConstantsUtil.SALT;
		return EncryptUtil.Encrypt(password, null);
	}

	/**
	 * 截取指定字节的字符串，多余部分用...代替
	 * 
	 * @param ss
	 * @param length
	 * @return
	 */
	public static String cutString(String str, int len) {
		if (null == str)
			return "";
		int sl = str.getBytes().length;
		if (sl > len * 2) {
			StringBuffer sb = new StringBuffer();
			char[] arr = str.toCharArray();
			for (int i = 0, j = 0; i < arr.length && j < len * 2; i++) {
				/* String.valueOf(arr[i]).matches("[\u4e00-\u9fa5]") 只是汉字
			     * String.valueOf(arr[i]).matches("[^x00-xff]") 双字节（包括汉字）
			     */
				if (String.valueOf(arr[i]).matches("[^x00-xff]")) {
					j += 2;
				} else {
					j++;
				}
				if (j == len * 2 - 1
						&& String.valueOf(arr[i]).matches("[^x00-xff]")) {

				} else {
					sb.append(arr[i]);
				}
			}
			return sb.toString() + "...";
		} else {
			return str;
		}
	}

	public static void main(String args[]) {
		String sss = "<div title='2013-06-17 12:47:44'>澳洲南部，因为天气炎热，一只考拉口渴，便爬上一民宅墙头讨水喝。足足喝了两三分钟后，还对男主人献吻以表谢意！";

		sss = Html2Text(sss);

		System.out.println(sss);
	}

	public static String Html2Text(String inputString) {
		String htmlStr = inputString; // 含html标签的字符串
		String textStr = "";
		java.util.regex.Pattern p_script;
		java.util.regex.Matcher m_script;
		java.util.regex.Pattern p_style;
		java.util.regex.Matcher m_style;
		java.util.regex.Pattern p_html;
		java.util.regex.Matcher m_html;

		java.util.regex.Pattern p_html1;
		java.util.regex.Matcher m_html1;

		try {
			String regEx_script = "<[//s]*?script[^>]*?>[//s//S]*?<[//s]*?///[//s]*?script[//s]*?>"; // 定义script的正则表达式{或<script[^>]*?>[//s//S]*?<///script>
																										// }
			String regEx_style = "<[//s]*?style[^>]*?>[//s//S]*?<[//s]*?///[//s]*?style[//s]*?>"; // 定义style的正则表达式{或<style[^>]*?>[//s//S]*?<///style>
																									// }
			String regEx_html = "<[^>]+>"; // 定义HTML标签的正则表达式
			String regEx_html1 = "<[^>]+";
			p_script = Pattern.compile(regEx_script, Pattern.CASE_INSENSITIVE);
			m_script = p_script.matcher(htmlStr);
			htmlStr = m_script.replaceAll(""); // 过滤script标签

			p_style = Pattern.compile(regEx_style, Pattern.CASE_INSENSITIVE);
			m_style = p_style.matcher(htmlStr);
			htmlStr = m_style.replaceAll(""); // 过滤style标签

			p_html = Pattern.compile(regEx_html, Pattern.CASE_INSENSITIVE);
			m_html = p_html.matcher(htmlStr);
			htmlStr = m_html.replaceAll(""); // 过滤html标签

			p_html1 = Pattern.compile(regEx_html1, Pattern.CASE_INSENSITIVE);
			m_html1 = p_html1.matcher(htmlStr);
			htmlStr = m_html1.replaceAll(""); // 过滤html标签

			textStr = htmlStr;

		} catch (Exception e) {
			System.err.println("Html2Text: " + e.getMessage());
		}

		return textStr;// 返回文本字符串
	}
}
