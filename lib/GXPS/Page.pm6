use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use GXPS::Raw::Types;
use GXPS::Raw::Page;

use GLib::GList;
use GXPS::Archive;
use GXPS::Links;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GXPSPageAncestry is export of Mu
  where GXPSPage | GObject;

class GXPS::Page {
  also does GLib::Roles::Object;

  has GXPSPage $!gp is implementor;

  submethod BUILD ( :$gxps-page ) {
    self.setGXPSPage($gxps-page) if $gxps-page
  }

  method setGXPSPage (GXPSPageAncestry $_) {
    my $to-parent;

    $!gp = do {
      when GXPSPage {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GXPSPage, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GXPS::Raw::Definitions::GXPSPage
    is also<GXPSPage>
  { $!gp }

  multi method new (
    $gxps-page where * ~~ GXPSPageAncestry,

    :$ref = True
  ) {
    return unless $gxps-page;

    my $o = self.bless( :$gxps-page );
    $o.ref if $ref;
    $o;
  }

  # Type: GXPSArchive
  method archive is rw  is g-property {
    my $gv = GLib::Value.new( GXPS::Archive.get_type );
    Proxy.new(
      FETCH => sub ($) {
        warn 'archive does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, GXPSArchive() $val is copy {
        $gv.object = $val;
        self.prop_set('archive', $gv);
      }
    );
  }

  # Type: string
  method source is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        warn 'source does not allow reading' if $DEBUG;
        '';
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('source', $gv);
      }
    );
  }

  method error_quark is static is also<error-quark> {
    gxps_page_error_quark();
  }

  # proto method get_anchor_destination (|)
  # { * }
  #
  # multi method get_anchor_destination (
  #   Str()                   $anchor,
  #   CArray[Pointer[GError]] $error   = gerror
  # ) {
  #   my $a = newCArray(cairo_rectangle_t);
  #
  #   samewith(
  #     $anchor,
  #     $a[0],
  #     $error;
  #   );
  # );
  method get_anchor_destination (
    Str()                      $anchor,
    Cairo::cairo_rectangle_t() $area,
    CArray[Pointer[GError]]    $error   = gerror
  )
    is also<get-anchor-destination>
  {
    clear_error;
    my $rv = so gxps_page_get_anchor_destination(
      $!gp,
      $anchor,
      $area,
      $error
    );
    set_error($error);
    $area;
  }

  method get_links (
    CArray[Pointer[GError]]  $error = gerror,
                            :$raw   = False,
                            :$glist = False
  )
    is also<get-links>
  {
    returnGList(
      gxps_page_get_links($!gp, $error),
      $raw,
      $glist,
      |GXPS::Link.getTypePair
    );
  }

  proto method get_size (|)
    is also<get-size>
  { * }

  multi method get_size {
    samewith($, $);
  }
  multi method get_size ($width is rw, $height is rw) {
    my gdouble ($w, $h) = 0e0 xx 2;
    gxps_page_get_size($!gp, $w, $h);
    ($width, $height) = ($w, $h);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gxps_page_get_type, $n, $t );
  }

  method render (
    Cairo::cairo_t()        $cr,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rv= so gxps_page_render($!gp, $cr, $error);
    set_error($error);
    $rv;
  }

}
