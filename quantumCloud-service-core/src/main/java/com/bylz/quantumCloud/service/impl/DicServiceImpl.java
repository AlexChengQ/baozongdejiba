package com.bylz.quantumCloud.service.impl;

import com.bylz.quantumCloud.model.DicValueVo;
import com.bylz.quantumCloud.service.DicService;
import com.likegene.framework.core.BaseServiceImpl;
import com.likegene.framework.core.Pagination;
import com.likegene.framework.core.QueryFilter;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2018/8/6
 */
@Service
public class DicServiceImpl extends BaseServiceImpl<DicValueVo, Long> implements DicService{
    /**
     * 添加字典
     *
     * @param filter
     * @return
     */
    @Override
    public int saveDic(QueryFilter filter) {
        filter.setStatementKey("saveDic");
        return this.save(filter).getReturnObj();
    }

    /**
     * 分页查询字典
     *
     * @param filter
     * @return
     */
    @Override
    public Pagination getDicListByPage(QueryFilter filter) {
        filter.setStatementKey("getDicList");
        return this.findPager(filter).getReturnObj();
    }

    /**
     * 根据id查询字典
     *
     * @param filter
     * @return
     */
    @Override
    public Map<String, Object> getDicById(QueryFilter filter) {
        filter.setStatementKey("getDicList");
        return this.findOne(filter).getReturnObj();
    }

    /**
     * 删除字典
     *
     * @param filter
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public int delDic(QueryFilter filter) {
        filter.setStatementKey("delDic");
        this.delete(filter).getReturnObj();
        filter.setStatementKey("delDicContent");
        filter.put("isDelAll",1);
        filter.put("dicId",filter.get("id"));
        this.delete(filter);
        return 1;
    }

    /**
     * 修改字典
     *
     * @param filter
     * @return
     */
    @Override
    public int updDic(QueryFilter filter) {
        return this.update(filter).getReturnObj();
    }

    /**
     * 根据字典Id获取字典内容
     *
     * @param filter
     * @return
     */
    @Override
    public Pagination getDicContentById(QueryFilter filter) {
        filter.setStatementKey("getDicContentById");
        return this.findPager(filter).getReturnObj();
    }

    /**
     * 添加字典内容
     * @param filter
     */
    @Override
    public void saveDicContent(QueryFilter filter) {
        filter.setStatementKey("saveDicContent");
        this.save(filter);
    }

    /**
     * 根据id获取字典内容
     *
     * @param filter
     * @return
     */
    @Override
    public Map<String, Object> getDicContent(QueryFilter filter) {
        filter.setStatementKey("getDicContent");
        return this.findOne(filter).getReturnObj();
    }

    /**
     * 修改字典内容
     *
     * @param filter
     */
    @Override
    public void updDicContent(QueryFilter filter) {
        filter.setStatementKey("updDicContent");
        this.update(filter);
    }

    /**
     * 删除字典内容
     *
     * @param filter
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public void delDicContent(QueryFilter filter) {
        filter.setStatementKey("delDicContent");
        this.delete(filter);
    }

    @Override
    public String getNamespace() {
        return DicValueVo.class.getSimpleName();
    }
}
