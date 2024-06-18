use v6.c;

use NativeCall;

use Cairo;
use GLib::Raw::Definitions;
use GXPS::Raw::Definitions;

unit package GXPS::Raw::Links;

### /usr/src/libgxps/libgxps/gxps-links.h

sub gxps_link_copy (GXPSLink $link)
  returns GXPSLink
  is      native(gxps)
  is      export
{ * }

sub gxps_link_free (GXPSLink $link)
  is      native(gxps)
  is      export
{ * }

sub gxps_link_get_area (
  GXPSLink                 $link,
  Cairo::cairo_rectangle_t $area
)
  is      native(gxps)
  is      export
{ * }

sub gxps_link_get_target (GXPSLink $link)
  returns GXPSLinkTarget
  is      native(gxps)
  is      export
{ * }

sub gxps_link_get_type
  returns GType
  is      native(gxps)
  is      export
{ * }

sub gxps_link_target_copy (GXPSLinkTarget $target)
  returns GXPSLinkTarget
  is      native(gxps)
  is      export
{ * }

sub gxps_link_target_free (GXPSLinkTarget $target)
  is      native(gxps)
  is      export
{ * }

sub gxps_link_target_get_anchor (GXPSLinkTarget $target)
  returns Str
  is      native(gxps)
  is      export
{ * }

sub gxps_link_target_get_type
  returns GType
  is      native(gxps)
  is      export
{ * }

sub gxps_link_target_get_uri (GXPSLinkTarget $target)
  returns Str
  is      native(gxps)
  is      export
{ * }

sub gxps_link_target_is_internal (GXPSLinkTarget $target)
  returns uint32
  is      native(gxps)
  is      export
{ * }
