package com.minzheng.blog.utils;


import com.google.common.base.Strings;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 日期工具类
 *
 * @author 11921
 */
public class DateUtil {
    public static final String YYYY_MM_DD_HH_MM_SS = "yyyy-MM-dd HH:mm:ss";
    public static final String YYYY_MM_DD_HH = "yyyy-MM-dd HH";
    public static final String YYYY_MM_DD = "yyyy-MM-dd";


    public static Date getSomeDay(Date date, int day) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.DATE, day);
        return calendar.getTime();
    }

    public static Date strToDate(String strDate) {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        try {
            return formatter.parse(strDate);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static String date2Str(Date date, String pattern) {
        return !Objects.isNull(date) && !Strings.isNullOrEmpty(pattern) ? Optional.of((new SimpleDateFormat(pattern)).format(date)).get() : (String) Optional.empty().get();
    }

    /**
     * 获取日期所在星期
     *
     * @param date 日期
     * @return 星期
     */
    public static int getDayOfWeek(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        return cal.get(Calendar.DAY_OF_WEEK) - 1;
    }

    /**
     * 获取日期所在月份
     *
     * @param date 日期
     * @return 月份
     */
    public static int getDayOfMonth(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        return cal.get(Calendar.DAY_OF_MONTH);
    }

    /**
     * 获取日期所在年份
     *
     * @param date 日期
     * @return 年份
     */
    public static int getDayOfYear(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        return cal.get(Calendar.YEAR);
    }

    public static String getMinTime(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        return getMinTime(calendar);
    }

    /**
     * 设置最小时间
     *
     * @param calendar
     */
    private static String getMinTime(Calendar calendar) {
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);
        return date2Str(calendar.getTime(), YYYY_MM_DD_HH_MM_SS);
    }

    public static String getMaxTime(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        return getMaxTime(calendar);
    }

    /**
     * 设置最大时间
     *
     * @param calendar
     */
    private static String getMaxTime(Calendar calendar) {
        calendar.set(Calendar.HOUR_OF_DAY, calendar.getActualMaximum(Calendar.HOUR_OF_DAY));
        calendar.set(Calendar.MINUTE, calendar.getActualMaximum(Calendar.MINUTE));
        calendar.set(Calendar.SECOND, calendar.getActualMaximum(Calendar.SECOND));
        calendar.set(Calendar.MILLISECOND, calendar.getActualMaximum(Calendar.MILLISECOND));
        return date2Str(calendar.getTime(), YYYY_MM_DD_HH_MM_SS);
    }

    /**
     * 获取多少小时前
     * @param hour 小时
     * @return 时间
     */
    public static String getBeforeHourTime(int hour) {
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.HOUR_OF_DAY, calendar.get(Calendar.HOUR_OF_DAY) - hour);
        return date2Str(calendar.getTime(), YYYY_MM_DD_HH_MM_SS);
    }

}
