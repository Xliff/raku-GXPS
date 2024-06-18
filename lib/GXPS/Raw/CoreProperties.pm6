use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GXPS::Raw::Definitions;

unit package GXPS::Raw::CoreProperties;

### /usr/src/libgxps/libgxps/gxps-core-properties.h

sub gxps_core_properties_get_category (GXPSCoreProperties $core_props)
  returns Str
  is      native(gxps)
  is      export
{ * }

sub gxps_core_properties_get_content_status (
  GXPSCoreProperties $core_props
)
  returns Str
  is      native(gxps)
  is      export
{ * }

sub gxps_core_properties_get_content_type (
  GXPSCoreProperties $core_props
)
  returns Str
  is      native(gxps)
  is      export
{ * }

sub gxps_core_properties_get_created (GXPSCoreProperties $core_props)
  returns time_t
  is      native(gxps)
  is      export
{ * }

sub gxps_core_properties_get_creator (GXPSCoreProperties $core_props)
  returns Str
  is      native(gxps)
  is      export
{ * }

sub gxps_core_properties_get_description (GXPSCoreProperties $core_props)
  returns Str
  is      native(gxps)
  is      export
{ * }

sub gxps_core_properties_get_identifier (GXPSCoreProperties $core_props)
  returns Str
  is      native(gxps)
  is      export
{ * }

sub gxps_core_properties_get_keywords (GXPSCoreProperties $core_props)
  returns Str
  is      native(gxps)
  is      export
{ * }

sub gxps_core_properties_get_language (GXPSCoreProperties $core_props)
  returns Str
  is      native(gxps)
  is      export
{ * }

sub gxps_core_properties_get_last_modified_by (
  GXPSCoreProperties $core_props
)
  returns Str
  is      native(gxps)
  is      export
{ * }

sub gxps_core_properties_get_last_printed (GXPSCoreProperties $core_props)
  returns time_t
  is      native(gxps)
  is      export
{ * }

sub gxps_core_properties_get_modified (GXPSCoreProperties $core_props)
  returns time_t
  is      native(gxps)
  is      export
{ * }

sub gxps_core_properties_get_revision (GXPSCoreProperties $core_props)
  returns Str
  is      native(gxps)
  is      export
{ * }

sub gxps_core_properties_get_subject (GXPSCoreProperties $core_props)
  returns Str
  is      native(gxps)
  is      export
{ * }

sub gxps_core_properties_get_title (GXPSCoreProperties $core_props)
  returns Str
  is      native(gxps)
  is      export
{ * }

sub gxps_core_properties_get_type
  returns GType
  is      native(gxps)
  is      export
{ * }

sub gxps_core_properties_get_version (GXPSCoreProperties $core_props)
  returns Str
  is      native(gxps)
  is      export
{ * }
