<template>
  <view class="top-tabs">
    <view
      v-for="tab in tabs"
      :key="tab.key"
      class="top-tab"
      :class="{ active: tab.key === active }"
      @click="$emit('change', tab.key)"
    >
      {{ tab.label }}
    </view>
  </view>
</template>

<script>
export default {
  props: {
    tabs: { type: Array, default: () => [] },
    active: { type: String, default: '' }
  }
}
</script>

<style>
.top-tabs {
  height: 76rpx;
  display: flex;
  align-items: stretch;
}

.top-tab {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #808080;
  font-size: 27rpx;
  position: relative;
  white-space: nowrap;
}

.top-tab.active {
  color: #198cff;
  font-weight: 500;
}

.top-tab.active::after {
  content: "";
  position: absolute;
  left: 50%;
  bottom: 4rpx;
  width: 84rpx;
  height: 4rpx;
  margin-left: -42rpx;
  border-radius: 2rpx;
  background: #198cff;
}
</style>
