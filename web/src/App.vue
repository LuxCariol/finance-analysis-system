<template>
  <div v-if="!user" class="login-shell">
    <div class="login-orb orb-one"></div>
    <div class="login-orb orb-two"></div>
    <div class="login-left">
      <div class="login-brand">
        <div class="brand-symbol">FA</div>
        <div>
          <div class="brand-name">金融财务分析</div>
          <div class="brand-caption">FINANCIAL INTELLIGENCE CONSOLE</div>
        </div>
      </div>
      <h1>让每一份报表<br /><span>成为经营决策的依据。</span></h1>
      <p>报表导入、数据转换、财务分析、经营预测，在一个现代化工作台中完成。</p>
      <div class="feature-row">
        <div><b>12</b><span>个月趋势</span></div>
        <div><b>1,500+</b><span>标准指标</span></div>
        <div><b>4</b><span>类财务比率</span></div>
      </div>
    </div>
    <div class="login-panel">
      <div class="login-panel-head">
        <span class="eyebrow">WELCOME BACK</span>
        <h2>登录管理控制台</h2>
        <p>使用实训项目管理员账号进入系统</p>
      </div>
      <el-form @submit.prevent="doLogin">
        <el-form-item label="账号">
          <el-input v-model="loginForm.account" size="large" placeholder="请输入账号">
            <template #prefix><el-icon><User /></el-icon></template>
          </el-input>
        </el-form-item>
        <el-form-item label="密码">
          <el-input v-model="loginForm.password" type="password" show-password size="large" placeholder="请输入密码"
            @keyup.enter="doLogin">
            <template #prefix><el-icon><Lock /></el-icon></template>
          </el-input>
        </el-form-item>
        <el-button type="primary" size="large" class="login-button" :loading="loginLoading" @click="doLogin">
          进入系统
        </el-button>
      </el-form>
      <div class="demo-hint">
        <span>演示账号</span>
        <code>root</code>
        <span>密码</span>
        <code>123456</code>
      </div>
      <div class="login-foot">数据驱动经营决策 · 金融财务分析实训项目</div>
    </div>
  </div>

  <el-container v-else class="app-shell">
    <el-aside width="248px" class="sidebar">
      <div class="sidebar-brand">
        <div class="brand-symbol small">FA</div>
        <div>
          <div class="brand-name">金融财务分析</div>
          <div class="brand-caption">MANAGEMENT CONSOLE</div>
        </div>
      </div>
      <div class="sidebar-section">工作台</div>
      <el-menu :default-active="active" class="side-menu" @select="handleMenu">
        <el-menu-item index="dashboard">
          <el-icon><DataLine /></el-icon><span>经营驾驶舱</span>
        </el-menu-item>
        <el-sub-menu index="finance">
          <template #title><el-icon><Histogram /></el-icon><span>财务数据</span></template>
          <el-menu-item index="report-profit">利润表</el-menu-item>
          <el-menu-item index="report-balance">资产负债表</el-menu-item>
          <el-menu-item index="report-cashflow">现金流量表</el-menu-item>
          <el-menu-item index="report-kmye">科目余额表</el-menu-item>
          <el-menu-item index="aging">账龄分析</el-menu-item>
        </el-sub-menu>
        <el-menu-item index="import">
          <el-icon><UploadFilled /></el-icon><span>数据导入</span>
        </el-menu-item>
        <el-menu-item index="companies">
          <el-icon><OfficeBuilding /></el-icon><span>公司管理</span>
        </el-menu-item>
        <el-menu-item index="users">
          <el-icon><UserFilled /></el-icon><span>用户管理</span>
        </el-menu-item>
        <el-menu-item index="roles">
          <el-icon><Avatar /></el-icon><span>角色管理</span>
        </el-menu-item>
        <el-menu-item index="menus">
          <el-icon><Menu /></el-icon><span>菜单管理</span>
        </el-menu-item>
        <el-menu-item index="dictionaries">
          <el-icon><Collection /></el-icon><span>系统字典</span>
        </el-menu-item>
        <el-menu-item index="code-library">
          <el-icon><Connection /></el-icon><span>编码字典</span>
        </el-menu-item>
        <el-menu-item index="code-mapper">
          <el-icon><Link /></el-icon><span>编码映射</span>
        </el-menu-item>
        <el-menu-item index="modes">
          <el-icon><Cpu /></el-icon><span>算法配置</span>
        </el-menu-item>
        <el-menu-item index="convert">
          <el-icon><RefreshRight /></el-icon><span>数据转换</span>
        </el-menu-item>
        <el-menu-item index="news">
          <el-icon><ChatDotRound /></el-icon><span>资讯管理</span>
        </el-menu-item>
      </el-menu>
      <div class="sidebar-bottom">
        <div class="sidebar-user">
          <el-avatar :size="34">{{ avatarText }}</el-avatar>
          <div><b>{{ user.userName }}</b><span>{{ user.accountName }}</span></div>
        </div>
        <el-button text class="logout-button" @click="logout">退出</el-button>
      </div>
    </el-aside>

    <el-container class="content-shell">
      <el-header class="topbar">
        <div class="topbar-title">
          <span class="eyebrow">FINANCIAL OPERATIONS</span>
          <h2>{{ currentMeta.title }}</h2>
          <p>{{ currentMeta.subtitle }}</p>
        </div>
        <div class="topbar-actions">
          <el-select v-model="selectedOrg" size="small" class="org-select" placeholder="选择公司">
            <el-option v-for="company in companies" :key="company.id" :label="company.orgName" :value="company.id" />
          </el-select>
          <el-tag effect="plain" round>{{ user.roleName || '财务分析员' }}</el-tag>
          <el-avatar :size="34" class="top-avatar">{{ avatarText }}</el-avatar>
        </div>
      </el-header>

      <el-main class="main-content" v-loading="pageLoading">
        <template v-if="active === 'dashboard'">
          <section class="hero-card">
            <div class="hero-copy">
              <div class="hero-kicker"><span class="live-dot"></span> 数据实时联动</div>
              <h1>{{ dashboard?.overview?.org?.orgName || '企业经营驾驶舱' }}</h1>
              <p>{{ dashboard?.overview?.org?.orgRemark || '从报表数据到经营洞察，实时掌握企业财务健康状态。' }}</p>
              <div class="hero-tags">
                <span>报告期 {{ periodText(dashboard?.period) }}</span>
                <span>最近同步 {{ dashboard?.counts?.results || 0 }} 条标准指标</span>
              </div>
            </div>
            <div class="hero-score">
              <el-progress type="dashboard" :percentage="Number(dashboard?.overview?.healthScore || 0)"
                :width="138" :stroke-width="12" color="#20b6ad" />
              <div class="score-label">综合财务健康分</div>
            </div>
          </section>

          <div class="stat-grid">
            <div class="stat-card teal">
              <div class="stat-icon"><el-icon><TrendCharts /></el-icon></div>
              <div class="stat-label">营业收入</div>
              <div class="stat-value">{{ compactMoney(dashboard?.overview?.revenue) }}<small>元</small></div>
              <div class="stat-hint">最新报告期 · {{ periodText(dashboard?.period) }}</div>
            </div>
            <div class="stat-card gold">
              <div class="stat-icon"><el-icon><Money /></el-icon></div>
              <div class="stat-label">净利润</div>
              <div class="stat-value">{{ compactMoney(dashboard?.overview?.netProfit) }}<small>元</small></div>
              <div class="stat-hint">{{ netProfitHint }}</div>
            </div>
            <div class="stat-card blue">
              <div class="stat-icon"><el-icon><OfficeBuilding /></el-icon></div>
              <div class="stat-label">资产总额</div>
              <div class="stat-value">{{ compactMoney(dashboard?.overview?.totalAssets) }}<small>元</small></div>
              <div class="stat-hint">负债合计 {{ compactMoney(dashboard?.overview?.totalLiabilities) }} 元</div>
            </div>
            <div class="stat-card rose">
              <div class="stat-icon"><el-icon><Wallet /></el-icon></div>
              <div class="stat-label">经营现金净额</div>
              <div class="stat-value" :class="{ negative: Number(dashboard?.overview?.operatingCash) < 0 }">
                {{ compactMoney(dashboard?.overview?.operatingCash) }}<small>元</small>
              </div>
              <div class="stat-hint">关注盈利质量与回款节奏</div>
            </div>
          </div>

          <div class="dashboard-grid">
            <div class="panel chart-panel wide">
              <div class="panel-head">
                <div><h3>收入与利润趋势</h3><p>2021 年 12 个月经营表现</p></div>
                <el-tag size="small" effect="plain">同比趋势</el-tag>
              </div>
              <div ref="profitChartEl" class="chart"></div>
            </div>
            <div class="panel alert-panel">
              <div class="panel-head">
                <div><h3>风险与建议</h3><p>根据最新指标自动诊断</p></div>
                <el-icon class="panel-icon"><Bell /></el-icon>
              </div>
              <div v-if="dashboard?.overview?.alerts?.length" class="alert-list">
                <div v-for="(alert, index) in dashboard.overview.alerts" :key="index" class="alert-item">
                  <span class="alert-dot" :class="alert.level"></span>
                  <div>
                    <div class="alert-title">{{ alert.title }} <em>{{ alert.value }}</em></div>
                    <p>{{ alert.suggestion }}</p>
                  </div>
                </div>
              </div>
              <el-empty v-else description="暂无风险提示" :image-size="70" />
            </div>
          </div>

          <div class="dashboard-grid lower">
            <div class="panel chart-panel">
              <div class="panel-head">
                <div><h3>现金流结构</h3><p>经营 / 投资 / 筹资活动</p></div>
              </div>
              <div ref="cashChartEl" class="chart small"></div>
            </div>
            <div class="panel ratio-panel">
              <div class="panel-head">
                <div><h3>核心比率</h3><p>四类指标综合观察</p></div>
                <el-button text type="primary" @click="handleMenu('ratio')">查看全部 <el-icon><ArrowRight /></el-icon></el-button>
              </div>
              <div class="ratio-grid">
                <div v-for="category in ratioCategories.slice(0, 4)" :key="category.name" class="ratio-category">
                  <span>{{ category.name }}</span>
                  <b>{{ category.items?.[0]?.value ?? '--' }}<small>{{ category.items?.[0]?.unit }}</small></b>
                  <el-tag size="small" :type="category.items?.[0]?.status === 'good' ? 'success' : category.items?.[0]?.status === 'risk' ? 'danger' : 'warning'">
                    {{ statusText(category.items?.[0]?.status) }}
                  </el-tag>
                </div>
              </div>
            </div>
            <div class="panel news-panel">
              <div class="panel-head">
                <div><h3>最新资讯</h3><p>企业经营与财务动态</p></div>
                <el-button text type="primary" @click="handleMenu('news')">更多</el-button>
              </div>
              <div v-for="item in dashboard?.news || []" :key="item.id" class="news-row">
                <span>{{ item.title }}</span><small>{{ item.upDate }}</small>
              </div>
            </div>
          </div>
        </template>

        <template v-else-if="active === 'ratio'">
          <div class="page-toolbar">
            <div><h1>财务比率分析</h1><p>短期偿债、长期偿债、盈利能力和营运能力</p></div>
            <el-tag type="success" effect="plain">综合健康分 {{ dashboard?.overview?.healthScore || '--' }}</el-tag>
          </div>
          <div class="ratio-page-grid">
            <div v-for="category in ratioCategories" :key="category.name" class="panel ratio-detail-card">
              <div class="panel-head"><div><h3>{{ category.name }}</h3><p>{{ category.items?.length || 0 }} 项核心指标</p></div></div>
              <div v-for="item in category.items || []" :key="item.key" class="ratio-detail-row">
                <div class="ratio-detail-main">
                  <div class="ratio-detail-name">{{ item.name }}
                    <el-tag size="small" :type="item.status === 'good' ? 'success' : item.status === 'risk' ? 'danger' : 'warning'">
                      {{ statusText(item.status) }}
                    </el-tag>
                  </div>
                  <div class="ratio-formula">{{ item.formula }}</div>
                  <div class="ratio-benchmark">参考：{{ item.benchmark }}</div>
                </div>
                <div class="ratio-detail-value">{{ item.value }}<small>{{ item.unit }}</small></div>
              </div>
            </div>
          </div>
        </template>

        <template v-else-if="active === 'reports'">
          <div class="page-toolbar">
            <div>
              <h1>{{ reportLabel }}</h1>
              <p>按会计期间查看导入的原始报表数据</p>
            </div>
            <div class="toolbar-actions">
              <el-select v-model="period" placeholder="会计期间" clearable @change="loadReports">
                <el-option v-for="item in periods" :key="item" :label="periodText(item)" :value="item" />
              </el-select>
              <el-button type="primary" :icon="Upload" @click="triggerReportUpload">导入 Excel</el-button>
              <input ref="reportFileEl" type="file" accept=".xls,.xlsx" hidden @change="onReportFile" />
            </div>
          </div>
          <div class="panel">
            <div class="table-toolbar">
              <el-input v-if="reportType === 'kmye'" v-model="reportKeyword" placeholder="搜索科目代码或名称"
                clearable style="width: 240px" @keyup.enter="loadReports" />
              <el-button v-if="reportType === 'kmye'" :icon="Search" @click="loadReports">查询</el-button>
              <span class="table-count">共 {{ reportTotal }} 条记录</span>
            </div>
            <el-table :data="reportRows" stripe height="560" class="data-table">
              <el-table-column prop="kjyearMoth" label="会计期间" width="110">
                <template #default="{ row }">{{ periodText(row.kjyearMoth) }}</template>
              </el-table-column>
              <template v-if="reportType === 'profit'">
                <el-table-column prop="byZyywsr" label="营业收入" align="right"><template #default="{ row }">{{ money(row.byZyywsr) }}</template></el-table-column>
                <el-table-column prop="byZyywcb" label="营业成本" align="right"><template #default="{ row }">{{ money(row.byZyywcb) }}</template></el-table-column>
                <el-table-column prop="byYylr" label="营业利润" align="right"><template #default="{ row }">{{ money(row.byYylr) }}</template></el-table-column>
                <el-table-column prop="byLrze" label="利润总额" align="right"><template #default="{ row }">{{ money(row.byLrze) }}</template></el-table-column>
                <el-table-column prop="byJlr" label="净利润" align="right"><template #default="{ row }">{{ money(row.byJlr) }}</template></el-table-column>
              </template>
              <template v-else-if="reportType === 'balance'">
                <el-table-column prop="qmLdzcHj" label="流动资产" align="right"><template #default="{ row }">{{ money(row.qmLdzcHj) }}</template></el-table-column>
                <el-table-column prop="qmFldzcFldzchj" label="非流动资产" align="right"><template #default="{ row }">{{ money(row.qmFldzcFldzchj) }}</template></el-table-column>
                <el-table-column prop="qmZczj" label="资产总计" align="right"><template #default="{ row }">{{ money(row.qmZczj) }}</template></el-table-column>
                <el-table-column prop="qmDysxFzhj" label="负债合计" align="right"><template #default="{ row }">{{ money(row.qmDysxFzhj) }}</template></el-table-column>
                <el-table-column prop="qmGdqySyzqyhj" label="所有者权益" align="right"><template #default="{ row }">{{ money(row.qmGdqySyzqyhj) }}</template></el-table-column>
              </template>
              <template v-else-if="reportType === 'cashflow'">
                <el-table-column prop="bqJyhdJyhdcsdje" label="经营活动" align="right"><template #default="{ row }">{{ money(row.bqJyhdJyhdcsdje) }}</template></el-table-column>
                <el-table-column prop="bqTzhdTzhdscsdxjllje" label="投资活动" align="right"><template #default="{ row }">{{ money(row.bqTzhdTzhdscsdxjllje) }}</template></el-table-column>
                <el-table-column prop="bqCzhdZchdxjllje" label="筹资活动" align="right"><template #default="{ row }">{{ money(row.bqCzhdZchdxjllje) }}</template></el-table-column>
                <el-table-column prop="bqXjjzjeXjqmye" label="期末现金" align="right"><template #default="{ row }">{{ money(row.bqXjjzjeXjqmye) }}</template></el-table-column>
              </template>
              <template v-else>
                <el-table-column prop="subjectCode" label="科目代码" width="140" />
                <el-table-column prop="subjectName" label="科目名称" min-width="180" />
                <el-table-column prop="qmjfye" label="期末借方" align="right"><template #default="{ row }">{{ money(row.qmjfye) }}</template></el-table-column>
                <el-table-column prop="qmdfye" label="期末贷方" align="right"><template #default="{ row }">{{ money(row.qmdfye) }}</template></el-table-column>
                <el-table-column prop="bqjffse" label="本期借方发生" align="right"><template #default="{ row }">{{ money(row.bqjffse) }}</template></el-table-column>
                <el-table-column prop="bqdffse" label="本期贷方发生" align="right"><template #default="{ row }">{{ money(row.bqdffse) }}</template></el-table-column>
              </template>
              <el-table-column prop="impTime" label="导入时间" width="160" />
            </el-table>
            <div class="pagination-row">
              <el-pagination background layout="total, prev, pager, next, sizes" :total="reportTotal"
                v-model:current-page="reportPage" v-model:page-size="reportSize" :page-sizes="[10, 20, 50]"
                @current-change="loadReports" @size-change="loadReports" />
            </div>
          </div>
        </template>

        <template v-else-if="active === 'aging'">
          <div class="page-toolbar">
            <div><h1>账龄分析</h1><p>查看往来款在不同账龄区间的分布</p></div>
            <div class="toolbar-actions">
              <el-select v-model="agingType" @change="loadAging">
                <el-option label="其他应付" :value="3" /><el-option label="其他应收" :value="4" />
                <el-option label="应付账款" :value="5" /><el-option label="应收账款" :value="6" />
                <el-option label="预付账款" :value="7" /><el-option label="预收账款" :value="8" />
              </el-select>
              <el-button :icon="Refresh" @click="loadAging">刷新</el-button>
            </div>
          </div>
          <div class="panel chart-panel">
            <div class="panel-head"><div><h3>账龄区间分布</h3><p>{{ periodText(agingData.period) }} · {{ agingData.rows?.length || 0 }} 个核算项目</p></div></div>
            <div ref="agingChartEl" class="chart"></div>
          </div>
          <div class="panel">
            <el-table :data="agingData.rows || []" stripe height="400" class="data-table">
              <el-table-column prop="projectCode" label="项目代码" width="140" />
              <el-table-column prop="projectName" label="项目名称" min-width="180" />
              <el-table-column prop="balance" label="余额" align="right"><template #default="{ row }">{{ money(row.balance) }}</template></el-table-column>
              <el-table-column prop="due1To30Days" label="0-90天" align="right"><template #default="{ row }">{{ money(row.due1To30Days) }}</template></el-table-column>
              <el-table-column prop="due31To90Days" label="91-180天" align="right"><template #default="{ row }">{{ money(row.due31To90Days) }}</template></el-table-column>
              <el-table-column prop="due91To180Days" label="181-360天" align="right"><template #default="{ row }">{{ money(row.due91To180Days) }}</template></el-table-column>
              <el-table-column prop="due181To360Days" label="361-720天" align="right"><template #default="{ row }">{{ money(row.due181To360Days) }}</template></el-table-column>
            </el-table>
          </div>
        </template>

        <template v-else-if="active === 'import'">
          <div class="page-toolbar"><div><h1>数据导入</h1><p>支持单表导入与批量导入，自动识别会计期间</p></div></div>
          <div class="import-grid">
            <div class="panel import-card">
              <div class="import-icon"><el-icon><UploadFilled /></el-icon></div>
              <h3>单表导入</h3>
              <p>选择一种报表类型，导入对应的金蝶 Excel 文件。</p>
              <el-select v-model="importType" style="width: 100%">
                <el-option label="利润表 / 损益表" value="profit" /><el-option label="资产负债表" value="balance" />
                <el-option label="现金流量表" value="cashflow" /><el-option label="科目余额表" value="kmye" />
              </el-select>
              <el-button type="primary" @click="triggerImportFile" :loading="uploadLoading">选择文件并导入</el-button>
              <input ref="importFileEl" type="file" accept=".xls,.xlsx" hidden @change="onImportFile" />
            </div>
            <div class="panel import-card">
              <div class="import-icon gold"><el-icon><Files /></el-icon></div>
              <h3>批量导入</h3>
              <p>一次选择多个报表文件，系统按文件名自动分类。</p>
              <div class="bulk-hint">支持：利润表、资产负债表、现金流量表、科目余额表、各类账龄分析</div>
              <el-button type="primary" plain @click="triggerBulkFiles" :loading="uploadLoading">选择多个文件</el-button>
              <input ref="bulkFileEl" type="file" accept=".xls,.xlsx" multiple hidden @change="onBulkFiles" />
              <div v-if="bulkResult" class="bulk-result">
                <b>{{ bulkResult.success }} 个文件导入成功</b>
                <span v-for="item in bulkResult.failed || []" :key="item">{{ item }}</span>
              </div>
            </div>
          </div>
          <div class="panel">
            <div class="panel-head"><div><h3>最近导入数据</h3><p>当前公司最近 10 条报表记录</p></div></div>
            <el-table :data="recentImports" stripe class="data-table">
              <el-table-column prop="reportType" label="报表类型" width="140" />
              <el-table-column prop="period" label="会计期间" width="130"><template #default="{ row }">{{ row.reportType === '账龄分析' ? row.period : periodText(row.period) }}</template></el-table-column>
              <el-table-column prop="rowCount" label="数据行数" width="100" align="right" />
              <el-table-column prop="impTime" label="导入时间" />
              <el-table-column prop="impUser" label="导入人" />
            </el-table>
          </div>
        </template>

        <template v-else-if="active === 'companies'">
          <div class="page-toolbar"><div><h1>公司管理</h1><p>维护企业档案和报表标准</p></div>
            <el-button type="primary" :icon="Plus" @click="openCompany()">新增公司</el-button></div>
          <div class="panel">
            <el-table :data="companies" stripe class="data-table">
              <el-table-column prop="id" label="ID" width="70" />
              <el-table-column prop="orgName" label="公司名称" min-width="220" />
              <el-table-column prop="shortName" label="简称" width="120" />
              <el-table-column prop="legalerName" label="法人" width="100" />
              <el-table-column prop="industry" label="行业" width="120" />
              <el-table-column prop="isList" label="上市" width="80"><template #default="{ row }">{{ row.isList === '0' ? '是' : '否' }}</template></el-table-column>
              <el-table-column label="操作" width="170" fixed="right"><template #default="{ row }">
                <el-button link type="primary" @click="openCompany(row)">编辑</el-button>
                <el-button link type="danger" @click="removeCompany(row)">删除</el-button>
              </template></el-table-column>
            </el-table>
          </div>
        </template>

        <template v-else-if="active === 'users'">
          <div class="page-toolbar"><div><h1>用户管理</h1><p>管理员账号、角色与所属公司</p></div>
            <el-button type="primary" :icon="Plus" @click="openUser()">新增用户</el-button></div>
          <div class="panel">
            <el-table :data="users" stripe class="data-table">
              <el-table-column prop="id" label="ID" width="70" />
              <el-table-column prop="userName" label="用户名称" />
              <el-table-column prop="accountName" label="账号" />
              <el-table-column prop="roleName" label="所属角色" />
              <el-table-column prop="locked" label="状态" width="90"><template #default="{ row }"><el-tag :type="row.locked ? 'danger' : 'success'" size="small">{{ row.locked ? '锁定' : '正常' }}</el-tag></template></el-table-column>
              <el-table-column prop="description" label="描述" />
              <el-table-column label="操作" width="230" fixed="right"><template #default="{ row }">
                <el-button link type="primary" @click="openUser(row)">编辑</el-button>
                <el-button link type="warning" @click="resetUser(row)">重置密码</el-button>
                <el-button link type="danger" @click="removeUser(row)">删除</el-button>
              </template></el-table-column>
            </el-table>
          </div>
        </template>

        <template v-else-if="active === 'roles'">
          <div class="page-toolbar"><div><h1>角色管理</h1><p>维护后台角色与权限基础信息</p></div>
            <el-button type="primary" :icon="Plus" @click="openRole()">新增角色</el-button></div>
          <div class="panel"><el-table :data="roles" stripe class="data-table">
            <el-table-column prop="id" label="ID" width="80" /><el-table-column prop="name" label="角色名称" />
            <el-table-column prop="description" label="描述" /><el-table-column prop="userName" label="创建人" />
            <el-table-column prop="createTime" label="创建时间" width="170" />
            <el-table-column label="操作" width="150"><template #default="{ row }">
              <el-button link type="primary" @click="openRole(row)">编辑</el-button>
              <el-button link type="danger" @click="removeRole(row)">删除</el-button></template></el-table-column>
          </el-table></div>
        </template>

        <template v-else-if="active === 'menus'">
          <div class="page-toolbar"><div><h1>菜单管理</h1><p>系统菜单、资源键和按钮权限</p></div>
            <el-button type="primary" :icon="Plus" @click="openMenu()">新增菜单</el-button></div>
          <div class="panel"><el-table :data="menus" stripe height="600" class="data-table">
            <el-table-column prop="id" label="ID" width="80" /><el-table-column prop="name" label="菜单名称" min-width="180" />
            <el-table-column prop="parentId" label="父节点" width="90" /><el-table-column prop="type" label="类型" width="80" />
            <el-table-column prop="resKey" label="资源键" min-width="150" /><el-table-column prop="resUrl" label="地址" min-width="200" />
            <el-table-column prop="orderNo" label="排序" width="80" />
            <el-table-column label="操作" width="150"><template #default="{ row }">
              <el-button link type="primary" @click="openMenu(row)">编辑</el-button>
              <el-button link type="danger" @click="removeMenu(row)">删除</el-button></template></el-table-column>
          </el-table></div>
        </template>

        <template v-else-if="active === 'dictionaries'">
          <div class="page-toolbar"><div><h1>系统字典</h1><p>统一维护系统枚举和基础配置</p></div>
            <div class="toolbar-actions"><el-input v-model="dictKeyword" placeholder="搜索字典" clearable @keyup.enter="loadDictionaries" />
              <el-button type="primary" :icon="Plus" @click="openDict()">新增字典</el-button></div></div>
          <div class="panel"><el-table :data="dictionaries" stripe class="data-table">
            <el-table-column prop="id" label="ID" width="80" /><el-table-column prop="cnName" label="中文名称" />
            <el-table-column prop="enName" label="英文名称" /><el-table-column prop="flag" label="状态"><template #default="{ row }">{{ row.flag === '1' ? '可编辑' : '不可编辑' }}</template></el-table-column>
            <el-table-column prop="remark" label="备注" />
            <el-table-column label="操作" width="150"><template #default="{ row }">
              <el-button link type="primary" @click="openDict(row)">编辑</el-button>
              <el-button link type="danger" @click="removeDict(row)">删除</el-button></template></el-table-column>
          </el-table></div>
        </template>

        <template v-else-if="active === 'code-library'">
          <div class="page-toolbar"><div><h1>编码字典</h1><p>标准科目编码与报表展示配置</p></div>
            <div class="toolbar-actions"><el-input v-model="codeKeyword" placeholder="搜索编码名称/编码" clearable @keyup.enter="loadCodeLibrary" />
              <el-button :icon="Refresh" @click="syncCodeLibrary">同步映射字段</el-button>
              <el-button type="primary" :icon="Plus" @click="openCode()">新增编码</el-button></div></div>
          <div class="panel"><el-table :data="codeLibrary" stripe height="600" class="data-table">
            <el-table-column prop="id" label="ID" width="90" /><el-table-column prop="codeName" label="编码名称" min-width="180" />
            <el-table-column prop="codeNo" label="编码" width="130" /><el-table-column prop="reportType" label="报表类型" width="100" />
            <el-table-column prop="useArea" label="作用域" width="100" /><el-table-column prop="isDetails" label="详情" width="70" />
            <el-table-column prop="survey" label="概要" width="100" /><el-table-column prop="remark" label="说明" />
            <el-table-column label="操作" width="150"><template #default="{ row }">
              <el-button link type="primary" @click="openCode(row)">编辑</el-button>
              <el-button link type="danger" @click="removeCode(row)">删除</el-button></template></el-table-column>
          </el-table></div>
        </template>

        <template v-else-if="active === 'code-mapper'">
          <div class="page-toolbar"><div><h1>编码映射</h1><p>原始报表字段与标准编码的对应关系</p></div>
            <div class="toolbar-actions"><el-input v-model="mapperKeyword" placeholder="搜索编码或字段" clearable @keyup.enter="loadCodeMappers" />
              <el-button type="primary" :icon="Plus" @click="openMapper()">新增映射</el-button></div></div>
          <div class="panel"><el-table :data="codeMappers" stripe height="600" class="data-table">
            <el-table-column prop="codeNo" label="标准编码" width="150" />
            <el-table-column prop="codeName" label="编码名称" min-width="220" />
            <el-table-column prop="basiField" label="原始报表字段" min-width="220" />
            <el-table-column label="操作" width="150"><template #default="{ row }">
              <el-button link type="primary" @click="openMapper(row)">编辑</el-button>
              <el-button link type="danger" @click="removeMapper(row)">删除</el-button></template></el-table-column>
          </el-table></div>
        </template>

        <template v-else-if="active === 'modes'">
          <div class="page-toolbar"><div><h1>算法配置</h1><p>预警规则与模板报告</p></div>
            <div class="toolbar-actions"><el-input v-model="modeKeyword" placeholder="搜索模板描述" clearable @keyup.enter="loadModes" />
              <el-button type="primary" :icon="Plus" @click="openMode()">新增算法</el-button></div></div>
          <div class="panel"><el-table :data="modes" stripe height="600" class="data-table">
            <el-table-column prop="id" label="ID" width="90" /><el-table-column prop="reportType" label="报表类型" width="100" />
            <el-table-column prop="reportConten" label="模板描述" min-width="180" /><el-table-column prop="modeCondition" label="条件" min-width="200" />
            <el-table-column prop="modeArea" label="模板编号" width="110" /><el-table-column prop="px" label="排序" width="80" />
            <el-table-column label="操作" width="150"><template #default="{ row }">
              <el-button link type="primary" @click="openMode(row)">编辑</el-button>
              <el-button link type="danger" @click="removeMode(row)">删除</el-button></template></el-table-column>
          </el-table></div>
        </template>

        <template v-else-if="active === 'convert'">
          <div class="page-toolbar"><div><h1>数据转换</h1><p>将原始报表字段转换为移动端使用的标准指标</p></div></div>
          <div class="convert-panel panel">
            <div class="convert-visual"><el-icon><RefreshRight /></el-icon></div>
            <h2>标准化数据转换</h2>
            <p>读取编码映射关系，把利润表、资产负债表和现金流量表字段写入 `t_report_result`。</p>
            <div class="convert-flow"><span>原始报表</span><i>→</i><span>编码映射</span><i>→</i><span>标准指标</span></div>
            <el-button type="primary" size="large" :loading="convertLoading" @click="runConvert">执行数据转换</el-button>
            <div v-if="convertResult !== null" class="convert-result">本次生成 <b>{{ convertResult }}</b> 条标准结果</div>
          </div>
          <div class="stat-grid compact">
            <div class="stat-card blue"><div class="stat-label">已转换期间</div><div class="stat-value">{{ periods.length }}<small>期</small></div></div>
            <div class="stat-card teal"><div class="stat-label">标准结果总数</div><div class="stat-value">{{ dashboard?.counts?.results || 0 }}<small>条</small></div></div>
            <div class="stat-card gold"><div class="stat-label">报表记录</div><div class="stat-value">{{ dashboard?.counts?.reports || 0 }}<small>条</small></div></div>
            <div class="stat-card rose"><div class="stat-label">公司数量</div><div class="stat-value">{{ companies.length }}<small>家</small></div></div>
          </div>
          <div class="panel conversion-result-panel">
            <div class="panel-head">
              <div><h3>转换结果</h3><p>导入后自动生成，可在这里核对最新期间的编码和金额</p></div>
              <div class="toolbar-actions">
                <el-select v-model="conversionPeriod" placeholder="会计期间" clearable @change="loadConversionResults" style="width: 150px">
                  <el-option v-for="item in periods" :key="item" :label="periodText(item)" :value="item" />
                </el-select>
                <el-input v-model="conversionKeyword" placeholder="编码或名称" clearable style="width: 170px" @keyup.enter="loadConversionResults" />
                <el-button :icon="Search" @click="loadConversionResults">查询</el-button>
              </div>
            </div>
            <el-table :data="conversionRows" stripe height="340" class="data-table">
              <el-table-column prop="period" label="会计期间" width="120"><template #default="{ row }">{{ periodText(row.period) }}</template></el-table-column>
              <el-table-column prop="codeNo" label="标准编码" width="150" />
              <el-table-column prop="codeName" label="指标名称" min-width="220" />
              <el-table-column prop="dataValue" label="数值" align="right" width="180"><template #default="{ row }">{{ money(row.dataValue) }}</template></el-table-column>
            </el-table>
            <div class="pagination-row">
              <el-pagination background layout="total, prev, pager, next" :total="conversionTotal"
                v-model:current-page="conversionPage" v-model:page-size="conversionSize"
                @current-change="loadConversionResults" />
            </div>
          </div>
        </template>

        <template v-else-if="active === 'news'">
          <div class="page-toolbar"><div><h1>资讯管理</h1><p>发布企业经营与财务分析资讯</p></div>
            <el-button type="primary" :icon="Plus" @click="openNews()">发布资讯</el-button></div>
          <div class="panel"><el-table :data="news" stripe class="data-table">
            <el-table-column prop="id" label="ID" width="70" /><el-table-column prop="title" label="标题" min-width="220" />
            <el-table-column prop="author" label="作者" width="110" /><el-table-column prop="viewNum" label="阅读数" width="90" />
            <el-table-column prop="upDate" label="发布日期" width="130" />
            <el-table-column label="操作" width="150"><template #default="{ row }">
              <el-button link type="primary" @click="openNews(row)">编辑</el-button>
              <el-button link type="danger" @click="removeNews(row)">删除</el-button></template></el-table-column>
          </el-table></div>
        </template>
      </el-main>
    </el-container>
  </el-container>

  <el-dialog v-model="companyDialog" :title="companyForm.id ? '编辑公司' : '新增公司'" width="620px">
    <el-form label-width="100px">
      <el-form-item label="公司名称"><el-input v-model="companyForm.orgName" /></el-form-item>
      <el-form-item label="公司简称"><el-input v-model="companyForm.shortName" /></el-form-item>
      <el-form-item label="法人"><el-input v-model="companyForm.legalerName" /></el-form-item>
      <el-form-item label="所属行业"><el-input v-model="companyForm.industry" /></el-form-item>
      <el-form-item label="负责人"><el-input v-model="companyForm.resPersonName" /></el-form-item>
      <el-form-item label="负责人电话"><el-input v-model="companyForm.resPersonTel" /></el-form-item>
      <el-form-item label="公司简介"><el-input v-model="companyForm.orgRemark" type="textarea" :rows="3" /></el-form-item>
    </el-form>
    <template #footer><el-button @click="companyDialog = false">取消</el-button><el-button type="primary" @click="saveCompany">保存</el-button></template>
  </el-dialog>

  <el-dialog v-model="userDialog" :title="userForm.id ? '编辑用户' : '新增用户'" width="560px">
    <el-form label-width="90px">
      <el-form-item label="用户名称"><el-input v-model="userForm.userName" /></el-form-item>
      <el-form-item label="账号"><el-input v-model="userForm.accountName" /></el-form-item>
      <el-form-item v-if="!userForm.id" label="密码"><el-input v-model="userForm.pwd" type="password" /></el-form-item>
      <el-form-item label="所属角色"><el-select v-model="userForm.roleId" style="width: 100%"><el-option v-for="r in roles" :key="r.id" :label="r.name" :value="r.id" /></el-select></el-form-item>
      <el-form-item label="所属公司"><el-select v-model="userForm.orgId" style="width: 100%"><el-option v-for="c in companies" :key="c.id" :label="c.orgName" :value="c.id" /></el-select></el-form-item>
      <el-form-item label="状态"><el-switch v-model="userForm.locked" :active-value="1" :inactive-value="0" active-text="锁定" inactive-text="正常" /></el-form-item>
      <el-form-item label="描述"><el-input v-model="userForm.description" type="textarea" :rows="2" /></el-form-item>
    </el-form>
    <template #footer><el-button @click="userDialog = false">取消</el-button><el-button type="primary" @click="saveUser">保存</el-button></template>
  </el-dialog>

  <el-dialog v-model="roleDialog" :title="roleForm.id ? '编辑角色' : '新增角色'" width="460px">
    <el-form label-width="80px"><el-form-item label="角色名称"><el-input v-model="roleForm.name" /></el-form-item>
      <el-form-item label="描述"><el-input v-model="roleForm.description" type="textarea" :rows="2" /></el-form-item></el-form>
    <template #footer><el-button @click="roleDialog = false">取消</el-button><el-button type="primary" @click="saveRole">保存</el-button></template>
  </el-dialog>

  <el-dialog v-model="menuDialog" :title="menuForm.id ? '编辑菜单' : '新增菜单'" width="560px">
    <el-form label-width="90px"><el-form-item label="菜单名称"><el-input v-model="menuForm.name" /></el-form-item>
      <el-form-item label="父节点"><el-input v-model="menuForm.parentId" /></el-form-item>
      <el-form-item label="资源键"><el-input v-model="menuForm.resKey" /></el-form-item>
      <el-form-item label="类型"><el-select v-model="menuForm.type" style="width:100%"><el-option label="根菜单" value="0" /><el-option label="子菜单" value="1" /><el-option label="按钮" value="2" /></el-select></el-form-item>
      <el-form-item label="地址"><el-input v-model="menuForm.resUrl" /></el-form-item>
      <el-form-item label="排序"><el-input-number v-model="menuForm.orderNo" :min="0" /></el-form-item>
      <el-form-item label="描述"><el-input v-model="menuForm.description" /></el-form-item></el-form>
    <template #footer><el-button @click="menuDialog = false">取消</el-button><el-button type="primary" @click="saveMenu">保存</el-button></template>
  </el-dialog>

  <el-dialog v-model="dictDialog" :title="dictForm.id ? '编辑字典' : '新增字典'" width="500px">
    <el-form label-width="90px"><el-form-item label="中文名称"><el-input v-model="dictForm.cnName" /></el-form-item>
      <el-form-item label="英文名称"><el-input v-model="dictForm.enName" /></el-form-item>
      <el-form-item label="可编辑"><el-switch v-model="dictForm.flag" active-value="1" inactive-value="0" /></el-form-item>
      <el-form-item label="备注"><el-input v-model="dictForm.remark" type="textarea" :rows="2" /></el-form-item></el-form>
    <template #footer><el-button @click="dictDialog = false">取消</el-button><el-button type="primary" @click="saveDict">保存</el-button></template>
  </el-dialog>

  <el-dialog v-model="codeDialog" :title="codeForm.id ? '编辑编码' : '新增编码'" width="600px">
    <el-form label-width="90px"><el-form-item label="编码名称"><el-input v-model="codeForm.codeName" /></el-form-item>
      <el-form-item label="编码"><el-input v-model="codeForm.codeNo" /></el-form-item>
      <el-form-item label="报表类型"><el-select v-model="codeForm.reportType" style="width:100%"><el-option label="资产负债表" value="1" /><el-option label="利润表" value="2" /><el-option label="现金流量表" value="3" /></el-select></el-form-item>
      <el-form-item label="作用域"><el-input v-model="codeForm.useArea" /></el-form-item>
      <el-form-item label="说明"><el-input v-model="codeForm.remark" /></el-form-item></el-form>
    <template #footer><el-button @click="codeDialog = false">取消</el-button><el-button type="primary" @click="saveCode">保存</el-button></template>
  </el-dialog>

  <el-dialog v-model="mapperDialog" :title="mapperForm.editing ? '编辑编码映射' : '新增编码映射'" width="560px">
    <el-form label-width="110px">
      <el-form-item label="标准编码"><el-input v-model="mapperForm.codeNo" :disabled="mapperForm.editing" /></el-form-item>
      <el-form-item label="原始报表字段"><el-input v-model="mapperForm.basiField" /></el-form-item>
    </el-form>
    <template #footer><el-button @click="mapperDialog = false">取消</el-button><el-button type="primary" @click="saveMapper">保存</el-button></template>
  </el-dialog>

  <el-dialog v-model="modeDialog" :title="modeForm.id ? '编辑算法配置' : '新增算法配置'" width="620px">
    <el-form label-width="90px"><el-form-item label="报表类型"><el-select v-model="modeForm.reportType" style="width:100%"><el-option label="资产负债表" value="1" /><el-option label="利润表" value="2" /><el-option label="现金流量表" value="3" /></el-select></el-form-item>
      <el-form-item label="模板描述"><el-input v-model="modeForm.reportConten" /></el-form-item>
      <el-form-item label="条件"><el-input v-model="modeForm.modeCondition" /></el-form-item>
      <el-form-item label="内容"><el-input v-model="modeForm.modeContent" type="textarea" :rows="3" /></el-form-item>
      <el-form-item label="排序"><el-input-number v-model="modeForm.px" :min="0" /></el-form-item></el-form>
    <template #footer><el-button @click="modeDialog = false">取消</el-button><el-button type="primary" @click="saveMode">保存</el-button></template>
  </el-dialog>

  <el-dialog v-model="newsDialog" :title="newsForm.id ? '编辑资讯' : '发布资讯'" width="650px">
    <el-form label-width="80px"><el-form-item label="标题"><el-input v-model="newsForm.title" /></el-form-item>
      <el-form-item label="作者"><el-input v-model="newsForm.author" /></el-form-item>
      <el-form-item label="内容"><el-input v-model="newsForm.content" type="textarea" :rows="6" /></el-form-item>
      <el-form-item label="阅读数"><el-input-number v-model="newsForm.viewNum" :min="0" /></el-form-item></el-form>
    <template #footer><el-button @click="newsDialog = false">取消</el-button><el-button type="primary" @click="saveNews">保存</el-button></template>
  </el-dialog>
