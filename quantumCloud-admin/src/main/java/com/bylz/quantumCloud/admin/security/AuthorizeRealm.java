package com.bylz.quantumCloud.admin.security;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.crypto.hash.Sha256Hash;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;
import org.springframework.stereotype.Service;

import com.likegene.framework.core.QueryFilter;
import com.bylz.quantumCloud.model.SysRoleResource;
import com.bylz.quantumCloud.model.SysUser;
import com.bylz.quantumCloud.service.SysRoleResourceService;
import com.bylz.quantumCloud.service.SysUserService;

/**
 * 
 * shiro用户权限控制
 * 
 * @author liuxiantao
 * @version 1.0
 * @since 2015-7-20
 */
@Service("authorizeRealm")
public class AuthorizeRealm extends AuthorizingRealm
{
    private Logger Logger = LoggerFactory.getLogger(AuthorizeRealm.class);
    
    private final static String ROLE_PREFIX = "ROLE:"; 
    
    @Autowired
    private CacheManager cacheManager;

    @Autowired
    private SysRoleResourceService sysRoleResourceService;
    
    @Autowired
    private SysUserService sysUserService;
    
    public AuthorizeRealm()
    {
        setName("AuthorizeProvider");
        setCredentialsMatcher(new HashedCredentialsMatcher(
                Sha256Hash.ALGORITHM_NAME));
    }

    /**
     * validate the login method of user name and password
     * 
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(
            AuthenticationToken authcToken) throws AuthenticationException
    {
    	UsernamePasswordToken token = (UsernamePasswordToken) authcToken;
        String pwd = new Sha256Hash(new String(token.getPassword())).toHex();
        String username = token.getUsername();
        
        return new SimpleAuthenticationInfo(username, pwd, getName());
    }

    /**
     * get the permission add into the simpleAuthorizationInfo
     */
	@Override
    protected AuthorizationInfo doGetAuthorizationInfo(
            PrincipalCollection principals)
    {
        String username = (String) principals.fromRealm(getName()).iterator()
                .next();
        if (username != null)
        {
            String permissionKey = ROLE_PREFIX+username;
            Cache cache = cacheManager.getCache("USER_ROLES");
            
            if (cache == null || cache.get(permissionKey) == null){
                Logger.debug("加载权限信息");
                SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
                Set<String> roles = new HashSet<String>();
                QueryFilter checkfilter=new QueryFilter();
                checkfilter.setStatementKey("login");
                checkfilter.put("username", username);
                SysUser checkUser=this.sysUserService.findOne(checkfilter).getReturnObj();
                if (username.equals("admin") || checkUser.getIsSuperadmin().intValue()==1){
                    roles.add("ADMIN");
                } else {
                    //查询用户权限
                    QueryFilter filter = new QueryFilter();
                    filter.setStatementKey("selectAuthorization");
                    filter.put("username",username);
                    List<SysRoleResource> resourceList  = sysRoleResourceService.findList(filter).getReturnObj();
                    for(SysRoleResource re:resourceList){
                        roles.add(re.getResource());
                    }                  
                }
                roles.add("NONE");
                info.setRoles(roles);
                cache.put(permissionKey, info);
                return info;
            } else {
                Logger.debug("从缓存中读取权限信息");
                SimpleAuthorizationInfo info = (SimpleAuthorizationInfo) cache.get(permissionKey).get();
                return info;
            }
        }
        else
        {
        	return null;
        }
    }
    
    

}
