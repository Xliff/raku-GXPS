use v6.c;

use Method::Also;
use NativeCall;

use GXPS::Raw::Types;
use GXPS::Raw::Document;

use GXPS::Page;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GXPSDocumentAncestry is export of Mu
  where GXPSDocument | GObject;

class GXPS::Document {
  also does GLib::Roles::Object;
  also does Positional;

  has GXPSDocument $!gd is implementor;

  submethod BUILD ( :$gxps-doc ) {
    self.setGXPSDocument($gxps-doc) if $gxps-doc
  }

  method setGXPSDocument (GXPSDocumentAncestry $_) {
    my $to-parent;

    $!gd = do {
      when GXPSDocument {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GXPSDocument, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GXPS::Raw::Definitions::GXPSDocument
    is also<GXPSDocument>
  { $!gd }

  multi method new (
    $gxps-doc where * ~~ GXPSDocumentAncestry,

    :$ref = True
  ) {
    return unless $gxps-doc;

    my $o = self.bless( :$gxps-doc );
    $o.ref if $ref;
    $o;
  }

  method get_n_pages is also<get-n-pages> {
    gxps_document_get_n_pages($!gd);
  }

  method AT-POS (\k) is also<AT_POS> {
    self.get_page(\k);
  }
  method get_page (
    Int()                    $n_page,
    CArray[Pointer[GError]]  $error   = gerror,
                            :$raw     = False
  )
    is also<get-page>
  {
    my guint $n = $n_page;

    clear_error;
    my $p = gxps_document_get_page($!gd, $n, $error);
    set_error($error);
    propReturnObject($p, $raw, |GXPS::Page.getTypePair);
  }

  method get_page_for_anchor (Str() $anchor, :$raw = False)
    is also<get-page-for-anchor>
  {
    propReturnObject(
      gxps_document_get_page_for_anchor($!gd, $anchor),
      $raw,
      |GXPS::Page.getTypePair
    );
  }

  proto method get_page_size (|)
    is also<get-page-size>
  { * }

  multi method get_page_size (Int() $n_page) {
    samewith($n_page, $, $);
  }
  multi method get_page_size (Int() $n_page, $width  is rw, $height is rw) {
    my guint    $n      = $n_page;
    my gdouble ($w, $h) = 0e0 xx 2;

    gxps_document_get_page_size($!gd, $n_page, $w, $h);
    ($width, $height) = ($w, $h);
  }

  method get_structure ( :$raw = False ) is also<get-structure> {
    propReturnObject(
      gxps_document_get_structure($!gd),
      $raw,
      |GXPS::Document::Structure.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gxps_document_get_type, $n, $t );
  }

  method iterator {
    generate-iterator (
      self,
      SUB      { self.get_n_pages },
      sub (\k) { self.AT-POS(k) }
    )
  }

}
