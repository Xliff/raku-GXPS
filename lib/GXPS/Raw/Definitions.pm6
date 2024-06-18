use v6.c

use NativeCall;

use Cairo;
use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GLib::Raw::Object;
use GIO::Raw::Definitions;

use GLib::Roles::Pointers;

unit package GXPS::Raw::Definitions;

constant gxps is export = 'gxps',v0;

constant GXPS_COLOR_MAX_CHANNELS is export = 8;

our constant cairo_fill_rule_t := uint32;
our constant cairo_line_cap_t  := uint32;
our constant cairo_line_join_t := uint32;

class GXPSLink          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GXPSLinkTarget    is repr<CPointer> does GLib::Roles::Pointers is export { }
class GXPSRenderContext is repr<CPointer> does GLib::Roles::Pointers is export { }
class GXPSResources     is repr<CPointer> does GLib::Roles::Pointers is export { }

class GXPSColor is repr<CStruct> does GLib::Roles::Pointers is export {
  has gdouble $.alpha  is rw;
  has gdouble $.red    is rw;
  has gdouble $.green  is rw;
  has gdouble $.blue   is rw;

  method a is rw { $!alpha }
  method r is rw { $!red   }
  method g is rw { $!green }
  method b is rw { $!blue  }
}

class GXPSBrush is repr<CStruct> does GLib::Roles::Pointers is export {
  has GXPSRenderContext      $.ctx    ;
  has Cairo::cairo_pattern_t $!pattern;
  has gdouble                $.opacity  is rw;

  method pattern is rw {
    Proxy.new:
      FETCH => -> $ { $!pattern },

      STORE => -> $, Cairo::cairo_pattern_t() $v {
        X::GLib::InvalidType.new(
          message => 'Value is not cairo_pattern_t compatible!'
        ).throw unless $v ~~ Cairo::cairo_pattern_t;
        $!pattern := $v;
      }
  }

}

class GXPSArchive is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS GObject       $.parent;
  has gboolean      $.initialized;
  has GError        $!init_error;
  has GFile         $!filename;
  has GHashTable    $!entries;
  has GXPSResources $!resources;

  method resources is rw {
    Proxy.new:
      FETCH => -> $                     { $!resources }
      STORE => -> $, GXPSResources() \v { $!resources := v }
  }

}

class GXPSPath is repr<CStruct> does GLib::Roles::Pointers is export {
  has GXPSRenderContext        $.ctx;
  has CArray[uint8]            $.data;
  has CArray[uint8]            $.clip_data;
  has Cairo::cairo_pattern_t   $.fill_pattern;
  has Cairo::cairo_pattern_t   $.stroke_pattern;
  has cairo_fill_rule_t        $.fill_rule;
  has gdouble                  $.line_width;
  has CArray[gdouble]          $.dash;
  has guint                    $.dash_len;
  has gdouble                  $.dash_offset;
  has cairo_line_cap_t         $.line_cap;
  has cairo_line_join_t        $.line_join;
  has gdouble                  $.miter_limit;
  has gdouble                  $.opacity;
  has Cairo::cairo_pattern_t   $.opacity_mask;

  has uint8             $.flags;         #= FLAGS: is-stroked:1, is-filled:1, is-closed:1
};

class GXPSOutlineIter is repr<CStruct> does GLib::Roles::Pointers is export {
  has gpointer $!d1;
  has gpointer $!d2;
}

constant GXPSError is export := guint32;
our enum GXPSErrorEnum is export <
  GXPS_ERROR_SOURCE_NOT_FOUND
  GXPS_ERROR_FONT
  GXPS_ERROR_IMAGE
>;

constant GXPSFileError is export := guint32;
our enum GXPSFileErrorEnum is export <
  GXPS_FILE_ERROR_INVALID
>;

constant GXPSPageError is export := guint32;
our enum GXPSPageErrorEnum is export <
  GXPS_PAGE_ERROR_INVALID
  GXPS_PAGE_ERROR_RENDER
  GXPS_PAGE_ERROR_INVALID_ANCHOR
>;
