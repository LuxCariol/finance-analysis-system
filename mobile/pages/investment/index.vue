<template>
  <view class="page">
    <AppHeader title="投资预测" subtitle="项目资本预算与现金流测算" eyebrow="INVESTMENT MODEL" back compact />
    <view class="card form-card">
      <view class="form-grid">
        <view class="field" v-for="field in fields" :key="field.key">
          <text class="label">{{ field.label }}</text>
          <input v-model="form[field.key]" type="digit" class="input" />
        </view>
      </view>
      <view class="actions">
        <view class="btn-ghost" @click="calculate(true)">快速测算</view>
        <view class="btn-primary" @click="calculate(false)">{{ loading ? '计算中…' : '完整测算' }}</view>
      </view>
    </view>

    <view v-if="result.npvInvestment !== undefined">
      <view class="result-grid">
        <MetricCard label="项目净现值" :value="compactMoney(result.npvInvestment)" unit="元"
          :tone="Number(result.npvInvestment) >= 0 ? 'teal' : 'red'" />
        <MetricCard label="内部收益率" :value="result.irrInvestment + '%'" unit="IRR" tone="gold" />
        <MetricCard label="投资回收期" :value="result.paybackInvestment > 0 ? result.paybackInvestment + ' 年' : '未回收'" unit="" />
        <MetricCard label="全资本净现值" :value="compactMoney(result.npvFullCapital)" unit="元" />
      </view>
      <view class="card conclusion">
        <text class="conclusion-title">测算结论</text>
        <text class="conclusion-text">{{ result.conclusion }}</text>
      </view>
      <view class="section-title">逐年现金流</view>
      <view class="card">
        <view class="row period-row">
          <text class="muted">年度</text><text class="muted">净利润</text><text class="muted">项目现金流</text>
        </view>
        <view v-for="row in result.yearly || []" :key="row.year" class="period-row">
          <text>第 {{ row.year }} 年</text>
          <text class="money">{{ compactMoney(row.netProfit) }}</text>
          <text class="money">{{ compactMoney(row.investmentCash) }}</text>
        </view>
      </view>
      <view class="card note"><text>{{ result.note }}</text></view>
    </view>
  </view>
</template>
<script>
import AppHeader from '../../components/AppHeader.vue'
import MetricCard from '../../components/MetricCard.vue'
import { post } from '../../common/request'
import { compactMoney } from '../../common/format'
export default {
  components: { AppHeader, MetricCard },
  data() {
    return {
      loading: false,
      result: {},
      compactMoney,
      form: {
        initialInvestment: 5000000,
        projectYears: 5,
        discountRate: 0.1,
        taxRate: 0.25,
        vatRate: 0.13,
        annualRevenue: 8000000,
        annualCost: 4500000,
        loanAmount: 2000000,
        loanRate: 0.06,
        loanYears: 3,
        salvageRate: 0.05,
        revenueGrowth: 0.03,
        costGrowth: 0.02
      },
      fields: [
        { key: 'initialInvestment', label: '初始投资（元）' },
        { key: 'projectYears', label: '项目年限' },
        { key: 'discountRate', label: '折现率（小数）' },
        { key: 'taxRate', label: '所得税率（小数）' },
        { key: 'vatRate', label: '增值税率（小数）' },
        { key: 'annualRevenue', label: '年营业收入（元）' },
        { key: 'annualCost', label: '年营业成本（元）' },
        { key: 'loanAmount', label: '借款金额（元）' },
        { key: 'loanRate', label: '借款利率（小数）' },
        { key: 'loanYears', label: '借款年限' },
        { key: 'salvageRate', label: '残值率（小数）' },
        { key: 'revenueGrowth', label: '收入增长率' }
      ]
    }
  },
  methods: {
    async calculate(preview) {
      this.loading = true
      try {
        this.result = await post(preview ? '/api/investment/preview' : '/api/investment/forecast', this.form)
      } catch (e) {
        this.result = {}
      } finally {
        this.loading = false
      }
    }
  }
}
</script>
<style>
.form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 22rpx 18rpx; }
.field { display: flex; flex-direction: column; }
.label { color: #6f7d90; font-size: 21rpx; margin-bottom: 8rpx; }
.input { height: 64rpx; padding: 0 14rpx; border-radius: 10rpx; background: #f4f6f9; color: #1e2c43; font-size: 23rpx; }
.actions { display: grid; grid-template-columns: 0.8fr 1.2fr; gap: 16rpx; margin-top: 28rpx; }
.result-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 18rpx; margin-bottom: 24rpx; }
.conclusion { background: linear-gradient(130deg, #172b49, #1c4a5d); color: #fff; }
.conclusion-title { font-size: 27rpx; font-weight: 600; }
.conclusion-text { display: block; margin-top: 12rpx; color: rgba(255,255,255,0.72); font-size: 22rpx; line-height: 1.7; }
.period-row { display: flex; justify-content: space-between; padding: 18rpx 0; border-bottom: 1rpx solid #f1f3f6; font-size: 22rpx; color: #56657a; }
.period-row text { flex: 1; }
.period-row text:nth-child(2), .period-row text:nth-child(3) { text-align: right; }
.period-row:last-child { border-bottom: none; }
.note { color: #8a96a7; font-size: 20rpx; line-height: 1.65; }
</style>
