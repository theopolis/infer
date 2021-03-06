# Copyright (c) 2016-present, Facebook, Inc.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

TESTS_DIR = ../..

ANALYZER = checkers
APP_DIR = ../codetoanalyze/xcodebuild/simple_app
SOURCES = $(wildcard $(APP_DIR)/simple_app/*.m)
OBJECTS = $(APP_DIR)/app_built
INFERPRINT_OPTIONS = --issues-tests

include $(TESTS_DIR)/infer.make

XCODEBUILD = xcodebuild -verbose -target simple_app -configuration Release -sdk iphonesimulator

$(OBJECTS): $(SOURCES)
	cd $(APP_DIR) && \
	$(XCODEBUILD) && \
	touch app_built

infer-out/report.json: $(CLANG_DEPS) $(SOURCES)
	$(QUIET)cd $(APP_DIR) && \
	$(XCODEBUILD) clean && \
	$(call silent_on_success,Testing xcodebuild default integration,\
	  $(INFER_BIN) -a $(ANALYZER) $(INFER_OPTIONS) --project-root $(TESTS_DIR) \
	    --results-dir $(CURDIR)/$(@D) -- $(XCODEBUILD))

clean:
	cd $(APP_DIR) && \
	$(XCODEBUILD) clean
	$(REMOVE_DIR) infer-out issues.exp.test
