# clash

maomao 的 clash 配置文件（分开管理代理规则和订阅，防止自定义规则被覆盖）

> 配置说明

1. 使用 `proxy-providers` 自动更新订阅链接
2. 自行添加 `rules` 规则
3. `rule-providers` 来自于 [clash-rules | GitHub](https://github.com/Loyalsoldier/clash-rules)
4. 仅保留新加坡节点
5. 客户端 [Clash Verge](https://github.com/clash-verge-rev/clash-verge-rev)

### 使用注意

当使用配置文件提示 `CloudConfig.yaml` 解析错误时，**请检查订阅链接是否已修改或是否可用（浏览器访问会下载 `yaml` 格式的文件）**

> 尽量新建配置文件进行修改

1. 在 Mac 时使用直接修改订阅地址导入即可
2. 在 Windows 时：
   1. 先手动导入订阅地址
   2. 再将其生成的配置文件复制并重命名为 `CloudConfig.yaml`（也可直接重命名）
   3. 最后直接导入本规则即可使用

### 转换链接方案

- [Lainbo 订阅转换](https://sub.lainbo.com/)

详细说明可参考[Clash Verge 系列使用最佳实践](https://lainbo.com/article/clash-config)

## 相关链接

- [Clash 知识库](https://clash.wiki/)
- [clash-rules | GitHub](https://github.com/Loyalsoldier/clash-rules)
- [什么是 rule-provider 、proxy-provider？怎么用？clash 分流规则终极使用方法](https://jamesdaily.life/rule-proxy-provider)
