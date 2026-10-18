<template>
  <view class="page">
    <AppHeader title="个人中心" subtitle="账号、企业与系统入口" eyebrow="ACCOUNT">
      <template #right>
        <view class="avatar">{{ (user.userName || 'U').slice(0, 1) }}</view>
      </template>
    </AppHeader>
    <view class="card user-card">
      <view>
        <text class="user-name">{{ user.userName || '--' }}</text>
        <text class="user-account">{{ user.accountName || '--' }} · {{ user.roleName || '分析员' }}</text>
      </view>
      <text class="pill">{{ org.orgName || '未关联公司' }}</text>
    </view>

    <view class="card edit-card">
      <view class="row" @click="editing = !editing">
        <text class="edit-title">账号资料</text>
        <text class="edit-toggle">{{ editing ? '收起' : '编辑' }}</text>
      </view>
      <view v-if="editing" class="edit-form">
        <view class="field"><text class="label">用户名称</text><input v-model="form.userName" class="input" /></view>
        <view class="field"><text class="label">原密码（修改密码时填写）</text><input v-model="form.oldPwd" type="password" class="input" /></view>
        <view class="field"><text class="label">新密码</text><input v-model="form.pwd" type="password" class="input" /></view>
        <view class="field"><text class="label">备注</text><input v-model="form.description" class="input" /></view>
        <view class="btn-primary" @click="save">保存资料</view>
      </view>
    </view>

    <view class="section-title">常用入口</view>
    <view class="card menu-card">
      <view class="menu-item" @click="go('/pages/reports/profit')"><text>利润明细</text><text>›</text></view>
      <view class="menu-item" @click="go('/pages/reports/balance')"><text>资产负债明细</text><text>›</text></view>
      <view class="menu-item" @click="go('/pages/reports/cashflow')"><text>现金流量明细</text><text>›</text></view>
      <view class="menu-item" @click="go('/pages/analysis/ratio')"><text>财务比率分析</text><text>›</text></view>
      <view class="menu-item" @click="go('/pages/news/list')"><text>财经资讯</text><text>›</text></view>
    </view>

    <view class="btn-ghost logout" @click="logout">退出登录</view>
    <text class="version">金融财务分析 · 移动端 v1.0.0</text>
  </view>
</template>
<script>
import AppHeader from '../../components/AppHeader.vue'
import { get, put, post } from '../../common/request'
export default {
  components: { AppHeader },
  data() {
    return {
      user: {},
      org: {},
      editing: false,
      form: { userName: '', oldPwd: '', pwd: '', description: '' }
    }
  },
  onShow() { this.load() },
  methods: {
    async load() {
      try {
        const data = await get('/api/auth/profile')
        this.user = data.user || {}
        this.org = data.org || {}
        this.form.userName = this.user.userName
        this.form.description = this.user.description || ''
      } catch (e) {}
    },
    async save() {
      try {
        await put('/api/auth/profile', this.form)
        uni.showToast({ title: '保存成功', icon: 'success' })
        this.editing = false
        this.load()
      } catch (e) {}
    },
    go(url) { uni.navigateTo({ url }) },
    async logout() {
      try { await post('/api/auth/logout') } catch (e) {}
      uni.removeStorageSync('finance_token')
      uni.removeStorageSync('finance_user')
      uni.reLaunch({ url: '/pages/login/login' })
    }
  }
}
</script>
<style>
.avatar { width: 68rpx; height: 68rpx; line-height: 68rpx; border-radius: 50%; background: rgba(255,255,255,0.14); text-align: center; font-size: 28rpx; font-weight: 700; }
.user-card { display: flex; align-items: center; justify-content: space-between; }
.user-name { display: block; font-size: 34rpx; font-weight: 700; color: #22314a; }
.user-account { display: block; margin-top: 8rpx; font-size: 21rpx; color: #8e99a9; }
.edit-title { font-size: 27rpx; font-weight: 600; color: #22314a; }
.edit-toggle { color: #0d7c78; font-size: 22rpx; }
.edit-form { margin-top: 20rpx; }
.field { margin-top: 18rpx; }
.label { display: block; color: #718095; font-size: 21rpx; margin-bottom: 8rpx; }
.input { height: 68rpx; padding: 0 18rpx; border-radius: 12rpx; background: #f3f6f9; color: #22314a; font-size: 24rpx; }
.btn-primary { margin-top: 26rpx; }
.menu-card { padding-top: 8rpx; padding-bottom: 8rpx; }
.menu-item { display: flex; justify-content: space-between; padding: 24rpx 0; border-bottom: 1rpx solid #f1f3f6; color: #3b4b63; font-size: 25rpx; }
.menu-item:last-child { border-bottom: none; }
.logout { margin-top: 26rpx; color: #b94c4c; }
.version { display: block; text-align: center; margin-top: 32rpx; color: #a4adba; font-size: 20rpx; }
</style>
