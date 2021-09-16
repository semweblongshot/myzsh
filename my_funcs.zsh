typeset -a J7_LIST
typeset -a J8_LIST
typeset -a J9_LIST
typeset -a J10_LIST
typeset -a J11_LIST
typeset -a J12_LIST
typeset -a J13_LIST
typeset -a J14_LIST
typeset -a J15_LIST
typeset -a J16_LIST
typeset -a J17_LIST

function getJVMs {
  pushd /Library/Java/JavaVirtualMachines/ &>/dev/null
  I=1
  N8=$(find . -maxdepth 1 -type d -a -name jdk1.8\* | wc -l)
  if [[ ${N8} -gt 0 ]]
  then
    for DIR in $(find . -maxdepth 1 -type d -a -name jdk1.8\* | sort -n)
    do
      # jdk1.8.0_192.jdk
      local JVM=$(echo ${DIR} | sed -e 's/\.\///' -e 's/^jdk//' -e 's/.jdk$//' )
      J8_LIST[I]=${JVM}
      (( I += 1 ))
    done
  fi

  I=1
  N9=$(find . -maxdepth 1 -type d -a -name jdk-9\* | wc -l)
  if [[ ${N9} -gt 0 ]]
  then
    for DIR in $(find . -maxdepth 1 -type d -a -name jdk-9\* | sort -n)
    do
      local JVM=$(echo ${DIR} | sed -e 's/\.\///' -e 's/^jdk-//' -e 's/.jdk$//' )
      J9_LIST[I]=${JVM}
      (( I += 1 ))
    done
  fi

  I=1
  N10=$(find . -maxdepth 1 -type d -a -name jdk-10\* | wc -l)
  if [[ ${N10} -gt 0 ]]
  then
    for DIR in $(find . -maxdepth 1 -type d -a -name jdk-10\* | sort -n)
    do
      local JVM=$(echo ${DIR} | sed -e 's/\.\///' -e 's/^jdk-//' -e 's/.jdk$//')
      J10_LIST[I]=${JVM}
      (( I += 1 ))
    done
  fi

  I=1
  N11=$(find . -maxdepth 1 -type d -a -name jdk-11\* | wc -l)
  if [[ ${N11} -gt 0 ]]
  then
    for DIR in $(find . -maxdepth 1 -type d -a -name jdk-11\* | sort -n)
    do
      local JVM=$(echo ${DIR} | sed -e 's/\.\///' -e 's/^jdk-//' -e 's/.jdk$//' )
      J11_LIST[I]=${JVM}
      (( I += 1 ))
    done
  fi

  I=1
  N12=$(find . -maxdepth 1 -type d -a -name jdk-12\* | wc -l)
  if [[ ${N12} -gt 0 ]]
  then
    for DIR in $(find . -maxdepth 1 -type d -a -name jdk-12\* | sort -n)
    do
      local JVM=$(echo ${DIR} | sed -e 's/\.\///' -e 's/^jdk-//' -e 's/.jdk$//' )
      J12_LIST[I]=${JVM}
      (( I += 1 ))
    done
  fi

  I=1
  N13=$(find . -maxdepth 1 -type d -a -name jdk-13\* | wc -l)
  if [[ ${N13} -gt 0 ]]
  then
    for DIR in $(find . -maxdepth 1 -type d -a -name jdk-13\* | sort -n)
    do
      local JVM=$(echo ${DIR} | sed -e 's/\.\///' -e 's/^jdk-//' -e 's/.jdk$//' )
      J13_LIST[I]=${JVM}
      (( I += 1 ))
    done
  fi

  I=1
  N14=$(find . -maxdepth 1 -type d -a -name jdk-14\* | wc -l)
  if [[ ${N14} -gt 0 ]]
  then
    for DIR in $(find . -maxdepth 1 -type d -a -name jdk-14\* | sort -n)
    do
      local JVM=$(echo ${DIR} | sed -e 's/\.\///' -e 's/^jdk-//' -e 's/.jdk$//' )
      J14_LIST[I]=${JVM}
      (( I += 1 ))
    done
  fi

  I=1
  N15=$(find . -maxdepth 1 -type d -a -name jdk-15\* | wc -l)
  if [[ ${N15} -gt 0 ]]
  then
    for DIR in $(find . -maxdepth 1 -type d -a -name jdk-15\* | sort -n)
    do
      local JVM=$(echo ${DIR} | sed -e 's/\.\///' -e 's/^jdk-//' -e 's/.jdk$//' )
      J15_LIST[I]=${JVM}
      (( I += 1 ))
    done
  fi

  I=1
  N16=$(find . -maxdepth 1 -type d -a -name jdk-16\* | wc -l)
  if [[ ${N16} -gt 0 ]]
  then
    for DIR in $(find . -maxdepth 1 -type d -a -name jdk-16\* | sort -n)
    do
      local JVM=$(echo ${DIR} | sed -e 's/\.\///' -e 's/^jdk-//' -e 's/.jdk$//' )
      J16[I]=${JVM}
      (( I += 1 ))
    done
  fi

  I=1
  N17=$(find . -maxdepth 1 -type d -a -name jdk-17\* | wc -l)
  if [[ ${N17} -gt 0 ]]
  then
    for DIR in $(find . -maxdepth 1 -type d -a -name jdk-17\* | sort -n)
    do
      local JVM=$(echo ${DIR} | sed -e 's/\.\///' -e 's/^jdk-//' -e 's/.jdk$//' )
      J17_LIST[I]=${JVM}
      (( I += 1 ))
    done
  fi

  popd&>/dev/null

  if [[ -n ${J8_LIST} ]]
  then
    echo "Latest Java 8: ${J8_LIST[-1]} from ${J8_LIST}"
  fi
  if [[ -n ${J9_LIST} ]]
  then
    echo "Latest Java 9: ${J9_LIST[-1]} from ${J9_LIST}"
  fi
  if [[ -n ${J10_LIST} ]]
  then
    echo "Latest Java 10: ${J10_LIST[-1]} from ${J10_LIST}"
  fi
  if [[ -n ${J11_LIST} ]]
  then
    echo "Latest Java 11: ${J11_LIST[-1]} from ${J11_LIST}"
  fi
  if [[ -n ${J12_LIST} ]]
  then
    echo "Latest Java 12: ${J12_LIST[-1]} from ${J12_LIST}"
  fi
  if [[ -n ${J13_LIST} ]]
  then
    echo "Latest Java 13: ${J13_LIST[-1]} from ${J13_LIST}"
  fi
  if [[ -n ${J14_LIST} ]]
  then
    echo "Latest Java 14: ${J14_LIST[-1]} from ${J14_LIST}"
  fi
  if [[ -n ${J15_LIST} ]]
  then
    echo "Latest Java 15: ${J15_LIST[-1]} from ${J15_LIST}"
  fi
  if [[ -n ${J16_LIST} ]]
  then
    echo "Latest Java 16: ${J16_LIST[-1]} from ${J16_LIST}"
  fi
  if [[ -n ${J17_LIST} ]]
  then
    echo "Latest Java 17: ${J17_LIST[-1]} from ${J17_LIST}"
  fi
}

