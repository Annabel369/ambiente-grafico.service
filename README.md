# 🛠️ 1. Crie o arquivo de serviço
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

#  📄 2. Dê permissão de execução ao scrip

    chmod +x /home/astral/iniciar-ambiente.sh

 # 🚀 3. Ative e inicie o serviç

    systemctl daemon-reexec
    systemctl daemon-reload
    systemctl enable ambiente-grafico.service
    systemctl start ambiente-grafico.service
  Se tudo estiver certo, o ambiente gráfico virtual será iniciado automaticamente após o boot.

  
