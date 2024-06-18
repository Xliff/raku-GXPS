use v6.c;

use GLib::Raw::Exports;
use ATK::Raw::Exports;
use Pango::Raw::Exports;
use GIO::Raw::Exports;
use GDK::Raw::Exports:ver<3>;
use GTK::Raw::Exports:ver<3>;
use GXPS::Raw::Exports;

my constant forced = 0;

unit package GXPS::Raw::Types;

need Cairo;
need GLib::Raw::Debug;
need GLib::Raw::Definitions;
need GLib::Raw::Enums;
need GLib::Raw::Exceptions;
need GLib::Raw::Object;
need GLib::Raw::Structs;
need GLib::Raw::Struct_Subs;
need GLib::Raw::Subs;
need GLib::Roles::Pointers;
need GLib::Roles::Implementor;
need ATK::Raw::Definitions;
need ATK::Raw::Enums;
need ATK::Raw::Structs;
need Pango::Raw::Definitions;
need Pango::Raw::Enums;
need Pango::Raw::Structs;
need Pango::Raw::Subs;
need GIO::DBus::Raw::Types;
need GIO::Raw::Definitions;
need GIO::Raw::Enums;
need GIO::Raw::Quarks;
need GIO::Raw::Structs;
need GIO::Raw::Subs;
need GDK::Raw::Definitions:ver<3>;
need GDK::Raw::Enums:ver<3>;
need GDK::Raw::Structs:ver<3>;
need GDK::Raw::Subs:ver<3>;
need GTK::Raw::Definitions:ver<3>;
need GTK::Raw::Enums:ver<3>;
need GTK::Raw::Requisition:ver<3>;
need GTK::Raw::Structs:ver<3>;
need GTK::Raw::Subs:ver<3>;
need GXPS::Raw::Definitions;

BEGIN {
  glib-re-export($_) for 'Cairo',
                         |@glib-exports,
                         |@atk-exports,
                         |@pango-exports,
                         |@gio-exports,
                         |@gdk-exports,
                         |@gtk-exports,
                         |@gxps-exports;
}