</template>

<script setup>
import { computed, nextTick, onBeforeUnmount, onMounted, reactive, ref, watch } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Plus, Upload, Search, Refresh } from '@element-plus/icons-vue'
import * as echarts from 'echarts'
import { api } from './api'

const loginForm = reactive({ account: 'root', password: '123456' })
const loginLoading = ref(false)
const user = ref(JSON.parse(localStorage.getItem('finance_admin_user') || 'null'))
const pageLoading = ref(false)
const active = ref('dashboard')
const companies = ref([])
const selectedOrg = ref(Number(localStorage.getItem('finance_selected_org')) || null)
const dashboard = ref(null)
const periods = ref([])
const period = ref('')
const ratioCategories = ref([])
const profitChartEl = ref(null)
const cashChartEl = ref(null)
const agingChartEl = ref(null)
let profitChart
let cashChart
let agingChart

const pageMeta = {
  dashboard: { title: '经营驾驶舱', subtitle: '企业财务健康状态与经营趋势' },
  ratio: { title: '财务比率分析', subtitle: '四类核心财务比率与经营诊断' },
  reports: { title: '财务报表明细', subtitle: '查看导入后的标准报表数据' },
  aging: { title: '账龄分析', subtitle: '往来款账龄区间与风险分布' },
  import: { title: '数据导入', subtitle: '单表和批量导入 Excel 报表' },
  companies: { title: '公司管理', subtitle: '企业档案与报表标准' },
  users: { title: '用户管理', subtitle: '管理员账号与数据权限' },
  roles: { title: '角色管理', subtitle: '后台角色与权限基础信息' },
  menus: { title: '菜单管理', subtitle: '系统菜单和按钮资源' },
  dictionaries: { title: '系统字典', subtitle: '统一维护系统枚举和配置' },
  'code-library': { title: '编码字典', subtitle: '标准科目编码与展示配置' },
  'code-mapper': { title: '编码映射', subtitle: '原始报表字段与标准编码的对应关系' },
  modes: { title: '算法配置', subtitle: '预警规则与模板报告' },
  convert: { title: '数据转换', subtitle: '生成移动端使用的标准指标' },
  news: { title: '资讯管理', subtitle: '企业经营与财务分析资讯' }
}
const currentMeta = computed(() => pageMeta[active.value] || pageMeta.dashboard)
const avatarText = computed(() => (user.value?.userName || 'U').slice(0, 1))
const netProfitHint = computed(() => {
  const value = Number(dashboard.value?.overview?.netProfit || 0)
  return value >= 0 ? '保持正向盈利' : '本期出现亏损，请关注成本'
})
const reportLabel = computed(() => ({ profit: '利润表', balance: '资产负债表', cashflow: '现金流量表', kmye: '科目余额表' }[reportType.value]))
const orgId = computed(() => selectedOrg.value || user.value?.orgId || companies.value[0]?.id || 1)

