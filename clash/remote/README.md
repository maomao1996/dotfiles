# clash 远程配置文件

maomao 的 clash 远程配置文件

> 配置说明

1. 使用 `ruleset` 自动更新远程规则
2. 加入常用代理组

## 代理组

- `✈️ 节点选择`
- `🌿 自动选择`
- `🖥️ AI编程`
- `🤖 AI专用`
- `📲 Telegram`
- `🕊️ Twitter(X)`
- `🛡️ 广告拦截`
- `🍃 应用净化`
- `🐟 漏网之鱼`
- `🇭🇰 香港自动`
- `🇨🇳 台湾自动`
- `🇸🇬 狮城自动`
- `🇯🇵 日本自动`
- `🇺🇸 美国自动`
- `🇪🇺 欧洲自动`
- `🎯 全球直连`

## 使用

1. 打开比较知名的转换网站
   1. <https://suburl.v1.mk/>
   2. <https://sub-web.netlify.app/>
   3. <https://acl4ssr-sub.github.io/>
2. 模式选择 `进阶模式`
3. 订阅地址输入 `机场给的订阅链接`
4. 客户端选择 `Clash`
5. 将以下链接复制到 `远程配置文件` 中（出现的下拉框需要点击选中）
   1. `https://raw.githubusercontent.com/maomao1996/dotfiles/main/clash/remote/config.ini`
   2. `https://jsdelivr.net/gh/maomao1996/dotfiles@main/clash/remote/config.ini`
6. 点击 `转换`
7. 将生成的链接用于更新订阅

### 扩展脚本设置

1. 在订阅列表右键点击订阅
2. 点击 `扩展脚本`
3. 输入以下内容

```js
// 添加自定义规则
const CUSTOM_RULES = [
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

- [ios_rule_script | GitHub](https://github.com/blackmatrix7/ios_rule_script)
- [ACL4SSR | GitHub](https://github.com/ACL4SSR/ACL4SSR/tree/master)
- [clash-rules | GitHub](https://github.com/Loyalsoldier/clash-rules)
- [RemoteConfig - lainbo | GitHub](https://github.com/lainbo/gists-hub/tree/master/src/Clash/RemoteConfig)
- [Custom_OpenClash_Rules | GitHub](https://github.com/Aethersailor/Custom_OpenClash_Rules)
- [meta-rules-dat | GitHub](https://github.com/MetaCubeX/meta-rules-dat)
- [mihomo | GitHub](https://github.com/MetaCubeX/mihomo)
- [Clash Verge 系列使用最佳实践](https://lainbo.com/article/clash-config)
