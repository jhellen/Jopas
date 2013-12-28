isEmpty(VERSION_PRI_INCLUDED) {
  VERSION_PRI_INCLUDED=1
  GIT_SHA = $$system(git rev-parse --short HEAD)

  isEmpty(VERSION) {
      GIT_TAG = $$system(git describe --tags --abbrev=0)
      GIT_VERSION = $$find(GIT_TAG, ^\\d+(\\.\\d+)?(\\.\\d+)?$)
      isEmpty(GIT_VERSION) {
          ## warning("Can't find a valid git tag version, got: $$GIT_TAG")
          GIT_VERSION = 0.0.0
      }
      !isEmpty(GIT_VERSION): VERSION = $$GIT_VERSION
  }
  CONFIG_SUBST += VERSION GIT_SHA

}
