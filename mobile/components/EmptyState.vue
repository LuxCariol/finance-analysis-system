<template>
  <view class="empty">
    <view class="empty-icon">∅</view>
    <text class="empty-title">{{ title }}</text>
    <text class="empty-desc">{{ desc }}</text>
  </view>
</template>

<script>
export default {
  props: {
    title: { type: String, default: '暂无数据' },
    desc: { type: String, default: '请先在后台导入报表或稍后刷新' }
  }
}
</script>

<style>
.empty { padding: 70rpx 20rpx; display: flex; flex-direction: column; align-items: center; }
.empty-icon { width: 90rpx; height: 90rpx; line-height: 86rpx; border-radius: 50%; background: #edf2f6; color: #a1acbb; text-align: center; font-size: 40rpx; }
.empty-title { margin-top: 22rpx; color: #526176; font-size: 28rpx; font-weight: 600; }
.empty-desc { margin-top: 10rpx; color: #9aa5b4; font-size: 22rpx; text-align: center; }
</style>
