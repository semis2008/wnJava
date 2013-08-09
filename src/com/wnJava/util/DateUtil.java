package com.wnJava.util;

import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

/**
 * 日期工具类
 * 
 * @author Kalor
 * @time 2012-12-17
 */
public class DateUtil {
	/**
	 * 获取当前的时间
	 * 
	 * @return Calendar
	 */
	public static Calendar getCalendarNow() {
		Calendar cal = Calendar.getInstance();
		return cal;
	}

	/**
	 * 获取当前的时间
	 * 
	 * @return String 2013-06-07 11:45
	 */
	public static String getTimeNow() {
		Calendar cal = Calendar.getInstance();
		String res = "";
		res = cal.get(Calendar.YEAR) + "-" + (cal.get(Calendar.MONTH) + 1)
				+ "-" + cal.get(Calendar.DAY_OF_MONTH) + " "
				+ cal.get(Calendar.HOUR_OF_DAY) + ":"
				+ cal.get(Calendar.MINUTE) + ":" +cal.get(Calendar.SECOND);
		return res;
	}

	/**
	 * 将date对象转换为calendar
	 * 
	 * @param date
	 * @return
	 */
	public static Calendar dateToCalendar(Date date) {
		Calendar cal = Calendar.getInstance();
		if (date == null) {
			return null;
		} else {
			cal.setTime(date);
		}
		return cal;
	}

	/**
	 * 格式化指定的日期
	 * 
	 * @param date
	 *            日期
	 * @param type
	 *            1：格式：2011年11月11日 ； 2：：2011/2/2 ； 3：2011/2/2 11:45 4: 12/21
	 * @return
	 */
	public static String formatDate(Date date, int type) {
		if (date == null)
			return "";
		Calendar cal = dateToCalendar(date);
		String res = "";
		switch (type) {
		case 1:
			res = cal.get(Calendar.YEAR) + "年" + (cal.get(Calendar.MONTH) + 1)
					+ "月" + cal.get(Calendar.DAY_OF_MONTH) + "日";
			break;
		case 2:
			res = cal.get(Calendar.YEAR) + "/" + (cal.get(Calendar.MONTH) + 1)
					+ "/" + cal.get(Calendar.DAY_OF_MONTH);
			break;
		case 3:
			res = cal.get(Calendar.YEAR) + "/" + (cal.get(Calendar.MONTH) + 1)
					+ "/" + cal.get(Calendar.DAY_OF_MONTH) + " "
					+ cal.get(Calendar.HOUR_OF_DAY) + ":"
					+ cal.get(Calendar.MINUTE);
			break;
		case 4:
			res = (cal.get(Calendar.MONTH) + 1) + "/"
					+ cal.get(Calendar.DAY_OF_MONTH);
			break;
		default:
			break;
		}
		return res;
	}

	/**
	 * 获取所给时间到目前为止的友好的显示信息 一小时之内：XX分钟；24小时之内：XX小时；1天之内：X月X日
	 * 
	 * @param date
	 *            所给时间
	 * @return 友好的显示信息
	 */
	public static String getPassedTime(Date date) {
		if (date == null)
			return "";
		Calendar cal = dateToCalendar(date);
		// TODO 添加主要逻辑
		int publishMonth = cal.get(Calendar.MONTH) + 1;
		int publishDay = cal.get(Calendar.DAY_OF_MONTH);
		int publishHour = cal.get(Calendar.HOUR_OF_DAY);
		int publishMin = cal.get(Calendar.MINUTE);

		Calendar c = Calendar.getInstance(TimeZone.getTimeZone("GMT+08:00")); // 获取东八区时间
		int month = c.get(Calendar.MONTH) + 1;
		int day = c.get(Calendar.DAY_OF_MONTH);
		int hour = c.get(Calendar.HOUR_OF_DAY);
		int min = c.get(Calendar.MINUTE);

		/*
		 * 1小时内返回 ‘XXX分钟’
		 */
		if (publishMonth == month && publishDay == day && publishHour == hour) {
			return min - publishMin + "分钟前";
		}

		/*
		 * 24小时之内返回 ‘XXX小时’
		 */
		if (publishMonth == month
				&& (publishDay == day || publishDay == day - 1
						&& hour < publishHour)) {
			if (publishDay == day)
				return hour - publishHour + "小时前";
			if (publishDay == day - 1)
				return 24 - (publishHour - hour) + "小时前";
		}
		return publishMonth + "月" + publishDay + "日";
	}

	public static void main(String args[]) {
		Calendar now = getCalendarNow();

		System.out.print(now.getTimeInMillis());
	}
}
