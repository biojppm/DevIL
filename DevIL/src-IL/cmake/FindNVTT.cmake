# Locate nvidia-texture-tools
# This module defines
# NVTT_LIBRARIES
# NVTT_FOUND, if false, do not try to link to nvtt
# NVTT_INCLUDE_DIR, where to find the headers
#


#TARGET_LINK_LIBRARIES(nvtt PUBLIC ${LIBS} nvcore nvimage nvthread squish bc6h bc7 nvmath)

set(_nvtt_search_paths
    /usr/local
    /usr
    ${NVTT_DIR}
    $ENV{NVTT_DIR}
    ${3rdPartyRoot}
)


macro(_nvtt_search_lib var name)
    find_library(${var}_LIBRARY NAMES ${name} ${_nvtt_search_paths}
        PATH_SUFFIXES lib64 lib lib/shared lib/static lib64/static)
    find_library(${var}_LIBRARY_DEBUG NAMES ${name}_d ${_nvtt_lib_paths})
    if(${var}_LIBRARY_DEBUG AND ${var}_LIBRARY)
        set(${var}_LINK_LIBRARY optimized ${${var}_LIBRARY} debug ${${var}_LIBRARY_DEBUG})
    else()
        set(${var}_LINK_LIBRARY ${${var}_LIBRARY})
    endif()
    if(${var}_LIBRARY OR ${var}_LIBRARY_DEBUG)
        list(APPEND NVTT_LIBRARIES ${${var}_LINK_LIBRARY})
    endif()
endmacro()


#----------------------------------------
set(NVTT_LIBRARIES)

FIND_PATH(NVTT_INCLUDE_DIR nvtt/nvtt.h ${_nvtt_search_paths})

_nvtt_search_lib(NVTT nvtt)
_nvtt_search_lib(NVTT_SQUISH squish)
_nvtt_search_lib(NVTT_NVCORE nvcore)
_nvtt_search_lib(NVTT_NVIMAGE nvimage)
_nvtt_search_lib(NVTT_NVTHREAD nvthread)
_nvtt_search_lib(NVTT_BC6H bc6h)
_nvtt_search_lib(NVTT_BC7 bc7)
_nvtt_search_lib(NVTT_MATH nvmath)


SET(NVTT_FOUND "NO")
IF(NVTT_LIBRARY AND NVTT_INCLUDE_DIR)
  SET(NVTT_FOUND "YES")
ENDIF(NVTT_LIBRARY AND NVTT_INCLUDE_DIR)
