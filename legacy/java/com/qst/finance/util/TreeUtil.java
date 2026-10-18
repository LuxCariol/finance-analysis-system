package com.qst.finance.util;

import java.util.ArrayList;
import java.util.List;

import com.qst.finance.common.TreeObject;

/**
 * 树结构工具(菜单管理使用)
 */
public final class TreeUtil {

    private TreeUtil() {
    }

    /**
     * 将平铺列表组装为树
     */
    public static List<TreeObject> build(List<TreeObject> list, Long rootParentId) {
        List<TreeObject> roots = new ArrayList<TreeObject>();
        if (list == null) {
            return roots;
        }
        for (TreeObject node : list) {
            if (rootParentId.equals(node.getParentId())) {
                roots.add(node);
            }
        }
        for (TreeObject root : roots) {
            fill(root, list);
        }
        return roots;
    }

    private static void fill(TreeObject parent, List<TreeObject> all) {
        for (TreeObject node : all) {
            if (parent.getId() != null && parent.getId().equals(node.getParentId())) {
                parent.getChildren().add(node);
                fill(node, all);
            }
        }
    }
}
