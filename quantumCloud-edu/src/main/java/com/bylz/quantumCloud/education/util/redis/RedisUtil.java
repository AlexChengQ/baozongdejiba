package com.bylz.quantumCloud.education.util.redis;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/7/12
 */
public class RedisUtil {

    private static String ADDR = "localhost";
    private static int PORT = 6379;
//    private static String AUTH = "123456";

    // 最大连接实例数，默认为8，-1表示无限制，如果pool已经分配了超过max_active个jedis实例，则此时pool为耗尽
    private static int MAX_ACTIVE = 1024;

    // 最大空闲实例，默认为8
    private static int MAX_IDLE = 200;

    // 最大等待连接时间，单位毫秒默认为-1，表示永不超时，超时会抛出JedisConnectionException
    private static int MAX_WAIT = 10 * 1000;

    private static int TIMEOUT = 10 * 1000;

    // 在borrow一个jedis实例时，是否提前进行validate操作，如果为true，则得到的jedis实例均是可用的
    private static boolean TEST_ON_BORROW = true;

    private static JedisPool jedisPool = null;
    /**
     * 初始化连接池
     */
    static {
        JedisPoolConfig config = new JedisPoolConfig();
        config.setMaxTotal(MAX_ACTIVE);
        config.setMaxIdle(MAX_IDLE);
        config.setMaxWaitMillis(MAX_WAIT);
        config.setTestOnBorrow(TEST_ON_BORROW);
        jedisPool = new JedisPool(config, ADDR, PORT, TIMEOUT);
    }

    /**
     * 获取jedis实例
     */
    public synchronized static Jedis getJedis() {
        if (jedisPool != null) {

            Jedis resource = jedisPool.getResource();
            return resource;
        }
        return null;
    }

    /**
     * 释放资源
     *
     * @param jedis
     */
    public static void close(final Jedis jedis) {
        if (jedis != null) {
            jedis.close();
        }
    }

    /**
     * 保存对象（键-值）
     *
     * @param <T>
     *
     * @param key
     * @param object
     * @return
     */
    public static <T> String setObject(String key, T object) {
        Jedis jedis = getJedis();
        try {
            return jedis.set(key.getBytes(), SerializeUtil.serializer(object));
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage(), e);
        } finally {
            close(jedis);
        }
    }

    /**
     * 带时间保存（键值）
     *
     * @param key
     * @param object
     * @param expiretime
     * @return
     */
    public static <T> String setObject(String key, T object, long expiretime) {
        Jedis jedis = null;
        try {
            jedis = getJedis();
            return jedis.psetex(key.getBytes(), expiretime, SerializeUtil.serializer(object));
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage(), e);
        } finally {
            close(jedis);
        }
    }

    /**
     * 读取对象（键-值）
     *
     * @param key
     * @param clazz
     * @return
     */
    public static <T> T getObject(String key, Class<T> clazz) {
        Jedis jedis = getJedis();
        try {
            byte[] bytes = jedis.get(key.getBytes());
            T object = SerializeUtil.deSerializer(bytes, clazz);
            return object;
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage(), e);
        } finally {
            close(jedis);
        }
    }

    /**
     * 删除key
     */
    public static Long deleteObject(String key) {
        Jedis jedis = null;
        try {
            jedis = getJedis();
            return jedis.del(key.getBytes());
        } catch (Exception e) {
            return null;
        } finally {
            close(jedis);
        }
    }

    /**
     * 检查存在
     *
     * @param key
     * @return
     */
    public static Boolean existsObject(String key) {
        Jedis jedis = null;
        try {
            jedis = getJedis();
            return jedis.exists(key.getBytes());
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage(), e);
        } finally {
            close(jedis);
        }
    }


    public static void main(String[] args) {
        Jedis jedis = null;
        try {
            jedis = getJedis();
            jedis.psetex("18855151334",500000,"aaaaa");
            System.out.println(existsObject("18855151334"));
            System.out.println(jedis.get("18855151334"));
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage(), e);
        } finally {
            close(jedis);
        }
    }
}
