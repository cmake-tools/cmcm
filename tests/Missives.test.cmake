#
# CMakeCM
# CMake Common Modules.
#
# SPDX-FileCopyrightText: 2024 flagarde
#
# SPDX-License-Identifier: MIT
#

include(SetupModulesList)

include("/home/working/Projects/cmcm/modules/Missives.cmake")

missive(ERROR "ERROR")
missive(WARN "WARN")
missive(INFO "INFO")
missive(NOTE "NOTE")
missive(TO_REMOVE "TO_REMOVE")
missive(TO_ADD "TO_ADD")