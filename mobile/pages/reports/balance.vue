<template>
  <view class="page no-tab">
    <AppHeader title="明细" :back="true">
      <template #filters>
        <FilterBar :year="year" :mode="mode" @mode-change="mode = $event" @year-change="changeYear" />
      </template>
    </AppHeader>
    <view class="table">
      <view class="table-head report-head">
        <view class="report-label">类目</view>
        <view class="report-value">金额（万元）</view>
      </view>
      <view v-for="(item, index) in rows" :key="index" class="table-row report-row">
        <view class="report-label">{{ item.CODE_NAME || item.codeName || item.CODE_NO || item.codeNo }}</view>
        <view class="report-value money">{{ numberText(item.DATA_VALUE !== undefined ? item.DATA_VALUE : item.dataValue) }}</view>
      </view>
    </view>
    <view v-if="!rows.length && !loading" class="placeholder">暂无资产负债表数据</view>
  </view>
</template>

<script>
import AppHeader from '../../components/AppHeader.vue'
import FilterBar from '../../components/FilterBar.vue'
import { get } from '../../common/request'

export default {
  components: { AppHeader, FilterBar },
  data() {
    return { year: '2021', mode: 'year', loading: true, rows: [] }
  },
  onLoad(options) {
    if (options && options.year) this.year = options.year
    this.load()
  },
  methods: {
    async load() {
      this.loading = true
      try {
        const data = await get('/api/report/balance', { period: this.year + '12' })
        this.rows = data.items || []
      } catch (error) {
        this.rows = []
      } finally {
        this.loading = false
      }
    },
    changeYear(year) {
      this.year = year
      this.load()
    },
    numberText(value) {
      return (Number(value || 0) / 10000).toFixed(2)
    }
  }
}
</script>

<style>
.report-head {
  height: 76rpx;
  font-size: 25rpx;
}

.report-row {
  min-height: 66rpx;
  font-size: 26rpx;
}

.report-label {
  flex: 1;
  padding-left: 36rpx;
}

.report-value {
  width: 220rpx;
  padding-right: 24rpx;
  text-align: right;
}

.report-head .report-label {
  padding-left: 0;
  text-align: center;
}

.report-head .report-value {
  text-align: center;
}
</style>
