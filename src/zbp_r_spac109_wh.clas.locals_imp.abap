CLASS lhc_ZR_SPAC109_WH DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR Warehouse RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR Warehouse RESULT result.

    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE Warehouse.

    METHODS validateUniqueName FOR VALIDATE ON SAVE
      IMPORTING keys FOR Warehouse~validateUniqueName.

    METHODS validateMandatory FOR VALIDATE ON SAVE
      IMPORTING keys FOR Warehouse~validateMandatory.

    METHODS validatePostalCode FOR VALIDATE ON SAVE
      IMPORTING keys FOR Warehouse~validatePostalCode.

    METHODS precheck_delete FOR PRECHECK
      IMPORTING keys FOR DELETE Warehouse.

ENDCLASS.

CLASS lhc_ZR_SPAC109_WH IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.

    IF requested_authorizations-%create = if_abap_behv=>mk-on.
      result-%create = if_abap_behv=>auth-allowed.
    ENDIF.

  ENDMETHOD.

  METHOD earlynumbering_create.
    LOOP AT entities INTO DATA(entity_with_id) WHERE WarehouseId IS NOT INITIAL.
      APPEND VALUE #( %cid        = entity_with_id-%cid
                      %is_draft   = entity_with_id-%is_draft
                      WarehouseId = entity_with_id-WarehouseId ) TO mapped-warehouse.
    ENDLOOP.

    DATA(entities_wo_id) = entities.
    DELETE entities_wo_id WHERE WarehouseId IS NOT INITIAL.
    CHECK entities_wo_id IS NOT INITIAL.

    SELECT MAX( warehouse_id ) FROM zspac109_wh INTO @DATA(lv_max_active).
    SELECT MAX( warehouseid )  FROM zdspac109_wh    INTO @DATA(lv_max_draft).

    DATA(lv_next) = nmax( val1 = lv_max_active val2 = lv_max_draft ).

    LOOP AT entities_wo_id INTO DATA(entity).
      lv_next += 1.
      APPEND VALUE #( %cid        = entity-%cid
                      %is_draft   = entity-%is_draft
                      WarehouseId = lv_next ) TO mapped-warehouse.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateUniqueName.
    READ ENTITIES OF zr_spac109_wh IN LOCAL MODE
      ENTITY Warehouse
        FIELDS ( WarehouseName )
        WITH CORRESPONDING #( keys )
      RESULT DATA(warehouses).

    LOOP AT warehouses INTO DATA(warehouse).

      APPEND VALUE #( %tky        = warehouse-%tky
                      %state_area = 'VALIDATE_WHNAME' ) TO reported-warehouse.

      CHECK warehouse-WarehouseName IS NOT INITIAL.

      SELECT SINGLE warehouse_id
        FROM zspac109_wh
        WHERE upper( warehouse_name ) = @( to_upper( condense( warehouse-WarehouseName ) ) )
          AND warehouse_id <> @warehouse-WarehouseId
        INTO @DATA(lv_existing_id).

      IF sy-subrc = 0.
        APPEND VALUE #( %tky = warehouse-%tky ) TO failed-warehouse.
        APPEND VALUE #( %tky        = warehouse-%tky
                        %state_area = 'VALIDATE_WHNAME'
                        %msg        = new_message_with_text(
                                        severity = if_abap_behv_message=>severity-error
                                        text     = |The warehouse "{ warehouse-WarehouseName }" already exists (ID { lv_existing_id }).| )
                        %element-WarehouseName = if_abap_behv=>mk-on ) TO reported-warehouse.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateMandatory.
    READ ENTITIES OF zr_spac109_wh IN LOCAL MODE
      ENTITY Warehouse
        FIELDS ( WarehouseName Address City PostalCode )
        WITH CORRESPONDING #( keys )
      RESULT DATA(warehouses).

    LOOP AT warehouses INTO DATA(warehouse).

      APPEND VALUE #( %tky        = warehouse-%tky
                      %state_area = 'VALIDATE_MANDATORY' ) TO reported-warehouse.

      DATA(lv_name)     = condense( warehouse-WarehouseName ).
      DATA(lv_address) = condense( warehouse-Address ).
      DATA(lv_city)     = condense( warehouse-City ).
      DATA(lv_postalcode) = condense( warehouse-PostalCode ).

      IF lv_name IS INITIAL.
        APPEND VALUE #( %tky = warehouse-%tky ) TO failed-warehouse.
        APPEND VALUE #( %tky        = warehouse-%tky
                        %state_area = 'VALIDATE_MANDATORY'
                        %msg        = new_message_with_text(
                                        severity = if_abap_behv_message=>severity-error
                                        text     = 'Warehouse name is required' )
                        %element-WarehouseName = if_abap_behv=>mk-on ) TO reported-warehouse.
      ENDIF.

      IF lv_address IS INITIAL.
        APPEND VALUE #( %tky = warehouse-%tky ) TO failed-warehouse.
        APPEND VALUE #( %tky        = warehouse-%tky
                        %state_area = 'VALIDATE_MANDATORY'
                        %msg        = new_message_with_text(
                                        severity = if_abap_behv_message=>severity-error
                                        text     = 'Address is required.' )
                        %element-Address = if_abap_behv=>mk-on ) TO reported-warehouse.
      ENDIF.

      IF lv_city IS INITIAL.
        APPEND VALUE #( %tky = warehouse-%tky ) TO failed-warehouse.
        APPEND VALUE #( %tky        = warehouse-%tky
                        %state_area = 'VALIDATE_MANDATORY'
                        %msg        = new_message_with_text(
                                        severity = if_abap_behv_message=>severity-error
                                        text     = 'City is required.' )
                        %element-City = if_abap_behv=>mk-on ) TO reported-warehouse.
      ENDIF.

      IF lv_postalcode IS INITIAL.
        APPEND VALUE #( %tky = warehouse-%tky ) TO failed-warehouse.
        APPEND VALUE #( %tky        = warehouse-%tky
                        %state_area = 'VALIDATE_MANDATORY'
                        %msg        = new_message_with_text(
                                        severity = if_abap_behv_message=>severity-error
                                        text     = 'Postal code is required.' )
                        %element-PostalCode = if_abap_behv=>mk-on ) TO reported-warehouse.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validatePostalCode.
    READ ENTITIES OF zr_spac109_wh IN LOCAL MODE
      ENTITY Warehouse
        FIELDS ( PostalCode )
        WITH CORRESPONDING #( keys )
      RESULT DATA(warehouses).

    LOOP AT warehouses INTO DATA(warehouse).

      APPEND VALUE #( %tky        = warehouse-%tky
                      %state_area = 'VALIDATE_POSTALCODE' ) TO reported-warehouse.

      DATA(lv_postal) = condense( |{ warehouse-PostalCode }| ).

      IF strlen( lv_postal ) <> 4 OR lv_postal CN '0123456789'.
        APPEND VALUE #( %tky = warehouse-%tky ) TO failed-warehouse.
        APPEND VALUE #( %tky        = warehouse-%tky
                        %state_area = 'VALIDATE_POSTALCODE'
                        %msg        = new_message_with_text(
                                        severity = if_abap_behv_message=>severity-error
                                        text     = 'Postal code must be exactly 4 digits (e.g. 2300).' )
                        %element-PostalCode = if_abap_behv=>mk-on ) TO reported-warehouse.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD precheck_delete.
    LOOP AT keys INTO DATA(key).

      SELECT SINGLE warehouse_id
        FROM zspac109_stock
        WHERE warehouse_id = @key-WarehouseId
        INTO @DATA(lv_stock_wh).

      IF sy-subrc = 0.
        APPEND VALUE #( %tky = key-%tky ) TO failed-warehouse.
        APPEND VALUE #( %tky = key-%tky
                        %msg = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text     = |The warehouse { key-WarehouseId } has stock and cannot be deleted.| ) ) TO reported-warehouse.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
