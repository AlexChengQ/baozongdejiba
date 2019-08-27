package com.bylz.quantumCloud.admin.core;

import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.core.SpringBeanUtil;
import com.bylz.quantumCloud.model.SysLog;
import com.bylz.quantumCloud.service.SysLogService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.*;

/**
 * 定时线程 每隔sleep秒执行一次 当用户操作日志队列(SysLogFilter.logs)长度超过length时，从队列取出length个元素批量保存到数据库
 * Created by Administrator on 2017/5/10 0010.
 */
public class SaveLogThread extends Thread {
    @Autowired
    private SysLogService sysLogService;
    //间隔时间
    private static int sleep = 10*1000;
    //临界长度
    private static int length = 50;

    @Override
    public synchronized void run() {
        this.sysLogService = SpringBeanUtil.getBean(SysLogService.class);
        while(true){
            try {
                Thread.sleep(sleep);
                //获取当前队列长度
                int size = SysLogFilter.logs.size();
                if(size>=length){
                    List<SysLog> list = new LinkedList<SysLog>();
                    //取队列元素
                    for (int i=0;i<length;i++){
                        list.add(SysLogFilter.logs.poll());
                    }

                    QueryFilter q = new QueryFilter();
                    q.setStatementKey("saveBatch");
                    q.put("list",list);
                    sysLogService.save(q);//批量保存
                }
            }catch (InterruptedException e){
                e.printStackTrace();
            }
        }
    }
}
