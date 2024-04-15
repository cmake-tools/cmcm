#
# CMakeCM
# CMake Common Modules.
#
# SPDX-FileCopyrightText: 2024 flagarde
#
# SPDX-License-Identifier: MIT
#

# Install and set-up CMakeMM
file(DOWNLOAD "https://cmake-tools.github.io/cmmm/latest/GetCMakeMM.cmake" "${CMAKE_CURRENT_BINARY_DIR}/GetCMakeMM.cmake")
include("${CMAKE_CURRENT_BINARY_DIR}/GetCMakeMM.cmake")
cmmm(VERSION latest)
cmmm_modules_list(URL "gh:cmake-tools/cmcm")
