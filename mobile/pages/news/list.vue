<template>
  <view class="page">
    <AppHeader title="财经资讯" subtitle="企业经营与财务分析动态" eyebrow="INSIGHTS" back compact />
    <view class="card" v-for="item in news" :key="item.id || item.ID">
      <view class="row">
        <text class="news-title">{{ item.title || item.TITLE }}</text>
        <text class="pill">{{ item.author || item.AUTHOR }}</text>
      </view>
      <text class="news-content">{{ item.content || item.CONTENT }}</text>
      <view class="news-foot">
        <text>{{ item.upDate || item.UP_DATE }}</text>
        <text>阅读 {{ item.viewNum || item.VIEW_NUM || 0 }}</text>
      </view>
    </view>
    <EmptyState v-if="!news.length" title="暂无资讯" desc="后台发布资讯后会展示在这里" />
  </view>
</template>
<script>
import AppHeader from '../../components/AppHeader.vue'
import EmptyState from '../../components/EmptyState.vue'
import { get } from '../../common/request'
export default {
  components: { AppHeader, EmptyState },
  data() { return { news: [] } },
  onLoad() { this.load() },
  methods: {
    async load() { try { this.news = await get('/api/news', { limit: 30 }) } catch (e) { this.news = [] } }
  }
}
</script>
<style>
.news-title { flex: 1; color: #22314a; font-size: 28rpx; font-weight: 600; line-height: 1.5; margin-right: 16rpx; }
.news-content { display: block; margin-top: 14rpx; color: #6d7a8d; font-size: 22rpx; line-height: 1.75; }
.news-foot { display: flex; justify-content: space-between; margin-top: 18rpx; color: #9aa5b4; font-size: 20rpx; }
</style>
