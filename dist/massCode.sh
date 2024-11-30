#!/bin/bash

# 设置颜色输出
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 获取当前时间作为提交信息
current_time=$(date "+%Y-%m-%d %H:%M:%S")

# 检查是否在git仓库中
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo -e "${RED}错误：当前目录不是git仓库！${NC}"
    exit 1
fi

# 检查是否有改动
if [ -z "$(git status --porcelain)" ]; then
    echo -e "${BLUE}没有检测到任何改动，无需提交。${NC}"
    exit 0
fi

# 执行 git 命令
echo -e "${BLUE}添加改动文件...${NC}"
git add .

# 提交更改，使用当前时间作为提交信息
echo -e "${BLUE}提交改动...${NC}"
git commit -m "Update: $current_time"

# 先尝试 pull
echo -e "${BLUE}正在从远程仓库拉取更新...${NC}"
if git pull origin main; then
    echo -e "${BLUE}正在推送到远程仓库...${NC}"
    if git push origin master; then
        echo -e "${GREEN}✅ 上传成功！${NC}"
    else
        echo -e "${RED}❌ 推送失败，请检查错误信息${NC}"
        exit 1
    fi
else
    echo -e "${RED}❌ 拉取更新失败，请检查错误信息${NC}"
    exit 1
fi

# 等待用户按键继续
read -n 1 -s -r -p "按任意键继续..."
echo