REPORT ztest.
* Made-up sample for testing Trident ABAP Review. No real data.

TABLES bkpf.
DATA: lt_bseg TYPE STANDARD TABLE OF bseg,
      lt_mseg TYPE STANDARD TABLE OF mseg,
      lv_matnr(18) TYPE c,
      lt_return TYPE STANDARD TABLE OF bapiret2,
      lv_bukrs TYPE bukrs.

START-OF-SELECTION.
  BREAK-POINT.

  SELECT *
    FROM bseg
    INTO TABLE lt_bseg
    WHERE bukrs = '1000'.

  SELECT * FROM mseg INTO TABLE lt_mseg.

  LOOP AT lt_bseg INTO DATA(ls_bseg).
    SELECT SINGLE * FROM bkpf INTO @DATA(ls_bkpf)
      WHERE belnr = @ls_bseg-belnr.
    UPDATE bkpf SET bktxt = 'X' WHERE belnr = ls_bseg-belnr.
    COMMIT WORK.
  ENDLOOP.

  CALL FUNCTION 'BAPI_ACC_DOCUMENT_POST'
    TABLES
      return = lt_return.

  IF lv_bukrs = '1000'.
    WRITE: / 'Company 1000'.
  ENDIF.
