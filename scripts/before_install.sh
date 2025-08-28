hooks:
  BeforeInstall:
    - location: scripts/create_directory.sh
      timeout: 60
      runas: ubuntu
    - location: scripts/stop_server.sh
      timeout: 60
      runas: ubuntu

