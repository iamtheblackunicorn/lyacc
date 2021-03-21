build: ; cd .. && tar -cvzf lyacc.tgz lyacc && mv lyacc.tgz lyacc && ls
test: ; dart pub get && dart analyze && cd example && cd lib && 
