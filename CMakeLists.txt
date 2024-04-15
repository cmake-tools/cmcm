#
# CMakeCM
# CMake Common Modules.
#
# SPDX-FileCopyrightText: 2024 flagarde
#
# SPDX-License-Identifier: MIT
#

cmake_minimum_required(VERSION 3.0...${CMAKE_VERSION} FATAL_ERROR)

project(CMCM VERSION 0.1 LANGUAGES NONE)

if("${CMAKE_PROJECT_NAME}" STREQUAL "${PROJECT_NAME}")
  option(ENABLE_DOCS "Build the docs" ON)
  option(ENABLE_TESTS "Build the tests" ON)
else()
  option(ENABLE_DOCS "Build the docs" OFF)
  option(ENABLE_TESTS "Build the tests" OFF)
endif()

if(ENABLE_DOCS)
  add_subdirectory(docs)
endif()

if(ENABLE_TESTS)
  include(CTest)
  add_subdirectory(tests)
endif()