const reportType = ref('profit')
const reportRows = ref([])
const reportTotal = ref(0)
const reportPage = ref(1)
const reportSize = ref(10)
const reportKeyword = ref('')
const reportFileEl = ref(null)
const importFileEl = ref(null)
const bulkFileEl = ref(null)
const importType = ref('profit')
const uploadLoading = ref(false)
const bulkResult = ref(null)
const recentImports = ref([])
const conversionRows = ref([])
const conversionTotal = ref(0)
const conversionPage = ref(1)
const conversionSize = ref(10)
const conversionKeyword = ref('')
const conversionPeriod = ref('')
const agingType = ref(7)
const agingData = ref({ rows: [], summary: {} })
const users = ref([])
const roles = ref([])
const menus = ref([])
const dictionaries = ref([])
const dictKeyword = ref('')
const codeLibrary = ref([])
const codeKeyword = ref('')
const codeMappers = ref([])
const mapperKeyword = ref('')
const modes = ref([])
const modeKeyword = ref('')
const news = ref([])
const convertLoading = ref(false)
const convertResult = ref(null)

const companyDialog = ref(false)
const companyForm = reactive({})
const userDialog = ref(false)
const userForm = reactive({})
const roleDialog = ref(false)
const roleForm = reactive({})
const menuDialog = ref(false)
const menuForm = reactive({})
const dictDialog = ref(false)
const dictForm = reactive({})
const codeDialog = ref(false)
const codeForm = reactive({})
const mapperDialog = ref(false)
const mapperForm = reactive({})
const modeDialog = ref(false)
const modeForm = reactive({})
const newsDialog = ref(false)
const newsForm = reactive({})

