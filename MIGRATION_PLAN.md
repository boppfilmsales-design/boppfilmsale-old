# 东渐网站（boppfilmsale）迁移路线图
> ASP + Access 老站 → Vercel + Supabase 现代化改造方案（草稿）
> 整理日期：2026-07-16 ｜ 当前状态：GitHub 已存档，迁移待定

---

## 0. 当前资产盘点（已确认）

| 项目 | 现状 |
|------|------|
| 源码位置 | 桌面 `web-东渐网站源码` |
| Git 仓库 | https://github.com/boppfilmsales-design/boppfilmsale-old （master 分支，已 push） |
| 技术栈 | 经典 ASP（VBScript）+ Access（Jet OLEDB 4.0） |
| 语言版本 | `c_*` 中文前台、`e_*` 英文前台；后台在 `huiguer.com/c_*.asp`、`e_*.asp` |
| 数据库 | Access `.mdb`，表前缀 `yuzhiguo_*`（管理员/产品大类/产品小类/产品/新闻/订单/留言/友链等） |
| 图片 | `pic/`（202MB）、`images/` 已排除在 git 外，本地保留，待走对象存储 |
| 第三方 | `aspnet_client`、`HttpErrors`、`huiguerdata`、`yuzhiguoeditor` 已 gitignore |

---

## 1. ⚠️ 必须先处理的安全问题（高危）

**`conn.asp` 内被发现植入黑帽 SEO 劫持代码：**
- 检测搜索引擎 UA（baidu/360/bing/sogou/sm/yisou/haosou）
- 对爬虫：用 `Microsoft.XMLHTTP` 从 `http://154.222.122.37/`、`http://154.222.122.34/` 抓取内容并替换页面，或 302 重定向到上述 IP
- 这是典型的 **cloaking / 搜索引擎劫持后门**，会导致域名被百度/Google 拉黑

**处理动作（迁移前必做）：**
1. 重写 `conn.asp`，**只保留纯数据库连接逻辑**，删除所有 `GetBot` / `getHTTPPage` / 重定向相关代码
2. 全仓库搜索 `154.222.122` 等特征字符串，确认无残留
3. 更换后台管理员密码（原 MD5 在 `yuzhiguo_administrator` 表，已被拖库风险）
4. 检查 `Global.asa`、`pub/*.asp` 是否有类似后门

---

## 2. 为什么不能直接上 Vercel

| 组件 | Vercel 支持？ | 原因 |
|------|--------------|------|
| `.asp` / `Global.asa` | ❌ | Vercel 无 IIS/ASP 运行时 |
| Access `.mdb` | ❌ | Vercel 无持久文件系统，且 ASP 才连得了 |
| `.html` 静态页 | ✅ | 纯静态可直接托管 |
| `css/`、`js/` | ✅ | 静态资源 |

**结论**：必须重写后端，Vercel 只适合托管"前端 + Serverless 函数"，数据库必须外置（Supabase 是正确选择）。

---

## 3. 目标架构

```
浏览器
  │
  ▼
Vercel (前端静态 + Serverless API)
  ├─ 静态：产品/新闻/关于 等页面（由原 .html 改造或重做）
  └─ API（/api/*，Node/Edge Functions）
        │
        ▼
Supabase（PostgreSQL + Auth + Storage）
  ├─ 数据库：原 Access 表迁移过来
  ├─ 后台登录：Supabase Auth 替代原管理员表
  └─ 图片：Supabase Storage 替代 pic/、images/
```

---

## 4. 迁移步骤（分阶段）

### 阶段 0：净化与备份（1–2 天）
- [ ] 清理 `conn.asp` 等后门（见第 1 节）
- [ ] 完整备份 Access `.mdb` 数据库文件
- [ ] 导出全部表结构 + 数据（用于阶段 2 迁移）
- [ ] 盘点所有动态功能清单（见第 5 节）

### 阶段 1：技术选型（决策）
建议栈（任选其一）：
- **方案 A（轻量）**：Next.js（React）+ Supabase JS SDK
  - 适合：想一次搞定前后台、SEO 友好（SSR）
- **方案 B（极简）**：Astro + Supabase
  - 适合：内容站为主、后台用独立 admin 面板
- **方案 C（沿用 ASP 思维）**：Node + Express + Supabase + 原生 HTML 模板
  - 适合：想尽量贴近原代码结构、降低重写成本

> 推荐 **方案 A（Next.js + Supabase）**：Vercel 原生支持、SSR 利于 SEO、生态成熟。

