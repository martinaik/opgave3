
CLASS zcl_spac109_data_loader DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS:
      fill_table
        RETURNING VALUE(r_output) TYPE string
        RAISING cx_sy_open_sql_db,
      cleanup
        RETURNING VALUE(r_output) TYPE STRING.

ENDCLASS.


CLASS zcl_spac109_data_loader IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    out->write( cleanup(  ) ).

    TRY.
      out->write( fill_table(  ) ).
    CATCH cx_sy_open_sql_db INTO DATA(lx).
      out->write( |Couldn't write entries to table. Error: { lx->get_longtext(  ) }| ).
    ENDTRY.

  ENDMETHOD.


  METHOD fill_table.

    DATA: temp_table TYPE TABLE OF zspac109_stock.

    temp_table = VALUE #(
      ( warehouse_id = 1 product_id = 1 amount =   3 )
      ( warehouse_id = 3 product_id = 4 amount =  42 )
      ( warehouse_id = 2 product_id = 5 amount =   1 )
      ( warehouse_id = 3 product_id = 5 amount = 321 )
      ( warehouse_id = 3 product_id = 1 amount =  20 )
      ( warehouse_id = 1 product_id = 5 amount =   9 )
      ( warehouse_id = 2 product_id = 3 amount =   5 )
      ( warehouse_id = 3 product_id = 2 amount =   4 )
      ( warehouse_id = 1 product_id = 4 amount =   0 )
      ( warehouse_id = 3 product_id = 3 amount =   8 )
      ( warehouse_id = 1 product_id = 3 amount = 100 )
      ( warehouse_id = 1 product_id = 2 amount =   7 )
      ( warehouse_id = 2 product_id = 4 amount =   0 )
    ).

    TRY.
      INSERT zspac109_stock FROM TABLE @( CORRESPONDING #( temp_table ) ).

    CATCH cx_sy_open_sql_db INTO DATA(lx).
      RAISE EXCEPTION lx.
    ENDTRY.

    r_output = |Inserted { sy-dbcnt } entries into table.|.

  ENDMETHOD.

  METHOD cleanup.

    DELETE FROM zspac109_stock.

    IF sy-subrc <> 0.
      ROLLBACK WORK.
      r_output = |Cleanup failed. Error: { sy-subrc }.|.
    ELSE.
      COMMIT WORK.
      r_output = |Successfully cleaned up { sy-dbcnt } entries.|.
    ENDIF.

  ENDMETHOD.
ENDCLASS.

