build: ; cd .. && tar -cvzf lyacc.tgz lyacc && mv lyacc.tgz lyacc && ls
test: ; dart pub get && dart analyze && cd example && cd lib && dart main.dart --version && dart main.dart ../sample/test.bs && dart main.dart --diagnostics ../sample/test.bs
