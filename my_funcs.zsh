typeset -a J7_LIST
typeset -a J8_LIST
typeset -a J9_LIST
typeset -a J10_LIST
typeset -a J11_LIST

function parse-java {
  URL="$1"

  #
  # http://download.oracle.com/otn-pub/java/jdk/8u141-b15/336fa29ff2bb4ef291e347e091f7f4a7/jdk-8u141-macosx-x64.dmg
  # http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.tar.gz
  # http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-macosx-x64.dmg
  # http://download.oracle.com/otn-pub/java/jdk/9.0.1+11/jdk-9.0.1_linux-x64_bin.tar.gz
  #
  # get-java 8 141 15 336fa29ff2bb4ef291e347e091f7f4a7
  # get-java 8 151 12 e758a0de34e24606bca991d704f6dcbf
  #                                                                     1       2        3      4          5 (1)   6 (2)   7      8     9
  if echo "${URL}" | grep -q "jdk/8"
  then
    echo "Java URL: ${URL}"
    echo -n "Parsed data: "
    # echo "${URL}" | sed -e "s@^http://download.oracle.com/otn-pub/java/jdk/\([0-9]*\)u\([0-9]*\)-b\([0-9]*\)/\(.*\)/jdk-\([0-9]*\)u\([0-9]*\)-\(.*\)-\([^.]*\)\.\(.*\)@major:\1 minor:\2 build:\3 key:\4 platform:\7 arch:\8 extension:\9@"
    echo "${URL}" | sed -e "s@^http://download.oracle.com/otn-pub/java/jdk/\([0-9]*\)u\([0-9]*\)-b\([0-9]*\)/\(.*\)/jdk-\([0-9]*\)u\([0-9]*\)-\(.*\)-\([^.]*\)\.\(.*\)@get-java-for \7-\8 \1 \2 \3 \4@"
  elif echo "${URL}" | grep -q "jdk/9"
  then
    echo "Java 9 URL: ${URL}"
    echo -n "Parsed data: "
    echo "${URL}" | sed -e "s@^http://download.oracle.com/otn-pub/java/jdk/\([0-9.]*\)+\([0-9]*\)/jdk-\([0-9.]*\)_\([^.]*\)\.\(.*\)@get-java-for \4 \1 \2@"
  fi

}

function get-java {
    if [[ "$1" =~ ^8 ]]
    then
      if [[ "$#" -ne 4 ]]
      then
          echo "Usage: get-java <major> <minor> <build> <key>"
          echo "For example, 8u25-b17 would be 8 25 17 or 7u71-b14 would be 7 71 14"
          return
      fi

      MAJOR="$1"
      MINOR="$2"
      BUILD="$3"
      KEY="$4"
      echo "Getting JDK ${MAJOR}u${MINOR}"
      curl -k -s -L -C - -b "oraclelicense=accept-securebackup-cookie" -O http://download.oracle.com/otn-pub/java/jdk/${MAJOR}u${MINOR}-b${BUILD}/${KEY}/jdk-${MAJOR}u${MINOR}-macosx-x64.dmg
      open jdk-${MAJOR}u${MINOR}-macosx-x64.dmg
      open "/Volumes/JDK ${MAJOR} Update ${MINOR}/JDK ${MAJOR} Update ${MINOR}.pkg"
      sleep 5
      echo -n "Hit enter after JDK ${MAJOR} install completes."
      read IN
      diskutil unmount $(diskutil list | grep "JDK ${MAJOR}" | awk '{ print $NF }')
      rm -f jdk-${MAJOR}u${MINOR}-macosx-x64.dmg
      echo

    else
      if [[ "$#" -ne 3 ]]
      then
          echo "Usage: get-java <major> <minor> <key>"
          echo "For example, 9.0.1+11 would be 9.0.1 11"
          return
      fi

      MAJOR="$1"
      MINOR="$2"
      KEY="$3"
      echo "Getting JDK ${MAJOR}+${MINOR} (key: ${KEY})"
      # http://download.oracle.com/otn-pub/java/jdk/9.0.1+11/jdk-9.0.1_linux-x64_bin.tar.gz
      # http://download.oracle.com/otn-pub/java/jdk/9.0.1+11/jdk-9.0.1_osx-x64_bin.dmg
      # http://download.oracle.com/otn-pub/java/jdk/9.0.4+11/c2514751926b4512b076cc82f959763f/jdk-9.0.4_osx-x64_bin.dmg
      echo "Running: curl -k -s -L -C - -b \"oraclelicense=accept-securebackup-cookie\" -O http://download.oracle.com/otn-pub/java/jdk/${MAJOR}+${MINOR}/${KEY}/jdk-${MAJOR}_osx-x64_bin.dmg"
      curl -k -s -L -C - -b "oraclelicense=accept-securebackup-cookie" -O http://download.oracle.com/otn-pub/java/jdk/${MAJOR}+${MINOR}/${KEY}/jdk-${MAJOR}_osx-x64_bin.dmg
      open jdk-${MAJOR}_osx-x64_bin.dmg
      open "/Volumes/JDK ${MAJOR}/JDK ${MAJOR}.pkg"
      sleep 5
      echo -n "Hit enter after JDK ${MAJOR} install completes."
      read IN
      diskutil unmount $(diskutil list | grep "JDK ${MAJOR}" | awk '{ print $NF }')
      rm -f jdk-${MAJOR}_osx-x64_bin.dmg
    fi
}

