# 现代 Web 管理端

技术栈：Vue 3、Vite、Element Plus、ECharts、Axios。

## 开发运行

后端先启动在 `8006`，然后：

```powershell
cd D:\code\CodexProgram\ShixunCode\financial-analysis\web
npm install
npm run dev
```

打开 Vite 输出的地址，通常是：

```text
http://localhost:5173/
```

开发地址会自动请求 `http://localhost:8006/api`。

## 构建并集成到后端

```powershell
cd D:\code\CodexProgram\ShixunCode\financial-analysis\web
npm run build
Copy-Item -Recurse -Force .\dist\* ..\backend\src\main\resources\static\web
cd ..\backend
mvn -B -DskipTests package
```

集成后的访问地址：

```text
http://localhost:8006/web/
```

## 页面

- 经营驾驶舱
- 利润表、资产负债表、现金流量表、科目余额表
- 账龄分析
- 单表/批量导入
- 公司、用户、角色、菜单、系统字典
- 编码字典、算法配置、数据转换
- 资讯管理
- 四类财务比率
