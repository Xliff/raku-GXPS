use v6.c;

use Method::Also;

use GXPS::Raw::Types;
use GXPS::Raw::CoreProperties;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GXPSCorePropertiesAncestry is export of Mu
  where GXPSCoreProperties | GObject;

class GXPS::CoreProperties {
  also does GLib::Roles::Object;

  has GXPSCoreProperties $!gcp is implementor;

  submethod BUILD ( :$gxps-core-prop ) {
    self.setGXPSCoreProperties($gxps-core-prop) if $gxps-core-prop
  }

  method setGXPSCoreProperties (GXPSCorePropertiesAncestry $_) {
    my $to-parent;

    $!gcp = do {
      when GXPSCoreProperties {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GXPSCoreProperties, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GXPS::Raw::Definitions::GXPSCoreProperties
    is also<GXPSCoreProperties>
  { $!gcp }

  multi method new (
    $gxps-core-prop where * ~~ GXPSCorePropertiesAncestry,

    :$ref = True
  ) {
    return unless $gxps-core-prop;

    my $o = self.bless( :$gxps-core-prop );
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

  method get_category
		is also<
			get-category
			category
		>
	{
    gxps_core_properties_get_category($!gcp);
  }

  method get_content_status
		is also<
			get-content-status
			content-status
      content_status
		>
	{
    gxps_core_properties_get_content_status($!gcp);
  }

  method get_content_type
		is also<
			get-content-type
			content-type
      content_type
		>
	{
    gxps_core_properties_get_content_type($!gcp);
  }

  method get_created
		is also<
			get-created
			created
		>
	{
    gxps_core_properties_get_created($!gcp);
  }

  method get_creator
		is also<
			get-creator
			creator
		>
	{
    gxps_core_properties_get_creator($!gcp);
  }

  method get_description
		is also<
			get-description
			description
		>
	{
    gxps_core_properties_get_description($!gcp);
  }

  method get_identifier
		is also<
			get-identifier
			identifier
		>
	{
    gxps_core_properties_get_identifier($!gcp);
  }

  method get_keywords
		is also<
			get-keywords
			keywords
		>
	{
    gxps_core_properties_get_keywords($!gcp);
  }

  method get_language
		is also<
			get-language
			language
		>
	{
    gxps_core_properties_get_language($!gcp);
  }

  method get_last_modified_by
		is also<
			get-last-modified-by
			last-modified-by
      last_modified_by
		>
	{
    gxps_core_properties_get_last_modified_by($!gcp);
  }

  method get_last_printed
		is also<
			get-last-printed
			last-printed
      last_printed
		>
	{
    gxps_core_properties_get_last_printed($!gcp);
  }

  method get_modified
		is also<
			get-modified
			modified
		>
	{
    gxps_core_properties_get_modified($!gcp);
  }

  method get_revision
		is also<
			get-revision
			revision
		>
	{
    gxps_core_properties_get_revision($!gcp);
  }

  method get_subject
		is also<
			get-subject
			subject
		>
	{
    gxps_core_properties_get_subject($!gcp);
  }

  method get_title
		is also<
			get-title
			title
		>
	{
    gxps_core_properties_get_title($!gcp);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gxps_core_properties_get_type, $n, $t )
  }

  method get_version
		is also<
			get-version
			version
		>
	{
    gxps_core_properties_get_version($!gcp);
  }

}
