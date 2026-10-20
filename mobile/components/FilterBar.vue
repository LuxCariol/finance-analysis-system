<template>
  <view class="filter-bar">
    <view class="mode" :class="{ active: mode === 'year' }" @click="setMode('year')">整年</view>
    <view class="mode" :class="{ active: mode === 'month' }" @click="setMode('month')">整月</view>
    <view class="mode" :class="{ active: mode === 'custom' }" @click="setMode('custom')">自定义</view>
    <picker class="year-picker" mode="selector" :range="yearLabels" :value="yearIndex" @change="changeYear">
      <view class="year">{{ year }}年 <text class="caret">⌄</text></view>
    </picker>
  </view>
</template>

<script>
export default {
  props: {
    year: { type: [String, Number], default: '2021' },
    mode: { type: String, default: 'year' }
  },
  data() {
    return {
      years: ['2021', '2020', '2019', '2018', '2017']
    }
  },
  computed: {
    yearLabels() {
      return this.years.map(item => item + '年')
    },
    yearIndex() {
      const index = this.years.indexOf(String(this.year))
      return index < 0 ? 0 : index
    }
  },
  methods: {
    setMode(mode) {
      this.$emit('mode-change', mode)
    },
    changeYear(event) {
      const value = this.years[Number(event.detail.value)] || this.years[0]
      this.$emit('year-change', value)
    }
  }
}
</script>

<style>
.filter-bar {
  height: 58rpx;
  display: flex;
  align-items: center;
  color: #ffffff;
  font-size: 28rpx;
}

.mode {
  margin-right: 54rpx;
  opacity: 0.92;
  line-height: 52rpx;
}

.mode.active {
  font-weight: 600;
  opacity: 1;
}

.year-picker {
  margin-left: auto;
}

.year {
  min-width: 118rpx;
  text-align: right;
  color: #ffffff;
  font-size: 28rpx;
}

.caret {
  font-size: 24rpx;
  margin-left: 4rpx;
  color: rgba(255, 255, 255, 0.85);
}
</style>
