use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GXPS::Raw::Definitions;

unit package GPXS::Raw::File;

### /usr/src/libgxps/libgxps/gxps-file.h

sub gxps_file_error_quark
  returns GQuark
  is      native(gxps)
  is      export
{ * }

sub gxps_file_get_core_properties (
  GXPSFile                $xps,
  CArray[Pointer[GError]] $error
)
  returns GXPSCoreProperties
  is      native(gxps)
  is      export
{ * }

sub gxps_file_get_document (
  GXPSFile                $xps,
  guint                   $n_doc,
  CArray[Pointer[GError]] $error
)
  returns GXPSDocument
  is      native(gxps)
  is      export
{ * }

sub gxps_file_get_document_for_link_target (
  GXPSFile       $xps,
  GXPSLinkTarget $target
)
  returns gint
  is      native(gxps)
  is      export
{ * }

sub gxps_file_get_n_documents (GXPSFile $xps)
  returns guint
  is      native(gxps)
  is      export
{ * }

sub gxps_file_get_type
  returns GType
  is      native(gxps)
  is      export
{ * }

sub gxps_file_new (
  GFile                   $filename,
  CArray[Pointer[GError]] $error
)
  returns GXPSFile
  is      native(gxps)
  is      export
{ * }