function resetForm(target, value = {}) {
  Object.keys(target).forEach(key => delete target[key])
  Object.assign(target, value)
}

async function doLogin() {
  if (!loginForm.account || !loginForm.password) return ElMessage.warning('请输入账号和密码')
  loginLoading.value = true
  try {
    const data = await api.login(loginForm.account, loginForm.password)
    localStorage.setItem('finance_admin_token', data.token)
    localStorage.setItem('finance_admin_user', JSON.stringify(data.user))
    user.value = data.user
    await boot()
    ElMessage.success('登录成功')
  } catch (error) {
    ElMessage.error(error.message)
  } finally {
    loginLoading.value = false
  }
}

function logout() {
  localStorage.removeItem('finance_admin_token')
  localStorage.removeItem('finance_admin_user')
  user.value = null
}

async function boot() {
  pageLoading.value = true
  try {
    companies.value = await api.companies('')
    if (!selectedOrg.value) selectedOrg.value = user.value?.orgId || companies.value[0]?.id || null
    await loadPeriods()
    await loadDashboard()
  } catch (error) {
    ElMessage.error(error.message)
  } finally {
    pageLoading.value = false
  }
}

async function loadPeriods() {
  periods.value = (await api.periods(orgId.value)).map(item => item.period)
  if (periods.value.length && !periods.value.includes(period.value)) period.value = periods.value[0]
}

