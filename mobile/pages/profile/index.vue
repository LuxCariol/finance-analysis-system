<template>
  <view class="page profile-page">
    <AppHeader title="我的" />
    <view class="profile-card">
      <view class="avatar">{{ initial }}</view>
      <view class="profile-info">
        <text class="user-name">{{ user.userName || user.user_name || '--' }}</text>
        <text class="user-account">{{ user.accountName || user.account_name || '--' }}</text>
      </view>
      <view class="company-tag">{{ org.shortName || org.short_name || org.orgName || '未关联公司' }}</view>
    </view>

    <view class="section-line">
      <view class="line-marker"></view>
      <text>账号信息</text>
    </view>
    <view class="info-row">
      <text class="info-label">所属公司</text>
      <text class="info-value">{{ org.orgName || org.org_name || '--' }}</text>
    </view>
    <view class="info-row">
      <text class="info-label">用户备注</text>
      <text class="info-value">{{ user.description || '--' }}</text>
    </view>
    <view class="info-row" @click="startEdit">
      <text class="info-label">修改资料</text>
      <text class="info-action">{{ editing ? '收起' : '编辑 ›' }}</text>
    </view>

    <view v-if="editing" class="edit-box">
      <view class="edit-field">
        <text class="edit-label">用户名称</text>
        <input v-model="form.userName" class="edit-input" />
      </view>
      <view class="edit-field">
        <text class="edit-label">原密码</text>
        <input v-model="form.oldPwd" class="edit-input" type="password" placeholder="修改密码时填写" />
      </view>
      <view class="edit-field">
        <text class="edit-label">新密码</text>
        <input v-model="form.pwd" class="edit-input" type="password" placeholder="不修改可留空" />
      </view>
      <view class="edit-field">
        <text class="edit-label">备注</text>
        <input v-model="form.description" class="edit-input" />
      </view>
      <view class="save-btn" @click="save">保存资料</view>
    </view>

    <view class="section-line">
      <view class="line-marker"></view>
      <text>常用功能</text>
    </view>
    <view class="menu-list">
      <view class="menu-row" @click="go('/pages/reports/profit')"><text>利润表明细</text><text class="menu-angle">›</text></view>
      <view class="menu-row" @click="go('/pages/reports/balance')"><text>资产负债明细</text><text class="menu-angle">›</text></view>
      <view class="menu-row" @click="go('/pages/reports/cashflow')"><text>现金流量明细</text><text class="menu-angle">›</text></view>
      <view class="menu-row" @click="go('/pages/analysis/ratio')"><text>比率分析</text><text class="menu-angle">›</text></view>
      <view class="menu-row" @click="go('/pages/finance/detail?type=aging&agingType=4')"><text>其他应收款账龄</text><text class="menu-angle">›</text></view>
      <view class="menu-row" @click="go('/pages/news/list')"><text>财经资讯</text><text class="menu-angle">›</text></view>
    </view>

    <view class="logout-btn" @click="logout">退出登录</view>
    <BottomNav active="profile" />
  </view>
</template>

<script>
import AppHeader from '../../components/AppHeader.vue'
import BottomNav from '../../components/BottomNav.vue'
import { get, put, post } from '../../common/request'

export default {
  components: { AppHeader, BottomNav },
  data() {
    return {
      user: {},
      org: {},
      editing: false,
      form: { userName: '', oldPwd: '', pwd: '', description: '' }
    }
  },
  computed: {
    initial() {
      const name = this.user.userName || this.user.user_name || 'U'
      return String(name).slice(0, 1).toUpperCase()
    }
  },
  onShow() {
    this.load()
  },
  methods: {
    async load() {
      try {
        const data = await get('/api/auth/profile')
        this.user = data.user || {}
        this.org = data.org || {}
        this.form.userName = this.user.userName || this.user.user_name || ''
        this.form.description = this.user.description || ''
      } catch (error) {
        this.user = {}
        this.org = {}
      }
    },
    startEdit() {
      this.editing = !this.editing
    },
    async save() {
      try {
        await put('/api/auth/profile', this.form)
        uni.showToast({ title: '保存成功', icon: 'success' })
        this.editing = false
        this.form.oldPwd = ''
        this.form.pwd = ''
        this.load()
      } catch (error) {}
    },
    go(url) {
      uni.navigateTo({ url })
    },
    async logout() {
      try {
        await post('/api/auth/logout')
      } catch (error) {}
      uni.removeStorageSync('finance_token')
      uni.removeStorageSync('finance_user')
      uni.reLaunch({ url: '/pages/login/login' })
    }
  }
}
</script>

<style>
.profile-page {
  background: #ffffff;
}

.profile-card {
  min-height: 150rpx;
  padding: 30rpx 28rpx;
  display: flex;
  align-items: center;
  background: #ffffff;
  border-bottom: 1rpx solid #eeeeee;
}

.avatar {
  width: 96rpx;
  height: 96rpx;
  line-height: 96rpx;
  border-radius: 50%;
  text-align: center;
  background: #3bbfe7;
  color: #ffffff;
  font-size: 38rpx;
  font-weight: 600;
}

.profile-info {
  margin-left: 24rpx;
  flex: 1;
}

.user-name {
  display: block;
  color: #303133;
  font-size: 34rpx;
  font-weight: 600;
}

.user-account {
  display: block;
  margin-top: 8rpx;
  color: #999999;
  font-size: 23rpx;
}

.company-tag {
  max-width: 220rpx;
  padding: 8rpx 16rpx;
  border: 1rpx solid #bce9f5;
  border-radius: 4rpx;
  color: #22a8d1;
  font-size: 22rpx;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
}

.section-line {
  height: 68rpx;
  padding-left: 14rpx;
  display: flex;
  align-items: center;
  background: #f0f8ff;
  color: #303133;
  font-size: 27rpx;
}

.line-marker {
  width: 8rpx;
  height: 28rpx;
  margin-right: 10rpx;
  background: #3bbfe7;
}

.info-row,
.menu-row {
  min-height: 76rpx;
  padding: 0 26rpx;
  display: flex;
  align-items: center;
  justify-content: space-between;
  border-bottom: 1rpx solid #eeeeee;
  color: #303133;
  font-size: 26rpx;
}

.info-label {
  color: #666666;
}

.info-value {
  max-width: 430rpx;
  text-align: right;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
}

.info-action {
  color: #198cff;
}

.edit-box {
  padding: 8rpx 26rpx 28rpx;
  background: #ffffff;
}

.edit-field {
  margin-top: 18rpx;
}

.edit-label {
  display: block;
  margin-bottom: 8rpx;
  color: #666666;
  font-size: 23rpx;
}

.edit-input {
  height: 68rpx;
  padding: 0 18rpx;
  border: 1rpx solid #e1e1e1;
  border-radius: 4rpx;
  color: #303133;
  font-size: 25rpx;
}

.save-btn {
  margin-top: 24rpx;
  height: 74rpx;
  line-height: 74rpx;
  background: #3bbfe7;
  color: #ffffff;
  text-align: center;
  font-size: 27rpx;
  border-radius: 4rpx;
}

.menu-list {
  background: #ffffff;
}

.menu-angle {
  color: #999999;
  font-size: 34rpx;
}

.logout-btn {
  margin: 34rpx 26rpx;
  height: 76rpx;
  line-height: 76rpx;
  border: 1rpx solid #e2e2e2;
  border-radius: 4rpx;
  text-align: center;
  color: #ee6666;
  font-size: 26rpx;
}
</style>
