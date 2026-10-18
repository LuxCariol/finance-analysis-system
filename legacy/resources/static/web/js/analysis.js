/* ==========================================================================
 * 分析/预测页面公共渲染
 * ========================================================================== */
var AnalysisPage = (function () {

    function shell(config) {
        var root = document.createElement('div');
        root.className = 'page';
        root.innerHTML = ''
            + '<div class="page-head"><div><h2>' + config.title + '</h2><div class="desc">' + config.desc + '</div></div>'
            + '<div class="toolbar">'
            + '<span class="text-light">公司</span><select id="orgSel" style="width:210px"></select>'
            + '<span class="text-light">会计年月</span><input type="month" id="monthSel">'
            + '<button class="btn primary" id="queryBtn">分析</button>'
            + (config.extraButton || '')
            + '</div></div>'
            + (config.tips ? '<div class="tip">' + config.tips + '</div>' : '')
            + (config.body || '');
        document.body.appendChild(root);
        return root;
    }

    function bindQuery(root, callback) {
        Cw.orgOptions(function (options) {
            var select = Cw.el('#orgSel', root);
            select.innerHTML = options.map(function (o) {
                return '<option value="' + o.value + '">' + o.text + '</option>';
            }).join('');
            select.value = '1';
            callback({orgId: select.value, kjyearMonth: Cw.el('#monthSel', root).value});
        });
        Cw.fillMonth('#monthSel', new Date().toISOString().slice(0, 7));
        Cw.el('#queryBtn', root).addEventListener('click', function () {
            callback({orgId: Cw.el('#orgSel', root).value, kjyearMonth: Cw.el('#monthSel', root).value});
        });
    }

    /** 比率分析 / 杜邦分析 / 资金预警 通用页面 */
    function indicatorPage(config) {
        var root = shell({
            title: config.title,
            desc: config.desc,
            tips: config.tips,
            body: ''
                + '<div class="card"><h3>指标概览 <small id="summary"></small></h3><div id="kpiBox"></div></div>'
                + '<div class="grid-2">'
                + '<div class="card"><h3>指标趋势(近6个月) <small id="trendTitle"></small></h3><div class="chart" id="trendChart"></div></div>'
                + '<div class="card"><h3>指标对比</h3><div class="chart" id="barChart"></div></div>'
                + '</div>'
                + '<div class="card"><h3>指标明细、预警与调整建议</h3><div id="listBox"></div></div>'
        });

        bindQuery(root, function (ctx) {
            Cw.el('#listBox', root).innerHTML = '<div class="empty">分析中...</div>';
            Api.get(config.api, ctx).then(function (data) {
                render(data, ctx);
            }).catch(function (e) {
                Cw.el('#listBox', root).innerHTML = '<div class="empty">分析失败: ' + Cw.esc(e.message) + '</div>';
            });
        });

        function render(data, ctx) {
            var list = data.list || [];
            var warnCount = data.warnCount || 0;
            Cw.el('#summary', root).innerHTML = '共 ' + list.length + ' 项指标，触发预警 <b class="up">' + warnCount + '</b> 项 · '
                + Cw.esc(data.kjyearMonth || '');
            var cards = list.slice(0, 6).map(function (item) {
                var level = item.warnLevel || 0;
                return {
                    label: item.resultName || item.modeName,
                    value: item.displayValue || '-',
                    badge: level,
                    badgeText: item.warnLevelText,
                    color: level >= 3 ? 'red' : (level === 2 ? 'orange' : (level === 1 ? 'orange' : 'green')),
                    sub: item.warnDesc ? Cw.esc(item.warnDesc) : '指标处于正常区间'
                };
            });
            Cw.kpiList(Cw.el('#kpiBox', root), cards);
            Cw.analysisItems(Cw.el('#listBox', root), list);
            renderCharts(list);
        }

        function renderCharts(list) {
            var top = list.slice(0, 8);
            CwChart.bar(Cw.el('#barChart', root),
                top.map(function (i) { return i.resultName || i.modeName; }),
                [{name: '当前值', data: top.map(function (i) { return Cw.num(i.value); }), color: '#2f6fed'}],
                {unit: ''});
            Cw.els('#listBox .analysis-item').forEach(function (node, index) {
                node.style.cursor = 'pointer';
                node.addEventListener('click', function () {
                    if (list[index]) {
                        loadTrend(list[index].modeCode, list[index].resultName || list[index].modeName);
                    }
                });
            });
            if (list.length) {
                loadTrend(list[0].modeCode, list[0].resultName || list[0].modeName);
            }
        }

        function loadTrend(modeCode, name) {
            Cw.el('#trendTitle').textContent = name ? '（' + name + '）' : '';
            Api.get('/api/analysis/trend', {
                modeCode: modeCode,
                orgId: Cw.el('#orgSel', root).value,
                kjyearMonth: Cw.el('#monthSel', root).value,
                months: 6
            }).then(function (series) {
                CwChart.line(Cw.el('#trendChart', root), series.months,
                    [{name: series.name || name, data: series.values, area: true, type: 'line'}], {unit: series.unit || ''});
            }).catch(function (e) {
                Cw.el('#trendChart', root).innerHTML = '<div class="empty">趋势数据加载失败: ' + Cw.esc(e.message) + '</div>';
            });
        }
    }

    return {shell: shell, bindQuery: bindQuery, indicatorPage: indicatorPage};
})();
