<template>
  <view class="page no-tab detail-page">
    <AppHeader :title="pageTitle" :back="true">
      <template #filters>
        <FilterBar :year="year" :mode="mode" @mode-change="mode = $event" @year-change="changeYear" />
      </template>
    </AppHeader>

    <template v-if="modeName === 'aging'">
      <view class="aging-summary">
        <text class="summary-range">{{ data.periodStart || (year + '01') }}、{{ data.periodEnd || (year + '12') }} {{ data.title || '' }}</text>
        <view class="total-line">
          <text class="total-value money">{{ numberText(data.yearTotal) }}</text>
          <text class="total-unit">万元</text>
        </view>
        <text class="update-text">数据已更新 至时间：{{ data.period || (year + '12') }}</text>
      </view>

      <view class="aging-section-title">
        <view class="aging-marker"></view>
        <text>{{ data.title || '' }}变动</text>
      </view>
      <view class="chart-caption">单位（万元）</view>
      <view class="aging-chart">
        <LineChart
          v-if="chartLabels.length"
          :labels="chartLabels"
          :series="chartSeries"
          :height="300"
          :y-max="25"
          :x-tick-count="5"
          :highlight-max="true"
        />
      </view>

      <view class="aging-section-title donut-title">
        <view class="aging-marker"></view>
        <text>各区间账龄占比（单位：万元）</text>
      </view>
      <view class="donut-block">
        <DonutChart :labels="donutLabels" :values="donutValues" />
      </view>
    </template>

    <template v-else>
      <view class="trend-summary">
        <text class="trend-name">{{ trend.name || code }}</text>
        <text class="trend-range">{{ year }}年 单位（万元）</text>
      </view>
      <view class="aging-chart">
        <LineChart v-if="trend.labels && trend.labels.length" :labels="trend.labels" :series="trendSeries" :height="320" />
        <view v-else class="placeholder">暂无趋势数据</view>
      </view>
    </template>
  </view>
</template>

<script>
import AppHeader from '../../components/AppHeader.vue'
import FilterBar from '../../components/FilterBar.vue'
import LineChart from '../../components/LineChart.vue'
import DonutChart from '../../components/DonutChart.vue'
import { get } from '../../common/request'

export default {
  components: { AppHeader, FilterBar, LineChart, DonutChart },
  data() {
    return {
      modeName: 'aging',
      agingType: 4,
      code: 'ZCFZ-G',
      year: '2021',
      mode: 'year',
      data: {},
      trend: {}
    }
  },
  computed: {
    pageTitle() {
      return this.modeName === 'aging' ? (this.data.title || '账龄分析') : (this.trend.name || '数据详情')
    },
    chartLabels() {
      return this.data.trendPeriods || []
    },
    chartSeries() {
      return [
        { name: '本期', values: this.data.trendValues || [] },
        { name: '上期', values: this.data.previousTrendValues || [] }
      ]
    },
    donutLabels() {
      const labels = (this.data.summary || {}).labels || []
      return labels.slice(0, 3).map(label => String(label).replace('-', '到'))
    },
    donutValues() {
      const values = (this.data.summary || {}).values || []
      return values.slice(0, 3)
    },
    trendSeries() {
      return [{ name: this.trend.name || this.code, values: this.trend.values || [] }]
    }
  },
  onLoad(options) {
    if (options) {
      if (options.type === 'aging' || options.agingType) this.modeName = 'aging'
      if (options.agingType) this.agingType = Number(options.agingType)
      if (options.type && options.type !== 'aging' && options.type !== 'trend') {
        this.modeName = 'aging'
        this.agingType = Number(options.type)
      }
      if (options.year) this.year = options.year
      if (options.code) this.code = decodeURIComponent(options.code)
    }
    this.load()
  },
  methods: {
    async load() {
      try {
        if (this.modeName === 'aging') {
          this.data = await get('/api/finance/aging', {
            type: this.agingType,
            period: this.year + '12'
          })
        } else {
          const result = await get('/api/finance/detail/chart', { code: this.code })
          this.trend = {
            ...result,
            labels: result.periods || [],
            values: (result.values || []).map(value => Number(value || 0))
          }
        }
      } catch (error) {
        this.data = {}
        this.trend = {}
      }
    },
    changeYear(year) {
      this.year = year
      this.load()
    },
    numberText(value) {
      return Number(value || 0).toFixed(2)
    }
  }
}
</script>

<style>
.detail-page {
  background: #ffffff;
}

.aging-summary {
  padding: 24rpx 24rpx 28rpx;
  text-align: center;
  background: #ffffff;
}

.summary-range {
  display: block;
  color: #666666;
  font-size: 27rpx;
  line-height: 38rpx;
}

.total-line {
  margin-top: 10rpx;
  display: flex;
  justify-content: center;
  align-items: baseline;
}

.total-value {
  color: #303133;
  font-size: 48rpx;
  font-weight: 600;
}

.total-unit {
  margin-left: 8rpx;
  color: #303133;
  font-size: 28rpx;
}

.update-text {
  display: block;
  margin-top: 8rpx;
  color: #999999;
  font-size: 22rpx;
}

.aging-section-title {
  height: 70rpx;
  padding-left: 12rpx;
  display: flex;
  align-items: center;
  background: #f0f8ff;
  color: #303133;
  font-size: 27rpx;
  border-top: 1rpx solid #f0f8ff;
  border-bottom: 1rpx solid #f0f8ff;
}

.aging-marker {
  width: 18rpx;
  height: 32rpx;
  margin-right: 8rpx;
  position: relative;
}

.aging-marker::before,
.aging-marker::after {
  content: "";
  position: absolute;
  left: 1rpx;
  width: 7rpx;
  height: 20rpx;
  border-radius: 2rpx;
  background: #3bbfe7;
  transform: skewX(-24deg);
}

.aging-marker::before {
  top: 1rpx;
}

.aging-marker::after {
  top: 14rpx;
}

.chart-caption {
  padding: 16rpx 26rpx 0;
  color: #666666;
  font-size: 23rpx;
  background: #ffffff;
}

.aging-chart {
  padding: 6rpx 20rpx 12rpx;
  background: #ffffff;
}

.donut-title {
  margin-top: 14rpx;
}

.donut-block {
  padding: 12rpx 14rpx 30rpx;
  background: #ffffff;
}

.trend-summary {
  padding: 30rpx 24rpx 10rpx;
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.trend-name {
  font-size: 30rpx;
  color: #303133;
}

.trend-range {
  font-size: 23rpx;
  color: #999999;
}
</style>
