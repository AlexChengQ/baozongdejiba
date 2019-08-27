package com.bylz.quantumCloud.service.impl;


import com.bylz.quantumCloud.model.ReadBook;
import com.bylz.quantumCloud.service.BannerService;
import com.bylz.quantumCloud.service.DicService;
import com.bylz.quantumCloud.service.ReadBookService;
import com.likegene.framework.core.BaseServiceImpl;
import com.likegene.framework.core.Pagination;
import com.likegene.framework.core.QueryFilter;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

/**
 * @author songhaozhang
 * @version 1.0
 * @Description:
 * @since 
 */
@Service
public class ReadBookServiceImpl extends BaseServiceImpl<ReadBook, Integer> implements ReadBookService{


    @Override
    public String getNamespace() {
        return ReadBook.class.getSimpleName();
    }
}
