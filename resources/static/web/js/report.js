/* ==========================================================================
 * 三大报表页面公共渲染: 顶部条件区 + KPI + 分节明细表 + 图表
 * ========================================================================== */
var ReportPage = (function () {

    function render(config) {
        var root = document.createElement('div');
        root.className = 'page';
        root.innerHTML = ''
            + '<div class="page-head"><div><h2>' + config.title + '</h2><div class="desc">' + config.desc + '</div></div>'
            + '<div class="toolbar">'
            + '<span class="text-light">公司</span><select id="orgSel" style="width:220px"></select>'
            + '<span class="text-light">会计年月</span><input type="month" id="monthSel">'
            + '<button class="btn primary" id="queryBtn">查询</button>'
            + '</div></div>'
            + '<div class="card"><h3>关键指标 <small id="monthLabel"></small></h3><div id="kpiBox"></div></div>'
            + '<div class="grid-2">'
            + '<div class="card"><h3>主要科目金额对比</h3><div class="chart" id="barChart"></div></div>'
            + '<div class="card"><h3>结构占比</h3><div class="chart" id="pieChart"></div></div>'
            + '</div>'
            + '<div class="card"><h3>报表明细</h3><div id="tableBox"></div></div>';
        document.body.appendChild(root);

        var state = {orgId: 1, month: ''};
        Cw.orgOptions(function (options) {
            var select = Cw.el('#orgSel', root);
            select.innerHTML = options.map(function (o) {
                return '<option value="' + o.value + '">' + o.text + '</option>';
            }).join('');
            select.value = '1';
            load();
        });
        Cw.fillMonth('#monthSel', new Date().toISOString().slice(0, 7));
        Cw.el('#queryBtn', root).addEventListener('click', load);

        function load() {
            state.orgId = Cw.el('#orgSel', root).value;
            state.month = Cw.el('#monthSel', root).value;
            Cw.el('#tableBox', root).innerHTML = '<div class="empty">加载中...</div>';
            Api.get(config.api, {orgId: state.orgId, kjyearMonth: state.month}).then(function (data) {
                renderKpi(data);
                renderTable(data);
                renderCharts(data);
                Cw.el('#monthLabel', root).textContent = '会计年月: ' + data.kjyearMonth + ' · ' + data.compareLabel + ' vs '
                    + data.currentLabel;
            }).catch(function (e) {
                Cw.el('#tableBox', root).innerHTML = '<div class="empty">加载失败: ' + Cw.esc(e.message) + '</div>';
            });
        }

        function renderKpi(data) {
            var kpi = data.kpi || [];
            if (!kpi.length) {
                Cw.el('#kpiBox', root).innerHTML = '<div class="empty">该会计年月暂无数据</div>';
                return;
            }
            Cw.kpiList(Cw.el('#kpiBox', root), kpi.map(function (item) {
                return {
                    label: item.name,
                    value: Cw.fmtMoney(item.current) + ' 元',
                    color: Cw.num(item.change) >= 0 ? 'primary' : 'orange',
                    sub: (data.currentLabel || '本期') + '较' + (data.compareLabel || '上期') + '：' + Cw.changeHtml(item.change, item.changeRate)
                };
            }));
        }

        function renderTable(data) {
            var sections = data.sections || [];
            var html = [];
            sections.forEach(function (section) {
                if (!section.items || !section.items.length) {
                    return;
                }
                html.push('<table class="data" style="margin-bottom:18px">');
                html.push('<thead><tr><th colspan="5" style="background:#eef4ff">' + Cw.esc(section.section) + '</th></tr>');
                html.push('<tr><th style="width:110px">编码</th><th>项目</th><th class="num">'
                    + Cw.esc(data.compareLabel) + '</th><th class="num">' + Cw.esc(data.currentLabel)
                    + '</th><th class="num">变动</th></tr></thead><tbody>');
                var totalCompare = 0, totalCurrent = 0;
                section.items.forEach(function (item) {
                    totalCompare += Cw.num(item.compare);
                    totalCurrent += Cw.num(item.current);
                    html.push('<tr><td class="text-light">' + Cw.esc(item.code) + '</td><td>' + Cw.esc(item.name) + '</td>'
                        + '<td class="num">' + Cw.fmtMoney(item.compare) + '</td>'
                        + '<td class="num">' + Cw.fmtMoney(item.current) + '</td>'
                        + '<td class="num">' + Cw.changeHtml(item.change, item.changeRate) + '</td></tr>');
                });
                html.push('<tr class="total"><td></td><td>小计</td><td class="num">' + Cw.fmtMoney(totalCompare)
                    + '</td><td class="num">' + Cw.fmtMoney(totalCurrent) + '</td><td class="num">'
                    + Cw.fmtMoney(totalCurrent - totalCompare) + '</td></tr>');
                html.push('</tbody></table>');
            });
            Cw.el('#tableBox', root).innerHTML = html.length ? html.join('') : '<div class="empty">暂无数据</div>';
        }

        function renderCharts(data) {
            var items = (data.chartData || []).slice(0, 12);
            CwChart.bar(Cw.el('#barChart', root),
                items.map(function (i) { return i.name; }),
                [
                    {name: data.compareLabel, data: items.map(function (i) { return Cw.num(i.compare); }), color: '#9fc0f7'},
                    {name: data.currentLabel, data: items.map(function (i) { return Cw.num(i.value); }), color: '#2f6fed'}
                ], {unit: '元'});
            var top = items.slice().sort(function (a, b) { return Cw.num(b.value) - Cw.num(a.value); }).slice(0, 8);
            CwChart.pie(Cw.el('#pieChart', root), top.map(function (i) {
                return {name: i.name, value: Cw.num(i.value)};
            }));
        }
    }

    return {render: render};
})();