async function loadDashboard() {
  dashboard.value = await api.dashboard(orgId.value)
  ratioCategories.value = Object.values(dashboard.value?.overview?.ratios || {})
  await nextTick()
  renderDashboardCharts()
}

function renderDashboardCharts() {
  if (profitChartEl.value && dashboard.value?.profitChart) {
    if (profitChart && profitChart.getDom() !== profitChartEl.value) {
      profitChart.dispose()
      profitChart = null
    }
    if (!profitChart || profitChart.isDisposed()) {
      profitChart = echarts.init(profitChartEl.value)
    }
    const data = dashboard.value.profitChart
    profitChart.setOption({
      color: ['#0d7c78', '#d8a03d'],
      tooltip: { trigger: 'axis' },
      legend: { top: 0, right: 0, textStyle: { color: '#738094' } },
      grid: { left: 50, right: 20, top: 40, bottom: 30 },
      xAxis: { type: 'category', data: data.periods, axisLine: { lineStyle: { color: '#dce3ea' } } },
      yAxis: { type: 'value', splitLine: { lineStyle: { color: '#eef2f5' } }, axisLabel: { formatter: v => compact(v) } },
      series: (data.series || []).map(item => ({ name: item.name, type: 'line', smooth: true, symbolSize: 5, data: item.values, areaStyle: { opacity: 0.06 } }))
    })
  }
  if (cashChartEl.value && dashboard.value?.cashChart) {
    if (cashChart && cashChart.getDom() !== cashChartEl.value) {
      cashChart.dispose()
      cashChart = null
    }
    if (!cashChart || cashChart.isDisposed()) {
      cashChart = echarts.init(cashChartEl.value)
    }
    const data = dashboard.value.cashChart
    cashChart.setOption({
      color: ['#0d7c78', '#4569a8', '#c85b54'],
      tooltip: { trigger: 'axis' },
      legend: { top: 0, right: 0, textStyle: { color: '#738094' } },
      grid: { left: 50, right: 20, top: 40, bottom: 30 },
      xAxis: { type: 'category', data: data.periods, axisLine: { lineStyle: { color: '#dce3ea' } } },
      yAxis: { type: 'value', splitLine: { lineStyle: { color: '#eef2f5' } }, axisLabel: { formatter: v => compact(v) } },
      series: (data.series || []).map(item => ({ name: item.name, type: 'bar', barMaxWidth: 16, data: item.values }))
    })
  }
}

