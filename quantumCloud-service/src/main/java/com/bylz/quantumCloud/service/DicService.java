package com.bylz.quantumCloud.service;

import com.likegene.framework.core.Pagination;
import com.likegene.framework.core.QueryFilter;

import java.util.Map;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:字典接口
 * @since 2018/8/6
 */
public interface DicService {

    /**
     * 添加字典
     * @param filter
     * @return
     */
    int saveDic(QueryFilter filter);

    /**
     * 分页查询字典
     * @param filter
     * @return
     */
    Pagination getDicListByPage(QueryFilter filter);

    /**
     * 根据id查询字典
     * @param filter
     * @return
     */
    Map<String,Object> getDicById(QueryFilter filter);

    /**
     * 删除字典
     * @param filter
     * @return
     */
    int delDic(QueryFilter filter);

    /**
     * 修改字典
     * @param filter
     * @return
     */
    int updDic(QueryFilter filter);

    /**
     * 根据字典Id获取字典内容
     * @param filter
     * @return
     */
    Pagination getDicContentById(QueryFilter filter);

    /**
     * 添加字典内容
     * @param filter
     */
    void saveDicContent(QueryFilter filter);

    /**
     * 根据id获取字典内容
     * @param filter
     * @return
     */
    Map<String,Object> getDicContent(QueryFilter filter);

    /**
     * 修改字典内容
     * @param filter
     */
    void updDicContent(QueryFilter filter);

    /**
     * 删除字典内容
     * @param filter
     */
    void delDicContent(QueryFilter filter);
}
