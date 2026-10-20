package com.qst.finance.service;

import com.qst.finance.common.DbUtils;
import com.qst.finance.common.SecurityUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class AuthService {
    private final JdbcTemplate jdbc;
    private final TokenStore tokenStore;

    public AuthService(JdbcTemplate jdbc, TokenStore tokenStore) {
        this.jdbc = jdbc;
        this.tokenStore = tokenStore;
    }

    public LoginUser login(String account, String password) {
        if (account == null || password == null) {
            return null;
        }
        String sql = "SELECT u.id, u.user_name, u.account_name, u.pwd, u.description, u.account_type, u.org_id, "
                + "ur.role_id, r.name AS role_name "
                + "FROM t_sys_user u "
                + "LEFT JOIN t_sys_user_role ur ON ur.user_id = u.id "
                + "LEFT JOIN t_sys_role r ON r.id = ur.role_id "
                + "WHERE u.account_name = ? AND u.locked = 0 ORDER BY ur.id LIMIT 1";
        List<Map<String, Object>> rows = jdbc.queryForList(sql, account.trim());
        if (rows.isEmpty()) {
            return null;
        }
        Map<String, Object> row = DbUtils.camelRow(rows.get(0));
        String stored = DbUtils.str(row, "pwd", "");
        String md5 = SecurityUtils.md5(password);
        if (!stored.equalsIgnoreCase(md5) && !stored.equals(password)) {
            return null;
        }
        LoginUser user = toUser(row);
        String token = SecurityUtils.token();
        tokenStore.put(token, user);
        return user;
    }

    public LoginUser findByAccount(String account) {
        String sql = "SELECT u.id, u.user_name, u.account_name, u.description, u.account_type, u.org_id, "
                + "ur.role_id, r.name AS role_name FROM t_sys_user u "
                + "LEFT JOIN t_sys_user_role ur ON ur.user_id = u.id "
                + "LEFT JOIN t_sys_role r ON r.id = ur.role_id WHERE u.account_name = ? LIMIT 1";
        Map<String, Object> row = DbUtils.queryOne(jdbc, sql, account);
        return row == null ? null : toUser(row);
    }

    public LoginUser findById(Long id) {
        String sql = "SELECT u.id, u.user_name, u.account_name, u.description, u.account_type, u.org_id, "
                + "ur.role_id, r.name AS role_name FROM t_sys_user u "
                + "LEFT JOIN t_sys_user_role ur ON ur.user_id = u.id "
                + "LEFT JOIN t_sys_role r ON r.id = ur.role_id WHERE u.id = ? LIMIT 1";
        Map<String, Object> row = DbUtils.queryOne(jdbc, sql, id);
        return row == null ? null : toUser(row);
    }

    private LoginUser toUser(Map<String, Object> row) {
        LoginUser user = new LoginUser();
        user.setId(Long.valueOf(String.valueOf(row.get("id"))));
        user.setUserName(DbUtils.str(row, "userName"));
        user.setAccountName(DbUtils.str(row, "accountName"));
        user.setDescription(DbUtils.str(row, "description"));
        user.setAccountType((int) DbUtils.num(row, "accountType"));
        Double orgId = DbUtils.number(row, "orgId");
        user.setOrgId(orgId == null ? null : orgId.longValue());
        Double roleId = DbUtils.number(row, "roleId");
        user.setRoleId(roleId == null ? null : roleId.longValue());
        user.setRoleName(DbUtils.str(row, "roleName"));
        return user;
    }
}
