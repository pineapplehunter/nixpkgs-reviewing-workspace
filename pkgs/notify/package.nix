{
  python3,
  runCommand,
  lib,
}:
runCommand "notify" { } ''
  mkdir -p $out/bin
  cp ${./notify.py} $out/bin/notify
  substituteInPlace $out/bin/notify \
    --replace-fail "/usr/bin/env python3" "${lib.getExe (python3.withPackages (ps: [ ps.requests ]))}"
''
