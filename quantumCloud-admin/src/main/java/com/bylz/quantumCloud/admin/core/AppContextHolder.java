package com.bylz.quantumCloud.admin.core;

import javax.servlet.ServletContext;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.stereotype.Component;
import org.springframework.web.context.ServletContextAware;

import com.likegene.framework.util.SettingUtil;

/**
 *
 * @author JT
 * @version 1.0
 * @since 2016-5-21
 */
@Component
public class AppContextHolder implements ServletContextAware
{
    public static final String USER_INFO = "USER_INFO";

    private static String  CONTEXTPATH;

    private static String  REALPATH;

    private static String  FILECONTEXTPATH;

    private static String  FILESAVEPATH;

    private static String BLOCKSAVEPATH;

    private static String BLOCKVIDEOSAVEPATH;

    private static boolean initialized = false;

    public static void init(ServletContext servletContext)
    {
        FILECONTEXTPATH = SettingUtil.getSetting("files.contextpath", null)
                .toString();
        if (!(FILECONTEXTPATH.startsWith("http://") || FILECONTEXTPATH
                .startsWith("/")))
        {
            FILECONTEXTPATH = servletContext.getContextPath() + "/"
                    + FILECONTEXTPATH;
        }
        CONTEXTPATH = servletContext.getContextPath();
        REALPATH = servletContext.getRealPath("/");

        FILESAVEPATH = SettingUtil.getSetting("uploadfilesavepath", null)
                .toString();
        if (!(FILESAVEPATH.contains(":") || FILESAVEPATH.startsWith("/")))
        {
            FILESAVEPATH = servletContext.getRealPath("/") + FILESAVEPATH;
        }

        BLOCKSAVEPATH = SettingUtil.getSetting("blocksavepath", null).toString();
        if (!(BLOCKSAVEPATH.contains(":") || BLOCKSAVEPATH.startsWith("/")))
        {
            BLOCKSAVEPATH = servletContext.getRealPath("/") + BLOCKSAVEPATH;
        }

        BLOCKVIDEOSAVEPATH = SettingUtil.getSetting("blockvideosavepath", null).toString();
        if (!(BLOCKVIDEOSAVEPATH.contains(":") || BLOCKVIDEOSAVEPATH.startsWith("/")))
        {
            BLOCKVIDEOSAVEPATH = servletContext.getRealPath("/") + BLOCKVIDEOSAVEPATH;
        }

        SettingUtil.putAllToServletContext(servletContext);
        servletContext.setAttribute("FILESAVEPATH", FILESAVEPATH);
        servletContext.setAttribute("FILECONTEXTPATH", FILECONTEXTPATH);
        servletContext.setAttribute("BLOCKSAVEPATH", BLOCKSAVEPATH);
        servletContext.setAttribute("BLOCKVIDEOSAVEPATH", BLOCKVIDEOSAVEPATH);
        initialized = true;
    }

    public static String getContextPath()
    {
        return CONTEXTPATH;
    }

    public static String getRealPath()
    {
        return REALPATH;
    }

    public static String getFileContextPath()
    {
        return FILECONTEXTPATH;
    }

    public static String getFileSavePath()
    {
        return FILESAVEPATH;
    }

    public static boolean isInitialized()
    {
        return initialized;
    }

    public static <T> T getCurrentUser()
    {
        try
        {
            if (SecurityUtils.getSubject() == null
                    || SecurityUtils.getSubject().getSession() == null)
                return null;
            return (T) SecurityUtils.getSubject().getSession()
                    .getAttribute(USER_INFO);
        }
        catch (Exception e)
        {
        }
        return null;
    }

    public static Session getSession()
    {
        try
        {
            if (SecurityUtils.getSubject() == null)
                return null;
            return SecurityUtils.getSubject().getSession();
        }
        catch (Exception e)
        {
        }
        return null;
    }

    public static String getBlockSavePath() {
        return BLOCKSAVEPATH;
    }

    public static String getBlockVideoSavePath() {
        return BLOCKVIDEOSAVEPATH;
    }

    @Override
    public void setServletContext(ServletContext arg0)
    {
        init(arg0);
    }
}
