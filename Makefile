ARCH := $(shell uname -m)

upgrade:
	flutter pub upgrade --major-versions

genapk:
	flutter build apk --split-per-abi -t lib/main_staging.dart

runner:
	dart run build_runner build

lint:
	dart format .
	dart fix --apply