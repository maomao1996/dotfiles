# Clash

maomao 的 clash 配置文件

> 配置说明

- [远程配置文件 `remote.ini` (个人主要使用)](/clash/remote/)
- [本地配置文件 `config.yaml`](/clash/yaml)

推荐本人[自用机场](https://xn--clouds-o43k.com/#/register?code=07YceqZM) 便宜量大稳定 10 元每月 1T 流量（已使用好几年）

## 添加自定义规则

- 点击【订阅】
- 编辑【全局扩展脚本】

```js
function main(config) {
  const prependRules = [
    // 添加自定义规则
    'DOMAIN-SUFFIX,notes.fe-mm.com,🎯 全球直连',
    'DOMAIN-SUFFIX,fe-mm.com,✈️ 节点选择'
  ]

  if (config.rules?.length) {
    config.rules = prependRules.concat(config.rules)
  }

  return config
}
```

## Clash Verge 日志占用大量磁盘空间

在默认情况下，Clash Verge 日志会一直保留在磁盘中，其会导致磁盘空间逐渐被占用，从而影响系统性能

<img width="575" alt="image" src="https://github.com/user-attachments/assets/53c7884a-fdf1-47be-a97b-33e424b55e13">

**解决方案:**

- 设置 Clash Verge 日志自动清理（默认不清理）
- 设置日志等级为 `warn` 或其他

- [[BUG] 缩短日志最长保留时间](https://github.com/zzzgydi/clash-verge/issues/713)

## 相关链接

- [Clash 知识库](https://clash.wiki/)
- [clash-rules | GitHub](https://github.com/Loyalsoldier/clash-rules)
- [什么是 rule-provider 、proxy-provider？怎么用？clash 分流规则终极使用方法](https://jamesdaily.life/rule-proxy-provider)
