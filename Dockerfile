# 第一阶段：获取静态二进制文件
FROM alpine:latest AS downloader

# 声明目标平台架构，由 Docker BuildKit 自动传入
ARG TARGETARCH

# 指定btop版本
ARG BTOP_VERSION=1.4.8

# 在alpine容器中下载并解压btop的静态二进制发布包
RUN apk add --no-cache wget tar && \
    set -eux; \
    case "${TARGETARCH}" in \
        amd64) BTOP_ARCH="x86_64" ;; \
        arm64) BTOP_ARCH="aarch64" ;; \
        *) echo "不支持的目标架构: ${TARGETARCH}"; exit 1 ;; \
    esac; \
    wget "https://github.com/aristocratos/btop/releases/download/v${BTOP_VERSION}/btop-${BTOP_ARCH}-unknown-linux-musl.tar.gz" -O /btop.tar.gz; \
    mkdir -p /tmp/btop; \
    tar -xzf /btop.tar.gz -C /tmp/btop; \
    find /tmp/btop -type f -name btop -exec cp {} /btop-static \;; \
    test -s /btop-static; \
    chmod +x /btop-static; \
    rm -f /btop.tar.gz; \
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
