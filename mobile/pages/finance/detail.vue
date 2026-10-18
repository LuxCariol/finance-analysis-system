<template>
  <view class="page">
    <AppHeader :title="title" :subtitle="subtitle" eyebrow="FINANCIAL DETAIL" back compact />
    <view class="tabs">
      <view class="tab" :class="{ active: mode === 'trend' }" @click="setMode('trend')">明细趋势</view>
      <view class="tab" :class="{ active: mode === 'aging' }" @click="setMode('aging')">账龄分析</view>
      <view class="tab" :class="{ active: mode === 'balance' }" @click="setMode('balance')">科目余额</view>
    </view>

    <view v-if="mode === 'trend'">
      <view class="card">
        <view class="row">
          <text class="card-title">{{ trend.name || code }}</text>
          <text class="pill">{{ (trend.values || []).length }} 期</text>
        </view>
        <LineChart :labels="trend.periods || []" :series="chartSeries" />
      </view>
      <view class="card">
        <view class="row period-row">
          <text class="muted">会计期间</text><text class="muted">金额（元）</text>
        </view>
        <view v-for="(period, index) in trend.periods || []" :key="index" class="period-row">
          <text>{{ periodText(period) }}</text>
          <text class="money">{{ money(trend.values ? trend.values[index] : 0) }}</text>
        </view>
        <EmptyState v-if="!(trend.periods || []).length" />
      </view>
    </view>

    <view v-else-if="mode === 'aging'">
      <view class="card">
        <view class="row">
          <text class="card-title">账龄结构</text>
          <picker :range="agingTypes" range-key="name" @change="changeAging">
            <view class="pill">{{ currentAgingName }} ▾</view>
          </picker>
        </view>
        <BarChart :items="agingChart" />
      </view>
      <view class="card">
        <view class="row period-row"><text class="muted">核算项目</text><text class="muted">余额（元）</text></view>
        <view v-for="(item, index) in aging.rows || []" :key="index" class="period-row">
          <view>
            <text class="account-name">{{ item.projectName }}</text>
            <text class="account-code">{{ item.projectCode }}</text>
          </view>
          <text class="money">{{ money(item.balance) }}</text>
        </view>
        <EmptyState v-if="!(aging.rows || []).length" title="暂无账龄数据" desc="请先在后台导入对应账龄分析表" />
      </view>
    </view>

    <view v-else>
      <view class="card">
        <view class="row period-row">
          <text class="muted">科目</text><text class="muted">期末余额（元）</text>
        </view>
        <view v-for="(item, index) in balances" :key="index" class="period-row">
          <view>
            <text class="account-name">{{ item.subjectName }}</text>
            <text class="account-code">{{ item.subjectCode }}</text>
          </view>
          <text class="money">{{ money(item.qmjfye || item.qmdfye) }}</text>
        </view>
        <EmptyState v-if="!balances.length" title="暂无科目余额" desc="请先导入科目余额表" />
      </view>
    </view>
  </view>
</template>

<script>
import AppHeader from '../../components/AppHeader.vue'
import LineChart from '../../components/LineChart.vue'
import BarChart from '../../components/BarChart.vue'
import EmptyState from '../../components/EmptyState.vue'
import { get } from '../../common/request'
import { money, periodText } from '../../common/format'

export default {
  components: { AppHeader, LineChart, BarChart, EmptyState },
  data() {
    return {
      code: 'ZCFZ-G',
      mode: 'trend',
      trend: {},
      aging: {},
      balances: [],
      agingType: 7,
      agingTypes: [
        { value: 3, name: '其他应付' }, { value: 4, name: '其他应收' },
        { value: 5, name: '应付账款' }, { value: 6, name: '应收账款' },
        { value: 7, name: '预付账款' }, { value: 8, name: '预收账款' }
      ],
      periodText,
      money
    }
  },
  computed: {
    title() { return this.mode === 'aging' ? '账龄与科目详情' : this.trend.name || '财务数据详情' },
    subtitle() { return this.mode === 'trend' ? (this.code + ' · 月度变化') : '往来款与科目余额' },
    chartSeries() { return [{ name: this.trend.name || this.code, values: this.trend.values || [] }] },
    currentAgingName() { return (this.agingTypes.find(item => item.value === this.agingType) || {}).name || '选择类型' },
    agingChart() {
      const summary = this.aging.summary || {}
      return (summary.labels || []).map((label, index) => ({ label, value: (summary.values || [])[index] }))
    }
  },
  onLoad(options) {
    if (options.code) this.code = options.code
    if (options.type === 'aging') this.mode = 'aging'
    this.load()
  },
  methods: {
    async load() {
      if (this.mode === 'trend') {
        try { this.trend = await get('/api/finance/detail/chart', { code: this.code }) } catch (e) { this.trend = {} }
      } else if (this.mode === 'aging') {
        await this.loadAging()
      } else {
        await this.loadBalance()
      }
    },
    async loadAging() {
      try { this.aging = await get('/api/finance/aging', { type: this.agingType }) } catch (e) { this.aging = {} }
    },
    async loadBalance() {
      try {
        const data = await get('/api/report/account-balance')
        this.balances = data.items || []
      } catch (e) { this.balances = [] }
    },
    setMode(mode) { this.mode = mode; this.load() },
    changeAging(event) { this.agingType = this.agingTypes[event.detail.value].value; this.loadAging() }
  }
}
</script>

<style>
.tabs { display: flex; background: #fff; padding: 8rpx; border-radius: 18rpx; margin-bottom: 22rpx; }
.tab { flex: 1; text-align: center; padding: 18rpx 0; font-size: 24rpx; color: #7b8798; border-radius: 13rpx; }
.tab.active { background: #12233f; color: #fff; }
.card-title { font-size: 29rpx; font-weight: 600; color: #22314a; }
.period-row { display: flex; justify-content: space-between; align-items: center; padding: 18rpx 0; border-bottom: 1rpx solid #f1f3f6; font-size: 23rpx; color: #56657a; }
.period-row:last-child { border-bottom: none; }
.account-name { display: block; color: #33445d; font-size: 23rpx; }
.account-code { display: block; margin-top: 4rpx; color: #a0a9b6; font-size: 19rpx; }
</style>
