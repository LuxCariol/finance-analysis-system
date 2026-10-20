import { API_BASE } from './config'

export function getApiBase() {
  const saved = uni.getStorageSync('finance_api_base_v2')
  return String(saved || API_BASE).replace(/\/+$/, '')
}

export function request(options) {
  const token = uni.getStorageSync('finance_token')
  return new Promise((resolve, reject) => {
    uni.request({
      url: getApiBase() + options.url,
      method: options.method || 'GET',
      data: options.data || {},
      header: {
        'Content-Type': 'application/json',
        'X-Token': token || '',
        ...(options.header || {})
      },
      timeout: 20000,
      success(res) {
        const body = res.data || {}
        if (res.statusCode === 401 || body.code === 401) {
          uni.removeStorageSync('finance_token')
          uni.reLaunch({ url: '/pages/login/login' })
          reject(new Error(body.message || '登录已失效'))
          return
        }
        if (body.code && body.code !== 200) {
          uni.showToast({ title: body.message || '请求失败', icon: 'none' })
          reject(new Error(body.message || '请求失败'))
          return
        }
        resolve(body.data !== undefined ? body.data : body)
      },
      fail(err) {
        uni.showToast({ title: '网络连接失败', icon: 'none' })
        reject(err)
      }
    })
  })
}

export function get(url, data) {
  return request({ url, data })
}

export function post(url, data) {
  return request({ url, method: 'POST', data })
}

export function put(url, data) {
  return request({ url, method: 'PUT', data })
}
