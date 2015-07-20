typeset -a J7_LIST
typeset -a J8_LIST

function get-java {
    if [[ "$#" -ne 3 ]]
    then
        echo "Usage: get-java <major> <minor> <build>"
        echo "For example, 8u25-b17 would be 8 25 17 or 7u71-b14 would be 7 71 14"
        return
    fi

    MAJOR="$1"
    MINOR="$2"
    BUILD="$3"
    echo "Getting JDK ${MAJOR}u${MINOR}"
    curl -s -L -C - -b "oraclelicense=accept-securebackup-cookie" -O http://download.oracle.com/otn-pub/java/jdk/${MAJOR}u${MINOR}-b${BUILD}/jdk-${MAJOR}u${MINOR}-macosx-x64.dmg
    open jdk-${MAJOR}u${MINOR}-macosx-x64.dmg
    open "/Volumes/JDK ${MAJOR} Update ${MINOR}/JDK ${MAJOR} Update ${MINOR}.pkg"
    sleep 5
    echo -n "Hit enter after JDK ${MAJOR} install completes."
    read IN
    diskutil unmount $(diskutil list | grep "JDK ${MAJOR}" | awk '{ print $NF }')
    rm -f jdk-${MAJOR}u${MINOR}-macosx-x64.dmg
    echo
}

function getJVMs {
  # pushd /Library/Java/JavaVirtualMachines/ &>/dev/null
  # I=1
  # for DIR in $(ls -1d jdk1.7*)
  # do
    # local JVM=$(echo ${DIR} | sed -e 's/^jdk//' -e 's/.jdk$//')
    # J7_LIST[I]=${JVM}
    # (( I += 1 ))
  # done
  # popd&>/dev/null

  pushd /Library/Java/JavaVirtualMachines/ &>/dev/null
  I=1
  for DIR in $(ls -1d jdk1.8*)
  do
    local JVM=$(echo ${DIR} | sed -e 's/^jdk//' -e 's/.jdk$//')
    J8_LIST[I]=${JVM}
    (( I += 1 ))
  done
  popd&>/dev/null

  # echo "Latest Java 7: ${J7_LIST[-1]} from ${J7_LIST}"
  echo "Lastest Java 8: ${J8_LIST[-1]} from ${J8_LIST}"
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
  else
    echo "Unknown JVM version: ${DESIRED}"
    return
  fi
  # echo "Update JAVA_HOME/PATH for JVM ${JVM}"

  # remove existing JAVA_HOME from current path
  NEWPATH=$(echo ${PATH} | sed -e "s@${JAVA_HOME}/bin:@@")
  # echo "Updated PATH to remove current JAVA_HOME: ${NEWPATH}"

  # set new JAVA_HOME and update path
  NEWHOME="/Library/Java/JavaVirtualMachines/jdk${JVM}.jdk/Contents/Home"
  NEWPATH="${NEWHOME}/bin:${NEWPATH}"
  # echo "Updated PATH to include ${JVM}: ${NEWPATH}"

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