async function loadReports() {
  pageLoading.value = true
  try {
    const data = await api.reports({ type: reportType.value, orgId: orgId.value, period: period.value, keyword: reportKeyword.value, page: reportPage.value, size: reportSize.value })
    reportRows.value = data.rows
    reportTotal.value = data.total
  } catch (error) { ElMessage.error(error.message) } finally { pageLoading.value = false }
}

async function loadAging() {
  pageLoading.value = true
  try {
    agingData.value = await api.aging({ type: agingType.value, orgId: orgId.value, period: period.value })
    await nextTick()
    if (agingChartEl.value) {
      if (agingChart && agingChart.getDom() !== agingChartEl.value) {
        agingChart.dispose()
        agingChart = null
      }
      if (!agingChart || agingChart.isDisposed()) {
        agingChart = echarts.init(agingChartEl.value)
      }
      const summary = agingData.value.summary || {}
      agingChart.setOption({
        color: ['#0d7c78'],
        tooltip: { trigger: 'axis' },
        grid: { left: 60, right: 25, top: 25, bottom: 40 },
        xAxis: { type: 'category', data: summary.labels || [], axisLabel: { color: '#718095' } },
        yAxis: { type: 'value', splitLine: { lineStyle: { color: '#eef2f5' } }, axisLabel: { formatter: v => compact(v) } },
        series: [{ type: 'bar', barMaxWidth: 34, data: summary.values || [], itemStyle: { borderRadius: [6, 6, 0, 0] } }]
      })
    }
  } catch (error) { ElMessage.error(error.message) } finally { pageLoading.value = false }
}

