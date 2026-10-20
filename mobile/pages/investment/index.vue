<template>
  <view class="page no-tab investment-page">
    <AppHeader title="预测结果" :back="true" />

    <view class="result-title">
      <view class="result-marker"></view>
      <text>预测结果</text>
    </view>
    <view class="group-bar">
      <view class="group-name">考虑通胀</view>
      <view class="group-name">不考虑通胀</view>
    </view>
    <view class="scenario-table">
      <view class="scenario-head">
        <view class="scenario-label"></view>
        <view v-for="(head, index) in heads" :key="index" class="scenario-col">
          <text>{{ head[0] }}</text>
          <text>{{ head[1] }}</text>
        </view>
      </view>
      <view class="scenario-row">
        <view class="scenario-label">静态投资<br>回收期</view>
        <view v-for="(item, index) in paybackValues" :key="index" class="scenario-col">{{ item }}</view>
      </view>
      <view class="scenario-row irr-row">
        <view class="scenario-label">内部收益<br>率（IRR）</view>
        <view v-for="(item, index) in irrValues" :key="index" class="scenario-col">{{ item }}</view>
      </view>
    </view>

    <view class="cash-title">
      <view class="result-marker"></view>
      <text>全资本金投入的现金流测算</text>
      <text class="cash-unit">（万元） ›</text>
    </view>
    <scroll-view scroll-x class="cash-scroll">
      <view class="cash-table">
        <view class="cash-row cash-head">
          <view class="cash-topic"></view>
          <view v-for="year in yearColumns" :key="year" class="cash-value">{{ year }}</view>
        </view>
        <view v-for="row in cashRows" :key="row.name" class="cash-row">
          <view class="cash-topic">{{ row.name }}</view>
          <view v-for="(value, index) in row.values" :key="index" class="cash-value money">
            {{ numberText(value) }}
          </view>
        </view>
      </view>
    </scroll-view>
  </view>
</template>

<script>
import AppHeader from '../../components/AppHeader.vue'
import { post } from '../../common/request'

export default {
  components: { AppHeader },
  data() {
    return {
      heads: [
        ['部分资本', '金投入'],
        ['全资本金', '投入'],
        ['部分资本', '金投入'],
        ['全资本金', '投入']
      ],
      inflationResult: {},
      plainResult: {},
      form: {
        initialInvestment: 200,
        projectYears: 10,
        discountRate: 0.1,
        taxRate: 0.25,
        vatRate: 0.13,
        annualRevenue: 240,
        annualCost: 180,
        loanAmount: 40,
        loanRate: 0.06,
        loanYears: 4,
        salvageRate: 0.05,
        revenueGrowth: 0.03,
        costGrowth: 0.02
      }
    }
  },
  computed: {
    paybackValues() {
      return [
        this.years(this.inflationResult.paybackInvestment),
        this.years(this.inflationResult.paybackFullCapital),
        this.years(this.plainResult.paybackInvestment),
        this.years(this.plainResult.paybackFullCapital)
      ]
    },
    irrValues() {
      return [
        this.percent(this.inflationResult.irrInvestment),
        this.percent(this.inflationResult.irrFullCapital),
        this.percent(this.plainResult.irrInvestment),
        this.percent(this.plainResult.irrFullCapital)
      ]
    },
    yearColumns() {
      return ['0', '1', '2', '3', '4', '5', '6', '7', '8']
    },
    cashRows() {
      const yearly = this.plainResult.yearly || []
      const initial = Number(this.plainResult.input ? this.plainResult.input.initialInvestment : 200)
      const sales = yearly.map(item => Number(item.revenue || 0))
      const vat = yearly.map(item => Number(item.vat || 0))
      const cost = yearly.map(item => Number(item.cost || 0))
      const tax = yearly.map(item => Number(item.incomeTax || 0))
      const inflow = sales.map((value, index) => value + vat[index])
      const outflow = cost.map((value, index) => value + tax[index])
      const zeros = yearly.map(() => 0)
      return [
        { name: '现金流入', values: [0].concat(inflow) },
        { name: '产品销售收入', values: [0].concat(sales) },
        { name: '销项税额', values: [0].concat(vat) },
        { name: '现金流出', values: [initial].concat(outflow) },
        { name: '期初支出金额', values: [initial].concat(zeros) },
        { name: '总成本费用', values: [0].concat(cost) },
        { name: '所得税费用', values: [0].concat(tax) }
      ]
    }
  },
  onLoad() {
    this.load()
  },
  methods: {
    async load() {
      try {
        const results = await Promise.all([
          post('/api/investment/forecast', { ...this.form, inflation: 1 }),
          post('/api/investment/forecast', { ...this.form, inflation: 0 })
        ])
        this.inflationResult = results[0] || {}
        this.plainResult = results[1] || {}
      } catch (error) {
        this.inflationResult = {}
        this.plainResult = {}
      }
    },
    years(value) {
      const number = Number(value || 0)
      return number > 0 ? number.toFixed(2) + '年' : '--'
    },
    percent(value) {
      return Number(value || 0).toFixed(2) + '%'
    },
    numberText(value) {
      return Number(value || 0).toFixed(2)
    }
  }
}
</script>

