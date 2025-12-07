# btop-docker

### 运行btop
```
docker run -it --rm \
  --net host \
  --pid host \
  --ipc host \
  --log-driver none \
  --cap-drop=ALL \
  stu2116edwardhu/btop
```

### btop交互

- 输入 `m` 或按下 `Esc` 弹出主菜单  
- 使用**上下箭头按钮**选中目标进程，按下 `t` 即可终止进程
- 选中目标进程按下 `s` 在弹出的信号列表里，输入或选择信号编号就能给对应进程发送 `SIGKILL` 之外的其他信号


### 其他主题的btop
```
docker run -it --rm --net host --pid host --ipc host --log-driver none --cap-drop=ALL defnotgustavom/btop
```