async function loadCompanies() { companies.value = await api.companies('') }
async function loadUsers() { users.value = await api.users(); roles.value = await api.roles() }
async function loadRoles() { roles.value = await api.roles() }
async function loadMenus() { menus.value = await api.menus() }
async function loadDictionaries() { dictionaries.value = await api.dictionaries(dictKeyword.value) }
async function loadCodeLibrary() { codeLibrary.value = await api.codeLibrary(codeKeyword.value) }
async function loadCodeMappers() { codeMappers.value = await api.codeMappers(mapperKeyword.value) }
async function loadModes() { modes.value = await api.modes(modeKeyword.value) }
async function loadNews() { news.value = await api.news() }

async function loadPage(page) {
  if (page === 'reports') return loadReports()
  if (page === 'ratio') return dashboard.value ? Promise.resolve() : loadDashboard()
  if (page === 'aging') return loadAging()
  if (page === 'import') return loadRecentImports()
  if (page === 'companies') return loadCompanies()
  if (page === 'users') return loadUsers()
  if (page === 'roles') return loadRoles()
  if (page === 'menus') return loadMenus()
  if (page === 'dictionaries') return loadDictionaries()
  if (page === 'code-library') return loadCodeLibrary()
  if (page === 'code-mapper') return loadCodeMappers()
  if (page === 'modes') return loadModes()
  if (page === 'convert') return loadConversionResults()
  if (page === 'news') return loadNews()
  if (page === 'dashboard') return loadDashboard()
}

async function loadRecentImports() {
  recentImports.value = await api.importHistory(orgId.value)
}

async function loadConversionResults() {
  const data = await api.conversionResults({
    orgId: orgId.value,
    period: conversionPeriod.value,
    keyword: conversionKeyword.value,
    page: conversionPage.value,
    size: conversionSize.value
  })
  conversionRows.value = data.rows || []
  conversionTotal.value = data.total || 0
}

async function handleMenu(index) {
  if (index === 'ratio') {
    active.value = 'ratio'
    if (!dashboard.value) await loadDashboard()
    return
  }
  if (index.startsWith('report-')) {
    reportType.value = index.replace('report-', '')
    reportPage.value = 1
    active.value = 'reports'
    await loadReports()
    return
  }
  active.value = index
  pageLoading.value = true
  try { await loadPage(index) } catch (error) { ElMessage.error(error.message) } finally { pageLoading.value = false }
}

function triggerReportUpload() { reportFileEl.value?.click() }
function triggerImportFile() { importFileEl.value?.click() }
function triggerBulkFiles() { bulkFileEl.value?.click() }

async function onReportFile(event) {
  const file = event.target.files?.[0]
  if (!file) return
  uploadLoading.value = true
  try {
    const result = await api.importReport(file, reportType.value, orgId.value)
    if (result.period) {
      await loadPeriods()
      period.value = result.period
      conversionPeriod.value = result.period
    }
    ElMessage.success(`导入成功：读取 ${result.count} 项，自动转换 ${result.converted || 0} 条标准结果`)
    await loadReports()
    await loadDashboard()
    await loadRecentImports()
    await loadConversionResults()
  } catch (error) { ElMessage.error(error.message) } finally {
    uploadLoading.value = false
    event.target.value = ''
  }
}

async function onImportFile(event) {
  const file = event.target.files?.[0]
  if (!file) return
  uploadLoading.value = true
  try {
    const result = await api.importReport(file, importType.value, orgId.value)
    if (result.period) {
      await loadPeriods()
      period.value = result.period
      conversionPeriod.value = result.period
    }
    ElMessage.success(`导入成功：读取 ${result.count} 项，自动转换 ${result.converted || 0} 条标准结果`)
    await loadRecentImports()
    await loadReports()
    await loadDashboard()
    await loadConversionResults()
  } catch (error) { ElMessage.error(error.message) } finally {
    uploadLoading.value = false
    event.target.value = ''
  }
}

async function onBulkFiles(event) {
  const files = Array.from(event.target.files || [])
  if (!files.length) return
  uploadLoading.value = true
  try {
    const result = await api.bulkImport(files, orgId.value)
    bulkResult.value = result
    ElMessage.success(`成功导入 ${result.success} 个文件，自动转换 ${result.converted || 0} 条标准结果`)
    await loadPeriods()
    await loadRecentImports()
    await loadReports()
    await loadDashboard()
    await loadConversionResults()
  } catch (error) { ElMessage.error(error.message) } finally {
    uploadLoading.value = false
    event.target.value = ''
  }
}

function openCompany(row) {
  resetForm(companyForm, row ? { ...row } : { orgName: '', shortName: '', legalerName: '', industry: '', resPersonName: '', resPersonTel: '', orgRemark: '' })
  companyDialog.value = true
}
async function saveCompany() {
  try {
    if (companyForm.id) await api.updateCompany(companyForm.id, companyForm)
    else await api.createCompany(companyForm)
    companyDialog.value = false
    ElMessage.success('保存成功')
    await loadCompanies(); await loadPeriods()
  } catch (error) { ElMessage.error(error.message) }
}
async function removeCompany(row) {
  try {
    await ElMessageBox.confirm(`确认删除公司“${row.orgName}”？`, '提示', { type: 'warning' })
    await api.deleteCompany(row.id)
    await loadCompanies()
    ElMessage.success('已删除')
  } catch (error) { if (error !== 'cancel') ElMessage.error(error.message) }
}

function openUser(row) {
  resetForm(userForm, row ? { ...row } : { userName: '', accountName: '', pwd: '', roleId: roles.value[0]?.id, orgId: orgId.value, locked: 0, description: '' })
  userDialog.value = true
}
async function saveUser() {
  try {
    if (userForm.id) await api.updateUser(userForm.id, userForm)
    else await api.createUser(userForm)
    userDialog.value = false
    await loadUsers()
    ElMessage.success('保存成功')
  } catch (error) { ElMessage.error(error.message) }
}
async function resetUser(row) {
  try {
    await ElMessageBox.confirm(`确认将 ${row.accountName} 的密码重置为 123456？`, '提示', { type: 'warning' })
    await api.resetPassword(row.id)
    ElMessage.success('密码已重置')
  } catch (error) { if (error !== 'cancel') ElMessage.error(error.message) }
}
async function removeUser(row) {
  try {
    await ElMessageBox.confirm(`确认删除用户“${row.accountName}”？`, '提示', { type: 'warning' })
    await api.deleteUser(row.id)
    await loadUsers()
    ElMessage.success('已删除')
  } catch (error) { if (error !== 'cancel') ElMessage.error(error.message) }
}

