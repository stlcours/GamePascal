<img align="left" src="https://github.com/tinyBigGAMES/GamePascal/blob/master/logo/GamePascal_256x256.png" width=256>

# GamePascal&trade; for Windows
Game Development System<br/><br/>
[![Chat on Discord](https://img.shields.io/discord/574777650762219541)](https://discord.gg/tcGxFat)
[![License](https://img.shields.io/badge/License-GamePascal-blue.svg)](LICENSE.md)
![Twitter Follow](https://img.shields.io/twitter/follow/tinyBigGAMES?style=social)
<br/><br/><br/><br/><br/>
## Overview
GamePascal™ compiler is a modern, modular, object-oriented programming language based on Object Pascal, a light-weight IDE and an advanced 2D game library (GamePascal Library) for Windows® PC. The library uses Direct3D®/OpenGL® for hardware accelerated rendering. It's robust, designed for easy use and suitable for making all types of 2D games and other graphic simulations. There is support for surfaces, textures, sprites, audio, streams, archives, configuration files, render targets, databases and much more.

## Language Features
* GamePascal language is modern, modular, object oriented and based on the Object Pascal.
* Namespaces, nested classes, inheritance
* Static(shared) members, indexed properties, default parameters.
* Overloaded routines, operator overloading, delegates, exception handling, regular expressions.
* Conditional compilation.
* Direct calling dll-defined routines.
* All calling conventions register, pascal, cdecl, stdcall, safecall are supported.

## Compiler Features
* Command-line compiler (gpc.exe <filename.[pas]>)
* x86 32bit code generation.
* Create standard EXEs and DLLs.
* Add version information and EXE icon.
* Fast compilation speeds, compiling and linking in a single step.
* Supports project directives ($CONSOLEAPP, $MODULENAME, $EXEICON, $SEARCHPATH, $ENABLERUNTIMETHEMES, $HIGHDPIAWARE, $ADDVERSIONINFO and more). These can be place in the main project source file to direct compiler behavior. The source becomes self-subscribing.
## IDE Features
- Multiple Project Support
- Toggle Code Folding
- Syntax Highlighting
- Project Options
- Single file project format
- File operations: open, close, close all, save, save all
- Edit operations: undo, redo, cut, copy, past, select all
- Search operations: find, find again, find/replace
- Compile/Compile & Run
- QuickHelp
- Param Hints (API Routines)
- Code Completion (API Routines) (Ctrl+Space)
- Integrated HTML Help
- Editor Options (Options->Editor Options)
- Context sensitive Help (F1) in the editor (place the cursor
  on a keyword and press F1 or right click).
- File Tabs with hints
- Entire game engine API is accessible
- EXE generation with version info and application icon
- Todo List (display all //TODO: or {TODO: } tags in current source file)
## Engine Features
* Uses Direct3D/OpenGL for 2D hardware rendering.
* Uses 32bit surfaces and textures.
* Free scaling, rotation, alpha blending and other special effects.
* Windowed and full screen modes.
* Frame based timing support.
* Low-level INI file and high-level configuration file support.
* Unified Streaming system (memory, file, EXE resources, zip archive).
* Can render to default application window or to a specified window handle.
* Advanced render target
* Scalable textured fonts (includes a Unicode font editor tool).
* Graphic primitives (lines, circles, rects, points).
* Advanced polygon rendering (scale, rotate, control line segment visibility).
* Advanced sprite management.
* Polypoint collision system for fast precise collision detection.
* Mouse and keyboard input management.
* OpenAL based audio system with support for .WAV and .OGG formats.
* Video playback for .OGV format
* Comprehensive math routines (vectors, angles, line intersection, clipping).
* Log file support.
* MySQL database support (MySQL local & remote | SQLite local only).
* Remote high score system (MySQL).
* High-level support for Actors, Entities and AI.
* Low-level system and common routines.
* Low-level (reliable UDP) networking.

## Minimum System Requirements
* Microsoft Windows 10
* DirectX 9/OpenGL 3.x
* OpenAL compliant audio card (optional)

## Installation
* Unzip the archive to a desired location.
* Run GPE.EXE in {installdir\bin} to start the GamePascal IDE.
* Inside the root of the [examples] folder are workspace files (.gpw).
* Each workspace holds projects for different aspects of the product such as language, library, demos, etc.
* See these examples and documentation for more information on using GamePascal.

## Known Issues
* There are some issues with exception handling. At this time, it is recommend not to use it (try/finally, try/exception).
* Documentation and examples are work-in-progress.

## Media
<img src="https://github.com/tinyBigGAMES/GamePascal/blob/master/logo/gp_context_help.gif" alt="GamePascal IDE" height="620" width="800">