function updateJava {
  local JVM
  DESIRED=$1

  if [[ "${DESIRED}" == "1.7" ]]
  then
    JVM=${J7_LIST[-1]}
  elif [[ "${DESIRED}" == "1.8" ]]
  then
    JVM=${J8_LIST[-1]}
  elif [[ "${DESIRED}" == "9" ]]
  then
    JVM=${J9_LIST[-1]}
  elif [[ "${DESIRED}" == "10" ]]
  then
    JVM=${J10_LIST[-1]}
  elif [[ "${DESIRED}" == "11" ]]
  then
    JVM=${J11_LIST[-1]}
  elif [[ "${DESIRED}" == "12" ]]
  then
    JVM=${J12_LIST[-1]}
  elif [[ "${DESIRED}" == "13" ]]
  then
    JVM=${J13_LIST[-1]}
  elif [[ "${DESIRED}" == "14" ]]
  then
    JVM=${J14_LIST[-1]}
  elif [[ "${DESIRED}" == "15" ]]
  then
    JVM=${J15_LIST[-1]}
  elif [[ "${DESIRED}" == "16" ]]
  then
    JVM=${J16_LIST[-1]}
  elif [[ "${DESIRED}" == "17" ]]
  then
    JVM=${J17_LIST[-1]}
  else
    echo "Unknown JVM version: ${DESIRED}"
    return
  fi
  # echo "Update JAVA_HOME/PATH for JVM ${JVM}"

  # remove existing JAVA_HOME from current path
  NEWPATH=$(echo ${PATH} | sed -e "s@${JAVA_HOME}/bin:@@")
  # echo "Updated PATH to remove current JAVA_HOME: ${NEWPATH}"

  # set new JAVA_HOME and update path
  if [[ "${DESIRED}" == "1.7" ]] || [[ "${DESIRED}" == "1.8" ]]
  then
    NEWHOME="/Library/Java/JavaVirtualMachines/jdk${JVM}.jdk/Contents/Home"
    NEWPATH="${NEWHOME}/bin:${NEWPATH}"
    # echo "Updated PATH to include ${JVM}: ${NEWPATH}"
  else
    NEWHOME="/Library/Java/JavaVirtualMachines/jdk-${JVM}.jdk/Contents/Home"
    NEWPATH="${NEWHOME}/bin:${NEWPATH}"
  fi

  export JAVA_HOME=${NEWHOME}
  export PATH=${NEWPATH}
}

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

function bup(){
  echo "Updating the brew formulas"
  brew update && brew upgrade && brew cleanup
}

function cleanupdocker(){
  #docker system prune -f
  docker rm $(docker ps -qa -f status=exited) -f
  docker rmi $(docker images -f dangling=true -qa) -f
  docker network prune -f
  docker volume prune -f
}
