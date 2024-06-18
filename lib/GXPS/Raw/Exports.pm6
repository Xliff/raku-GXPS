use v6.c;

unit package GXPS::Raw::Exports;

our @gxps-exports is export;

BEGIN {
  @gxps-exports = <
    GXPS::Raw::Definitions
  >;
}
