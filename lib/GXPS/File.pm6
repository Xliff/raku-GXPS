use v6.c;

use Method::Also;
use NativeCall;

use GXPS::Raw::Types;
use GXPS::Raw::File;

use GXPS::CoreProperties;
use GXPS::Document;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use GIO::Roles::GFile;

our subset GXPSFileAncestry is export of Mu
  where GXPSFile | GObject;

class GXPS::File {
  also does GLib::Roles::Object;
  also does Positional;

  has GXPSFile $!gf is implementor;

  submethod BUILD ( :$gxps-file ) {
    self.setGXPSFile($gxps-file) if $gxps-file
  }

  method setGXPSFile (GXPSFileAncestry $_) {
    my $to-parent;

    $!gf = do {
      when GXPSFile {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GXPSFile, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GXPS::Raw::Definitions::GXPSFile
    is also<GXPSFile>
  { $!gf }

  multi method new (
    $gxps-file where * ~~ GXPSFileAncestry,

    :$ref = True
  ) {
    return unless $gxps-file;

    my $o = self.bless( :$gxps-file );
    $o.ref if $ref;
    $o;
  }
  multi method new (GFile() $file, CArray[Pointer[GError]] $error = gerror) {
    clear_error;
    my $gxps-file = gxps_file_new($file, $error);
    set_error($error);

    $gxps-file ?? self.bless( :$gxps-file ) !! Nil;
  }

  # Type: GFile
  method file is rw  is g-property {
    my $gv = GLib::Value.new( GIO::File.get_type );
    Proxy.new(
      FETCH => sub ($) {
        warn 'file does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, GFile()  $val is copy {
        $gv.object = $val;
        self.prop_set('file', $gv);
      }
    );
  }

  method error_quark is static is also<error-quark> {
    gxps_file_error_quark();
  }

  method get_core_properties (
    CArray[Pointer[GError]]  $error = gerror,
                            :$raw   = False
  )
    is also<get-core-properties>
  {
    clear_error;
    my $cp = gxps_file_get_core_properties($!gf, $error);
    set_error($error);
    propReturnObject($cp, $raw, |GXPS::CoreProperties.getTypePair);
  }

  method AT-POS (\k) is also<AT_POS> {
    k < self.get_n_documents ?? self.get_document(k) !! Nil;
  }
  method get_document (
    Int()                    $n_doc,
    CArray[Pointer[GError]]  $error  = gerror,
                            :$raw    = False
  )
    is also<get-document>
  {
    my guint $n = $n_doc;

    clear_error;
    my $d = gxps_file_get_document($!gf, $n, $error);
    set_error($error);
    propReturnObject($d, $raw, |GXPS::Document.getTypePair)
  }

  method get_document_for_link_target (
    GXPSLinkTarget()  $target,
                     :$raw     = False
  )
    is also<get-document-for-link-target>
  {
    propReturnObject(
      gxps_file_get_document_for_link_target($!gf, $target),
      $raw,
      |GXPS::Document.getTypePair
    )
  }

  method get_n_documents
    is also<
      get-n-documents
      elems
    >
  {
    gxps_file_get_n_documents($!gf);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gxps_file_get_type, $n, $t );
  }

  method iterator {
    generate-iterator (
      self,
      SUB      { self.get_n_documents },
      sub (\k) { self.AT-POS(k) }
    )
  }

}
