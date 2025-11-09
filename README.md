<img width="1122" height="705" alt="image" src="https://github.com/user-attachments/assets/319f4090-53ba-4706-9dc3-8b5995d43205" />
# 🧰 1. Atualize o sistema

      sudo apt update && sudo apt upgrade -y
# 🖥️ 2. Instale o ambiente gráfico leve (Openbox + Xorg dummy

      sudo apt install -y xserver-xorg-video-dummy xserver-xorg-core xinit openbox feh x11vnc
# 🌄 3. Configure o Xorg com driver dummy
      sudo mkdir -p /etc/X11/xorg.conf.d
      sudo nano /etc/X11/xorg.conf.d/99-dummy.conf
Cole o seguinte:

      Section "Monitor"
          Identifier "Monitor0"
          HorizSync 28.0-80.0
          VertRefresh 48.0-75.0
          Modeline "1920x1080" 172.80 1920 2040 2248 2576 1080 1081 1084 1118
      EndSection

      Section "Device"
          Identifier "Card0"
          Driver "dummy"
          VideoRam 256000
      EndSection

      Section "Screen"
          Identifier "Screen0"
          Device "Card0"
          Monitor "Monitor0"
          DefaultDepth 24
          SubSection "Display"
              Depth 24
              Modes "1920x1080"
          EndSubSection
      EndSection
      
# 🔊 4. Instale e configure o PulseAudio

      sudo apt install -y pulseaudio
No script de inicialização, adicione:

      export XDG_RUNTIME_DIR="/run/user/$(id -u)"
      mkdir -p "$XDG_RUNTIME_DIR"
      pulseaudio --start




# 🌞 5. Instale o Sunshine
Baixe o pacote .deb mais recente do site oficial do Sunshine e instale:

      sudo dpkg -i sunshine-*.deb
      sudo apt install -f  # para resolver dependências



# 📡 6. Configure o VNC
O x11vnc já foi instalado. Para iniciar:

      x11vnc -display :1 -nopw -forever -shared -bg



# 🧾 7. Crie o script de inicialização
Salve como /home/SEU_USUARIO/iniciar-ambiente.sh:


Dê permissão de execução:

chmod +x /home/SEU_USUARIO/iniciar-ambiente.sh



# 🔁 8. (Opcional) Crie um serviço systemd
      sudo nano /etc/systemd/system/ambiente-grafico.service


Conteúdo:

         [Unit]
      Description=Ambiente gráfico virtual com Sunshine e VNC
      After=network.target

      [Service]
      Type=simple
      User=SEU_USUARIO
      Environment=DISPLAY=:1
      Environment=XDG_RUNTIME_DIR=/run/user/1000
      ExecStart=/home/SEU_USUARIO/iniciar-ambiente.sh
      Restart=always

      [Install]
      WantedBy=multi-user.target


Ative com:

      sudo systemctl daemon-reload
      sudo systemctl enable ambiente-grafico.service
      sudo systemctl start ambiente-grafico.service



Se quiser, posso te ajudar a adicionar suporte para áudio remoto via PipeWire ou configurar o Sunshine para autenticação automática.



# 🛠️ 8. Crie o arquivo de serviço
Como root, execute:

      nano /etc/systemd/system/ambiente-grafico.service

E cole o seguinte conteúdo:

      
    [Unit]
    Description=Ambiente gráfico virtual com Sunshine e VNC
    After=network.target

    [Service]
    Type=simple
    User=astral
    Environment=DISPLAY=:1
    Environment=XDG_RUNTIME_DIR=/run/user/1000
    ExecStart=/home/astral/iniciar-ambiente.sh
    Restart=always

    [Install]
    WantedBy=multi-user.target

#  📄 9. Dê permissão de execução ao scrip

    chmod +x /home/astral/iniciar-ambiente.sh

 # 🚀 10. Ative e inicie o serviç

    systemctl daemon-reexec
    systemctl daemon-reload
    systemctl enable ambiente-grafico.service
    systemctl start ambiente-grafico.service
  Se tudo estiver certo, o ambiente gráfico virtual será iniciado automaticamente após o boot.

  
<img width="1384" height="925" alt="image" src="https://github.com/user-attachments/assets/db57aefe-5d1a-4601-87a0-18fcd8b538b5" />
acess Moonlight


  
