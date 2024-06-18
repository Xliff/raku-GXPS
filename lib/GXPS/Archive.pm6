use v6.c;

use NativeCall;

use GXPS::Raw::Types;
use GXPS::Raw::Archive;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

use GIO::Roles::Initable;
use GIO::Roles::GFile;

class GXPS::Archive {
  also does GLib::Roles::Object;

  has GXPSArchive $!ga is implementor;

  method new (GFile() $file, CArray[Pointer[GError]] $error = gerror) {
    clear_error;
    my $gpxs-archive = gxps_archive_new($file, $error);
    set_error($error);

    $gpxs-archive ?? self.bless( :$gpxs-archive ) !! Nil
  }

  # Type: GFile
  method file is rw  is g-property {
    my $gv = GLib::Value.new( GIO::File.get_type );
    Proxy.new(
      FETCH => sub ($) {
        warn 'file does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, GFile() $val is copy {
        $gv.object = $val;
        self.prop_set('file', $gv);
      }
    );
  }

  method get_resources ( :$raw = False ) {
    propReturnObject(
      gxps_archive_get_resources($!ga),
      $raw,
      |GXPS::Resources.getTypePair
    );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gxps_archive_get_type, $n, $t );
  }

  method has_entry (Str() $path) {
    so gxps_archive_has_entry($!ga, $path);
  }

  method open (Str() $path, :$raw = False) {
    propReturnObject(
      gxps_archive_open($!ga, $path),
      $raw,
      |GIO::InputStream.getTypePair
    );
  }

  method read_entry (
    Str()                     $path,
    CArray[Str]               $buffer,
                              $bytes_read is rw,
    CArray[Pointer[GError]]   $error             = gerror,
                             :$all               = False
  ) {
    my gsize $r = 0;

    clear_error;
    gxps_archive_read_entry($!ga, $path, $buffer, $r, $error);
    set_error($error);

    my ($rb, $s) = ( ppr($buffer), $bytes_read = $r );

    $all.not ?? $rb !! ($rb, $s);
  }

}
