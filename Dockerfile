# 第一阶段：获取静态二进制文件
FROM alpine:latest AS downloader

# 在alpine容器中下载并解压btop的静态二进制发布包
RUN wget https://github.com/aristocratos/btop/releases/download/v1.3.0/btop-x86_64-linux-musl.tbz -O /btop.tbz && \
    tar -xjf /btop.tbz -C /tmp && \
    mv /tmp/btop/bin/btop /btop-static && \
    rm -f /btop.tbz && \
    rm -rf /tmp/btop


# 第二阶段：构建最终极简镜像
FROM scratch

# 从上一阶段只复制btop二进制文件
COPY --from=downloader /btop-static /btop

# 配置字符编码环境
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
# 终端类型和颜色支持
ENV TERM=xterm-256color

# 运行btop
ENTRYPOINT ["/btop"]