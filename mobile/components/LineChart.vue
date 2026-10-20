<template>
  <view class="chart-wrap">
    <canvas :canvas-id="canvasId" :id="canvasId" class="line-canvas" :style="{ height: height + 'rpx' }"></canvas>
    <view v-if="showLegend" class="legend">
      <view v-for="(item, index) in series" :key="index" class="legend-item">
        <view class="dot" :style="{ background: colorAt(index) }"></view>
        <text class="legend-text">{{ item.name }}</text>
      </view>
    </view>
  </view>
</template>

<script>
import { COLORS } from '../common/config'

export default {
  props: {
    labels: { type: Array, default: () => [] },
    series: { type: Array, default: () => [] },
    height: { type: Number, default: 300 },
    unit: { type: String, default: '' },
    showLegend: { type: Boolean, default: true },
    yMax: { type: Number, default: 0 },
    xTickCount: { type: Number, default: 4 },
    highlightMax: { type: Boolean, default: false },
    colors: { type: Array, default: () => COLORS }
  },
  data() {
    return {
      canvasId: 'line_' + Math.floor(Math.random() * 100000000),
      width: 0
    }
  },
  watch: {
    labels: { handler() { this.draw() }, deep: true },
    series: { handler() { this.draw() }, deep: true }
  },
  mounted() {
    this.$nextTick(() => setTimeout(this.draw, 80))
  },
  methods: {
    colorAt(index) {
      return this.colors[index % this.colors.length]
    },
    formatLabel(label) {
      if (!label) return ''
      const text = String(label)
      return text.length === 6 ? text.slice(0, 4) + '.' + text.slice(4) : text
    },
    niceMax(value) {
      if (value <= 0) return 1
      const magnitude = Math.pow(10, Math.floor(Math.log(value) / Math.LN10))
      const normalized = value / magnitude
      const step = normalized <= 1 ? 1 : normalized <= 2 ? 2 : normalized <= 5 ? 5 : 10
      return step * magnitude
    },
    draw() {
      if (!this.labels.length || !this.series.length) return
      this.$nextTick(() => {
        uni.createSelectorQuery().in(this).select('#' + this.canvasId).boundingClientRect(rect => {
          if (!rect || !rect.width) {
            setTimeout(this.draw, 80)
            return
          }
          const width = rect.width
          const height = rect.height
          const ctx = uni.createCanvasContext(this.canvasId, this)
          const padding = { left: 42, right: 18, top: 20, bottom: 34 }
          const chartWidth = Math.max(1, width - padding.left - padding.right)
          const chartHeight = Math.max(1, height - padding.top - padding.bottom)
          const allValues = []
          this.series.forEach(item => (item.values || []).forEach(value => allValues.push(Number(value || 0))))
          let maxValue = this.yMax || Math.max.apply(null, allValues.concat([1]))
          maxValue = this.yMax || this.niceMax(maxValue * 1.08)
          const minValue = 0
          const xFor = index => padding.left + (this.labels.length <= 1
            ? chartWidth / 2 : chartWidth * index / (this.labels.length - 1))
          const yFor = value => padding.top + chartHeight
            - (Number(value || 0) - minValue) / (maxValue - minValue || 1) * chartHeight

          ctx.clearRect(0, 0, width, height)
          ctx.setStrokeStyle('#f1f1f1')
          ctx.setLineWidth(1)
          ctx.setFillStyle('#999999')
          ctx.setFontSize(10)
          const ticks = 5
          for (let i = 0; i <= ticks; i++) {
            const value = maxValue * i / ticks
            const y = yFor(value)
            ctx.beginPath()
            ctx.moveTo(padding.left, y)
            ctx.lineTo(width - padding.right, y)
            ctx.stroke()
            const label = value >= 100 ? value.toFixed(0) : value.toFixed(value < 10 ? 1 : 0)
            ctx.fillText(label, 3, y + 3)
          }

          this.series.forEach((item, seriesIndex) => {
            const values = item.values || []
            const color = this.colorAt(seriesIndex)
            const points = values.map((value, index) => ({ x: xFor(index), y: yFor(value), value: Number(value || 0) }))
            ctx.setStrokeStyle(color)
            ctx.setLineWidth(2)
            ctx.beginPath()
            points.forEach((point, index) => {
              if (index === 0) ctx.moveTo(point.x, point.y)
              else ctx.lineTo(point.x, point.y)
            })
            ctx.stroke()
            if (this.highlightMax && points.length) {
              let maxPoint = points[0]
              points.forEach(point => {
                if (point.value > maxPoint.value) maxPoint = point
              })
              ctx.setFillStyle(color)
              ctx.beginPath()
              ctx.arc(maxPoint.x, maxPoint.y, 3, 0, Math.PI * 2)
              ctx.fill()
              ctx.setFillStyle('#666666')
              ctx.setFontSize(10)
              const text = maxPoint.value.toFixed(2)
              let tx = maxPoint.x + 5
              if (tx + text.length * 6 > width - 4) tx = maxPoint.x - text.length * 6 - 5
              ctx.fillText(text, tx, Math.max(10, maxPoint.y - 6))
            }
          })

          const tickCount = Math.min(Math.max(2, this.xTickCount), this.labels.length)
          const indexes = []
          for (let i = 0; i < tickCount; i++) {
            indexes.push(Math.round(i * (this.labels.length - 1) / (tickCount - 1)))
          }
          ctx.setFillStyle('#999999')
          ctx.setFontSize(10)
          indexes.forEach(index => {
            const text = this.formatLabel(this.labels[index])
            const x = xFor(index) - text.length * 3
            ctx.fillText(text, Math.max(padding.left - 6, Math.min(x, width - text.length * 6)), height - 10)
          })
          if (this.unit) {
            ctx.setFillStyle('#999999')
            ctx.setFontSize(10)
            ctx.fillText(this.unit, 3, 12)
          }
          ctx.draw()
        }).exec()
      })
    }
  }
}
</script>

<style>
.chart-wrap {
  width: 100%;
}

.line-canvas {
  width: 100%;
  display: block;
}

.legend {
  display: flex;
  justify-content: center;
  flex-wrap: wrap;
  padding: 8rpx 0 2rpx;
}

.legend-item {
  display: flex;
  align-items: center;
  margin: 0 20rpx;
}

.dot {
  width: 18rpx;
  height: 8rpx;
  border-radius: 4rpx;
  margin-right: 8rpx;
}

.legend-text {
  font-size: 22rpx;
  color: #666666;
}
</style>
