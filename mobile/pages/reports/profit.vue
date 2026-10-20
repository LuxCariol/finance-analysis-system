<template>
  <view class="page no-tab profit-detail">
    <AppHeader title="明细" :back="true">
      <template #filters>
        <FilterBar :year="year" :mode="mode" @mode-change="mode = $event" @year-change="changeYear" />
      </template>
    </AppHeader>
    <view class="table">
      <view class="table-head detail-head">
        <view class="col-label">类目</view>
        <view class="col-money">金额（万元）</view>
        <view class="col-rate">同比</view>
        <view class="col-rate">环比</view>
      </view>
      <view v-for="item in rows" :key="item.field" class="table-row detail-row">
        <view class="col-label label-cell">
          <view v-if="item.field === 'YYLR'" class="row-bullet"></view>
          <text>{{ item.name }}</text>
        </view>
        <view class="col-money money-cell">{{ numberText(item.value) }}</view>
        <view class="col-rate rate-cell">{{ rateText(item.yoy) }}</view>
        <view class="col-rate rate-cell">{{ rateText(item.mom) }}</view>
      </view>
    </view>
    <view v-if="!rows.length && !loading" class="placeholder">暂无利润表数据</view>
  </view>
</template>

<script>
import AppHeader from '../../components/AppHeader.vue'
import FilterBar from '../../components/FilterBar.vue'
import { get } from '../../common/request'

export default {
  components: { AppHeader, FilterBar },
  data() {
    return {
      year: '2021',
      mode: 'year',
      loading: true,
      rows: []
    }
  },
  onLoad(options) {
    if (options && options.year) this.year = options.year
    this.load()
  },
  methods: {
    async load() {
      this.loading = true
      try {
        const data = await get('/api/finance/annual-profit', { year: this.year })
        this.rows = (data.items || []).filter(item => item.field !== 'JLR')
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
      return Number(value || 0).toFixed(2)
    },
    rateText(value) {
      const number = Number(value || 0)
      return (number < 0 ? '-' : '') + Math.abs(number).toFixed(2) + '%'
    }
  }
}
</script>

<style>
.detail-head {
  height: 76rpx;
  font-size: 25rpx;
  font-weight: 500;
}

.detail-row {
  min-height: 66rpx;
  font-size: 26rpx;
}

.col-label {
  width: 48%;
}

.col-money {
  width: 19%;
  text-align: right;
}

.col-rate {
  width: 16.5%;
  text-align: right;
}

.col-rate:last-child {
  width: 16.5%;
  padding-right: 18rpx;
}

.detail-head .col-label {
  padding-left: 0;
  text-align: center;
}

.detail-head .col-money,
.detail-head .col-rate {
  padding-right: 8rpx;
  text-align: center;
}

.label-cell {
  min-width: 0;
  padding-left: 48rpx;
  display: flex;
  align-items: center;
}

.row-bullet {
  width: 10rpx;
  height: 10rpx;
  margin-left: -20rpx;
  margin-right: 10rpx;
  border-radius: 50%;
  background: #3bbfe7;
}

.money-cell {
  color: #303133;
  font-family: "DIN Alternate", "Arial Narrow", Arial, sans-serif;
}

.rate-cell {
  color: #303133;
  font-family: "DIN Alternate", "Arial Narrow", Arial, sans-serif;
}
</style>
