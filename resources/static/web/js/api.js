/* ==========================================================================
 * 请求层: 统一处理 JSON、错误、登录失效
 * ========================================================================== */
window.CW_LOGIN_URL = '/web/login.html';

var Api = (function () {
    function handle(response) {
        if (response.status === 401) {
            if (window.top && window.top !== window) {
                window.top.location.href = window.CW_LOGIN_URL;
            } else {
                window.location.href = window.CW_LOGIN_URL;
            }
            throw new Error('登录已过期');
        }
        return response.json();
    }

    function check(result) {
        if (!result || typeof result.code === 'undefined') {
            throw new Error('返回数据格式错误');
        }
        if (result.code !== 0) {
            throw new Error(result.message || '操作失败');
        }
        return result.data;
    }

    function buildQuery(params) {
        if (!params) {
            return '';
        }
        var parts = [];
        for (var key in params) {
            if (params[key] === undefined || params[key] === null || params[key] === '') {
                continue;
            }
            parts.push(encodeURIComponent(key) + '=' + encodeURIComponent(params[key]));
        }
        return parts.length ? '?' + parts.join('&') : '';
    }

    return {
        get: function (url, params) {
            return fetch(url + buildQuery(params), {
                method: 'GET',
                credentials: 'same-origin',
                headers: {'Accept': 'application/json'}
            }).then(handle).then(check);
        },
        post: function (url, data) {
            return fetch(url, {
                method: 'POST',
                credentials: 'same-origin',
                headers: {'Content-Type': 'application/json;charset=UTF-8'},
                body: JSON.stringify(data || {})
            }).then(handle).then(check);
        },
        postParam: function (url, params) {
            return fetch(url + buildQuery(params), {
                method: 'POST',
                credentials: 'same-origin'
            }).then(handle).then(check);
        },
        postForm: function (url, formData) {
            return fetch(url, {
                method: 'POST',
                credentials: 'same-origin',
                body: formData
            }).then(handle).then(check);
        }
    };
})();
