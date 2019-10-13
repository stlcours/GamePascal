<img align="left" src="https://github.com/tinyBigGAMES/GamePascal/blob/master/logo/GamePascal_256x256.png" width=256>

# GamePascal&trade; for Windows
Game Development System

## Overview
GamePascal™ Game Development System is a modern, modular, object oriented programming language based on a Object Pascal, a light-weight IDE (GamePascal Edit) and an advanced 2D game library (GamePascal Library) for Windows® PC. The engine uses Direct3D®/OpenGL® for hardware accelerated rendering. It's robust, designed for easy use and suitable for making all types of 2D games and other graphic simulations. There is support for surfaces, textures, sprites, audio, streams, archives, configuration files, render targets, swap chains, databases and much more.

## Language Features
* GamePascal language is modern, modular, object oriented and based on the Object Pascal.
* Namespaces, nested classes, inheritance
* Static(shared) members, indexed properties, default parameters.
* Overloaded routines, operator overloading, delegates, exception handling, regular expressions.
* Conditional compilation. 
* Direct calling dll-defined routines. 
* All calling conventions register, pascal, cdecl, stdcall, safecall are supported.
* Delphi 7+ level feature support.

## IDE Features
* Toggle Code Folding
* Line numbers
* Syntax Highlighting
* Project Options
* User Registration/Feedback from IDE (Help->Register/Feedback)
* File operations: open, close, close all, save, save all, print/preview
* Edit operations: undo, redo, cut, copy, past, select all
* Search operations: find, find again, find/replace
* Compile/Compile & Run
* Parameter Hints (Shift+Ctrl+Space)
* Code Completion (Ctrl+Space)
* Code Templates (Ctrl+J)
* Char Pop-up (Ctrl+.)
* Sync Edit (Shift+Ctrl+J)
* Integrated CHM Help
* Editor Options (Options->Editor Options)
* FontStudio for textured font generation (Tools->FontStudio)
* Context sensitive Help (F1) in the editor (place the cursor on a keyword and press F1 or right click).
* Full GamePascal Library integration
* EXE generation with version info, application icon & high DPI aware support
* Auto increment file version build number
* Persistent editor state

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
* Run GPE.EXE in {installdir\bin} to start the IDE.
* See examples and documentation for more information on using GamePascal.

## Known Issues
* GPE.EXE will run Notepad++ tweaked to work with GamePascal until a proper IDE has been completed.
* There are some issues with exception handling. At this time, it is recommend not to use it (try/finally, try/exception).