#!/bin/bash

echo "🔧 Finalizando instâncias antigas..."
pkill -f "Xorg :1"
pkill -f "Xvfb :1"
pkill -f "sunshine"
pkill -f "pulseaudio"
rm -f /tmp/.X1-lock /tmp/.X11-unix/X1

echo "🖥️ Iniciando Xorg com driver dummy..."
Xorg :1 -config /etc/X11/xorg.conf.d/99-dummy.conf &
sleep 2
export DISPLAY=:1

echo "🔊 Iniciando PulseAudio..."
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
mkdir -p "$XDG_RUNTIME_DIR"
pulseaudio --start

echo "🖼️ Aplicando papel de parede..."
feh --bg-scale /root/minecraft.jpg &

echo "🪟 Iniciando Openbox..."
openbox &

echo "🌞 Iniciando Sunshine..."
if ! ss -ltn | grep -q ":48010"; then
    /usr/bin/sunshine &
else
    echo "⚠️ Porta 48010 ocupada. Usando porta alternativa 48011..."
    cp /etc/sunshine/sunshine.conf /tmp/sunshine-alt.conf
    sed -i 's/"rtsp_port": 48010/"rtsp_port": 48011/' /tmp/sunshine-alt.conf
    SUNSHINE_CONFIG=/tmp/sunshine-alt.conf /usr/bin/sunshine &
fi

echo "📡 Iniciando VNC..."
x11vnc -display :1 -nopw -forever -shared -bg

echo "✅ Ambiente gráfico virtual iniciado com sucesso!"

# Mantém o script ativo se rodando em segundo plano
while true; do sleep 60; done
