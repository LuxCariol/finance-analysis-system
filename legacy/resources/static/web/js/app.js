/* ==========================================================================
 * 前端通用框架: 表格 / 分页 / 表单弹窗 / 通用增删改查 / 提示
 * ========================================================================== */
var Cw = (function () {
    var orgCache = null;

    function el(selector, root) {
        return (root || document).querySelector(selector);
    }

    function els(selector, root) {
        return Array.prototype.slice.call((root || document).querySelectorAll(selector));
    }

    function esc(text) {
        if (text === null || text === undefined) {
            return '';
        }
        return String(text).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;');
    }

    function num(value) {
        if (value === null || value === undefined || value === '') {
            return 0;
        }
        var n = Number(value);
        return isNaN(n) ? 0 : n;
    }

    function fmtNum(value, scale) {
        if (value === null || value === undefined || value === '') {
            return '-';
        }
        var s = scale === undefined ? 2 : scale;
        return num(value).toLocaleString('zh-CN', {minimumFractionDigits: s, maximumFractionDigits: s});
    }

    function fmtMoney(value, scale) {
        if (value === null || value === undefined || value === '') {
            return '-';
        }
        return fmtNum(value, scale === undefined ? 2 : scale);
    }

    function fmtPercent(value, scale) {
        if (value === null || value === undefined || value === '') {
            return '-';
        }
        return (num(value) * 100).toFixed(scale === undefined ? 2 : scale) + '%';
    }

    function toast(message, type) {
        var node = document.createElement('div');
        node.className = 'toast ' + (type || 'info');
        node.textContent = message;
        document.body.appendChild(node);
        setTimeout(function () {
            node.style.transition = 'opacity .3s';
            node.style.opacity = '0';
            setTimeout(function () {
                document.body.removeChild(node);
            }, 320);
        }, 2200);
    }

    function closeModal() {
        els('.mask').forEach(function (mask) {
            mask.parentNode.removeChild(mask);
        });
    }

    function modal(options) {
        closeModal();
        var mask = document.createElement('div');
        mask.className = 'mask';
        var modalHtml = '<div class="modal" style="width:' + (options.width || 620) + 'px">'
            + '<div class="modal-head"><span>' + esc(options.title || '') + '</span>'
            + '<span class="close" data-close="1">&times;</span></div>'
            + '<div class="modal-body">' + (options.bodyHtml || '') + '</div>'
            + '<div class="modal-foot">'
            + '<button class="btn" data-close="1">取消</button>'
            + (options.hideOk ? '' : '<button class="btn primary" data-ok="1">' + (options.okText || '保存') + '</button>')
            + '</div></div>';
        mask.innerHTML = modalHtml;
        document.body.appendChild(mask);
        mask.addEventListener('click', function (event) {
            if (event.target.getAttribute('data-close') || event.target === mask) {
                closeModal();
                if (options.onCancel) {
                    options.onCancel();
                }
            }
            if (event.target.getAttribute('data-ok')) {
                if (!options.onOk) {
                    closeModal();
                    return;
                }
                var ok = options.onOk(els('.modal-body', mask)[0]);
                if (ok !== false) {
                    closeModal();
                }
            }
        });
        if (options.afterRender) {
            options.afterRender(els('.modal-body', mask)[0]);
        }
        return mask;
    }

    function confirmDialog(message, onConfirm) {
        modal({
            title: '操作确认',
            width: 420,
            bodyHtml: '<div style="padding:6px 2px;font-size:14px;line-height:1.8">' + esc(message) + '</div>',
            okText: '确定',
            onOk: function () {
                onConfirm();
            }
        });
    }

    function fieldHtml(item, value) {
        var name = item.field;
        var val = value === undefined || value === null ? (item.defaultValue === undefined ? '' : item.defaultValue) : value;
        if (item.type === 'select') {
            var options = ['<option value="">请选择</option>'];
            (item.options || []).forEach(function (opt) {
                var key = opt.value === undefined ? opt : opt.value;
                var text = opt.text === undefined ? opt : opt.text;
                options.push('<option value="' + esc(key) + '"' + (String(key) === String(val) ? ' selected' : '') + '>'
                    + esc(text) + '</option>');
            });
            return '<select data-field="' + name + '" ' + (item.disabled ? 'disabled' : '') + '>'
                + options.join('') + '</select>';
        }
        if (item.type === 'checkboxGroup') {
            var boxes = [];
            var current = Array.isArray(val) ? val.map(String) : [];
            (item.options || []).forEach(function (opt) {
                var key = opt.value === undefined ? opt : opt.value;
                var text = opt.text === undefined ? opt : opt.text;
                boxes.push('<label><input type="checkbox" data-field="' + name + '" value="' + esc(key) + '"'
                    + (current.indexOf(String(key)) >= 0 ? ' checked' : '') + '>' + esc(text) + '</label>');
            });
            return '<div class="checkbox-group">' + boxes.join('') + '</div>';
        }
        if (item.type === 'textarea') {
            return '<textarea data-field="' + name + '" rows="' + (item.rows || 4) + '" placeholder="'
                + esc(item.placeholder || '') + '">' + esc(val) + '</textarea>';
        }
        if (item.type === 'file') {
            return '<input type="file" data-field="' + name + '" accept=".xls,.xlsx">';
        }
        var inputType = item.type || 'text';
        return '<input type="' + inputType + '" data-field="' + name + '" value="' + esc(val) + '" placeholder="'
            + esc(item.placeholder || '') + '" ' + (item.disabled ? 'disabled' : '') + '>';
    }

    function formHtml(fields, data) {
        var html = ['<div class="form-grid">'];
        (fields || []).forEach(function (item) {
            var val = data ? data[item.field] : undefined;
            html.push('<div class="lbl">' + (item.required ? '<em>*</em>' : '') + esc(item.title) + '</div>');
            html.push('<div class="' + (item.full ? 'full' : '') + '">' + fieldHtml(item, val) + '</div>');
        });
        html.push('</div>');
        return html.join('');
    }

    function readForm(root) {
        var data = {};
        els('[data-field]', root).forEach(function (node) {
            var field = node.getAttribute('data-field');
            if (node.type === 'checkbox') {
                if (!data[field]) {
                    data[field] = [];
                }
                if (node.checked) {
                    data[field].push(node.value);
                }
            } else if (node.type === 'radio') {
                if (node.checked) {
                    data[field] = node.value;
                }
            } else if (node.disabled) {
                // 忽略禁用字段
            } else {
                data[field] = node.value;
            }
        });
        return data;
    }

    function renderTable(container, columns, rows, options) {
        options = options || {};
        if (!rows || !rows.length) {
            container.innerHTML = '<div class="empty">' + (options.emptyText || '暂无数据') + '</div>';
            return;
        }
        var html = ['<table class="data"><thead><tr>'];
        columns.forEach(function (col) {
            html.push('<th class="' + (col.align === 'right' ? 'num' : '') + '"'
                + (col.width ? ' style="width:' + col.width + '"' : '') + '>' + esc(col.title) + '</th>');
        });
        html.push('</tr></thead><tbody>');
        rows.forEach(function (row, index) {
            html.push('<tr>');
            columns.forEach(function (col) {
                var content = col.render ? col.render(row, index) : esc(row[col.field]);
                if (content === undefined || content === null) {
                    content = '';
                }
                html.push('<td class="' + (col.align === 'right' ? 'num' : '') + '">' + content + '</td>');
            });
            html.push('</tr>');
        });
        html.push('</tbody></table>');
        container.innerHTML = html.join('');
        if (options.afterRender) {
            options.afterRender(container);
        }
    }

    function levelBadge(level, text) {
        var cls = level >= 3 ? 'red' : (level === 2 ? 'orange' : (level === 1 ? 'yellow' : 'green'));
        return '<span class="badge ' + cls + '">' + esc(text || (level >= 3 ? '严重' : (level === 2 ? '警告' : (level === 1 ? '提示' : '正常')))) + '</span>';
    }

    function changeHtml(value, rate) {
        var cls = num(value) > 0 ? 'up' : (num(value) < 0 ? 'down' : '');
        var rateText = (rate === null || rate === undefined) ? '-' : fmtPercent(rate);
        return '<span class="' + cls + '">' + (num(value) > 0 ? '↑' : (num(value) < 0 ? '↓' : ''))
            + ' ' + fmtMoney(value, 2) + '</span> <span class="text-light">(' + rateText + ')</span>';
    }

    /** 通用增删改查页面 */
    function crud(config) {
        var state = {pageNum: 1, pageSize: config.pageSize || 10, rows: [], total: 0, query: {}};
        var root = document.createElement('div');
        root.className = 'page';
        var searchHtml = '';
        if (config.searchFields && config.searchFields.length) {
            searchHtml = (config.searchFields || []).map(function (item) {
                var inner;
                if (item.type === 'select') {
                    inner = fieldHtml(item, item.value);
                } else if (item.type === 'month') {
                    inner = '<input type="month" data-search="' + item.field + '" value="' + esc(item.value || '') + '">';
                } else {
                    inner = '<input type="text" data-search="' + item.field + '" placeholder="' + esc(item.title) + '" value="'
                        + esc(item.value || '') + '">';
                }
                return inner;
            }).join('');
        }
        root.innerHTML = '<div class="page-head"><div><h2>' + esc(config.title) + '</h2>'
            + (config.desc ? '<div class="desc">' + esc(config.desc) + '</div>' : '')
            + '</div><div class="toolbar" id="head-tools"></div></div>'
            + (config.tips ? '<div class="tip">' + config.tips + '</div>' : '')
            + (config.extraHtml || '')
            + '<div class="card"><div class="toolbar">' + searchHtml
            + (searchHtml ? '<button class="btn primary" data-action="search">查询</button>'
                + '<button class="btn" data-action="reset">重置</button>' : '')
            + '<span class="spacer"></span>'
            + (config.saveUrl ? '<button class="btn primary" data-action="add">+ 新增</button>' : '')
            + '</div><div id="table-box"></div><div class="pager" id="pager-box"></div></div>';
        (config.container || document.body).appendChild(root);

        var tableBox = el('#table-box', root);
        var pagerBox = el('#pager-box', root);

        function load() {
            var params = {};
            for (var key in state.query) {
                params[key] = state.query[key];
            }
            if (config.pageList) {
                params.pageNum = state.pageNum;
                params.pageSize = state.pageSize;
            }
            tableBox.innerHTML = '<div class="empty">加载中...</div>';
            Api.get(config.listUrl, params).then(function (data) {
                var rows = config.pageList ? data.rows : data;
                state.rows = rows || [];
                state.total = config.pageList ? data.total : state.rows.length;
                renderTable(tableBox, columns(), state.rows, {emptyText: config.emptyText || '暂无数据'});
                renderPager();
            }).catch(function (error) {
                tableBox.innerHTML = '<div class="empty">加载失败: ' + esc(error.message) + '</div>';
            });
        }

        function columns() {
            var list = (config.columns || []).slice();
            if (config.rowActions && config.rowActions.length) {
                list.push({
                    title: '操作',
                    width: config.actionWidth || '170px',
                    render: function (row) {
                        return (config.rowActions || []).map(function (action) {
                            if (action.visible && !action.visible(row)) {
                                return '';
                            }
                            return '<button class="btn small ' + (action.className || '') + '" data-action="'
                                + esc(action.action) + '" data-id="' + esc(row[config.idField || 'id']) + '">'
                                + esc(action.text) + '</button> ';
                        }).join('');
                    }
                });
            }
            return list;
        }

        function renderPager() {
            if (!config.pageList || state.total <= state.pageSize) {
                pagerBox.innerHTML = '<span class="text-light">共 ' + state.total + ' 条</span>';
                return;
            }
            var pages = Math.ceil(state.total / state.pageSize);
            pagerBox.innerHTML = '<span>共 ' + state.total + ' 条</span>'
                + '<button class="btn small" data-page="prev"' + (state.pageNum <= 1 ? ' disabled' : '') + '>上一页</button>'
                + '<span>' + state.pageNum + ' / ' + pages + '</span>'
                + '<button class="btn small" data-page="next"' + (state.pageNum >= pages ? ' disabled' : '') + '>下一页</button>';
        }

        function openForm(row) {
            var fields = typeof config.formFields === 'function' ? config.formFields(row) : config.formFields;
            modal({
                title: (row ? '编辑' : '新增') + config.title,
                width: config.formWidth || 640,
                bodyHtml: formHtml(fields, row || {}),
                okText: '保存',
                afterRender: function (body) {
                    if (config.afterFormRender) {
                        config.afterFormRender(body, row || {});
                    }
                },
                onOk: function (body) {
                    var data = readForm(body);
                    var error = validate(fields, data);
                    if (error) {
                        toast(error, 'error');
                        return false;
                    }
                    if (row) {
                        data[config.idField || 'id'] = row[config.idField || 'id'];
                    }
                    if (config.onBeforeSave) {
                        var modified = config.onBeforeSave(data, row);
                        if (modified === false) {
                            return false;
                        }
                        if (modified) {
                            data = modified;
                        }
                    }
                    Api.post(config.saveUrl, data).then(function () {
                        toast('保存成功', 'success');
                        load();
                        if (config.onAfterSave) {
                            config.onAfterSave();
                        }
                    }).catch(function (e) {
                        toast(e.message, 'error');
                    });
                    return true;
                }
            });
        }

        function validate(fields, data) {
            for (var i = 0; i < (fields || []).length; i++) {
                var item = fields[i];
                if (item.required) {
                    var value = data[item.field];
                    if (value === undefined || value === null || value === '' || (Array.isArray(value) && !value.length)) {
                        return '请填写: ' + item.title;
                    }
                }
            }
            return null;
        }

        root.addEventListener('click', function (event) {
            var target = event.target;
            var action = target.getAttribute('data-action');
            if (action === 'search') {
                state.query = {};
                els('[data-search]', root).forEach(function (input) {
                    state.query[input.getAttribute('data-search')] = input.value;
                });
                state.pageNum = 1;
                load();
                return;
            }
            if (action === 'reset') {
                els('[data-search]', root).forEach(function (input) {
                    input.value = '';
                });
                state.query = {};
                state.pageNum = 1;
                load();
                return;
            }
            if (action === 'add') {
                openForm(null);
                return;
            }
            if (target.hasAttribute('data-page')) {
                if (target.getAttribute('data-page') === 'prev' && state.pageNum > 1) {
                    state.pageNum--;
                }
                if (target.getAttribute('data-page') === 'next' && state.pageNum * state.pageSize < state.total) {
                    state.pageNum++;
                }
                load();
                return;
            }
            if (action) {
                var id = target.getAttribute('data-id');
                var row = null;
                state.rows.forEach(function (item) {
                    if (String(item[config.idField || 'id']) === String(id)) {
                        row = item;
                    }
                });
                if (action === 'edit' && row) {
                    if (config.beforeEdit) {
                        config.beforeEdit(row, function (detail) {
                            openForm(detail);
                        });
                    } else {
                        openForm(row);
                    }
                }
                if (action === 'delete' && row) {
                    confirmDialog('确定要删除该记录吗？删除后不可恢复。', function () {
                        Api.postParam(config.deleteUrl, {id: row[config.idField || 'id']}).then(function () {
                            toast('删除成功', 'success');
                            load();
                        }).catch(function (e) {
                            toast(e.message, 'error');
                        });
                    });
                }
                (config.rowActions || []).forEach(function (item) {
                    if (item.action === action && item.onClick) {
                        item.onClick(row, id);
                    }
                });
            }
        });

        state.reload = load;
        state.openForm = openForm;
        state.root = root;
        load();
        return state;
    }

    function loadOrgs() {
        if (orgCache) {
            return Promise.resolve(orgCache);
        }
        return Api.get('/api/sys/org/list').then(function (list) {
            orgCache = list || [];
            return orgCache;
        });
    }

    function orgOptions(callback) {
        loadOrgs().then(function (list) {
            callback((list || []).map(function (org) {
                return {value: org.id, text: org.orgName};
            }));
        });
    }

    function fillMonth(selector, month, onChange) {
        var input = el(selector);
        if (!input) {
            return;
        }
        input.value = month || '';
        if (onChange) {
            input.addEventListener('change', function () {
                onChange(input.value);
            });
        }
    }

    function kpiList(container, items) {
        var html = ['<div class="kpi-list">'];
        items.forEach(function (item) {
            html.push('<div class="kpi ' + (item.color || 'primary') + '">'
                + '<div class="label"><span>' + esc(item.label) + '</span>'
                + (item.badge ? levelBadge(item.badge, item.badgeText) : '') + '</div>'
                + '<div class="value">' + (item.htmlValue !== undefined ? item.htmlValue : esc(item.value)) + '</div>'
                + (item.sub ? '<div class="sub">' + item.sub + '</div>' : '')
                + '</div>');
        });
        html.push('</div>');
        container.innerHTML = html.join('');
    }

    function analysisItems(container, list) {
        if (!list || !list.length) {
            container.innerHTML = '<div class="empty">暂无指标数据，请先在【数据转换】中执行数据全量转换</div>';
            return;
        }
        var html = [];
        list.forEach(function (item) {
            html.push('<div class="analysis-item warn-' + (item.warnLevel || 0) + '">'
                + '<div class="head"><span class="name">' + esc(item.resultName || item.modeName) + '</span>'
                + '<span class="val">' + esc(item.displayValue || '-') + '</span></div>'
                + '<div style="font-size:12.5px;color:#7f8c9b">算法: <code>' + esc(item.calcExpression || '') + '</code> '
                + levelBadge(item.warnLevel, item.warnLevelText)
                + (item.momRate !== null && item.momRate !== undefined ? ' <span class="text-light">环比 '
                    + fmtPercent(item.momRate) + '</span>' : '') + '</div>'
                + '<dl>'
                + (item.warnDesc ? '<dt>预警说明</dt><dd class="up">' + esc(item.warnDesc) + '</dd>' : '')
                + (item.mainFactor ? '<dt>主要因素</dt><dd>' + esc(item.mainFactor) + '</dd>' : '')
                + (item.advantage ? '<dt>优点</dt><dd>' + esc(item.advantage) + '</dd>' : '')
                + (item.disadvantage ? '<dt>缺点</dt><dd>' + esc(item.disadvantage) + '</dd>' : '')
                + (item.advise ? '<dt>调整建议</dt><dd>' + esc(item.advise) + '</dd>' : '')
                + '</dl></div>');
        });
        container.innerHTML = html.join('');
    }

    return {
        el: el,
        els: els,
        esc: esc,
        num: num,
        fmtNum: fmtNum,
        fmtMoney: fmtMoney,
        fmtPercent: fmtPercent,
        toast: toast,
        modal: modal,
        closeModal: closeModal,
        confirm: confirmDialog,
        formHtml: formHtml,
        readForm: readForm,
        renderTable: renderTable,
        levelBadge: levelBadge,
        changeHtml: changeHtml,
        crud: crud,
        loadOrgs: loadOrgs,
        orgOptions: orgOptions,
        fillMonth: fillMonth,
        kpiList: kpiList,
        analysisItems: analysisItems
    };
})();
