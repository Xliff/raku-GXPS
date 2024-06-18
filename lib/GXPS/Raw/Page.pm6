use v6.c;

use NativeCall;

use Cairo;
use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GXPS::Raw::Definitions;

unit package GXPS::Raw::Page;

### /usr/src/libgxps/libgxps/gxps-page.h

sub gxps_page_error_quark
  returns GQuark
  is      native(gxps)
  is      export
{ * }

sub gxps_page_get_anchor_destination (
  Str                      $anchor,
  Cairo::cairo_rectangle_t $area,
  CArray[Pointer[GError]]  $error
)
  returns uint32
  is      native(gxps)
  is      export
{ * }

sub gxps_page_get_links (
  GXPSPage                $page,
  CArray[Pointer[GError]] $error
)
  returns GList
  is      native(gxps)
  is      export
{ * }

sub gxps_page_get_size (
  GXPSPage $page,
  gdouble  $width is rw,
  gdouble  $height is rw
)
  is      native(gxps)
  is      export
{ * }

sub gxps_page_get_type
  returns GType
  is      native(gxps)
  is      export
{ * }

sub gxps_page_render (
  GXPSPage                $page,
  Cairo::cairo_t          $cr,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gxps)
  is      export
{ * }
