<template>
  <view v-if="items && items.length">
    <view v-for="(item, index) in items" :key="index" class="report-row" @click="$emit('select', item)">
      <view class="item-main">
        <text class="item-name">{{ item.CODE_NAME || item.codeName || item.name }}</text>
        <text class="item-code">{{ item.CODE_NO || item.codeNo || item.code }}</text>
      </view>
      <text class="item-value money">{{ money(item.DATA_VALUE !== undefined ? item.DATA_VALUE : item.dataValue) }}</text>
      <text class="chevron">›</text>
    </view>
  </view>
  <EmptyState v-else />
</template>

<script>
import { money } from '../common/format'
import EmptyState from './EmptyState.vue'

export default {
  components: { EmptyState },
  props: { items: { type: Array, default: () => [] } },
  methods: { money }
}
</script>

<style>
.report-row {
  display: flex;
  align-items: center;
  padding: 22rpx 0;
  border-bottom: 1rpx solid #eef1f5;
}
.report-row:last-child { border-bottom: none; }
.item-main { flex: 1; display: flex; flex-direction: column; }
.item-name { color: #22314a; font-size: 27rpx; }
.item-code { margin-top: 6rpx; color: #9aa5b4; font-size: 19rpx; letter-spacing: 1rpx; }
.item-value { color: #17243a; font-size: 26rpx; }
.chevron { margin-left: 12rpx; color: #bdc5d0; font-size: 36rpx; }
</style>
