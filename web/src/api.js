import axios from 'axios'

const sameOrigin = typeof window !== 'undefined' && window.location.port === '8006'
export const API_BASE = import.meta.env.VITE_API_BASE || (sameOrigin ? '' : 'http://localhost:8006')

const http = axios.create({
  baseURL: API_BASE,
  timeout: 30000
})

http.interceptors.request.use(config => {
  const token = localStorage.getItem('finance_admin_token')
  if (token) {
    config.headers['X-Token'] = token
  }
  return config
})

http.interceptors.response.use(
  response => {
    const body = response.data
    if (body && body.code !== undefined) {
      if (body.code === 401) {
        localStorage.removeItem('finance_admin_token')
        localStorage.removeItem('finance_admin_user')
        window.location.reload()
        return Promise.reject(new Error('登录已失效'))
      }
      if (body.code !== 200) {
        return Promise.reject(new Error(body.message || '请求失败'))
      }
      return body.data
    }
    return body
  },
  error => Promise.reject(new Error(error.response?.data?.message || error.message || '网络连接失败'))
)

export const api = {
  login: (account, password) => http.post('/api/auth/login', { account, password }),
  dashboard: orgId => http.get('/api/admin/dashboard', { params: { orgId } }),
  companies: keyword => http.get('/api/admin/companies', { params: { keyword } }),
  createCompany: data => http.post('/api/admin/companies', data),
  updateCompany: (id, data) => http.put(`/api/admin/companies/${id}`, data),
  deleteCompany: id => http.delete(`/api/admin/companies/${id}`),
  users: () => http.get('/api/admin/users'),
  createUser: data => http.post('/api/admin/users', data),
  updateUser: (id, data) => http.put(`/api/admin/users/${id}`, data),
  deleteUser: id => http.delete(`/api/admin/users/${id}`),
  resetPassword: id => http.post(`/api/admin/users/${id}/reset-password`),
  roles: () => http.get('/api/admin/roles'),
  createRole: data => http.post('/api/admin/roles', data),
  updateRole: (id, data) => http.put(`/api/admin/roles/${id}`, data),
  deleteRole: id => http.delete(`/api/admin/roles/${id}`),
  menus: () => http.get('/api/admin/menus'),
  createMenu: data => http.post('/api/admin/menus', data),
  updateMenu: (id, data) => http.put(`/api/admin/menus/${id}`, data),
  deleteMenu: id => http.delete(`/api/admin/menus/${id}`),
  dictionaries: keyword => http.get('/api/admin/dictionaries', { params: { keyword } }),
  createDictionary: data => http.post('/api/admin/dictionaries', data),
  updateDictionary: (id, data) => http.put(`/api/admin/dictionaries/${id}`, data),
  deleteDictionary: id => http.delete(`/api/admin/dictionaries/${id}`),
  periods: orgId => http.get('/api/admin/report-periods', { params: { orgId } }),
  reports: params => http.get('/api/admin/reports', { params }),
  importReport: (file, type, orgId) => {
    const form = new FormData()
    form.append('file', file)
    form.append('type', type)
    if (orgId) form.append('orgId', orgId)
    return http.post('/api/admin/reports/import', form, { headers: { 'Content-Type': 'multipart/form-data' } })
  },
  bulkImport: (files, orgId) => {
    const form = new FormData()
    files.forEach(file => form.append('files', file))
    if (orgId) form.append('orgId', orgId)
    return http.post('/api/admin/reports/bulk-import', form, { headers: { 'Content-Type': 'multipart/form-data' } })
  },
  aging: params => http.get('/api/admin/aging', { params }),
  codeLibrary: keyword => http.get('/api/admin/code-library', { params: { keyword } }),
  createCode: data => http.post('/api/admin/code-library', data),
  updateCode: (id, data) => http.put(`/api/admin/code-library/${id}`, data),
  deleteCode: id => http.delete(`/api/admin/code-library/${id}`),
  syncCodeLibrary: () => http.post('/api/admin/code-library/sync'),
  codeMappers: keyword => http.get('/api/admin/code-mappers', { params: { keyword } }),
  createMapper: data => http.post('/api/admin/code-mappers', data),
  updateMapper: (codeNo, data) => http.put(`/api/admin/code-mappers/${encodeURIComponent(codeNo)}`, data),
  deleteMapper: codeNo => http.delete(`/api/admin/code-mappers/${encodeURIComponent(codeNo)}`),
  modes: keyword => http.get('/api/admin/modes', { params: { keyword } }),
  createMode: data => http.post('/api/admin/modes', data),
  updateMode: (id, data) => http.put(`/api/admin/modes/${id}`, data),
  deleteMode: id => http.delete(`/api/admin/modes/${id}`),
  news: () => http.get('/api/admin/news'),
  createNews: data => http.post('/api/admin/news', data),
  updateNews: (id, data) => http.put(`/api/admin/news/${id}`, data),
  deleteNews: id => http.delete(`/api/admin/news/${id}`),
  convert: orgId => http.post('/api/admin/convert', { orgId })
}
