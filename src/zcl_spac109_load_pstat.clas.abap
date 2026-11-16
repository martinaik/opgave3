CLASS zcl_spac109_load_pstat DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.



CLASS ZCL_SPAC109_LOAD_PSTAT IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA lt_status TYPE TABLE OF zspac109_pstat.
    lt_status = VALUE #(
      ( client = sy-mandt status = 'ACTIVE'   description = 'Active' )
      ( client = sy-mandt status = 'INACTIVE' description = 'Inactive' ) ).
    MODIFY zspac109_pstat FROM TABLE @lt_status.
    out->write( |Processed { sy-dbcnt } statuses.| ).
  ENDMETHOD.
ENDCLASS.
