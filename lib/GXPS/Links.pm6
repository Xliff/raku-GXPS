use v6.c;

use Method::Also;

use GXPS::Raw::Types;
use GXPS::Raw::Links;

use GLib::Roles::Implementor;

class GXPS::Link::Target {
  also does GLib::Roles::Implementor;

  has GXPSLinkTarget $!glt is implementor;

  submethod BUILD ( :$gxps-link-target ) {
    $!glt = $gxps-link-target if $gxps-link-target;
  }

  method GXPS::Raw::Definitions::GXPSLinkTarget
    is also<GXPSLinkTarget>
  { $!glt }

  method new (GXPSLinkTarget $gxps-link-target) {
    $gxps-link-target ?? self.bless( :$gxps-link-target ) !! Nil;
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      gxps_link_target_copy($!glt),
      $raw,
      |self.getTypePair
    );
  }

  method free {
    gxps_link_target_free($!glt);
  }

  method get_anchor is also<get-anchor> {
    gxps_link_target_get_anchor($!glt);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gxps_link_target_get_type, $n, $t );
  }

  method get_uri is also<get-uri> {
    gxps_link_target_get_uri($!glt);
  }

  method is_internal is also<is-internal> {
    so gxps_link_target_is_internal($!glt);
  }

}

class GXPS::Link {
  also does GLib::Roles::Implementor;

  has GXPSLink $!gl is implementor;

  submethod BUILD ( :$gxps-link ) {
    $!gl = $gxps-link if $gxps-link;
  }

  method GXPS::Raw::Definitions::GXPSLink
    is also<GXPSLink>
  { $!gl }

  method new (GXPSLink $gxps-link) {
    $gxps-link ?? self.bless( :$gxps-link ) !! Nil;
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      gxps_link_copy($!gl),
      $raw,
      |self.getTypePair
    );
  }

  method free {
    gxps_link_free($!gl);
  }

  # cw: Returns $area!
  method get_area (cairo_rectangle_t() $area) is also<get-area> {
    gxps_link_get_area($!gl, $area);
  }

  method get_target ( :$raw = False ) is also<get-target> {
    propReturnObject(
      gxps_link_get_target($!gl),
      $raw,
      |GXPS::Link::Target.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gxps_link_get_type, $n, $t );
  }

}
