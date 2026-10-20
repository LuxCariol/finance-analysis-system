const fs = require('fs');
const path = require('path');

const root = path.resolve(__dirname, '..');
const mobileRoot = path.join(root, 'mobile');
const outputRoot = path.join(root, 'deliverables', '移动端开发阶段检查');
const evidenceRoot = path.join(outputRoot, '附件');
const sourceExtensions = new Set(['.vue', '.js', '.scss', '.json']);
const ignoredDirectories = new Set(['node_modules', 'static', 'unpackage', '.hbuilderx']);

function ensureDir(directory) {
  fs.mkdirSync(directory, { recursive: true });
}

function walk(directory, files) {
  for (const name of fs.readdirSync(directory)) {
    const full = path.join(directory, name);
    const stat = fs.statSync(full);
    if (stat.isDirectory()) {
      if (!ignoredDirectories.has(name)) walk(full, files);
    } else if (sourceExtensions.has(path.extname(name).toLowerCase())) {
      files.push(full);
    }
  }
}

function countLines(source, extension) {
  const lines = source.replace(/^\uFEFF/, '').split(/\r?\n/);
  let blank = 0;
  let comment = 0;
  let inBlockComment = false;
  let inHtmlComment = false;

  for (const rawLine of lines) {
    const line = rawLine.trim();
    if (!line) {
      blank++;
      continue;
    }

    let isComment = false;
    if (inBlockComment || inHtmlComment) {
      isComment = true;
      if (inBlockComment && line.includes('*/')) inBlockComment = false;
      if (inHtmlComment && line.includes('-->')) inHtmlComment = false;
    } else if (line.startsWith('<!--')) {
      isComment = true;
      if (!line.includes('-->')) inHtmlComment = true;
    } else if (line.startsWith('/*')) {
      isComment = true;
      if (!line.includes('*/')) inBlockComment = true;
    } else if (line.startsWith('//') || line.startsWith('*')) {
      isComment = true;
    } else if (extension === '.json' && line.startsWith('//')) {
      isComment = true;
    }

    if (isComment) comment++;
  }

  return {
    physical: lines.length,
    blank,
    comment,
    effective: lines.length - blank - comment
  };
}

function csvCell(value) {
  const text = String(value == null ? '' : value);
  return '"' + text.replace(/"/g, '""') + '"';
}

function writeCsv(file, headers, rows) {
  const lines = [headers.map(csvCell).join(',')];
  for (const row of rows) lines.push(row.map(csvCell).join(','));
  fs.writeFileSync(file, '\uFEFF' + lines.join('\r\n'), 'utf8');
}

ensureDir(evidenceRoot);
const files = [];
walk(mobileRoot, files);
files.sort((a, b) => a.localeCompare(b, 'zh-CN'));

const details = [];
const summary = {
  files: 0,
  physical: 0,
  blank: 0,
  comment: 0,
  effective: 0,
  vue: 0,
  js: 0,
  scss: 0,
  json: 0
};

for (const file of files) {
  const extension = path.extname(file).toLowerCase();
  const result = countLines(fs.readFileSync(file, 'utf8'), extension);
  const relative = path.relative(root, file).replace(/\\/g, '/');
  details.push([
    relative,
    extension.slice(1).toUpperCase(),
    result.physical,
    result.blank,
    result.comment,
    result.effective
  ]);
  summary.files++;
  summary.physical += result.physical;
  summary.blank += result.blank;
  summary.comment += result.comment;
  summary.effective += result.effective;
  summary[extension.slice(1)] = (summary[extension.slice(1)] || 0) + 1;
}

writeCsv(
  path.join(evidenceRoot, '代码行数明细.csv'),
  ['文件', '类型', '物理行', '空行', '注释行', '有效代码行'],
  details
);

writeCsv(
  path.join(evidenceRoot, '代码行数汇总.csv'),
  ['统计口径', '文件数', '物理行', '空行', '注释行', '有效代码行'],
  [
    ['移动端源码（不含量表、生成产物、静态资源）', summary.files, summary.physical, summary.blank, summary.comment, summary.effective],
    ['Vue 页面与组件', summary.vue, '', '', '', ''],
    ['JavaScript', summary.js, '', '', '', ''],
    ['SCSS 样式', summary.scss, '', '', '', ''],
    ['JSON 配置', summary.json, '', '', '', '']
  ]
);

const apiFiles = [
  'backend/src/main/java/com/qst/finance/controller/MobileApiController.java',
  'backend/src/main/java/com/qst/finance/service/AnalyticsService.java',
  'backend/src/main/java/com/qst/finance/service/ForecastService.java',
  'backend/src/main/java/com/qst/finance/service/InvestmentService.java',
  'backend/src/main/java/com/qst/finance/service/ApiSupport.java',
  'backend/src/main/java/com/qst/finance/service/TokenStore.java',
  'backend/src/main/java/com/qst/finance/service/LoginUser.java',
  'backend/src/main/java/com/qst/finance/common/ApiResult.java',
  'backend/src/main/java/com/qst/finance/common/ApiAuthException.java',
  'backend/src/main/java/com/qst/finance/common/ApiExceptionHandler.java'
];
const apiDetails = [];
const apiSummary = { files: 0, physical: 0, blank: 0, comment: 0, effective: 0 };
for (const relative of apiFiles) {
  const file = path.join(root, relative);
  if (!fs.existsSync(file)) continue;
  const result = countLines(fs.readFileSync(file, 'utf8'), '.java');
  apiDetails.push([
    relative.replace(/\\/g, '/'),
    'Java',
    result.physical,
    result.blank,
    result.comment,
    result.effective
  ]);
  apiSummary.files++;
  apiSummary.physical += result.physical;
  apiSummary.blank += result.blank;
  apiSummary.comment += result.comment;
  apiSummary.effective += result.effective;
}
writeCsv(
  path.join(evidenceRoot, '移动端接口代码明细.csv'),
  ['文件', '类型', '物理行', '空行', '注释行', '有效代码行'],
  apiDetails
);
writeCsv(
  path.join(evidenceRoot, '移动端接口代码汇总.csv'),
  ['统计口径', '文件数', '物理行', '空行', '注释行', '有效代码行'],
  [['移动端接口相关后端代码', apiSummary.files, apiSummary.physical, apiSummary.blank,
    apiSummary.comment, apiSummary.effective]]
);

console.log(JSON.stringify({ mobile: summary, mobileApi: apiSummary }, null, 2));
