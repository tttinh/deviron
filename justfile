dev: devdown devup devin

dev-clean: devdown devup-no-cache devin

devup:
  devcontainer up --workspace-folder .

devup-no-cache:
  devcontainer up --build-no-cache --workspace-folder .

devdown:
  docker ps -aq --filter label=devcontainer.local_folder={{justfile_directory()}} | xargs -r docker rm -f

devin *args='zsh':
  devcontainer exec --workspace-folder . {{args}}
