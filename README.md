## linux命令
- 切换到根目录cd /
- 切换到用户目录cd ~

毕业项目经历笔记
Controller 层的职责应该仅仅是处理请求和返回结果，不应该包含复杂的业务逻辑。
Service 层的职责是管理业务逻辑，将判断逻辑放在 UserService 层更符合分层架构设计。

改jsp不用mvn
改java代码不用mvn但是需要重新运行tomcat

想改的话只需要改controller 里的request mapping的路径，并改访问的页面地址即可

启动数据库


Admin 的用户管理模块
add
delete
edit
query all one

Admin 的数据分析和统计模块 的系统日志和操作记录
自动记录✅
显示所有✅
删除指定✅
搜索指定✅
页面显示✅



我这个图书管理系统分为两个层面，第一个是admin，第二个是user。不同权限的用户登录进入不同的页面。现在admin用户页面的数据分析和统计模块下面的用户行为分析页面功能还没做你给我一点思路




rar a archive.rar 文件名或文件夹 多个留空

unrar x archive.rar

# --------
记录


admin专有功能

add
delete
edit
all users







# 图书管理系统开发工作流程指南

## 目录
- [工作环境设置](#工作环境设置)
- [分支策略](#分支策略)
- [开发流程](#开发流程)
- [常用命令](#常用命令)
- [最佳实践](#最佳实践)

## 工作环境设置

### 开发工具
- **Cursor编辑器**：主要代码编写工具
- **其他IDE**：代码运行和测试环境

### 分支结构
- `master`：稳定版本分支
- `cursor`：开发测试分支

## 分支策略

### master 分支
- 用途：存放稳定、已测试的代码
- 特点：只接受经过测试的合并请求
- 操作：不直接在此分支开发

### cursor 分支
- 用途：日常开发和测试
- 特点：可以自由提交和修改
- 操作：所有新功能在此分支开发

## 开发流程

### 在 Cursor 编辑器中（开发）

1. **确认分支**
```bash
git checkout cursor
```

2. **代码提交**
```bash
git add .
git commit -m "功能描述"
git push origin cursor
```

### 在其他 IDE 中（测试）

1. **获取代码**
- 选择 "从 'origin/cursor' 新建分支..."
- 或使用命令：
```bash
git checkout cursor
git pull origin cursor
```

2. **测试流程**
- 运行代码
- 进行功能测试
- 检查运行效果

3. **合并到主分支**
```bash
git checkout master
git merge cursor
git push origin master
```

## 常用命令

### 分支操作
```bash
# 查看所有分支
git branch -a

# 切换分支
git checkout [分支名]

# 创建并切换分支
git checkout -b [分支名]
```

### 代码同步
```bash
# 提交代码
git add .
git commit -m "提交说明"

# 推送到远程
git push origin [分支名]

# 拉取更新
git pull origin [分支名]
```

## 最佳实践

### 开发建议
1. 保持 master 分支代码稳定
2. 定期推送 cursor 分支更新
3. 提交信息要清晰明确
4. 先测试再合并到 master

### 日常工作流程
1. 在 Cursor 中开发新功能
2. 提交到 cursor 分支
3. 在其他 IDE 中测试
4. 测试通过后合并到 master

### 注意事项
- 切换分支前先提交或暂存更改
- 定期同步远程代码
- 解决冲突时保持代码完整性
- 重要更改前先备份