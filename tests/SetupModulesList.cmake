#
# CMakeCM
# CMake Common Modules.
#
# SPDX-FileCopyrightText: 2024-2026 flagarde
#
# SPDX-License-Identifier: MIT
#
cmake_policy(VERSION ${CMAKE_VERSION})

# Install and set-up CMakeMM
file(DOWNLOAD "https://cmake-tools.github.io/cmmm/latest/GetCMakeMM.cmake" "${CMAKE_CURRENT_BINARY_DIR}/GetCMakeMM.cmake")
include("${CMAKE_CURRENT_BINARY_DIR}/GetCMakeMM.cmake")
cmmm(VERSION latest)
cmmm_modules_list(URL "gh:cmake-tools/cmcm")
