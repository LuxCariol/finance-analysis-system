<script>
export default {
  onLaunch() {
    const token = uni.getStorageSync('finance_token')
    if (!token) {
      uni.reLaunch({ url: '/pages/login/login' })
    }
  },
  globalData: {
    apiBase: 'http://localhost:8006'
  }
}
</script>

<style>
page {
  background: #f2f5f9;
  color: #17243a;
  font-family: -apple-system, BlinkMacSystemFont, "PingFang SC", "Microsoft YaHei", sans-serif;
}

.page {
  min-height: 100vh;
  padding: 0 28rpx 40rpx;
  box-sizing: border-box;
}

.card {
  background: #ffffff;
  border-radius: 24rpx;
  box-shadow: 0 12rpx 32rpx rgba(18, 35, 63, 0.07);
  padding: 28rpx;
  margin-bottom: 24rpx;
}

.section-title {
  font-size: 32rpx;
  font-weight: 700;
  color: #17243a;
  margin: 26rpx 0 18rpx;
}

.muted {
  color: #7d899b;
  font-size: 24rpx;
}

.money {
  font-family: "DIN Alternate", "Arial Narrow", sans-serif;
  font-weight: 700;
  letter-spacing: 1rpx;
}

.pill {
  display: inline-block;
  padding: 6rpx 16rpx;
  border-radius: 999rpx;
  font-size: 21rpx;
  background: #e9f7f5;
  color: #0d7c78;
}

.pill.warn {
  background: #fff3e5;
  color: #c87918;
}

.pill.risk {
  background: #fdecec;
  color: #c33f3f;
}

.row {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.divider {
  height: 1rpx;
  background: #eef1f5;
  margin: 20rpx 0;
}

.btn-primary {
  height: 88rpx;
  line-height: 88rpx;
  border-radius: 18rpx;
  background: linear-gradient(135deg, #0d7c78, #18a39c);
  color: #fff;
  text-align: center;
  font-size: 30rpx;
  font-weight: 600;
}

.btn-ghost {
  height: 76rpx;
  line-height: 76rpx;
  border-radius: 16rpx;
  border: 1rpx solid #d9e0e9;
  background: #fff;
  color: #31425c;
  text-align: center;
  font-size: 27rpx;
}

.safe-bottom {
  height: env(safe-area-inset-bottom);
}
</style>
