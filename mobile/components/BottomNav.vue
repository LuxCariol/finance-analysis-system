<template>
  <view class="bottom-nav">
    <view
      v-for="item in items"
      :key="item.key"
      class="nav-item"
      :class="{ active: item.key === active }"
      @click="go(item)"
    >
      <image class="nav-icon" :src="iconOf(item)" mode="aspectFit"></image>
      <text class="nav-text">{{ item.label }}</text>
    </view>
    <view class="safe-area"></view>
  </view>
</template>

<script>
export default {
  props: {
    active: { type: String, default: 'report' }
  },
  data() {
    return {
      items: [
        { key: 'report', label: '报告', url: '/pages/home/home', icon: 'home' },
        { key: 'analysis', label: '分析', url: '/pages/analysis/index', icon: 'statistics' },
        { key: 'forecast', label: '预测', url: '/pages/forecast/profit', icon: 'forecast' },
        { key: 'profile', label: '我的', url: '/pages/profile/index', icon: 'wode' }
      ]
    }
  },
  methods: {
    iconOf(item) {
      if (item.key !== this.active) return '/static/tabBar/' + item.icon + '.png'
      if (item.icon === 'wode') return '/static/tabBar/wode-select.png'
      return '/static/tabBar/' + item.icon + '_selected.png'
    },
    go(item) {
      if (item.key === this.active) return
      uni.reLaunch({ url: item.url })
    }
  }
}
</script>

<style>
.bottom-nav {
  position: fixed;
  left: 0;
  right: 0;
  bottom: 0;
  z-index: 90;
  display: flex;
  flex-wrap: wrap;
  background: #ffffff;
  border-top: 1rpx solid #eeeeee;
}

.nav-item {
  width: 25%;
  height: 112rpx;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: #878787;
}

.nav-item.active {
  color: #3bbfe7;
}

.nav-icon {
  width: 44rpx;
  height: 44rpx;
  display: block;
}

.nav-text {
  margin-top: 8rpx;
  font-size: 22rpx;
  line-height: 24rpx;
  color: inherit;
}

.safe-area {
  width: 100%;
  height: env(safe-area-inset-bottom);
  background: #ffffff;
}
</style>
