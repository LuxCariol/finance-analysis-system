package com.qst.finance.service;

import com.qst.finance.common.DbUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service
public class MenuService {
    private final JdbcTemplate jdbc;

    public MenuService(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    public List<Map<String, Object>> allMenus() {
        List<Map<String, Object>> rows = DbUtils.query(jdbc,
                "SELECT id, name, parent_id, res_key, type, res_url, order_no, icon, btn, is_hide, description "
                        + "FROM t_sys_resources ORDER BY order_no, id");
        for (Map<String, Object> row : rows) {
            row.put("children", new ArrayList<Map<String, Object>>());
        }
        return rows;
    }

    public List<Map<String, Object>> tree(boolean onlyMenu) {
        List<Map<String, Object>> rows = allMenus();
        Map<Integer, Map<String, Object>> byId = new LinkedHashMap<Integer, Map<String, Object>>();
        for (Map<String, Object> row : rows) {
            byId.put(((Number) row.get("id")).intValue(), row);
        }
        List<Map<String, Object>> roots = new ArrayList<Map<String, Object>>();
        for (Map<String, Object> row : rows) {
            int parentId = ((Number) row.get("parentId")).intValue();
            int type = Integer.parseInt(String.valueOf(row.get("type")));
            if (onlyMenu && type == 2) {
                continue;
            }
            if (parentId == 0) {
                roots.add(row);
            } else {
                Map<String, Object> parent = byId.get(parentId);
                if (parent != null) {
                    children(parent).add(row);
                }
            }
        }
        sortTree(roots);
        return roots;
    }

    @SuppressWarnings("unchecked")
    private List<Map<String, Object>> children(Map<String, Object> node) {
        Object children = node.get("children");
        if (!(children instanceof List)) {
            children = new ArrayList<Map<String, Object>>();
            node.put("children", children);
        }
        return (List<Map<String, Object>>) children;
    }

    private void sortTree(List<Map<String, Object>> nodes) {
        Collections.sort(nodes, new Comparator<Map<String, Object>>() {
            @Override
            public int compare(Map<String, Object> a, Map<String, Object> b) {
                int orderA = (int) DbUtils.num(a, "orderNo");
                int orderB = (int) DbUtils.num(b, "orderNo");
                return orderA == orderB ? ((Number) a.get("id")).intValue() - ((Number) b.get("id")).intValue()
                        : orderA - orderB;
            }
        });
        for (Map<String, Object> node : nodes) {
            sortTree(children(node));
        }
    }

    public List<Map<String, Object>> buttons(long parentId) {
        List<Map<String, Object>> rows = DbUtils.query(jdbc,
                "SELECT id, name, res_key, btn, description FROM t_sys_resources "
                        + "WHERE parent_id = ? AND type = '2' ORDER BY order_no, id", parentId);
        if (rows.isEmpty()) {
            Map<String, Object> button = new LinkedHashMap<String, Object>();
            button.put("btn", "addFun,addFun,btn btn-xs btn-info,新增");
            rows.add(button);
        }
        return rows;
    }

    public List<Map<String, Object>> roleMenus(Long roleId) {
        return DbUtils.query(jdbc,
                "SELECT r.id, r.parent_id, r.type, r.name FROM t_sys_resources r "
                        + "JOIN t_sys_role_action a ON a.res_id = r.id WHERE a.role_id = ?", roleId);
    }
}
