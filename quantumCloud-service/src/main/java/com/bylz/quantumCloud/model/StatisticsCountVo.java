package com.bylz.quantumCloud.model;

import java.io.Serializable;
import java.util.Date;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/2/26
 */
public class StatisticsCountVo implements Serializable {
    private static final long serialVersionUID = 6126798250323195400L;

    private int userCount;

    private int taskCount;

    private Date ObtainDate;

    public int getUserCount() {
        return userCount;
    }

    public void setUserCount(int userCount) {
        this.userCount = userCount;
    }

    public int getTaskCount() {
        return taskCount;
    }

    public void setTaskCount(int taskCount) {
        this.taskCount = taskCount;
    }

    public Date getObtainDate() {
        return ObtainDate;
    }

    public void setObtainDate(Date obtainDate) {
        ObtainDate = obtainDate;
    }
}
