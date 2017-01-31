typeset -a J7_LIST
typeset -a J8_LIST

function parse-java {
  URL="$1"

  # http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-macosx-x64.dmg
  #                                                                     1       2        3      4          5 (1)   6 (2)   7      8     9
  echo "Java URL: ${URL}"
  echo -n "Parsed data: "
  # echo "${URL}" | sed -e "s@^http://download.oracle.com/otn-pub/java/jdk/\([0-9]*\)u\([0-9]*\)-b\([0-9]*\)/\(.*\)/jdk-\([0-9]*\)u\([0-9]*\)-\(.*\)-\([^.]*\)\.\(.*\)@major:\1 minor:\2 build:\3 key:\4 platform:\7 arch:\8 extension:\9@"
  echo "${URL}" | sed -e "s@^http://download.oracle.com/otn-pub/java/jdk/\([0-9]*\)u\([0-9]*\)-b\([0-9]*\)/\(.*\)/jdk-\([0-9]*\)u\([0-9]*\)-\(.*\)-\([^.]*\)\.\(.*\)@get-java-for \7-\8 \1 \2 \3 \4@"
}

function get-java {
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
}

function get-java-for {
    if [[ "$#" -ne 5 ]]
    then
        echo "Usage: get-java <platform> <major> <minor> <build> <key>"
        echo "Platform should be one of linux-i586, linux-x64, macosx-x64, windows-i586 or windows-x64"
        echo "For example, 8u121-b13 would be 8 121 13 or 7u71-b14 would be 7 71 14, key is a new component of the download URL."
        return
    fi

    PLATFORM="$1"
    MAJOR="$2"
    MINOR="$3"
    BUILD="$4"
    KEY="$5"

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

    echo "Getting JDK ${MAJOR}u${MINOR} for ${PLATFORM}"
    echo "curl -k -s -L -C - -b \"oraclelicense=accept-securebackup-cookie\" -O http://download.oracle.com/otn-pub/java/jdk/${MAJOR}u${MINOR}-b${BUILD}/${KEY}/jdk-${MAJOR}u${MINOR}-${PLATFORM}.${SUFFIX}"
    curl -k -s -L -C - -b "oraclelicense=accept-securebackup-cookie" -O "http://download.oracle.com/otn-pub/java/jdk/${MAJOR}u${MINOR}-b${BUILD}/${KEY}/jdk-${MAJOR}u${MINOR}-${PLATFORM}.${SUFFIX}"
    echo
}

function echo-java-for {
    if [[ "$#" -ne 4 ]]
    then
        echo "Usage: get-java <platform> <major> <minor> <build>"
        echo "Platform should be one of linux-i586, linux-x64, macosx-x64, windows-i586 or windows-x64"
        echo "For example, 8u25-b17 would be 8 25 17 or 7u71-b14 would be 7 71 14"
        return
    fi

    PLATFORM="$1"
    MAJOR="$2"
    MINOR="$3"
    BUILD="$4"

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

    echo "Getting JDK ${MAJOR}u${MINOR} for ${PLATFORM}"
    echo "curl -k -s -L -C - -b \"oraclelicense=accept-securebackup-cookie\" -O http://download.oracle.com/otn-pub/java/jdk/${MAJOR}u${MINOR}-b${BUILD}/jdk-${MAJOR}u${MINOR}-${PLATFORM}.${SUFFIX}"
    echo
}

function getJVMs {
  pushd /Library/Java/JavaVirtualMachines/ &>/dev/null
  I=1
  for DIR in $(ls -1rtd jdk1.8*)
  do
    local JVM=$(echo ${DIR} | sed -e 's/^jdk//' -e 's/.jdk$//')
    J8_LIST[I]=${JVM}
    (( I += 1 ))
  done
  popd&>/dev/null

  # echo "Latest Java 7: ${J7_LIST[-1]} from ${J7_LIST}"
  echo "Lastest Java: ${J8_LIST[-1]} from ${J8_LIST}"
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
