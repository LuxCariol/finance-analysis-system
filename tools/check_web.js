const path = require('path');
const puppeteer = require(path.join(__dirname, '..', 'web', 'node_modules', 'puppeteer-core'));

async function main() {
  const browser = await puppeteer.launch({
    executablePath: 'C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe',
    headless: 'new',
    args: ['--no-sandbox', '--disable-gpu']
  });
  const page = await browser.newPage();
  await page.setViewport({ width: 1440, height: 1000, deviceScaleFactor: 1 });
  const errors = [];
  page.on('pageerror', error => errors.push(error.message));
  page.on('console', message => {
    if (message.type() === 'error' && !message.text().includes('Failed to load resource')) {
      errors.push(message.text());
    }
  });
  await page.goto('http://localhost:8006/web/', { waitUntil: 'networkidle0', timeout: 30000 });
  await page.$$eval('input', inputs => {
    const setValue = (input, value) => {
      const setter = Object.getOwnPropertyDescriptor(HTMLInputElement.prototype, 'value').set;
      setter.call(input, value);
      input.dispatchEvent(new Event('input', { bubbles: true }));
    };
    const account = inputs.find(input => input.type === 'text');
    const password = inputs.find(input => input.type === 'password');
    setValue(account, 'root');
    setValue(password, '123456');
  });
  await page.click('.login-button');
  await page.waitForSelector('.hero-card', { timeout: 20000 });
  await new Promise(resolve => setTimeout(resolve, 1500));
  await page.screenshot({
    path: path.join(__dirname, 'web-dashboard.png'),
    fullPage: true
  });
  const summary = await page.evaluate(() => ({
    title: document.querySelector('.hero-card h1')?.textContent,
    stats: document.querySelector('.stat-grid')?.innerText.replace(/\s+/g, ' ').trim(),
    panels: [...document.querySelectorAll('.panel-head h3')].map(node => node.textContent)
  }));
  console.log(JSON.stringify(summary, null, 2));
  await page.evaluate(() => {
    const item = [...document.querySelectorAll('.el-menu-item')].find(node => node.textContent.trim() === '公司管理');
    item?.click();
  });
  await new Promise(resolve => setTimeout(resolve, 1000));
  const companyText = await page.evaluate(() => document.body.innerText);
  console.log('company-page:', companyText.includes('示范制造有限公司') ? 'PASS' : 'FAIL');
  await page.evaluate(() => {
    const item = [...document.querySelectorAll('.el-menu-item')].find(node => node.textContent.trim() === '利润表');
    item?.click();
  });
  await new Promise(resolve => setTimeout(resolve, 1000));
  const reportText = await page.evaluate(() => document.body.innerText);
  console.log('profit-page:', reportText.includes('营业收入') ? 'PASS' : 'FAIL');
  await page.evaluate(() => {
    const item = [...document.querySelectorAll('.el-menu-item')].find(node => node.textContent.trim() === '经营驾驶舱');
    item?.click();
  });
  await new Promise(resolve => setTimeout(resolve, 900));
  await page.evaluate(() => {
    const button = [...document.querySelectorAll('button')].find(node => node.textContent.includes('查看全部'));
    button?.click();
  });
  await new Promise(resolve => setTimeout(resolve, 900));
  const ratioText = await page.evaluate(() => document.body.innerText);
  console.log('ratio-page:', ratioText.includes('短期偿债能力') ? 'PASS' : 'FAIL');
  await page.evaluate(() => {
    const item = [...document.querySelectorAll('.el-menu-item')].find(node => node.textContent.trim() === '数据导入');
    item?.click();
  });
  await new Promise(resolve => setTimeout(resolve, 900));
  const importText = await page.evaluate(() => document.body.innerText);
  console.log('import-page:', importText.includes('批量导入') ? 'PASS' : 'FAIL');
  await page.evaluate(() => {
    const item = [...document.querySelectorAll('.el-menu-item')].find(node => node.textContent.trim() === '编码映射');
    item?.click();
  });
  await new Promise(resolve => setTimeout(resolve, 900));
  const mapperText = await page.evaluate(() => document.body.innerText);
  console.log('mapper-page:', mapperText.includes('原始报表字段') ? 'PASS' : 'FAIL');
  await page.evaluate(() => {
    const item = [...document.querySelectorAll('.el-menu-item')].find(node => node.textContent.trim() === '数据转换');
    item?.click();
  });
  await new Promise(resolve => setTimeout(resolve, 1200));
  const conversionText = await page.evaluate(() => document.body.innerText);
  console.log('conversion-page:', conversionText.includes('转换结果') && conversionText.includes('标准编码') ? 'PASS' : 'FAIL');
  await page.evaluate(() => {
    const item = [...document.querySelectorAll('.el-menu-item')].find(node => node.textContent.trim() === '经营驾驶舱');
    item?.click();
  });
  await new Promise(resolve => setTimeout(resolve, 1500));
  const canvasCount = await page.$$eval('canvas', nodes => nodes.length);
  console.log('dashboard-charts-return:', canvasCount >= 2 ? 'PASS' : `FAIL (canvas=${canvasCount})`);
  await page.screenshot({
    path: path.join(__dirname, 'web-report.png'),
    fullPage: true
  });
  if (errors.length) {
    console.error('Browser errors:');
    errors.forEach(error => console.error(error));
    process.exitCode = 1;
  }
  await browser.close();
}

main().catch(error => {
  console.error(error);
  process.exit(1);
});
