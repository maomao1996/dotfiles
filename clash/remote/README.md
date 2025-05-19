# clash 远程配置文件

maomao 的 clash 远程配置文件

> 配置说明

1. 白名单模式「**没有命中规则的网络流量，统统使用代理**」
2. 加入常用代理组
3. 扩展脚本设置来添加自定义规则（防止被覆盖）
4. 客户端 [Clash Verge](https://github.com/clash-verge-rev/clash-verge-rev)

推荐本人[自用机场](https://xn--cloud-cl5i.net/#/register?code=07YceqZM) 便宜量大稳定 10 元每月 1T 流量（已使用好几年）

## 代理组

> 名称后带 `自动` 的，会使用 `url-test` 自动选择最优节点
>
> 名称后带 `负载` 的，会使用 `load-balance` 负载均衡策略（分全局负载和地区负载）

- `✈️ 节点选择`
- `♻️ 自动选择`
- `🕹 手动选择`
- `🔮 负载均衡`
- `🖥️ AI编程`
- `🤖 AI专用`
- `📲 Telegram`
- `🕊️ Twitter(X)`
- `🍃 应用净化`
- `🛡️ 广告拦截`
- `🐟 漏网之鱼`
- `🇭🇰 香港自动`
- `🇭🇰 香港负载`
- `🇨🇳 台湾自动`
- `🇨🇳 台湾负载`
- `🇸🇬 狮城自动`
- `🇸🇬 狮城负载`
- `🇯🇵 日本自动`
- `🇯🇵 日本负载`
- `🇺🇸 美国自动`
- `🇺🇸 美国负载`
- `🇪🇺 欧洲自动`
- `🇪🇺 欧洲负载`
- `🎯 全球直连`

## 配置文件

- 默认配置 `config.ini`
  - `https://raw.githubusercontent.com/maomao1996/dotfiles/main/clash/remote/config.ini`
  - `https://jsdelivr.net/gh/maomao1996/dotfiles@main/clash/remote/config.ini`
- 广告拦截专用（无代理功能） `adblock-no-proxy.ini`
  - `https://raw.githubusercontent.com/maomao1996/dotfiles/main/clash/remote/adblock-no-proxy.ini`
  - `https://jsdelivr.net/gh/maomao1996/dotfiles@main/clash/remote/adblock-no-proxy.ini`

[配置文件字段说明 | subconverter](https://github.com/tindy2013/subconverter/blob/master/README-cn.md#%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6)

## 使用

1. 打开比较知名的转换网站
   1. **<https://maomao1996.github.io/subconverter-web/> (茂茂自用的 clash 远程配置文件转换工具)**
   2. <https://suburl.v1.mk/>
   3. <https://sub-web.netlify.app/>
   4. <https://acl4ssr-sub.github.io/>
2. 模式选择 `进阶模式`
3. 订阅地址输入 `机场给的订阅链接`
4. 客户端选择 `Clash`
5. 复制需要的[配置文件](#配置文件)，将其粘贴到 `远程配置文件` 中（出现的下拉框需要点击选中）
6. 点击 `转换`
7. 将生成的链接用于更新订阅

> 配置图

<img width="773" alt="配置图" src="https://github.com/user-attachments/assets/50f7d152-93d9-413e-9835-40388c21064e">

### 扩展脚本设置

1. 在订阅列表右键点击订阅
2. 点击 `扩展脚本` 或 `全局扩展脚本`
3. 输入以下内容

```js
// 添加自定义规则
const CUSTOM_RULES = [
  // '✈️ 节点选择'
  // '♻️ 自动选择'
  // '🕹 手动选择'
  // '🔮 负载均衡'
  // '🖥️ AI编程'
  // '🤖 AI专用'
  // '📲 Telegram'
  // '🕊️ Twitter(X)'
  // '🛡️ 广告拦截'
  // '🐟 漏网之鱼'
  // '🇭🇰 香港自动'
  // '🇭🇰 香港负载'
  // '🇨🇳 台湾自动'
  // '🇨🇳 台湾负载'
  // '🇸🇬 狮城自动'
  // '🇸🇬 狮城负载'
  // '🇯🇵 日本自动'
  // '🇯🇵 日本负载'
  // '🇺🇸 美国自动'
  // '🇺🇸 美国负载'
  // '🇪🇺 欧洲自动'
  // '🇪🇺 欧洲负载'
  // '🎯 全球直连'
  // 'DOMAIN-SUFFIX,notes.fe-mm.com,🎯 全球直连',
]

const cnDnsList = ['https://1.12.12.12/dns-query', 'https://223.5.5.5/dns-query']

// 大部分的网络请求都会走这个里面的，这里目前是腾讯、阿里、和使用节点查询的1.0.0.1的dns
const trustDnsList = [
  'https://doh.pub/dns-query', // 腾讯
  'https://dns.alidns.com/dns-query', // 阿里（这里会触发h3和普通的并发查询）
  '180.184.1.1' // 字节-火山引擎的DNS
]
const notionDns = 'tls://dns.jerryw.cn' // notion加速dns
const notionUrls = [
  'http-inputs-notion.splunkcloud.com',
  '+.notion-static.com',
  '+.notion.com',
  '+.notion.new',
  '+.notion.site',
  '+.notion.so'
]
const combinedUrls = notionUrls.join(',')

// 基础配置
const baseOption = {
  mode: 'rule',
  // ipv6 支持
  ipv6: true,
  // 允许局域网连接
  'allow-lan': true,
  // 统一延迟（更换延迟计算方式,去除握手等额外延迟）
  'unified-delay': true,
  // TCP 并发（同时对所有ip进行连接，返回延迟最低的地址）
  'tcp-concurrent': true,
  // 进程匹配模式
  'find-process-mode': 'strict',
  // 全局客户端指纹（随机指纹）
  'global-client-fingerprint': 'random',
  // 缓存
  profile: {
    'store-selected': true,
    'store-fake-ip': true
  },
  // 自动同步时间以防止时间不准导致无法正常联网
  ntp: {
    enable: true,
    'write-to-system': false,
    server: 'time.apple.com',
    port: 123
  },
  // 域名嗅探
  sniffer: {
    enable: true,
    sniff: {
      TLS: { ports: [443, 8443] },
      HTTP: { ports: [80, '8080-8880'] }
    }
  },
  // GeoIP 数据模式
  'geodata-mode': true,
  // Geo 文件加载器
  'geodata-loader': 'standard',
  // Geo 自动更新
  'geo-auto-update': true
}

const dnsOptions = {
  enable: false,
  // DOH 优先使用 http/3
  'prefer-h3': true,
  // 用于解析其他DNS服务器、和节点的域名, 必须为IP, 可为加密DNS。注意这个只用来解析节点和其他的dns，其他网络请求不归他管
  'default-nameserver': cnDnsList,
  nameserver: trustDnsList, // 其他网络请求都归他管
  'nameserver-policy': {
    [combinedUrls]: notionDns,
    'geosite:geolocation-!cn': trustDnsList
  }
}

const isObject = (value) => {
  return value !== null && typeof value === 'object'
}

const mergeConfig = (existingConfig, newConfig) => {
  if (!isObject(existingConfig)) {
    existingConfig = {}
  }
  if (!isObject(newConfig)) {
    return existingConfig
  }
  return { ...existingConfig, ...newConfig }
}

function main(config) {
  if (config.rules?.length) {
    config.rules = CUSTOM_RULES.concat(config.rules)
  }

  config.dns = mergeConfig(config.dns, dnsOptions)
  return { ...config, ...baseOption }
}
```

- config 参数说明： <https://raw.githubusercontent.com/dongchengjie/meta-json-schema/refs/heads/main/schemas/clash-verge-merge-json-schema.json>

## 相关链接

- [subconverter | GitHub](https://github.com/tindy2013/subconverter) 订阅转换
- [ios_rule_script | GitHub](https://github.com/blackmatrix7/ios_rule_script) 规则脚本
- [ACL4SSR | GitHub](https://github.com/ACL4SSR/ACL4SSR/tree/master) 规则集
- [clash-rules | GitHub](https://github.com/Loyalsoldier/clash-rules) 规则集
- [RemoteConfig - lainbo | GitHub](https://github.com/lainbo/gists-hub/tree/master/src/Clash/RemoteConfig)
- [Custom_OpenClash_Rules | GitHub](https://github.com/Aethersailor/Custom_OpenClash_Rules)
- [meta-rules-dat | GitHub](https://github.com/MetaCubeX/meta-rules-dat)
- [mihomo | GitHub](https://github.com/MetaCubeX/mihomo)
- [Clash Verge 系列使用最佳实践](https://lainbo.com/article/clash-config)
