/*
    Copyright (C) 2012 Modelon AB

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, version 3 of the License.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#ifndef CONFIG_FMILIB_H_
#define CONFIG_FMILIB_H_

#ifndef WIN32
#cmakedefine WIN32
#endif

#cmakedefine MINGW

#ifndef CMAKE_INTDIR
#define CMAKE_INTDIR "."
#endif

/* Platform folder separator */
#define FMI_FILE_SEP "@FMI_FILE_SEP@"	

/* DLL file name suffix(.so, .dll, ...) */
#define FMI_DLL_EXT "@CMAKE_SHARED_MODULE_SUFFIX@" 

/* Folder name in which the DLL is found for this platform */
#define FMI_PLATFORM "@FMI_PLATFORM@"

#define FMI_BINARIES "binaries"
#define FMI_MODEL_DESCRIPTION_XML "modelDescription.xml"

#cmakedefine FMILIB_STATIC_LIB_ONLY

#ifndef FMILIB_STATIC_LIB_ONLY
 #if defined WIN32
  #ifdef FMILIB_BUILDING_LIBRARY
    #if 0 /* defined(__GNUC__)  MSYS currently does not support visibility attribute */ 
      #define FMILIB_EXPORT __attribute__ ((dllexport))
    #else
		/* Note: actually gcc seems to also supports this syntax. */
      #define FMILIB_EXPORT __declspec(dllexport) 
    #endif
  #else
    #if 0 /* defined(__GNUC__) MSYS currently does not support visibility attribute  */
      #define FMILIB_EXPORT __attribute__ ((dllimport))
    #else
		/* Note: actually gcc seems to also supports this syntax. */
      #define FMILIB_EXPORT __declspec(dllimport)
    #endif
  #endif
  #define FMILIB_PRIVATE
 #else
  #if __GNUC__ >= 4
    #define FMILIB_EXPORT __attribute__ ((visibility ("default")))
    #define FMILIB_PRIVATE  __attribute__ ((visibility ("hidden")))
  #else
    #define FMILIB_EXPORT
    #define FMILIB_PRIVATE
  #endif
 #endif
#else
    #define FMILIB_EXPORT
    #define FMILIB_PRIVATE
#endif

#cmakedefine FMILIB_ENABLE_LOG_LEVEL_DEBUG

#cmakedefine FMILIB_GENERATE_BUILD_STAMP
#ifdef FMILIB_GENERATE_BUILD_STAMP
#ifdef __cplusplus
extern "C" {
#endif
FMILIB_EXPORT const char* fmilib_get_build_stamp(void);
#ifdef __cplusplus
}
#endif
#endif

#endif
