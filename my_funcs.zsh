#
# addPath - function to manage PATH
#
# Examples
#   addPath "/opt/local/bin"
#   addPath -b -e HOME
#
function addPath {
  local ADDPATH BEFORE VAR before
  local AFTER=default
  local -a envvar

  # parse opts
  zparseopts -K -D b=before e:=envvar

  # determine before/after
  if [[ "${before}" == "-b" ]]
  then
    BEFORE=default
    AFTER=
  else
    BEFORE=
    AFTER=default
  fi

  if [[ "${envvar[1]}" == "-e" ]]
  then
    VAR=$(eval echo \$${envvar[2]})
    if [[ -d "${VAR}/bin" ]]
    then
      ADDPATH="${VAR}/bin"
    elif [[ -d "${VAR}" ]]
    then
      ADDPATH="${VAR}"
    else
      ADDPATH=
    fi
  fi

  if [[ "$#" == "1" ]]
  then
    ADDPATH=$1
  fi

  if [[ -n "${ADDPATH}" ]]
  then
    if [[ -n "${BEFORE}" ]]
    then
      # echo "adding ${ADDPATH} before"
      export PATH=${ADDPATH}:${PATH}
    elif [[ -n "${AFTER}" ]]
    then
      # echo "adding ${ADDPATH} after"
      export PATH=${PATH}:${ADDPATH}
    else
      echo "don't know where to addpath ${ADDPATH}"
    fi
  fi
}

# upgrade global package
syspip(){
  PIP_REQUIRE_VIRTUALENV="" pip "$@"
}
