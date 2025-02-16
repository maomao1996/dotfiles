const fs = require('fs').promises
const path = require('path')

async function getRealDomain() {
  try {
    const response = await fetch('https://www.88ys.cn', {
      redirect: 'follow',
      timeout: 10000
    })

    const finalUrl = response.url
    const domainMatch = finalUrl.match(/https?:\/\/(?:www\.)?([^/]+)/)

    if (domainMatch) {
      return domainMatch[1]
    }
  } catch (error) {
    console.error(`获取域名时出错: ${error.message}`)
    return null
  }

  return null
}

async function updateRuleFile() {
  // 获取新域名
  const newDomain = await getRealDomain()
  if (!newDomain) {
    console.log('无法获取新域名')
    return false
  }

  const rulePath = path.join(process.cwd(), 'clash/rule/direct.list')

  try {
    // 检查文件是否存在
    await fs.access(rulePath)

    // 读取当前文件内容
    let content = await fs.readFile(rulePath, 'utf-8')

    // 查找88影视网相关规则块
    const pattern = /# \[88影视网\].*?\n(?:DOMAIN-SUFFIX,[^\n]+\n)*/

    // 构建新的规则
    const newRule = `# [88影视网](https://www.88ys.cn)\nDOMAIN-SUFFIX,${newDomain}\n`

    // 更新内容
    let updatedContent
    if (pattern.test(content)) {
      updatedContent = content.replace(pattern, newRule)
    } else {
      updatedContent = content.trim() + '\n\n' + newRule
    }

    // 写入更新后的内容
    await fs.writeFile(rulePath, updatedContent, 'utf-8')
    console.log(`已更新规则: ${newDomain}`)
    return true
  } catch (error) {
    if (error.code === 'ENOENT') {
      console.log('规则文件不存在')
    } else {
      console.error(`更新规则时出错: ${error.message}`)
    }
    return false
  }
}

// 执行更新
updateRuleFile().catch(console.error)
