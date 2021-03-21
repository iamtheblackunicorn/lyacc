build: ; cd .. && tar -cvzf FunkOff.tgz FunkOff && mv FunkOff.tgz FunkOff && ls
test: ; dart pub get && dart analyze && cd example && cd lib && dart main.dart
