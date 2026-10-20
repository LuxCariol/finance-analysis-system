<template>
  <view class="login-page">
    <view class="login-top">
      <view class="status-space"></view>
      <view class="logo">FA</view>
      <text class="login-title">金融财务分析</text>
      <text class="login-sub">Financial Analysis System</text>
    </view>
    <view class="login-card">
      <text class="card-title">账号登录</text>
      <view class="field">
        <text class="field-label">账号</text>
        <input v-model="form.account" class="field-input" placeholder="请输入账号" />
      </view>
      <view class="field">
        <text class="field-label">密码</text>
        <input v-model="form.password" class="field-input" type="password" placeholder="请输入密码" />
      </view>
      <view class="field">
        <text class="field-label">服务器地址</text>
        <input v-model="form.server" class="field-input" placeholder="http://电脑IP:8006" />
      </view>
      <view class="login-btn" :class="{ loading }" @click="login">{{ loading ? '登录中…' : '登 录' }}</view>
      <view class="demo-line">
        <text>演示账号：root</text>
        <text>密码：123456</text>
      </view>
    </view>
    <text class="footer">数据驱动经营决策 · 财务分析实训项目</text>
  </view>
</template>

<script>
import { post } from '../../common/request'
import { API_BASE } from '../../common/config'

export default {
  data() {
    return {
      loading: false,
      form: {
        account: 'root',
        password: '123456',
        server: uni.getStorageSync('finance_api_base_v2') || API_BASE
      }
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
        const server = String(this.form.server || API_BASE).trim().replace(/\/+$/, '')
        if (!/^https?:\/\//.test(server)) {
          uni.showToast({ title: '服务器地址需以 http:// 开头', icon: 'none' })
          this.loading = false
          return
        }
        uni.setStorageSync('finance_api_base_v2', server)
        const data = await post('/api/auth/login', {
          account: this.form.account,
          password: this.form.password
        })
        uni.setStorageSync('finance_token', data.token)
        uni.setStorageSync('finance_user', data.user)
        uni.reLaunch({ url: '/pages/home/home' })
      } catch (error) {
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
  background: #ffffff;
}

.login-top {
  height: 520rpx;
  background: #3bbfe7;
  display: flex;
  flex-direction: column;
  align-items: center;
  color: #ffffff;
}

.status-space {
  height: calc(var(--status-bar-height) + 50rpx);
  min-height: 80rpx;
}

.logo {
  width: 116rpx;
  height: 116rpx;
  line-height: 116rpx;
  border: 4rpx solid rgba(255, 255, 255, 0.85);
  border-radius: 50%;
  text-align: center;
  font-size: 40rpx;
  font-weight: 700;
  letter-spacing: 2rpx;
}

.login-title {
  margin-top: 32rpx;
  font-size: 46rpx;
  font-weight: 600;
  letter-spacing: 3rpx;
}

.login-sub {
  margin-top: 12rpx;
  font-size: 22rpx;
  letter-spacing: 2rpx;
  color: rgba(255, 255, 255, 0.78);
}

.login-card {
  position: relative;
  margin: -100rpx 52rpx 0;
  padding: 46rpx 40rpx 34rpx;
  background: #ffffff;
  border: 1rpx solid #eeeeee;
  box-shadow: 0 16rpx 46rpx rgba(53, 130, 153, 0.12);
}

.card-title {
  display: block;
  text-align: center;
  color: #303133;
  font-size: 32rpx;
  font-weight: 500;
}

.field {
  margin-top: 30rpx;
}

.field-label {
  display: block;
  margin-bottom: 10rpx;
  color: #666666;
  font-size: 24rpx;
}

.field-input {
  height: 78rpx;
  padding: 0 20rpx;
  border: 1rpx solid #dddddd;
  border-radius: 4rpx;
  color: #303133;
  font-size: 27rpx;
}

.login-btn {
  margin-top: 40rpx;
  height: 80rpx;
  line-height: 80rpx;
  border-radius: 4rpx;
  text-align: center;
  background: #3bbfe7;
  color: #ffffff;
  font-size: 29rpx;
  letter-spacing: 2rpx;
}

.login-btn.loading {
  opacity: 0.65;
}

.demo-line {
  margin-top: 22rpx;
  display: flex;
  justify-content: space-between;
  color: #999999;
  font-size: 21rpx;
}

.footer {
  display: block;
  margin-top: 60rpx;
  text-align: center;
  color: #aaaaaa;
  font-size: 21rpx;
}
</style>
