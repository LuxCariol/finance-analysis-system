/* ==========================================================================
 * 数据导入页面公共逻辑: 模板下载 + Excel上传 + 导入结果 + 数据预览
 * ========================================================================== */
var ImportPage = (function () {

    function render(config) {
        var root = document.createElement('div');
        root.className = 'page';
        root.innerHTML = ''
            + '<div class="page-head"><div><h2>' + config.title + '</h2><div class="desc">' + config.desc + '</div></div></div>'
            + '<div class="tip">操作流程：① 下载导入模板 → ② 用金蝶K8数据整理模板（或直接使用K8导出报表）→ ③ 选择会计年月并上传 → '
            + '④ 导入成功后到【模型管理 - 数据转换】执行数据全量转换。导入过程按 100 条分批入库，失败自动回滚。</div>'
            + '<div class="card"><h3>导入设置</h3>'
            + '<div class="form-grid" style="grid-template-columns:120px 220px 120px 220px">'
            + '<div class="lbl">公司</div><div><select id="orgSel" style="width:100%"></select></div>'
            + '<div class="lbl">会计年月</div><div><input type="month" id="monthSel"></div>'
            + (config.reportTypeSelector ? '<div class="lbl">报表类型</div><div><select id="reportSel" style="width:100%"></select></div>' : '')
            + (config.agingType ? '<div class="lbl">账龄类型</div><div><select id="agingSel" style="width:100%">'
                + '<option value="2">应收账款账龄</option><option value="1">应付账款账龄</option>'
                + '<option value="7">预付账款账龄</option><option value="3">其他应收款账龄</option></select></div>' : '')
            + '<div class="lbl">Excel文件</div><div class="full"><input type="file" id="fileSel" accept=".xls,.xlsx"></div>'
            + '<div class="lbl">重复数据处理</div><div class="full"><label style="margin-right:16px"><input type="radio" name="override" value="true"> 覆盖已导入数据</label>'
            + '<label><input type="radio" name="override" value="false" checked> 跳过（保留原数据）</label></div>'
            + '</div>'
            + '<div style="margin-top:14px" class="toolbar">'
            + '<button class="btn primary" id="uploadBtn">开始导入</button>'
            + '<button class="btn" id="templateBtn">下载导入模板</button>'
            + '<button class="btn" id="sampleBtn">下载示例数据模板</button>'
            + '</div></div>'
            + '<div class="card" id="resultCard" style="display:none"><h3>导入结果</h3><div id="resultBox"></div></div>'
            + (config.preview ? '<div class="card"><h3>' + (config.previewTitle || '数据预览') + '</h3><div id="previewBox"></div></div>' : '')
        document.body.appendChild(root);

        Cw.orgOptions(function (options) {
            Cw.el('#orgSel', root).innerHTML = options.map(function (o) {
                return '<option value="' + o.value + '">' + o.text + '</option>';
            }).join('');
        });
        Cw.fillMonth('#monthSel', new Date().toISOString().slice(0, 7));
        if (config.reportTypeSelector) {
            Cw.el('#reportSel', root).innerHTML = config.reportTypeSelector.map(function (item) {
                return '<option value="' + item.value + '">' + item.text + '</option>';
            }).join('');
        }

        function reportType() {
            return config.reportTypeSelector ? Cw.el('#reportSel', root).value : config.reportType;
        }

        Cw.el('#templateBtn', root).addEventListener('click', function () {
            download(false);
        });
        Cw.el('#sampleBtn', root).addEventListener('click', function () {
            download(true);
        });
        Cw.el('#uploadBtn', root).addEventListener('click', upload);
        if (config.preview) {
            loadPreview();
        }

        function download(sample) {
            window.location.href = '/api/import/template?reportType=' + encodeURIComponent(reportType())
                + '&sample=' + sample;
        }

        function upload() {
            var file = Cw.el('#fileSel', root).files[0];
            if (!file) {
                Cw.toast('请先选择需要导入的 Excel 文件', 'error');
                return;
            }
            var formData = new FormData();
            formData.append('file', file);
            formData.append('reportType', reportType());
            formData.append('orgId', Cw.el('#orgSel', root).value);
            formData.append('kjyearMonth', Cw.el('#monthSel', root).value);
            formData.append('override', document.querySelector('input[name=override]:checked').value);
            var agingSel = Cw.el('#agingSel', root);
            if (agingSel) {
                formData.append('agingType', agingSel.value);
            }
            Cw.el('#uploadBtn', root).disabled = true;
            Cw.el('#uploadBtn', root).textContent = '导入中...';
            Api.postForm('/api/import/upload', formData).then(function (result) {
                Cw.el('#resultCard', root).style.display = 'block';
                Cw.el('#resultBox', root).innerHTML = '<div class="kpi-list">'
                    + kpi('报表类型', result.reportName || result.reportType)
                    + kpi('会计年月', result.kjyearMonth || '-')
                    + kpi('成功导入', result.successRows + ' 条')
                    + kpi('失败/跳过', result.failRows + ' 条')
                    + kpi('批次号', result.batchId)
                    + '</div><div class="tip" style="margin-top:12px">' + Cw.esc(result.message || '') + '</div>';
                Cw.toast(result.message || '导入完成', result.skipped ? 'info' : 'success');
                if (config.preview) {
                    loadPreview();
                }
            }).catch(function (e) {
                Cw.el('#resultCard', root).style.display = 'block';
                Cw.el('#resultBox', root).innerHTML = '<div class="empty up">' + Cw.esc(e.message) + '</div>';
                Cw.toast(e.message, 'error');
            }).then(function () {
                Cw.el('#uploadBtn', root).disabled = false;
                Cw.el('#uploadBtn', root).textContent = '开始导入';
            });
        }

        function kpi(label, value) {
            return '<div class="kpi primary"><div class="label"><span>' + Cw.esc(label)
                + '</span></div><div class="value" style="font-size:16px">' + Cw.esc(value) + '</div></div>';
        }

        function loadPreview() {
            if (config.onPreview) {
                config.onPreview({
                    orgId: Cw.el('#orgSel', root).value,
                    kjyearMonth: Cw.el('#monthSel', root).value
                }, Cw.el('#previewBox', root));
            }
        }
    }

    return {render: render};
})();
