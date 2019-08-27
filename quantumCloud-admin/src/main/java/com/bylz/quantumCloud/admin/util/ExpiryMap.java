package com.bylz.quantumCloud.admin.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/7/16
 */
public class ExpiryMap<K,V> extends HashMap {


    private HashMap<K, Long> expiryMap = new HashMap<K,Long>();

    /**
     * Constructs an empty <tt>HashMap</tt> with the specified initial
     * capacity and load factor.
     *
     * @param initialCapacity the initial capacity
     * @param loadFactor      the load factor
     * @throws IllegalArgumentException if the initial capacity is negative
     *                                  or the load factor is nonpositive
     */
    public ExpiryMap(int initialCapacity, float loadFactor) {
        super(initialCapacity, loadFactor);
    }

    /**
     * Constructs an empty <tt>HashMap</tt> with the specified initial
     * capacity and the default load factor (0.75).
     *
     * @param initialCapacity the initial capacity.
     * @throws IllegalArgumentException if the initial capacity is negative.
     */
    public ExpiryMap(int initialCapacity) {
        super(initialCapacity);
    }

    /**
     * Constructs an empty <tt>HashMap</tt> with the default initial capacity
     * (16) and the default load factor (0.75).
     */
    public ExpiryMap() {
        regularDelete();
    }

    /**
     * Constructs a new <tt>HashMap</tt> with the same mappings as the
     * specified <tt>Map</tt>.  The <tt>HashMap</tt> is created with
     * default load factor (0.75) and an initial capacity sufficient to
     * hold the mappings in the specified <tt>Map</tt>.
     *
     * @param m the map whose mappings are to be placed in this map
     * @throws NullPointerException if the specified map is null
     */
    public ExpiryMap(Map m) {
        super(m);
    }

    public V put(K key, V value, long expiryTime) {
        expiryMap.put(key, System.currentTimeMillis() + expiryTime);
        return (V) super.put(key, value);
    }


    public V get(Object key) {
        if (key == null)
            return null;
        boolean flag = checkExpiry(key);//惰性删除
        if(!flag) {
            return (V) super.get(key);
        }
        return null;
    }


    public boolean isExist(K key) {
        return super.containsKey(key);
    }

    public int size() {
        return entrySet().size();
    }

    public boolean isEmpty() {
        return entrySet().size() == 0;
    }


    public void regularDelete() {
        Runnable runnable = new Runnable() {
            public void run() {
                for(Object key : expiryMap.keySet()) {
                    checkExpiry(key);
                }
            }
        };
        ScheduledExecutorService executor = Executors.newScheduledThreadPool(1);
        long oneDay = 24 * 60 * 60 * 1000;
        long initDelay  = getTimeMillis("17:17:00") - System.currentTimeMillis();
        initDelay = initDelay > 0 ? initDelay : oneDay + initDelay;

        executor.scheduleAtFixedRate(
                runnable,
                initDelay,
                oneDay,
                TimeUnit.MILLISECONDS);

    }


    /**
     * 获取指定时间对应的毫秒数
     * @param time “HH:mm:ss”
     * @return
     */
    private static long getTimeMillis(String time) {
        try {
            DateFormat dateFormat = new SimpleDateFormat("yy-MM-dd HH:mm:ss");
            DateFormat dayFormat = new SimpleDateFormat("yy-MM-dd");
            Date curDate = dateFormat.parse(dayFormat.format(new Date()) + " " + time);
            return curDate.getTime();
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return 0;
    }


    private boolean checkExpiry(Object key) {
        boolean flag = false;
        if (expiryMap.containsKey(key)) {
            long expiryTime = expiryMap.get(key);

            flag = System.currentTimeMillis() > expiryTime;

            if (flag) {
                super.remove(key);
                expiryMap.remove(key);
            }

        }

        return flag;
    }


    public static ExpiryMap getInstance() {
        return myMap.INSTANCE.getInstance();
    }

    private enum myMap{
        INSTANCE;
        private ExpiryMap singletonMap;
        myMap() {
            singletonMap = new ExpiryMap();
        }

        private ExpiryMap getInstance() {
            return singletonMap;
        }
    }

}
