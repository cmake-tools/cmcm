#
# CMakeCM
# CMake Common Modules.
#
# SPDX-FileCopyrightText: 2024 flagarde
#
# SPDX-License-Identifier: MIT
#

set(CONF_PATH "${CMAKE_CURRENT_SOURCE_DIR}")
set(PROJECT_AUTHOR "flagarde")
set(PROJECT_COPYRIGHT "2023, flagarde")
configure_file("${CMAKE_CURRENT_SOURCE_DIR}/conf.py.in" "${CMAKE_CURRENT_BINARY_DIR}/conf.py")

find_program(SPHINX_BUILD NAMES sphinx-build HINTS ENV CONDA_PREFIX DOC "sphinx-build")

if("${SPHINX_BUILD}" STREQUAL "SPHINX_BUILD-NOTFOUND")
  message(WARNING "sphinx-build not found ! Documentation will not be generated !")
else()
  add_custom_target(docs-html "${SPHINX_BUILD}" "${CMAKE_CURRENT_SOURCE_DIR}" "${CMAKE_CURRENT_BINARY_DIR}/html" -b html -c "${CMAKE_CURRENT_BINARY_DIR}" DEPENDS "${CMAKE_CURRENT_BINARY_DIR}/conf.py"
          WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}"
          COMMENT "Generating doc using Sphinx (html).")
  install(DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/html" DESTINATION "share/doc")

  find_package(LATEX COMPONENTS LUALATEX)
  if(LATEX_LUALATEX_FOUND)
    add_custom_target(docs-pdf "${SPHINX_BUILD}" "${CMAKE_CURRENT_SOURCE_DIR}" "${CMAKE_CURRENT_BINARY_DIR}/pdf" -b latex -c "${CMAKE_CURRENT_BINARY_DIR}"
            DEPENDS "${CMAKE_CURRENT_BINARY_DIR}/conf.py"
            WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}"
            COMMENT "Generating doc using Sphinx (pdf).")
    add_custom_target(docs-generate-pdf ${LUALATEX_COMPILER} "${CMAKE_CURRENT_BINARY_DIR}/pdf/cmcm.tex"
            COMMAND ${LUALATEX_COMPILER} "${CMAKE_CURRENT_BINARY_DIR}/pdf/cmcm.tex"
            DEPENDS docs-pdf
            WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/pdf"
            COMMENT "Generating pdf using LuaLaTeX.")
    add_custom_target(docs-all ALL
            DEPENDS docs-pdf docs-html docs-generate-pdf
            WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}"
            COMMENT "Generating doc using Sphinx (all).")
    install(FILES "${CMAKE_CURRENT_BINARY_DIR}/pdf/cmcm.pdf" DESTINATION "share/doc/pdf")
  else()
    add_custom_target(docs-all ALL DEPENDS docs-html
            WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}"
            COMMENT "Generating doc using Sphinx (all).")
  endif()
endif()