function get-java-for {
    PLATFORM="$1"
    # echo "Usage: get-java <platform> <major> <minor> <build> <key>"
    # echo "Platform should be one of linux-i586, linux-x64, macosx-x64, windows-i586 or windows-x64"
    # echo "For example, 8u121-b13 would be 8 121 13 or 7u71-b14 would be 7 71 14, key is a new component of the download URL."
    # return

    case "${PLATFORM}" in
        "linux-i586")
            SUFFIX="tar.gz"
            ;;
        "linux-x64")
            SUFFIX="tar.gz"
            ;;
        "macosx-x64")
            SUFFIX="dmg"
            ;;
        "windows-i586")
            SUFFIX="exe"
            ;;
        "windows-x64")
            SUFFIX="exe"
            ;;
        *)
            echo "ERROR: Unable to find platform ${PLATFORM}"
            return
            ;;
    esac

    if [[ "$#" -eq 5 ]]
    then
      MAJOR="$2"
      MINOR="$3"
      BUILD="$4"
      KEY="$5"

      echo "Getting JDK ${MAJOR}u${MINOR} for ${PLATFORM}"
      echo "curl -k -s -L -C - -b \"oraclelicense=accept-securebackup-cookie\" -O http://download.oracle.com/otn-pub/java/jdk/${MAJOR}u${MINOR}-b${BUILD}/${KEY}/jdk-${MAJOR}u${MINOR}-${PLATFORM}.${SUFFIX}"
      curl -k -s -L -C - -b "oraclelicense=accept-securebackup-cookie" -O "http://download.oracle.com/otn-pub/java/jdk/${MAJOR}u${MINOR}-b${BUILD}/${KEY}/jdk-${MAJOR}u${MINOR}-${PLATFORM}.${SUFFIX}"
      echo
    elif [[ "$#" -eq 3 ]]
    then
      echo "Getting JDK ${MAJOR}u${MINOR} for ${PLATFORM}"
      echo "curl -k -s -L -C - -b "oraclelicense=accept-securebackup-cookie" -O http://download.oracle.com/otn-pub/java/jdk/${MAJOR}+${MINOR}/jdk-${MAJOR}_${PLATFORM}_bin.${SUFFIX}"
      curl -k -s -L -C - -b "oraclelicense=accept-securebackup-cookie" -O http://download.oracle.com/otn-pub/java/jdk/${MAJOR}+${MINOR}/jdk-${MAJOR}_${PLATFORM}_bin.${SUFFIX}
    fi
}

function echo-java-for {
    PLATFORM="$1"

    case "${PLATFORM}" in
        "linux-i586")
            SUFFIX="tar.gz"
            ;;
        "linux-x64")
            SUFFIX="tar.gz"
            ;;
        "macosx-x64")
            SUFFIX="dmg"
            ;;
        "windows-i586")
            SUFFIX="exe"
            ;;
        "windows-x64")
            SUFFIX="exe"
            ;;
        *)
            echo "ERROR: Unable to find platform ${PLATFORM}"
            return
            ;;
    esac

    if [[ "$#" -eq 5 ]]
    then
      MAJOR="$2"
      MINOR="$3"
      BUILD="$4"
      KEY="$5"

      echo "Getting JDK ${MAJOR}u${MINOR} for ${PLATFORM}"
      echo "curl -k -s -L -C - -b \"oraclelicense=accept-securebackup-cookie\" -O \"http://download.oracle.com/otn-pub/java/jdk/${MAJOR}u${MINOR}-b${BUILD}/${KEY}/jdk-${MAJOR}u${MINOR}-${PLATFORM}.${SUFFIX}\""
      echo
    elif [[ "$#" -eq 3 ]]
    then
      echo "Getting JDK ${MAJOR}u${MINOR} for ${PLATFORM}"
      echo "curl -k -s -L -C - -b \"oraclelicense=accept-securebackup-cookie\" -O \"http://download.oracle.com/otn-pub/java/jdk/${MAJOR}+${MINOR}/jdk-${MAJOR}_${PLATFORM}_bin.${SUFFIX}\""
    fi
}

function getJVMs {
  pushd /Library/Java/JavaVirtualMachines/ &>/dev/null
  I=1
  N8=$(find . -maxdepth 1 -type d -a -name jdk1.8\* | wc -l)
  if [[ ${N8} -gt 0 ]]
  then
    for DIR in $(find . -maxdepth 1 -type d -a -name jdk1.8\* | sort -n)
    do
      local JVM=$(echo ${DIR} | sed -e 's/^jdk//' -e 's/.jdk$//' -e 's/\.\///')
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
      local JVM=$(echo ${DIR} | sed -e 's/^jdk-//' -e 's/.jdk$//' -e 's/\.\///')
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
      local JVM=$(echo ${DIR} | sed -e 's/^jdk-//' -e 's/.jdk$//' -e 's/\.\///')
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
      local JVM=$(echo ${DIR} | sed -e 's/^jdk-//' -e 's/.jdk$//' -e 's/\.\///')
      J11_LIST[I]=${JVM}
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
