dev: devdown devup devin

devup:
  devcontainer up --workspace-folder .

devdown:
  docker rm -f $(docker ps -q --filter label=devcontainer.local_folder={{justfile_directory()}})

devin *args='zsh':
  devcontainer exec --workspace-folder . {{args}}
