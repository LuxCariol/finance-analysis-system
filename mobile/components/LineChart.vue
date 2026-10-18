<template>
  <view class="chart-wrap">
    <canvas :canvas-id="canvasId" :id="canvasId" class="line-canvas"></canvas>
    <view class="legend">
      <view v-for="(series, index) in series" :key="index" class="legend-item">
        <view class="dot" :style="{ background: colors[index % colors.length] }"></view>
        <text>{{ series.name }}</text>
      </view>
    </view>
  </view>
</template>

<script>
import { COLORS } from '../common/config'

export default {
  props: {
    labels: { type: Array, default: () => [] },
    series: { type: Array, default: () => [] }
  },
  data() {
    return {
      canvasId: 'line_' + Math.floor(Math.random() * 1000000),
      colors: COLORS
    }
  },
  watch: {
    series: { handler() { this.draw() }, deep: true },
    labels() { this.draw() }
  },
  mounted() {
    this.$nextTick(() => setTimeout(this.draw, 120))
  },
  methods: {
    draw() {
      if (!this.labels.length || !this.series.length) return
      uni.createSelectorQuery().in(this).select('#' + this.canvasId).boundingClientRect(rect => {
        const width = rect ? rect.width : 620
        const height = rect ? rect.height : 260
        const context = uni.createCanvasContext(this.canvasId, this)
        context.clearRect(0, 0, width, height)
        const padding = { left: 14, right: 14, top: 18, bottom: 34 }
        const chartWidth = width - padding.left - padding.right
        const chartHeight = height - padding.top - padding.bottom
        const values = this.series.reduce((all, item) => all.concat((item.values || []).map(Number)), [])
        let min = Math.min(...values, 0)
        let max = Math.max(...values, 1)
        if (min === max) max = min + 1
        const xFor = index => padding.left + (this.labels.length === 1 ? chartWidth / 2 : chartWidth * index / (this.labels.length - 1))
        const yFor = value => padding.top + chartHeight - (Number(value) - min) / (max - min) * chartHeight
        context.setLineWidth(1)
        context.setStrokeStyle('#edf1f5')
        for (let i = 0; i <= 3; i++) {
          const y = padding.top + chartHeight * i / 3
          context.beginPath()
          context.moveTo(padding.left, y)
          context.lineTo(width - padding.right, y)
          context.stroke()
        }
        this.series.forEach((item, seriesIndex) => {
          const color = this.colors[seriesIndex % this.colors.length]
          const points = (item.values || []).map((value, index) => ({ x: xFor(index), y: yFor(value) }))
          context.setStrokeStyle(color)
          context.setLineWidth(2.5)
          context.beginPath()
          points.forEach((point, index) => {
            if (index === 0) context.moveTo(point.x, point.y)
            else context.lineTo(point.x, point.y)
          })
          context.stroke()
          context.setFillStyle(color)
          points.forEach(point => {
            context.beginPath()
            context.arc(point.x, point.y, 3, 0, Math.PI * 2)
            context.fill()
          })
        })
        context.setFillStyle('#8b96a6')
        context.setFontSize(10)
        this.labels.forEach((label, index) => {
          if (this.labels.length > 7 && index % 2 !== 0) return
          const text = label.length > 6 ? label.slice(2) : label
          context.fillText(text, xFor(index) - 10, height - 12)
        })
        context.draw()
      }).exec()
    }
  }
}
</script>

<style>
.chart-wrap { width: 100%; }
.line-canvas { width: 100%; height: 300rpx; }
.legend { display: flex; flex-wrap: wrap; margin-top: 12rpx; }
.legend-item { display: flex; align-items: center; margin-right: 24rpx; color: #738094; font-size: 21rpx; }
.dot { width: 12rpx; height: 12rpx; border-radius: 50%; margin-right: 8rpx; }
</style>
