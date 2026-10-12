/* ==========================================================================
 * 图表封装: 优先使用 ECharts(CDN)，未加载成功时使用内置 SVG 渲染，
 * 保证在没有外网的环境下曲线图/柱状图/饼图依然可以展示。
 * ========================================================================== */
var CwChart = (function () {
    function hasEcharts() {
        return typeof window.echarts !== 'undefined';
    }

    function target(node) {
        return typeof node === 'string' ? document.querySelector(node) : node;
    }

    function init(node) {
        var dom = target(node);
        if (hasEcharts()) {
            var instance = window.echarts.init(dom);
            if (!dom.__cwResize) {
                dom.__cwResize = true;
                window.addEventListener('resize', function () {
                    var chart = window.echarts.getInstanceByDom(dom);
                    if (chart) {
                        chart.resize();
                    }
                });
            }
            return instance;
        }
        return null;
    }

    function line(node, categories, series, options) {
        options = options || {};
        var instance = init(node);
        if (instance) {
            instance.setOption({
                tooltip: {trigger: 'axis'},
                legend: {data: series.map(function (s) { return s.name; }), bottom: 0},
                grid: {left: 60, right: 24, top: 28, bottom: 46},
                xAxis: {type: 'category', data: categories, boundaryGap: false},
                yAxis: {type: 'value', name: options.unit || '', nameTextStyle: {color: '#999'}},
                series: series.map(function (s) {
                    return {
                        name: s.name,
                        type: s.type || 'line',
                        smooth: true,
                        connectNulls: true,
                        symbolSize: 6,
                        data: s.data,
                        areaStyle: s.area ? {opacity: .12} : undefined,
                        barMaxWidth: 26
                    };
                })
            });
            return;
        }
        svgLine(target(node), categories, series, options);
    }

    function bar(node, categories, series, options) {
        options = options || {};
        var instance = init(node);
        if (instance) {
            instance.setOption({
                tooltip: {trigger: 'axis'},
                legend: {data: series.map(function (s) { return s.name; }), bottom: 0},
                grid: {left: 60, right: 24, top: 28, bottom: 46},
                xAxis: {type: 'category', data: categories},
                yAxis: {type: 'value', name: options.unit || ''},
                series: series.map(function (s) {
                    return {name: s.name, type: 'bar', data: s.data, barMaxWidth: 28, itemStyle: {color: s.color}};
                })
            });
            return;
        }
        svgLine(target(node), categories, series, options, true);
    }

    function pie(node, data, options) {
        options = options || {};
        var instance = init(node);
        if (instance) {
            instance.setOption({
                tooltip: {trigger: 'item', formatter: '{b}: {c} ({d}%)'},
                legend: {type: 'scroll', bottom: 0},
                series: [{
                    type: 'pie',
                    radius: options.donut ? ['40%', '66%'] : '62%',
                    center: ['50%', '46%'],
                    data: data,
                    label: {formatter: '{b}\n{d}%'}
                }]
            });
            return;
        }
        svgPie(target(node), data);
    }

    function gauge(node, value, name) {
        var instance = init(node);
        var max = 100;
        if (instance) {
            instance.setOption({
                series: [{
                    type: 'gauge',
                    min: 0,
                    max: max,
                    progress: {show: true},
                    axisLine: {lineStyle: {width: 14}},
                    detail: {valueAnimation: true, formatter: '{value}%', fontSize: 20},
                    data: [{value: value, name: name}]
                }]
            });
            return;
        }
        var dom = target(node);
        dom.innerHTML = '<div style="text-align:center;padding-top:60px">'
            + '<div style="font-size:34px;font-weight:bold;color:#2f6fed">' + value + '%</div>'
            + '<div class="text-light" style="margin-top:8px">' + (name || '') + '</div></div>';
    }

    /* -------------------------------------------------- SVG 兜底渲染 */
    function svgLine(dom, categories, series, options, isBar) {
        var width = dom.clientWidth || 640;
        var height = dom.clientHeight || 300;
        var padding = {left: 70, right: 20, top: 20, bottom: 46};
        var colors = ['#2f6fed', '#17b978', '#f5a623', '#e74c3c', '#8e44ad'];
        var max = 0;
        series.forEach(function (s) {
            (s.data || []).forEach(function (v) {
                if (v !== null && v !== undefined && Math.abs(Number(v)) > max) {
                    max = Math.abs(Number(v));
                }
            });
        });
        if (max === 0) {
            max = 1;
        }
        var plotW = width - padding.left - padding.right;
        var plotH = height - padding.top - padding.bottom;
        var svg = ['<svg width="100%" height="' + height + '" viewBox="0 0 ' + width + ' ' + height + '">'];
        for (var g = 0; g <= 4; g++) {
            var y = padding.top + plotH * g / 4;
            svg.push('<line x1="' + padding.left + '" y1="' + y + '" x2="' + (width - padding.right) + '" y2="' + y
                + '" stroke="#eef1f6"/>');
            svg.push('<text x="' + (padding.left - 8) + '" y="' + (y + 4) + '" font-size="11" fill="#9aa5b1" text-anchor="end">'
                + shortNumber(max * (4 - g) / 4) + '</text>');
        }
        var step = categories.length > 1 ? plotW / (categories.length - 1) : plotW;
        categories.forEach(function (label, index) {
            var x = padding.left + step * index;
            svg.push('<text x="' + x + '" y="' + (height - 24) + '" font-size="11" fill="#9aa5b1" text-anchor="middle">'
                + label + '</text>');
        });
        series.forEach(function (s, si) {
            var color = colors[si % colors.length];
            if (isBar) {
                var barW = Math.max(8, step / (series.length + 1));
                (s.data || []).forEach(function (v, index) {
                    if (v === null || v === undefined) {
                        return;
                    }
                    var barH = Math.abs(Number(v)) / max * plotH;
                    var x = padding.left + step * index - barW / 2 + si * barW;
                    svg.push('<rect x="' + x + '" y="' + (padding.top + plotH - barH) + '" width="' + barW + '" height="'
                        + barH + '" fill="' + color + '" opacity="0.85" rx="2"/>');
                });
            } else {
                var points = [];
                (s.data || []).forEach(function (v, index) {
                    if (v === null || v === undefined) {
                        return;
                    }
                    points.push((padding.left + step * index) + ',' + (padding.top + plotH - Math.abs(Number(v)) / max * plotH));
                });
                if (points.length) {
                    svg.push('<polyline points="' + points.join(' ') + '" fill="none" stroke="' + color
                        + '" stroke-width="2"/>');
                    points.forEach(function (p) {
                        var xy = p.split(',');
                        svg.push('<circle cx="' + xy[0] + '" cy="' + xy[1] + '" r="3" fill="' + color + '"/>');
                    });
                }
            }
        });
        svg.push('</svg>');
        var legend = series.map(function (s, index) {
            return '<span style="margin-right:14px"><i style="display:inline-block;width:10px;height:10px;border-radius:2px;background:'
                + colors[index % colors.length] + ';margin-right:5px"></i>' + s.name + '</span>';
        }).join('');
        dom.innerHTML = svg.join('') + '<div style="text-align:center;font-size:12px;color:#7f8c9b">' + legend + '</div>';
    }

    function svgPie(dom, data) {
        var total = 0;
        data.forEach(function (item) {
            total += Number(item.value) || 0;
        });
        var colors = ['#2f6fed', '#17b978', '#f5a623', '#e74c3c', '#8e44ad', '#16a085', '#d35400'];
        var start = -Math.PI / 2;
        var svg = ['<svg width="100%" height="280" viewBox="0 0 360 280">'];
        var legend = [];
        data.forEach(function (item, index) {
            var ratio = total === 0 ? 0 : (Number(item.value) || 0) / total;
            var angle = ratio * Math.PI * 2;
            var end = start + angle;
            var x1 = 120 + 90 * Math.cos(start);
            var y1 = 140 + 90 * Math.sin(start);
            var x2 = 120 + 90 * Math.cos(end);
            var y2 = 140 + 90 * Math.sin(end);
            var large = angle > Math.PI ? 1 : 0;
            var color = colors[index % colors.length];
            if (ratio > 0) {
                svg.push('<path d="M120,140 L' + x1 + ',' + y1 + ' A90,90 0 ' + large + ' 1 ' + x2 + ',' + y2
                    + ' Z" fill="' + color + '" opacity="0.9"/>');
            }
            legend.push('<div style="font-size:12px;margin-bottom:4px"><i style="display:inline-block;width:10px;height:10px;border-radius:2px;background:'
                + color + ';margin-right:6px"></i>' + item.name + ' ' + (ratio * 100).toFixed(2) + '%</div>');
            start = end;
        });
        svg.push('</svg>');
        dom.innerHTML = '<div style="display:flex;align-items:center">'
            + '<div style="flex:0 0 240px">' + svg.join('') + '</div>'
            + '<div style="flex:1;max-height:260px;overflow:auto">' + legend.join('') + '</div></div>';
    }

    function shortNumber(value) {
        var v = Number(value);
        if (Math.abs(v) >= 100000000) {
            return (v / 100000000).toFixed(1) + '亿';
        }
        if (Math.abs(v) >= 10000) {
            return (v / 10000).toFixed(0) + '万';
        }
        return v.toFixed(0);
    }

    return {line: line, bar: bar, pie: pie, gauge: gauge, hasEcharts: hasEcharts};
})();
