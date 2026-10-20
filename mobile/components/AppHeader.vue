<template>
  <view class="app-header">
    <view class="status-space"></view>
    <view class="title-row">
      <view class="back" :class="{ invisible: !back }" @click="goBack">
        <text class="back-arrow">‹</text>
      </view>
      <text class="title">{{ title }}</text>
      <view class="right-slot"><slot name="right"></slot></view>
    </view>
    <view v-if="hasFilters" class="filter-slot"><slot name="filters"></slot></view>
    <view v-if="hasTabs" class="tab-slot"><slot name="tabs"></slot></view>
  </view>
</template>

<script>
export default {
  props: {
    title: { type: String, default: '' },
    back: { type: Boolean, default: false }
  },
  computed: {
    hasFilters() {
      return !!((this.$slots && this.$slots.filters) || (this.$scopedSlots && this.$scopedSlots.filters))
    },
    hasTabs() {
      return !!((this.$slots && this.$slots.tabs) || (this.$scopedSlots && this.$scopedSlots.tabs))
    }
  },
  methods: {
    goBack() {
      if (!this.back) return
      const pages = getCurrentPages()
      if (pages.length > 1) {
        uni.navigateBack({ delta: 1 })
      } else {
        uni.reLaunch({ url: '/pages/home/home' })
      }
    }
  }
}
</script>

<style>
.app-header {
  background: #3bbfe7;
  color: #ffffff;
}

.status-space {
  height: calc(var(--status-bar-height) + 8rpx);
  min-height: 48rpx;
}

.title-row {
  height: 82rpx;
  display: flex;
  align-items: center;
  padding: 0 20rpx;
  position: relative;
}

.back {
  width: 64rpx;
  height: 82rpx;
  display: flex;
  align-items: center;
}

.back.invisible {
  visibility: hidden;
}

.back-arrow {
  font-family: Arial, sans-serif;
  font-size: 58rpx;
  line-height: 1;
  color: #ffffff;
  font-weight: 300;
}

.title {
  flex: 1;
  text-align: center;
  font-size: 34rpx;
  font-weight: 500;
  letter-spacing: 1rpx;
  color: #ffffff;
}

.right-slot {
  width: 64rpx;
  min-height: 40rpx;
  text-align: right;
  font-size: 24rpx;
}

.filter-slot {
  padding: 0 24rpx 8rpx;
}

.tab-slot {
  padding: 0 10rpx;
}
</style>
