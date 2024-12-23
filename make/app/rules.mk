#
# Copyright (c) 2014, Google, Inc. All rights reserved
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files
# (the "Software"), to deal in the Software without restriction,
# including without limitation the rights to use, copy, modify, merge,
# publish, distribute, sublicense, and/or sell copies of the Software,
# and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

LOCAL_DIR := $(GET_LOCAL_DIR)

# common user task related globals
XBIN_LDFLAGS := --gc-sections

$(info app user tasks ARCH=$(USER_ARCH))


# some linkers set the default arm pagesize to 32K. No idea why.
XBIN_LDFLAGS += \
	-z max-page-size=0x1000

# linking script to link this user task
USER_TASK_LINKER_SCRIPT := $(BUILDDIR)/user_task.ld

# 用户链接文件（.ld）
#include arch specific support for user tasks

# rule to copy it to BUILD directory
$(USER_TASK_LINKER_SCRIPT): $(LOCAL_DIR)/arch/$(USER_ARCH)/user_task_template.ld
	@echo generating $@
	@$(MKDIR)
	$(NOECHO)cp $< $@

GENERATED +=  $(USER_TASK_LINKER_SCRIPT)