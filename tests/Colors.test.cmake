#
# CMakeCM
# CMake Common Modules.
#
# SPDX-FileCopyrightText: 2024 flagarde
#
# SPDX-License-Identifier: MIT
#

include(SetupModulesList)

include(Colors)

check_color_support(VARIABLE COLOR_SUPPORT)
message(STATUS "Color support ${COLOR_SUPPORT}")
