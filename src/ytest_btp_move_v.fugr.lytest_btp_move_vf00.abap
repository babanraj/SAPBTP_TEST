*---------------------------------------------------------------------*
*    view related FORM routines
*   generation date: 07.07.2021 at 10:24:00
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: YTEST_BTP_MOVE_V................................*
FORM GET_DATA_YTEST_BTP_MOVE_V.
  PERFORM VIM_FILL_WHERETAB.
*.read data from database.............................................*
  REFRESH TOTAL.
  CLEAR   TOTAL.
  SELECT * FROM YTEST_BTP_MOVE_T WHERE
(VIM_WHERETAB) .
    CLEAR YTEST_BTP_MOVE_V .
YTEST_BTP_MOVE_V-MANDT =
YTEST_BTP_MOVE_T-MANDT .
YTEST_BTP_MOVE_V-FIELD1 =
YTEST_BTP_MOVE_T-FIELD1 .
<VIM_TOTAL_STRUC> = YTEST_BTP_MOVE_V.
    APPEND TOTAL.
  ENDSELECT.
  SORT TOTAL BY <VIM_XTOTAL_KEY>.
  <STATUS>-ALR_SORTED = 'R'.
*.check dynamic selectoptions (not in DDIC)...........................*
  IF X_HEADER-SELECTION NE SPACE.
    PERFORM CHECK_DYNAMIC_SELECT_OPTIONS.
  ELSEIF X_HEADER-DELMDTFLAG NE SPACE.
    PERFORM BUILD_MAINKEY_TAB.
  ENDIF.
  REFRESH EXTRACT.
ENDFORM.
*---------------------------------------------------------------------*
FORM DB_UPD_YTEST_BTP_MOVE_V .
*.process data base updates/inserts/deletes.........................*
LOOP AT TOTAL.
  CHECK <ACTION> NE ORIGINAL.
MOVE <VIM_TOTAL_STRUC> TO YTEST_BTP_MOVE_V.
  IF <ACTION> = UPDATE_GELOESCHT.
    <ACTION> = GELOESCHT.
  ENDIF.
  CASE <ACTION>.
   WHEN NEUER_GELOESCHT.
IF STATUS_YTEST_BTP_MOVE_V-ST_DELETE EQ GELOESCHT.
     READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY>.
     IF SY-SUBRC EQ 0.
       DELETE EXTRACT INDEX SY-TABIX.
     ENDIF.
    ENDIF.
    DELETE TOTAL.
    IF X_HEADER-DELMDTFLAG NE SPACE.
      PERFORM DELETE_FROM_MAINKEY_TAB.
    ENDIF.
   WHEN GELOESCHT.
  SELECT SINGLE FOR UPDATE * FROM YTEST_BTP_MOVE_T WHERE
  FIELD1 = YTEST_BTP_MOVE_V-FIELD1 .
    IF SY-SUBRC = 0.
    DELETE YTEST_BTP_MOVE_T .
    ENDIF.
    IF STATUS-DELETE EQ GELOESCHT.
      READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY> BINARY SEARCH.
      DELETE EXTRACT INDEX SY-TABIX.
    ENDIF.
    DELETE TOTAL.
    IF X_HEADER-DELMDTFLAG NE SPACE.
      PERFORM DELETE_FROM_MAINKEY_TAB.
    ENDIF.
   WHEN OTHERS.
  SELECT SINGLE FOR UPDATE * FROM YTEST_BTP_MOVE_T WHERE
  FIELD1 = YTEST_BTP_MOVE_V-FIELD1 .
    IF SY-SUBRC <> 0.   "insert preprocessing: init WA
      CLEAR YTEST_BTP_MOVE_T.
    ENDIF.
YTEST_BTP_MOVE_T-MANDT =
YTEST_BTP_MOVE_V-MANDT .
YTEST_BTP_MOVE_T-FIELD1 =
YTEST_BTP_MOVE_V-FIELD1 .
    IF SY-SUBRC = 0.
    UPDATE YTEST_BTP_MOVE_T .
    ELSE.
    INSERT YTEST_BTP_MOVE_T .
    ENDIF.
    READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY>.
    IF SY-SUBRC EQ 0.
      <XACT> = ORIGINAL.
      MODIFY EXTRACT INDEX SY-TABIX.
    ENDIF.
    <ACTION> = ORIGINAL.
    MODIFY TOTAL.
  ENDCASE.
ENDLOOP.
CLEAR: STATUS_YTEST_BTP_MOVE_V-UPD_FLAG,
STATUS_YTEST_BTP_MOVE_V-UPD_CHECKD.
MESSAGE S018(SV).
ENDFORM.
*---------------------------------------------------------------------*
FORM READ_SINGLE_YTEST_BTP_MOVE_V.
  SELECT SINGLE * FROM YTEST_BTP_MOVE_T WHERE
FIELD1 = YTEST_BTP_MOVE_V-FIELD1 .
YTEST_BTP_MOVE_V-MANDT =
YTEST_BTP_MOVE_T-MANDT .
YTEST_BTP_MOVE_V-FIELD1 =
YTEST_BTP_MOVE_T-FIELD1 .
ENDFORM.
*---------------------------------------------------------------------*
FORM CORR_MAINT_YTEST_BTP_MOVE_V USING VALUE(CM_ACTION) RC.
  DATA: RETCODE LIKE SY-SUBRC, COUNT TYPE I, TRSP_KEYLEN TYPE SYFLENG.
  FIELD-SYMBOLS: <TAB_KEY_X> TYPE X.
  CLEAR RC.
MOVE YTEST_BTP_MOVE_V-FIELD1 TO
YTEST_BTP_MOVE_T-FIELD1 .
MOVE YTEST_BTP_MOVE_V-MANDT TO
YTEST_BTP_MOVE_T-MANDT .
  CORR_KEYTAB             =  E071K.
  CORR_KEYTAB-OBJNAME     = 'YTEST_BTP_MOVE_T'.
  IF NOT <vim_corr_keyx> IS ASSIGNED.
    ASSIGN CORR_KEYTAB-TABKEY TO <vim_corr_keyx> CASTING.
  ENDIF.
  ASSIGN YTEST_BTP_MOVE_T TO <TAB_KEY_X> CASTING.
  PERFORM VIM_GET_TRSPKEYLEN
    USING 'YTEST_BTP_MOVE_T'
    CHANGING TRSP_KEYLEN.
  <VIM_CORR_KEYX>(TRSP_KEYLEN) = <TAB_KEY_X>(TRSP_KEYLEN).
  PERFORM UPDATE_CORR_KEYTAB USING CM_ACTION RETCODE.
  ADD: RETCODE TO RC, 1 TO COUNT.
  IF RC LT COUNT AND CM_ACTION NE PRUEFEN.
    CLEAR RC.
  ENDIF.

ENDFORM.
*---------------------------------------------------------------------*
