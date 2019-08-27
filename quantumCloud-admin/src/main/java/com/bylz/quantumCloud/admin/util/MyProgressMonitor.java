package com.bylz.quantumCloud.admin.util;

import com.jcraft.jsch.SftpProgressMonitor;

import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/8/16
 */
public class MyProgressMonitor extends TimerTask implements SftpProgressMonitor {
    private long progressInterval = 5 * 1000; // 默认间隔时间为5秒

    private boolean isEnd = false; // 记录传输是否结束

    private long transfered; // 记录已传输的数据总大小

    private long fileSize; // 记录文件总大小

    private Timer timer; // 定时器对象

    private String vid;//视频id

    private String definition;//清晰度

    private boolean isScheduled = false; // 记录是否已启动timer记时器

    public MyProgressMonitor(long fileSize,String vid,String definition) {
        this.fileSize = fileSize;
        this.vid = vid;
        this.definition = definition;
    }

    @Override
    public void run() {
        ExpiryMap<String,Object> expiryMap = ExpiryMap.getInstance();
        Map map = (Map)expiryMap.get(vid);
        if(map == null) {
            map = new HashMap();
        }

        if (!isEnd()) { // 判断传输是否已结束
            System.out.println("Transfering is in progress.");
            long transfered = getTransfered();
            if (transfered != fileSize) { // 判断当前已传输数据大小是否等于文件总大小
                map.put(definition,"0");
                expiryMap.put(vid,map);
                System.out.println("Current transfered: " + transfered + " bytes");
                sendProgressMessage(transfered);
            } else {
                System.out.println("File transfering is done.");
                map.put(definition,"1");
                expiryMap.put(vid,map);
                setEnd(true); // 如果当前已传输数据大小等于文件总大小，说明已完成，设置end
            }
        } else {
            map.put(definition,"1");
            expiryMap.put(vid,map);
            System.out.println("Transfering done. Cancel timer.");
            stop(); // 如果传输结束，停止timer记时器
            return;
        }
    }

    public void stop() {
        System.out.println("Try to stop progress monitor.");
        if (timer != null) {
            timer.cancel();
            timer.purge();
            timer = null;
            isScheduled = false;
        }
        System.out.println("Progress monitor stoped.");
    }

    public void start() {
        System.out.println("Try to start progress monitor.");
        if (timer == null) {
            timer = new Timer();
        }
        timer.schedule(this, 1000, progressInterval);
        isScheduled = true;
        System.out.println("Progress monitor started.");
    }

    /**
     * 打印progress信息
     * @param transfered
     */
    private void sendProgressMessage(long transfered) {
        if (fileSize != 0) {
            double d = ((double)transfered * 100)/(double)fileSize;
            DecimalFormat df = new DecimalFormat( "#.##");
            System.out.println("Sending progress message: " + df.format(d) + "%");
        } else {
            System.out.println("Sending progress message: " + transfered);
        }
    }

    /**
     * 实现了SftpProgressMonitor接口的count方法
     */
    public boolean count(long count) {
        if (isEnd()) return false;
        if (!isScheduled) {
            start();
        }
        add(count);
        return true;
    }

    /**
     * 实现了SftpProgressMonitor接口的end方法
     */
    public void end() {
        setEnd(true);
        System.out.println("transfering end.");
    }

    private synchronized void add(long count) {
        transfered = transfered + count;
    }

    private synchronized long getTransfered() {
        return transfered;
    }

    public synchronized void setTransfered(long transfered) {
        this.transfered = transfered;
    }

    private synchronized void setEnd(boolean isEnd) {
        this.isEnd = isEnd;
    }

    private synchronized boolean isEnd() {
        return isEnd;
    }

    public void init(int op, String src, String dest, long max) {
        // Not used for putting InputStream
    }
}
