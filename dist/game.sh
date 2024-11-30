#!/bin/bash

echo "请输入您的姓名:"
#read name
name=$1
channel=$2
echo "您好，$name,欢迎来到 $channel!"
# 这里用`shuf -i 1-10 -n 1`也可以
number=$(shuf -i 1-10 -n 1)
echo $number
# while循环用法，很简单!
while true
do
    echo "请输入1-10的数字"
    read guess
    if [[ $guess -eq $number ]] ; then
        echo "你猜对了! 是否继续？(y/n) : "
        read choice
        # 使用双等号 == 进行字符串比较，并且保持一致性
        if [[ $choice == "y" || $choice == "Y" ]]; then
            number=$((RANDOM % 10 + 1)) # 生成新的随机数
            echo $number # 方便演示观察
            continue
        elif [[ $choice == "n" || $choice == "N" ]]; then
            break # 如果用户选择不继续，则跳出循环
        else
            echo "无效的输入，请输入 y 或 n."
            continue # 如果输入不是 y/Y 或 n/N，则让用户重新输入
        fi
    elif [[ $guess -lt $number ]]; then
        echo "小了"
    elif [[ $guess -gt $number ]]; then
        echo "大了"
    else
        echo "无效的输入，请输入1-10之间的数字。"
    fi
done