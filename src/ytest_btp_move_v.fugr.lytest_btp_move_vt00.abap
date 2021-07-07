*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 07.07.2021 at 10:24:00
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: YTEST_BTP_MOVE_V................................*
TABLES: YTEST_BTP_MOVE_V, *YTEST_BTP_MOVE_V. "view work areas
CONTROLS: TCTRL_YTEST_BTP_MOVE_V
TYPE TABLEVIEW USING SCREEN '9001'.
DATA: BEGIN OF STATUS_YTEST_BTP_MOVE_V. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_YTEST_BTP_MOVE_V.
* Table for entries selected to show on screen
DATA: BEGIN OF YTEST_BTP_MOVE_V_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE YTEST_BTP_MOVE_V.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YTEST_BTP_MOVE_V_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF YTEST_BTP_MOVE_V_TOTAL OCCURS 0010.
INCLUDE STRUCTURE YTEST_BTP_MOVE_V.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF YTEST_BTP_MOVE_V_TOTAL.

*.........table declarations:.................................*
TABLES: YTEST_BTP_MOVE_T               .
