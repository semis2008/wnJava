package com.wnJava.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import com.wnJava.bo.LoverInfoBO;
import com.wnJava.vo.LoveRoadVO;
import com.wnJava.vo.LoverHolidayVO;

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
		SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		return f.format(cal.getTime());
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
	 * 获取当前时间几天之后的日期
	 * 
	 * @param dat
	 *            数目
	 * @param format
	 *            格式
	 * @return
	 * @throws ParseException
	 */
	public static String DateAfterStr(int dat, String format) {
		SimpleDateFormat f = new SimpleDateFormat(format);
		Calendar calen = Calendar.getInstance();
		calen.add(Calendar.DAY_OF_YEAR, dat);
		Date c = calen.getTime();
		return f.format(c);
	}

	/**
	 * 获取包括纪念日在内的假日，用于lovertime的节日提醒,取当前时间之后的最近的5条记录
	 * 
	 * @param birthday
	 * @return
	 */
	public static List<LoverHolidayVO> getLoveHoliday(LoverInfoBO bo) {
		List result = new ArrayList<LoverHolidayVO>();
		Map<String, String> holidayMap = getHolidayMap();
		int count = 0;
		for (int i = 1; i < 365; i++) {
			String afterDay = DateAfterStr(i, "MM/dd");
			LoverHolidayVO vo = new LoverHolidayVO();
			if (holidayMap.get(afterDay) != null) {
				vo.setDaysStr(i + "天后");
				vo.setHolidayName(holidayMap.get(afterDay));
				vo.setTip(holidayMap.get(afterDay)+"了，要庆祝下么？");
				result.add(vo);
				count++;
			}else {
				//获取和恋爱相关的纪念日
				String birthStr = formatDate(bo.getBirthday(), 4);
				String meetDayStr = formatDate(bo.getMeetTime(), 4);
				String loveDayStr = formatDate(bo.getLoveTime(), 4);
				String marriageDayStr = formatDate(bo.getMarriageTime(), 4);
				if(afterDay.equals(birthStr)) {
					vo.setDaysStr(i + "天后");
					vo.setHolidayName(bo.getName()+"の生日");
					vo.setTip("是"+bo.getName()+"的生日哦，准备好礼物了么");
					result.add(vo);
					count++;
				}else if(afterDay.equals(meetDayStr)) {
					vo.setDaysStr(i + "天后");
					vo.setHolidayName("相识纪念日");
					vo.setTip("是你们认识的日子哦，想想怎么纪念下~");
					result.add(vo);
					count++;
				}else if(afterDay.equals(loveDayStr)) {
					vo.setDaysStr(i + "天后");
					vo.setHolidayName("相爱纪念日");
					vo.setTip("是你们相爱的日子，还记得那一刻的感受么？");
					result.add(vo);
					count++;
				}else if(afterDay.equals(marriageDayStr)) {
					vo.setDaysStr(i + "天后");
					vo.setHolidayName("结婚纪念日");
					vo.setTip("终于修正正果了，不忘初心，才能始终。");
					result.add(vo);
					count++;
				} 
			}
			if (count == 5)
				break;
		}
		return result;
	}
 	
	/**
	 * 获取假期Map
	 * 
	 * @return
	 */
	private static Map<String, String> getHolidayMap() {
		Map<String, String> holidayMap = new HashMap<String, String>();
		holidayMap.put("01/01", "元旦");
		holidayMap.put("02/14", "西方情人节");
		holidayMap.put("03/07", "女生节");
		holidayMap.put("03/08", "妇女节");
		holidayMap.put("03/12", "植树节");
		holidayMap.put("04/01", "愚人节");
		holidayMap.put("05/01", "劳动节");
		holidayMap.put("05/04", "青年节");
		holidayMap.put("06/01", "儿童节");
		holidayMap.put("09/10", "教师节");
		holidayMap.put("10/01", "国庆节");
		holidayMap.put("10/14", "感恩节（加拿大）");
		holidayMap.put("11/11", "光棍节");
		holidayMap.put("11/28", "感恩节（美国）");
		holidayMap.put("12/24", "平安夜");
		holidayMap.put("12/25", "圣诞节");
		return holidayMap;
	}

	/**
	 * 格式化指定的日期
	 * 
	 * @param date
	 *            日期
	 * @param type
	 *            1：格式：2011-11-11 ； 2：：2011/2/2 ； 3：2011/2/2 11:45 4: 12/21 5:2012-11-11 23:22:03
	 * @return
	 */
	public static String formatDate(Date date, int type) {
		if (date == null)
			return "";
	  	String pattern = "";
		switch (type) {
		case 1:
			pattern = "yyyy-MM-dd";
			break;
		case 2:
			pattern = "yyyy/MM/dd";
			break;
		case 3:
			pattern = "yyyy/MM/dd HH:mm";
			break;
		case 4:
			pattern = "MM/dd";
			break;
		case 5:
			pattern = "yyyy-MM-dd HH:mm:ss";
			break;
		default:
			pattern = "yyyy/MM/dd HH:mm:ss";
			break;
		}
		
		SimpleDateFormat format = new SimpleDateFormat(pattern);
		String res = format.format(date);
		return res;
	}

	/**
	 * 获取所给时间到目前为止的友好的显示信息 一小时之内：XX分钟；24小时之内：XX小时；其他： X天前
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
		int publishYear = cal.get(Calendar.YEAR);
		int publishMonth = cal.get(Calendar.MONTH) + 1;
		int publishDay = cal.get(Calendar.DAY_OF_MONTH);
		int publishHour = cal.get(Calendar.HOUR_OF_DAY);
		int publishMin = cal.get(Calendar.MINUTE);

		Calendar c = Calendar.getInstance(TimeZone.getTimeZone("GMT+08:00")); // 获取东八区时间
		int year = c.get(Calendar.YEAR);
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
		return dateDiff(date, c.getTime());
	}

	/**
	 * 获取两个日期的时间差 返回友好的提示
	 * 
	 * @param endDate
	 * @param startDate
	 * @return
	 */
	public static String dateDiff(Date endDate, Date startDate) {
		return dateDiff(formatDate(endDate, 2), formatDate(startDate, 2),
				"yyyy/MM/dd");
	}

	/**
	 * 获取两个日期的时间差 返回友好的提示
	 * 
	 * @param endTime
	 * @param startTime
	 * @param format
	 * @return
	 */
	public static String dateDiff(String endTime, String startTime,
			String format) {
		// 按照传入的格式生成一个simpledateformate对象
		SimpleDateFormat sd = new SimpleDateFormat(format);
		long nd = 1000 * 24 * 60 * 60;// 一天的毫秒数
		long diff;
		long day = 0l;
		try {
			// 获得两个时间的毫秒时间差异
			diff = sd.parse(endTime).getTime() - sd.parse(startTime).getTime();
			day = diff / nd;// 计算差多少天
		} catch (ParseException e) {
			e.printStackTrace();
		}
		if (day == 0l) {
			return "今天";
		} else if (day == 1l) {
			return "明天";
		} else if (day == -1l) {
			return "昨天";
		} else {
			if (day > 0) {
				return day + "天后";
			} else {
				return -day + "天前";
			}
		}
	}

	public static void main(String args[]) throws ParseException {
		Date d = new SimpleDateFormat("yyyy/MM/dd").parse("2013/11/11");
		System.out.print(getPassedTime(d));
	}
}
