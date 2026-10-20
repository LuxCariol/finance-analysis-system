<script>
export default {
  onLaunch() {
    const token = uni.getStorageSync('finance_token')
    if (!token) {
      uni.reLaunch({ url: '/pages/login/login' })
    }
  },
  globalData: {
    apiBase: 'http://127.0.0.1:8006'
  }
}
</script>

<style>
page {
  background: #ffffff;
  color: #303133;
  font-family: "PingFang SC", "Microsoft YaHei", "Helvetica Neue", Arial, sans-serif;
  font-size: 26rpx;
  -webkit-font-smoothing: antialiased;
}

view,
text,
scroll-view {
  box-sizing: border-box;
}

.page {
  min-height: 100vh;
  padding-bottom: calc(112rpx + env(safe-area-inset-bottom));
  background: #ffffff;
}

.page.no-tab {
  padding-bottom: env(safe-area-inset-bottom);
}

.page-blue {
  background: #3bbfe7;
}

.card {
  margin: 0;
  padding: 26rpx 28rpx;
  background: #ffffff;
  border-bottom: 1rpx solid #eeeeee;
}

.row {
  display: flex;
  align-items: center;
}

.between {
  justify-content: space-between;
}

.muted {
  color: #999999;
}

.small {
  font-size: 22rpx;
}

.money {
  font-family: "DIN Alternate", "Arial Narrow", Arial, sans-serif;
}

.table {
  width: 100%;
  background: #ffffff;
}

.table-head {
  display: flex;
  align-items: center;
  height: 58rpx;
  background: #e6e6e6;
  color: #303133;
  font-size: 24rpx;
  font-weight: 500;
}

.table-row {
  display: flex;
  align-items: center;
  min-height: 66rpx;
  border-bottom: 1rpx solid #eeeeee;
  color: #303133;
  font-size: 26rpx;
}

.table-head > view,
.table-row > view {
  padding: 0 14rpx;
  min-width: 0;
}

.cell-label {
  flex: 1;
}

.cell-number {
  text-align: right;
  font-family: "DIN Alternate", "Arial Narrow", Arial, sans-serif;
}

.index-page {
  background: #ffffff;
}

.placeholder {
  padding: 80rpx 0;
  text-align: center;
  color: #999999;
  font-size: 24rpx;
}

.btn-primary {
  height: 80rpx;
  line-height: 80rpx;
  border-radius: 6rpx;
  background: #3bbfe7;
  color: #ffffff;
  text-align: center;
  font-size: 28rpx;
}

.btn-ghost {
  height: 76rpx;
  line-height: 76rpx;
  border: 1rpx solid #d9d9d9;
  border-radius: 6rpx;
  color: #666666;
  background: #ffffff;
  text-align: center;
  font-size: 26rpx;
}

.safe-bottom {
  height: env(safe-area-inset-bottom);
  background: #ffffff;
}
</style>