function openRole(row) { resetForm(roleForm, row ? { ...row } : { name: '', description: '' }); roleDialog.value = true }
async function saveRole() {
  try {
    if (roleForm.id) await api.updateRole(roleForm.id, roleForm)
    else await api.createRole(roleForm)
    roleDialog.value = false; await loadRoles(); ElMessage.success('保存成功')
  } catch (error) { ElMessage.error(error.message) }
}
async function removeRole(row) {
  try {
    await ElMessageBox.confirm(`确认删除角色“${row.name}”？`, '提示', { type: 'warning' })
    await api.deleteRole(row.id); await loadRoles(); ElMessage.success('已删除')
  } catch (error) { if (error !== 'cancel') ElMessage.error(error.message) }
}

function openMenu(row) { resetForm(menuForm, row ? { ...row } : { name: '', parentId: 0, resKey: '', type: '1', resUrl: '/', orderNo: 99, description: '' }); menuDialog.value = true }
async function saveMenu() {
  try {
    if (menuForm.id) await api.updateMenu(menuForm.id, menuForm)
    else await api.createMenu(menuForm)
    menuDialog.value = false; await loadMenus(); ElMessage.success('保存成功')
  } catch (error) { ElMessage.error(error.message) }
}
async function removeMenu(row) {
  try {
    await ElMessageBox.confirm(`确认删除菜单“${row.name}”？`, '提示', { type: 'warning' })
    await api.deleteMenu(row.id); await loadMenus(); ElMessage.success('已删除')
  } catch (error) { if (error !== 'cancel') ElMessage.error(error.message) }
}

function openDict(row) { resetForm(dictForm, row ? { ...row } : { cnName: '', enName: '', flag: '1', remark: '' }); dictDialog.value = true }
async function saveDict() {
  try {
    if (dictForm.id) await api.updateDictionary(dictForm.id, dictForm)
    else await api.createDictionary(dictForm)
    dictDialog.value = false; await loadDictionaries(); ElMessage.success('保存成功')
  } catch (error) { ElMessage.error(error.message) }
}
async function removeDict(row) {
  try {
    await ElMessageBox.confirm(`确认删除字典“${row.cnName}”？`, '提示', { type: 'warning' })
    await api.deleteDictionary(row.id); await loadDictionaries(); ElMessage.success('已删除')
  } catch (error) { if (error !== 'cancel') ElMessage.error(error.message) }
}

function openCode(row) { resetForm(codeForm, row ? { ...row } : { codeName: '', codeNo: '', reportType: '1', useArea: '', remark: '' }); codeDialog.value = true }
async function saveCode() {
  try {
    if (codeForm.id) await api.updateCode(codeForm.id, codeForm)
    else await api.createCode(codeForm)
    codeDialog.value = false; await loadCodeLibrary(); ElMessage.success('保存成功')
  } catch (error) { ElMessage.error(error.message) }
}
async function removeCode(row) {
  try {
    await ElMessageBox.confirm(`确认删除编码“${row.codeName}”？`, '提示', { type: 'warning' })
    await api.deleteCode(row.id); await loadCodeLibrary(); ElMessage.success('已删除')
  } catch (error) { if (error !== 'cancel') ElMessage.error(error.message) }
}

async function syncCodeLibrary() {
  try {
    const count = await api.syncCodeLibrary()
    ElMessage.success(`同步完成，更新 ${count} 条编码`)
    await loadCodeLibrary()
  } catch (error) { ElMessage.error(error.message) }
}

function openMapper(row) {
  resetForm(mapperForm, row
    ? { codeNo: row.codeNo, basiField: row.basiField, editing: true }
    : { codeNo: '', basiField: '', editing: false })
  mapperDialog.value = true
}

async function saveMapper() {
  try {
    if (mapperForm.editing) await api.updateMapper(mapperForm.codeNo, mapperForm)
    else await api.createMapper(mapperForm)
    mapperDialog.value = false
    await loadCodeMappers()
    ElMessage.success('保存成功')
  } catch (error) { ElMessage.error(error.message) }
}

async function removeMapper(row) {
  try {
    await ElMessageBox.confirm(`确认删除编码映射“${row.codeNo}”？`, '提示', { type: 'warning' })
    await api.deleteMapper(row.codeNo)
    await loadCodeMappers()
    ElMessage.success('已删除')
  } catch (error) { if (error !== 'cancel') ElMessage.error(error.message) }
}

function openMode(row) { resetForm(modeForm, row ? { ...row } : { reportType: '1', reportConten: '', modeCondition: '', modeContent: '', px: 99 }); modeDialog.value = true }
async function saveMode() {
  try {
    if (modeForm.id) await api.updateMode(modeForm.id, modeForm)
    else await api.createMode(modeForm)
    modeDialog.value = false; await loadModes(); ElMessage.success('保存成功')
  } catch (error) { ElMessage.error(error.message) }
}
async function removeMode(row) {
  try {
    await ElMessageBox.confirm(`确认删除算法配置“${row.reportConten}”？`, '提示', { type: 'warning' })
    await api.deleteMode(row.id); await loadModes(); ElMessage.success('已删除')
  } catch (error) { if (error !== 'cancel') ElMessage.error(error.message) }
}

function openNews(row) { resetForm(newsForm, row ? { ...row } : { title: '', author: '系统管理员', content: '', viewNum: 0, upPerson: '系统管理员', upPersonTel: '13800138000', clzz: '1' }); newsDialog.value = true }
async function saveNews() {
  try {
    if (newsForm.id) await api.updateNews(newsForm.id, newsForm)
    else await api.createNews(newsForm)
    newsDialog.value = false; await loadNews(); ElMessage.success('保存成功')
  } catch (error) { ElMessage.error(error.message) }
}
async function removeNews(row) {
  try {
    await ElMessageBox.confirm(`确认删除资讯“${row.title}”？`, '提示', { type: 'warning' })
    await api.deleteNews(row.id); await loadNews(); ElMessage.success('已删除')
  } catch (error) { if (error !== 'cancel') ElMessage.error(error.message) }
}

async function runConvert() {
  convertLoading.value = true
  try {
    convertResult.value = await api.convert(orgId.value)
    await loadDashboard()
    await loadConversionResults()
    ElMessage.success('数据转换成功')
  } catch (error) { ElMessage.error(error.message) } finally { convertLoading.value = false }
}

watch(selectedOrg, async value => {
  if (!value) return
  localStorage.setItem('finance_selected_org', String(value))
  if (!user.value) return
  await loadPeriods()
  if (active.value === 'dashboard') await loadDashboard()
  else if (active.value === 'reports') { reportPage.value = 1; await loadReports() }
  else if (active.value === 'aging') await loadAging()
  else if (active.value === 'convert') await loadConversionResults()
})

onMounted(async () => {
  if (user.value) {
    try { await boot() } catch (error) { ElMessage.error(error.message) }
  }
  window.addEventListener('resize', resizeCharts)
})
onBeforeUnmount(() => {
  window.removeEventListener('resize', resizeCharts)
  profitChart?.dispose(); cashChart?.dispose(); agingChart?.dispose()
})
function resizeCharts() {
  if (profitChart && !profitChart.isDisposed()) profitChart.resize()
  if (cashChart && !cashChart.isDisposed()) cashChart.resize()
  if (agingChart && !agingChart.isDisposed()) agingChart.resize()
}

function compactMoney(value) {
  const number = Number(value || 0)
  const abs = Math.abs(number)
  if (abs >= 100000000) return (number / 100000000).toFixed(2) + ' 亿'
  if (abs >= 10000) return (number / 10000).toFixed(1) + ' 万'
  return number.toLocaleString('zh-CN', { maximumFractionDigits: 0 })
}
function compact(value) {
  const n = Number(value || 0)
  if (Math.abs(n) >= 100000000) return (n / 100000000).toFixed(1) + '亿'
  if (Math.abs(n) >= 10000) return (n / 10000).toFixed(0) + '万'
  return String(Math.round(n))
}
function money(value) {
  return Number(value || 0).toLocaleString('zh-CN', { minimumFractionDigits: 2, maximumFractionDigits: 2 })
}
function periodText(value) {
  return value ? `${String(value).slice(0, 4)}-${String(value).slice(4, 6)}` : '--'
}
function statusText(status) {
  return status === 'good' ? '稳健' : status === 'risk' ? '预警' : '关注'
}
</script>
