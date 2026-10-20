<template>
  <view class="donut-wrap">
    <canvas :canvas-id="canvasId" :id="canvasId" class="donut-canvas"></canvas>
    <view class="donut-legend">
      <view v-for="(label, index) in labels" :key="index" class="legend-item">
        <view class="legend-dot" :style="{ background: colorAt(index) }"></view>
        <text class="legend-label">{{ label }}</text>
      </view>
    </view>
  </view>
</template>

<script>
export default {
  props: {
    labels: { type: Array, default: () => [] },
    values: { type: Array, default: () => [] },
    colors: { type: Array, default: () => ['#91cb74', '#188cff', '#fac858', '#3bbfe7', '#ee6666', '#73c0de'] }
  },
  data() {
    return {
      canvasId: 'donut_' + Math.floor(Math.random() * 100000000)
    }
  },
  watch: {
    values: { handler() { this.draw() }, deep: true },
    labels: { handler() { this.draw() }, deep: true }
  },
  mounted() {
    this.$nextTick(() => setTimeout(this.draw, 100))
  },
  methods: {
    colorAt(index) {
      return this.colors[index % this.colors.length]
    },
    draw() {
      const values = (this.values || []).map(value => Math.max(0, Number(value || 0)))
      if (!values.length) return
      this.$nextTick(() => {
        uni.createSelectorQuery().in(this).select('#' + this.canvasId).boundingClientRect(rect => {
          if (!rect || !rect.width) {
            setTimeout(this.draw, 80)
            return
          }
          const width = rect.width
          const height = rect.height
          const ctx = uni.createCanvasContext(this.canvasId, this)
          const total = values.reduce((sum, value) => sum + value, 0)
          const centerX = width * 0.34
          const centerY = height * 0.5
          const radius = Math.min(width * 0.2, height * 0.34)
          const lineWidth = radius * 0.62
          ctx.clearRect(0, 0, width, height)
          let start = -Math.PI / 2
          values.forEach((value, index) => {
            const angle = total === 0 ? Math.PI * 2 / values.length : Math.PI * 2 * value / total
            if (angle <= 0) return
            ctx.beginPath()
            ctx.setStrokeStyle(this.colorAt(index))
            ctx.setLineWidth(lineWidth)
            ctx.arc(centerX, centerY, radius, start + 0.012, start + angle - 0.012)
            ctx.stroke()
            const middle = start + angle / 2
            const tx = centerX + Math.cos(middle) * radius
            const ty = centerY + Math.sin(middle) * radius + 4
            ctx.setFillStyle('#ffffff')
            ctx.setFontSize(11)
            if (ctx.setTextAlign) ctx.setTextAlign('center')
            ctx.fillText((total === 0 ? 0 : value / total * 100).toFixed(2) + '%', tx - 18, ty)
            start += angle
          })
          ctx.draw()
        }).exec()
      })
    }
  }
}
</script>

<style>
.donut-wrap {
  width: 100%;
}

.donut-canvas {
  width: 100%;
  height: 270rpx;
  display: block;
}

.donut-legend {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-wrap: wrap;
  padding: 2rpx 0 8rpx;
}

.legend-item {
  display: flex;
  align-items: center;
  margin: 0 14rpx;
}

.legend-dot {
  width: 14rpx;
  height: 14rpx;
  border-radius: 50%;
  margin-right: 8rpx;
}

.legend-label {
  color: #666666;
  font-size: 22rpx;
}
</style>
