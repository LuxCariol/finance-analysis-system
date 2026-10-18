<template>
  <view class="login-page">
    <view class="orb orb-a"></view>
    <view class="orb orb-b"></view>
    <view class="login-head">
      <view class="brand-mark">FA</view>
      <text class="brand">金融财务分析</text>
      <text class="brand-sub">Financial Intelligence Workspace</text>
    </view>
    <view class="login-card">
      <text class="welcome">欢迎回来</text>
      <text class="welcome-sub">登录后查看企业经营报告与财务分析</text>
      <view class="field">
        <text class="label">账号</text>
        <input v-model="form.account" class="input" placeholder="请输入账号" />
      </view>
      <view class="field">
        <text class="label">密码</text>
        <input v-model="form.password" class="input" type="password" placeholder="请输入密码" />
      </view>
      <view class="login-btn" :class="{ loading }" @click="login">
        {{ loading ? '登录中…' : '进入系统' }}
      </view>
      <view class="demo">
        <text>演示账号：root</text>
        <text>密码：123456</text>
      </view>
    </view>
    <text class="footer">数据驱动经营决策 · 财务分析实训项目</text>
  </view>
</template>

<script>
import { post } from '../../common/request'

export default {
  data() {
    return {
      loading: false,
      form: { account: 'root', password: '123456' }
    }
  },
  methods: {
    async login() {
      if (!this.form.account || !this.form.password) {
        uni.showToast({ title: '请输入账号和密码', icon: 'none' })
        return
      }
      this.loading = true
      try {
        const data = await post('/api/auth/login', this.form)
        uni.setStorageSync('finance_token', data.token)
        uni.setStorageSync('finance_user', data.user)
        uni.reLaunch({ url: '/pages/home/home' })
      } catch (error) {
        // request helper already displays the message
      } finally {
        this.loading = false
      }
    }
  }
}
</script>

<style>
.login-page {
  min-height: 100vh;
  padding: 0 44rpx;
  box-sizing: border-box;
  background: linear-gradient(155deg, #0e1e36 0%, #17395f 60%, #0d6664 100%);
  position: relative;
  overflow: hidden;
}
.orb { position: absolute; border-radius: 50%; filter: blur(2rpx); }
.orb-a { width: 460rpx; height: 460rpx; background: rgba(20, 186, 174, 0.18); right: -200rpx; top: -120rpx; }
.orb-b { width: 340rpx; height: 340rpx; background: rgba(216, 160, 61, 0.12); left: -160rpx; bottom: 140rpx; }
.login-head { padding-top: calc(var(--status-bar-height) + 120rpx); position: relative; }
.brand-mark {
  width: 82rpx; height: 82rpx; line-height: 82rpx; border-radius: 22rpx;
  background: linear-gradient(135deg, #20b6ad, #0d7c78); color: #fff;
  text-align: center; font-weight: 800; font-size: 28rpx; letter-spacing: 1rpx;
  box-shadow: 0 16rpx 30rpx rgba(13, 124, 120, 0.32);
}
.brand { display: block; margin-top: 34rpx; color: #fff; font-size: 50rpx; font-weight: 700; letter-spacing: 2rpx; }
.brand-sub { display: block; margin-top: 10rpx; color: rgba(255,255,255,0.5); font-size: 20rpx; letter-spacing: 3rpx; text-transform: uppercase; }
.login-card {
  position: relative; margin-top: 76rpx; padding: 40rpx 34rpx 34rpx;
  border-radius: 32rpx; background: rgba(255,255,255,0.97);
  box-shadow: 0 30rpx 70rpx rgba(0,0,0,0.22);
}
.welcome { display: block; color: #16243b; font-size: 38rpx; font-weight: 700; }
.welcome-sub { display: block; margin-top: 10rpx; color: #8a96a7; font-size: 22rpx; }
.field { margin-top: 30rpx; }
.label { display: block; color: #536175; font-size: 23rpx; margin-bottom: 12rpx; }
.input { height: 86rpx; padding: 0 24rpx; border-radius: 16rpx; background: #f3f6f9; color: #1b2a42; font-size: 27rpx; box-sizing: border-box; }
.login-btn {
  margin-top: 38rpx; height: 92rpx; line-height: 92rpx; border-radius: 18rpx;
  background: linear-gradient(135deg, #0d7c78, #19a79f); color: #fff;
  text-align: center; font-size: 30rpx; font-weight: 600; box-shadow: 0 16rpx 30rpx rgba(13,124,120,0.22);
}
.login-btn.loading { opacity: 0.7; }
.demo { margin-top: 24rpx; display: flex; justify-content: space-between; color: #98a3b2; font-size: 20rpx; }
.footer { display: block; margin-top: 54rpx; text-align: center; color: rgba(255,255,255,0.4); font-size: 20rpx; letter-spacing: 1rpx; }
</style>
