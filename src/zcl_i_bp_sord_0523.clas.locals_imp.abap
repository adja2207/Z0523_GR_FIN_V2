CLASS lhc_header DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR header RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR header RESULT result.

    METHODS createTravelByTemplate FOR MODIFY
      IMPORTING keys FOR ACTION header~createTravelByTemplate RESULT result.

    METHODS validatestatus FOR VALIDATE ON SAVE
      IMPORTING keys FOR header~validatestatus.

ENDCLASS.

CLASS lhc_header IMPLEMENTATION.

  METHOD get_instance_features.


  ENDMETHOD.

  METHOD get_instance_authorizations.
   DATA(lv_auth) = COND #( WHEN
  cl_abap_context_info=>get_user_technical_name( ) EQ
  'CB9980000523'
  THEN if_abap_behv=>auth-allowed

  ELSE if_abap_behv=>auth-unauthorized ).

    LOOP AT keys ASSIGNING FIELD-SYMBOL(<ls_keys>).

      APPEND INITIAL LINE TO result ASSIGNING FIELD-SYMBOL(<ls_result>).

      <ls_result> = VALUE #( %key = <ls_keys>-%key
                             %op-%update
      = lv_auth %delete
      = lv_auth %action-createTravelByTemplate
      = lv_auth %assoc-_item
      = lv_auth ).
    ENDLOOP.
  ENDMETHOD.

  METHOD createTravelByTemplate.

   READ ENTITIES OF zcd_i_sord_0523 in local mode
    ENTITY header
    FIELDS ( Idsales  Firstname  Lastname Country Email  Deliverydate Createon Orderstatus Imagenurl )
    WITH VALUE #( FOR row_key IN keys ( %key = row_key-%key ) )
    RESULT DATA(lt_entity_order)
    FAILED failed
    REPORTED reported.

    DATA lt_create_order TYPE TABLE FOR CREATE
    zcd_i_sord_0523\\header.

    SELECT MAX( Idsales ) FROM ztb_sord_0523
    INTO @DATA(lv_order_id).

    DATA(lv_today) = cl_abap_context_info=>get_system_date(  ).


    lt_create_order = VALUE #( FOR create_row IN
    lt_entity_order INDEX INTO Idsales (  idsales =  lv_order_id + Idsales
    Email      = create_row-Email
    Firstname  = create_row-Firstname
    Lastname   = create_row-Lastname
    Country    = create_row-Country
    Createon   =   lv_today
    Deliverydate = lv_today + 30
    Orderstatus = '2'
    Imagenurl   = create_row-Imagenurl ) ).

    MODIFY ENTITIES OF zcd_i_sord_0523
    IN LOCAL MODE ENTITY header
    CREATE FIELDS ( Idsales Email  Firstname Lastname Country  Createon Deliverydate Orderstatus Imagenurl )
    WITH lt_create_order
    MAPPED mapped
    FAILED failed
    REPORTED reported.
    result = VALUE #( FOR result_row IN lt_create_order INDEX INTO idx
    ( %cid_ref = keys[ idx ]-%cid_ref
      %key = keys[ idx ]-%key
     %param = CORRESPONDING #( result_row ) ) ).

  ENDMETHOD.

  METHOD validatestatus.
      READ ENTITY zcd_i_sord_0523\\header
     FIELDS ( Orderstatus )
    WITH VALUE #( FOR <row_key> IN keys ( %key = <row_key>-%key ) )
    RESULT DATA(lt_order_result).
    LOOP AT lt_order_result INTO DATA(ls_order_result).
      CASE ls_order_result-orderstatus.
        WHEN '1'.
        WHEN '2'.
        WHEN '3'.
        WHEN OTHERS.
          APPEND VALUE #( %key = ls_order_result-%key ) TO failed-header.
          APPEND VALUE #( %key = ls_order_result-%key
                          %msg = new_message( id = 'ZMC_SORD_0523'
                                               number = '004'
                                               v1 = ls_order_result-orderstatus
                                               severity = if_abap_behv_message=>severity-error )
                                               %element-orderstatus = if_abap_behv=>mk-on ) TO reported-header.
      ENDCASE.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZCD_I_SORD_0523 DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZCD_I_SORD_0523 IMPLEMENTATION.

  METHOD save_modified.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
