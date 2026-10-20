<template>
  <view class="page forecast-page">
    <AppHeader title="预测">
      <template #filters>
        <view class="forecast-filter">
          <view class="forecast-filter-left">
            <text>起始年度</text>
            <text class="unit-text">单位：万元</text>
          </view>
          <picker mode="selector" :range="yearOptions" :value="yearIndex" @change="changeStartYear">
            <view class="start-year">{{ startYear }}</view>
          </picker>
        </view>
      </template>
      <template #tabs>
        <TopTabs :tabs="tabs" :active="active" @change="changeTab" />
      </template>
    </AppHeader>

    <view class="table forecast-table">
      <view class="forecast-head">
        <view class="forecast-label"></view>
        <view v-for="year in years" :key="year" class="forecast-year">{{ year }}</view>
      </view>
      <view v-for="row in rows" :key="row.name" class="forecast-row">
        <view class="forecast-label">{{ row.name }}</view>
        <view v-for="(value, index) in row.values" :key="index" class="forecast-value money">
          {{ numberText(value) }}
        </view>
      </view>
    </view>
    <view v-if="!rows.length && !loading" class="placeholder">暂无预测数据</view>
    <BottomNav active="forecast" />
  </view>
</template>

<script>
import AppHeader from '../../components/AppHeader.vue'
import TopTabs from '../../components/TopTabs.vue'
import BottomNav from '../../components/BottomNav.vue'
import { get } from '../../common/request'

export default {
  components: { AppHeader, TopTabs, BottomNav },
  data() {
    return {
      active: 'profit',
      startYear: '2022',
      yearOptions: ['2022', '2023', '2024'],
      years: ['2022', '2023', '2024'],
      rows: [],
      loading: true,
      tabs: [
        { key: 'profit', label: '损益表预测' },
        { key: 'investment', label: '投资预测' }
      ]
    }
  },
  computed: {
    yearIndex() {
      const index = this.yearOptions.indexOf(String(this.startYear))
      return index < 0 ? 0 : index
    }
  },
  onShow() {
    this.load()
  },
  methods: {
    async load() {
      this.loading = true
      try {
        const data = await get('/api/forecast/annual-profit', { startYear: this.startYear, years: 3 })
        this.years = data.years || []
        this.rows = data.rows || []
      } catch (error) {
        this.rows = []
      } finally {
        this.loading = false
      }
    },
    changeStartYear(event) {
      this.startYear = this.yearOptions[Number(event.detail.value)] || this.yearOptions[0]
      this.load()
    },
    changeTab(tab) {
      if (tab === 'investment') {
        uni.navigateTo({ url: '/pages/investment/index' })
      } else {
        this.active = tab
      }
    },
    numberText(value) {
      return Number(value || 0).toFixed(2)
    }
  }
}
</script>

<style>
.forecast-page {
  background: #ffffff;
}

.forecast-filter {
  height: 58rpx;
  display: flex;
  align-items: center;
  justify-content: space-between;
  color: #ffffff;
  font-size: 28rpx;
}

.forecast-filter-left {
  display: flex;
  align-items: baseline;
}

.unit-text {
  margin-left: 26rpx;
  font-size: 24rpx;
  color: rgba(255, 255, 255, 0.92);
}

.start-year {
  color: #ffffff;
  font-size: 28rpx;
}

.forecast-table {
  background: #ffffff;
}

.forecast-head {
  height: 100rpx;
  display: flex;
  align-items: flex-end;
  padding-bottom: 20rpx;
  color: #303133;
  font-size: 25rpx;
  background: #ffffff;
}

.forecast-label {
  width: 31%;
  padding-left: 40rpx;
}

.forecast-year {
  width: 23%;
  text-align: center;
}

.forecast-row {
  height: 78rpx;
  display: flex;
  align-items: center;
  border-bottom: 1rpx solid #f1f1f1;
  color: #303133;
  font-size: 26rpx;
}

.forecast-row:last-child {
  border-bottom: none;
}

.forecast-value {
  width: 23%;
  padding-right: 18rpx;
  text-align: right;
  color: #303133;
  font-size: 25rpx;
}

.forecast-head .forecast-label {
  padding-left: 0;
}
</style>