<style>
.investment-page {
  background: #ffffff;
}

.result-title {
  height: 82rpx;
  padding-left: 12rpx;
  display: flex;
  align-items: center;
  color: #303133;
  font-size: 28rpx;
}

.result-marker {
  width: 18rpx;
  height: 32rpx;
  margin-right: 8rpx;
  position: relative;
}

.result-marker::before,
.result-marker::after {
  content: "";
  position: absolute;
  left: 1rpx;
  width: 7rpx;
  height: 20rpx;
  border-radius: 2rpx;
  background: #3bbfe7;
  transform: skewX(-24deg);
}

.result-marker::before {
  top: 1rpx;
}

.result-marker::after {
  top: 14rpx;
}

.group-bar {
  height: 62rpx;
  display: flex;
  align-items: center;
  background: #f5f6f8;
}

.group-name {
  width: 38%;
  text-align: center;
  color: #198cff;
  font-size: 27rpx;
}

.group-name:first-child {
  margin-left: 24%;
}

.scenario-table {
  padding-bottom: 26rpx;
  background: #ffffff;
}

.scenario-head,
.scenario-row {
  display: flex;
  align-items: center;
}

.scenario-head {
  min-height: 104rpx;
  color: #303133;
  font-size: 26rpx;
}

.scenario-label {
  width: 24%;
  padding-left: 24rpx;
  color: #303133;
  font-size: 26rpx;
  line-height: 36rpx;
}

.scenario-col {
  width: 19%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: #303133;
  font-size: 25rpx;
  line-height: 34rpx;
}

.scenario-row {
  min-height: 84rpx;
  color: #303133;
  font-size: 26rpx;
}

.scenario-row .scenario-col {
  font-family: "DIN Alternate", "Arial Narrow", Arial, sans-serif;
}

.cash-title {
  height: 82rpx;
  padding-left: 12rpx;
  display: flex;
  align-items: center;
  color: #303133;
  font-size: 28rpx;
}

.cash-unit {
  margin-left: auto;
  padding-right: 20rpx;
  color: #666666;
  font-size: 24rpx;
}

.cash-scroll {
  width: 100%;
  white-space: nowrap;
}

.cash-table {
  min-width: 900rpx;
}

.cash-row {
  height: 62rpx;
  display: flex;
  align-items: center;
  border-bottom: 1rpx solid #f1f1f1;
  font-size: 25rpx;
  color: #303133;
}

.cash-head {
  height: 50rpx;
  color: #666666;
}

.cash-topic {
  width: 300rpx;
  padding-left: 30rpx;
  flex-shrink: 0;
}

.cash-value {
  width: 110rpx;
  padding-right: 8rpx;
  text-align: right;
  flex-shrink: 0;
}
</style>
