#!/sbin/sh

remove_redundancies() {
  local SED=$(which gnused)
  [ -z "$SED" ] && return

  local ROM_SDK=$(getprop "ro.build.version.sdk");
  [ -z "$ROM_SDK" ] && return
  
  # remove the app manager if SDK version > Android 10
  if [ $ROM_SDK -gt 29 ]; then
     echo "I: OrangeFox: Android 11+ ROM - removing the App Manager"
     local XML=/twres/pages/advanced.xml
     $SED -i '/name="{@appmgr_title}"/I,+3 d' $XML
     rm -f /sbin/aapt
  fi
}

remove_redundancies;
exit 0;
#