### 阶段 2：数据库迁移 Access → Supabase Postgres（2–4 天）
- [ ] 在 Supabase 建 project
- [ ] 用脚本（Python `pyodbc` 读 mdb + `supabase` 写）或中间格式（CSV/SQL）迁移
- [ ] 表映射（示例）：
  | 原 Access 表 | Supabase 表 | 备注 |
  |---|---|---|
  | `yuzhiguo_administrator` | `admin_users`（或 Supabase Auth） | 密码需重新哈希（bcrypt/argon2） |
  | `yuzhiguo_big_class` | `product_categories` | 大类 |
  | `yuzhiguo_small_class` | `product_subcategories` | 小类 |
  | `yuzhiguo_products` | `products` | 产品主表 |
  | `yuzhiguo_news` | `news` | 新闻 |
  | `yuzhiguo_order` | `orders` | 订单 |
  | `yuzhiguo_feedback` | `feedback` | 留言 |
  | `yuzhiguo_link` | `links` | 友链 |
- [ ] 中英文字段合并或分 `lang` 列（原站 `c_*` / `e_*` 是两套逻辑，建议统一为 `lang` 字段）

### 阶段 3：后端 API 重写（ASP → Node Serverless，3–6 天）
- [ ] 用 Next.js Route Handlers / API Routes 重写原 `c_*.asp` 的后台逻辑
- [ ] 认证：Supabase Auth 替代 `check.asp` + session
- [ ] 文件上传：Supabase Storage 替代原 `huiguerdata` / 编辑器上传
- [ ] 防注入：原 ASP 拼接 SQL 严重（如 `sql="... where name='"&name&"'"`），全部改用参数化查询

### 阶段 4：前端页面改造（3–7 天）
- [ ] 静态部分（首页/产品展示/新闻）用 React/Astro 组件化
- [ ] 保留原 `css/` 样式风格（可延用 `.css` 文件）
- [ ] 中英文切换改为 `?lang=` 或路由 `/cn` `/en`
- [ ] 图片：上传 Supabase Storage，页面引用 CDN URL

### 阶段 5：后台管理界面重做（3–5 天）
- [ ] 产品/新闻/订单/留言/友链 CRUD
- [ ] 管理员权限（原 `power` 字段逻辑简化）
- [ ] 富文本编辑器替换 `yuzhiguoeditor`（用 TipTap / Quill）

### 阶段 6：部署与验证（1–2 天）
- [ ] Vercel 连接 GitHub 仓库（建议新仓库放 Next.js 代码，本仓库作为源码归档）
- [ ] 配置环境变量（Supabase URL / Anon Key / Service Key）
- [ ] 自定义域名 + HTTPS
- [ ] 提交 sitemap、百度/Google 站长平台重新收录（因曾劫持，需申诉恢复）

---

## 5. 现有动态功能清单（待迁移）

| 模块 | 前台 | 后台 | 复杂度 |
|------|------|------|--------|
| 产品展示 | `c_products/`, `c_products_show/` | `huiguer.com/c_products.asp` | 高（分类+详情+搜索） |
| 新闻 | `c_news/`, `c_news_show/` | `huiguer.com/c_news.asp` | 中 |
| 订单 | `c_order/` | `huiguer.com/c_order.asp` | 中（含表单提交） |
| 留言/反馈 | `c_feedback/` | `huiguer.com/c_feedback.asp` | 低 |
| 单页栏目 | `c_info/`, `html_info/` | `huiguer.com/c_lanmu.asp` | 低 |
| 导航管理 | — | `c_menu.asp`, `c_link.asp` | 低 |
| 友情链接 | — | `c_link.asp` | 低 |
| 后台管理员 | — | `administrator.asp` | 低 |
| 英文版 | `e_*` 全套 | `e_*.asp` 全套 | 同中文 |

---

## 6. 工作量与成本粗估

| 角色 | 估算人天 | 说明 |
|------|---------|------|
| 净化+备份 | 1–2 | 安全必做 |
| 数据库迁移 | 2–4 | 取决于数据量 |
| 后端 API | 3–6 | 核心工作量 |
| 前端改造 | 3–7 | 视还原度 |
| 后台重做 | 3–5 | |
| 部署验证 | 1–2 | |
| **合计** | **13–26 人天** | 约 3–5 周（单人） |

**成本**：
- Vercel：Hobby 免费 / Pro $20/月
- Supabase：Free tier 够用 / Pro $25/月
- 域名：已有（续费成本）
- 无服务器费用（Serverless 按量，小站几乎免费）

---

## 7. 决策建议

- **如果只想要"网站能打开"**：先做静态版（阶段 4 简化 + 阶段 6），1 周内上线，后台暂缓。
- **如果要完整前后台**：按阶段 0–6 走，预计 3–5 周。
- **如果预算有限**：可先用 Supabase 托管数据 + 最小后台，前台用 Astro 静态生成。

---

## 8. 待用户确认的事项
- [ ] 是否继续推进迁移？还是仅存档？
- [ ] 技术栈偏好（Next.js / Astro / 其它）？
- [ ] 是否自有无服务器开发能力，或需要外包/协助？
- [ ] 后台必须 100% 还原原功能，还是可以简化？
- [ ] 图片资源（pic/ 202MB）如何处理——全部上 Supabase Storage，还是只传在用部分？
