# Copyright (c) 2017-present, Facebook, Inc.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

TESTS_DIR = ../..
ROOT_DIR = $(TESTS_DIR)/../..
CODETOANALYZE_DIR = ../codetoanalyze/objc_retain_cycles

ANALYZER = checkers
SOURCES = $(CODETOANALYZE_DIR)/View.m $(CODETOANALYZE_DIR)/ViewController.m $(CODETOANALYZE_DIR)/Caller.m
OBJECTS = $(CODETOANALYZE_DIR)/View.o $(CODETOANALYZE_DIR)/ViewController.o $(CODETOANALYZE_DIR)/Caller.o
CLANG_OPTIONS = -c $(OBJC_CLANG_OPTIONS)
INFER_OPTIONS = --biabduction-only --report-custom-error --developer-mode --project-root $(TESTS_DIR)
INFERPRINT_OPTIONS = --project-root $(TESTS_DIR) --issues-tests

include $(TESTS_DIR)/infer.make
include $(TESTS_DIR)/objc.make

infer-out/report.json: $(CLANG_DEPS) $(SOURCES) $(MAKEFILE_LIST)
	$(QUIET)$(REMOVE_DIR) buck-out && \
	$(call silent_on_success,Testing analysis with Objective-C Retain cycles,\
	$(INFER_BIN) $(INFER_OPTIONS) --results-dir $(CURDIR)/infer-out -- clang $(CLANG_OPTIONS) -fobjc-arc $(SOURCES))
