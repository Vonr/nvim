#!/bin/sh

dir="${HOME}/.local/share/nvim/lsp_servers/jdtls"
jar="${dir}/plugins/org.eclipse.equinox.launcher_*"

/usr/lib/jvm/java-17-graalvm-ee/bin/java \
    -javaagent:"${HOME}/.local/bin/lombok.jar" \
    -Xbootclasspath/a:"${HOME}/.local/bin/lombok.jar" \
    -Declipse.application=org.eclipse.jdt.ls.core.id1 \
    -Dosgi.bundles.defaultStartLevel=4 \
    -Declipse.product=org.eclipse.jdt.ls.core.product \
    -Dlog.protocol=true \
    -Dlog.level=ALL \
    -Xms1g \
    -jar "$(eval echo "$jar")" \
    -configuration "${dir}/config_linux" \
    -data "$1" \
    --add-modules=ALL-SYSTEM \
    --add-opens java.base/java.util=ALL-UNNAMED \
    --add-opens java.base/java.lang=ALL-UNNAMED
