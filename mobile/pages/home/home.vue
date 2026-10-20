<template>
  <view class="page home-page">
    <AppHeader title="企业报告">
      <template #filters>
        <FilterBar :year="year" :mode="mode" @mode-change="mode = $event" @year-change="changeYear" />
      </template>
    </AppHeader>

    <view v-if="loading" class="placeholder">正在加载企业报告…</view>
    <view v-else class="report-body">
      <view class="home-head first">
        <view class="home-marker"></view>
        <text class="home-title">概述</text>
      </view>
      <view class="home-separator"></view>

      <view class="home-head">
        <view class="home-marker"></view>
        <text class="home-title">利润表</text>
        <view class="home-link" @click="go('/pages/reports/profit')">报表明细 <text class="angle">›</text></view>
      </view>
      <view class="home-separator"></view>
      <view class="home-copy">
        <text class="copy-text" :class="{ collapsed: !profitOpen }">{{ data.profitNarrative || '暂无利润表报告' }}</text>
        <text class="expand" @click="profitOpen = !profitOpen">{{ profitOpen ? '收起⌃' : '展开⌄' }}</text>
      </view>
      <view class="home-separator"></view>

      <view class="home-head">
        <view class="home-marker"></view>
        <text class="home-title">资产负债表</text>
        <view class="home-link" @click="go('/pages/reports/balance')">报表明细 <text class="angle">›</text></view>
      </view>
      <view class="home-separator"></view>
      <view class="home-copy balance-copy">
        <text class="copy-text">无报告</text>
        <text class="expand" @click="balanceOpen = !balanceOpen">{{ balanceOpen ? '收起⌃' : '展开⌄' }}</text>
      </view>
      <view class="home-separator"></view>

      <view class="home-head">
        <view class="home-marker"></view>
        <text class="home-title">现金流量</text>
        <view class="home-link" @click="go('/pages/reports/cashflow')">报表明细 <text class="angle">›</text></view>
      </view>
      <view class="home-separator"></view>
      <view class="home-copy cash-copy">
        <text class="copy-text" :class="{ collapsed: !cashOpen }">{{ data.cashNarrative || '暂无现金流量报告' }}</text>
        <text class="expand" @click="cashOpen = !cashOpen">{{ cashOpen ? '收起⌃' : '展开⌄' }}</text>
      </view>
    </view>
    <BottomNav active="report" />
  </view>
</template>

<script>
import AppHeader from '../../components/AppHeader.vue'
import FilterBar from '../../components/FilterBar.vue'
import BottomNav from '../../components/BottomNav.vue'
import { get } from '../../common/request'

export default {
  components: { AppHeader, FilterBar, BottomNav },
  data() {
    return {
      loading: true,
      data: {},
      year: '2021',
      mode: 'year',
      profitOpen: false,
      balanceOpen: false,
      cashOpen: false
    }
  },
  onShow() {
    this.load()
  },
  methods: {
    async load() {
      this.loading = true
      try {
        this.data = await get('/api/home/report', { period: this.year + '12' })
      } catch (error) {
        this.data = {}
      } finally {
        this.loading = false
      }
    },
    changeYear(year) {
      this.year = year
      this.load()
    },
    go(url) {
      uni.navigateTo({ url })
    }
  }
}
</script>

<style>
.home-page {
  background: #ffffff;
}

.report-body {
  padding-top: 6rpx;
}

.home-head {
  height: 78rpx;
  padding: 0 24rpx 0 14rpx;
  display: flex;
  align-items: center;
  background: #ffffff;
}

.home-head.first {
  height: 100rpx;
}

.home-marker {
  width: 18rpx;
  height: 30rpx;
  position: relative;
  margin-right: 8rpx;
}

.home-marker::before,
.home-marker::after {
  content: "";
  position: absolute;
  left: 1rpx;
  width: 7rpx;
  height: 18rpx;
  border-radius: 2rpx;
  background: #3bbfe7;
  transform: skewX(-24deg);
}

.home-marker::before {
  top: 1rpx;
}

.home-marker::after {
  top: 13rpx;
}

.home-title {
  font-size: 28rpx;
  font-weight: 500;
  color: #303133;
}

.home-link {
  margin-left: auto;
  font-size: 26rpx;
  color: #666666;
}

.angle {
  font-family: Arial, sans-serif;
  margin-left: 4rpx;
  font-size: 30rpx;
}

.home-separator {
  height: 20rpx;
  background: #eeeeee;
}

.home-copy {
  position: relative;
  min-height: 142rpx;
  padding: 24rpx 24rpx 30rpx;
  background: #ffffff;
}

.copy-text {
  display: inline;
  font-size: 26rpx;
  line-height: 40rpx;
  color: #303133;
  word-break: break-all;
}

.copy-text.collapsed {
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.expand {
  position: absolute;
  right: 24rpx;
  bottom: 24rpx;
  padding-left: 12rpx;
  background: #ffffff;
  color: #666666;
  font-size: 24rpx;
  line-height: 40rpx;
}

.balance-copy {
  min-height: 96rpx;
}

.cash-copy {
  min-height: 250rpx;
}

.cash-copy .copy-text.collapsed {
  -webkit-line-clamp: 4;
}
</style>
