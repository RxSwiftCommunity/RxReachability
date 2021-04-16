GITHUB_URL := https://github.com/RxSwiftCommunity/RxReachability/

include .makefiles/ludicrous.mk
include .makefiles/bundler.mk
include .makefiles/ios.mk

PLATFORM := 'iOS'
TEST_SCHEME := 'RxReachability'
WORKSPACE := 'RxReachability-Example/RxReachability_Example.xcworkspace'
DESTINATION := 'platform=iOS Simulator,OS=14.4,name=iPhone 12'

%:
	@:

args = `arg="$(filter-out $@,$(MAKECMDGOALS))" && echo $${arg:-${1}}`

#> Lint the podspec for upload
pod_lint:
	@pod spec lint RxReachability.podspec  \
	--fail-fast \
	--no-clean

#> Publish a podspec to Podspec repo
pod_publish:
	@pod repo push RxReachability.podspec \
	--private \
	--skip-tests \
	--allow-warnings

#> Build API documentation; https://github.com/realm/jazzy
jazzy:
	@jazzy

#> Markdown API using sourcedocs; https://github.com/eneko/SourceDocs
sourcedocs:
	@sourcedocs generate \
	--module-name RxReachability \
	--output-folder 'docs/reference' \
	--collapsible \
	--table-of-contents \
	--spm-module RxReachability
	
#> Generate linux unit tests
spm-linuxmain:
	swift test --generate-linuxmain

#> Generate docs using sourcedocs through swift pm
spm-docs:
	swift run sourcedocs generate --clean --spm-module RxReachability --output-folder docs/reference --module-name-path

#> Build via Swift PM
spm-build:
	swift build --disable-sandbox -c release

#> Public cocoapod spec
public-pod:
	pod trunk register rxwebkit@rxswift.org "RxWebKit Maintainers"
	pod trunk push RxReachability
