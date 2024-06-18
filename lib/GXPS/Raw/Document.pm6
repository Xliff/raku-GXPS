use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GXPS::Raw::Definitions;

unit package GXPS::Raw::Document;

### /usr/src/libgxps/libgxps/gxps-document.h

sub gxps_document_get_n_pages (GXPSDocument $doc)
  returns guint
  is      native(gxps)
  is      export
{ * }

sub gxps_document_get_page (
  GXPSDocument            $doc,
  guint                   $n_page,
  CArray[Pointer[GError]] $error
)
  returns GXPSPage
  is      native(gxps)
  is      export
{ * }

sub gxps_document_get_page_for_anchor (
  GXPSDocument $doc,
  Str          $anchor
)
  returns gint
  is      native(gxps)
  is      export
{ * }

sub gxps_document_get_page_size (
  GXPSDocument $doc,
  guint        $n_page,
  gdouble      $width   is rw,
  gdouble      $height  is rw
)
  returns uint32
  is      native(gxps)
  is      export
{ * }

sub gxps_document_get_structure (GXPSDocument $doc)
  returns GXPSDocumentStructure
  is      native(gxps)
  is      export
{ * }

sub gxps_document_get_type
  returns GType
  is      native(gxps)
  is      export
{ * }
