use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GIO::Raw::Structs;
use GXPS::Raw::Definitions;

unit package GXPS::Raw::Archive;

### /usr/src/libgxps/libgxps/gxps-archive.h

sub gxps_archive_get_resources (GXPSArchive $archive)
  returns GXPSResources
  is      native(gxps)
  is      export
{ * }

sub gxps_archive_get_type
  returns GType
  is      native(gxps)
  is      export
{ * }

sub gxps_archive_has_entry (
  GXPSArchive $archive,
  Str         $path
)
  returns uint32
  is      native(gxps)
  is      export
{ * }

sub gxps_archive_new (
  GFile                   $filename,
  CArray[Pointer[GError]] $error
)
  returns GXPSArchive
  is      native(gxps)
  is      export
{ * }

sub gxps_archive_open (
  GXPSArchive $archive,
  Str         $path
)
  returns GInputStream
  is      native(gxps)
  is      export
{ * }

sub gxps_archive_read_entry (
  GXPSArchive             $archive,
  Str                     $path,
  CArray[Str]             $buffer,
  gsize                   $bytes_read,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gxps)
  is      export
{ * }
