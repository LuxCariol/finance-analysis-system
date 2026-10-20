<template>
  <StatementPage :initial-tab="tab" :back="false" />
</template>

<script>
import StatementPage from '../../components/StatementPage.vue'

export default {
  components: { StatementPage },
  data() {
    return { tab: 'balance' }
  },
  onLoad(options) {
    if (options && options.tab) this.tab = options.tab
  }
}
</script>
