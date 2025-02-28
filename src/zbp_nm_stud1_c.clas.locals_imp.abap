CLASS lhc_Attendance DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.



    METHODS CalculateAttendance FOR DETERMINE ON modify
      IMPORTING keys FOR Attendance~CalculateAttendance.

ENDCLASS.

CLASS lhc_Attendance IMPLEMENTATION.

METHOD CalculateAttendance.

  " Declare internal tables and variables
  DATA: lt_students   TYPE TABLE OF znm_student1_cds,       " Student table
        lt_update     TYPE TABLE FOR UPDATE znm_student1_cds, " Update table for Student
        lt_attendance TYPE TABLE OF znm_attendance,         " Attendance table
        ls_student    TYPE znm_student1_cds,
        ls_update     LIKE LINE OF lt_update,               " Update structure for Student table
        ls_attendance TYPE znm_attendance,                 " Structure for attendance table
        lv_total_classes     TYPE p DECIMALS 2 VALUE 0,
        lv_attended_classes  TYPE p DECIMALS 2 VALUE 0,
        lv_percentage        TYPE p DECIMALS 2 VALUE 0.

  " Fetch all students from the Student table
  SELECT *
    FROM znm_student1_cds
    INTO TABLE @lt_students.

  " Loop through each student and calculate their overall attendance percentage
  LOOP AT lt_students INTO ls_student.

    " Initialize values for calculations
    CLEAR: lv_total_classes, lv_attended_classes, lv_percentage, lt_attendance.

    " Fetch the most recent attendance records for the current student
    SELECT *
      FROM znm_attendance
      WHERE student_id = @ls_student-studentid
      INTO TABLE @lt_attendance.

    " Check if attendance records are found
    IF lines( lt_attendance ) > 0.

      " Loop through fetched attendance records to calculate total and attended classes
      LOOP AT lt_attendance INTO ls_attendance.
        lv_total_classes    = lv_total_classes + ls_attendance-total_classes.  " Correct field name
        lv_attended_classes = lv_attended_classes + ls_attendance-attended_classes.  " Correct field name
      ENDLOOP.

      " Calculate overall attendance percentage
      IF lv_total_classes > 0.
        lv_percentage = ( lv_attended_classes * 100 ) / lv_total_classes.
      ELSE.
        lv_percentage = 0.
      ENDIF.

      " Prepare update structure for Student table
      CLEAR ls_update.
      ls_update-studentid     = ls_student-studentid.  " Map Student ID (only the modified student's ID)
      ls_update-attendpercent = lv_percentage.         " Assign calculated percentage

      " Append to update table
      APPEND ls_update TO lt_update.

    ENDIF.

  ENDLOOP.

  " Update student entity using RAP EML (Entity Manipulation Language) - Only update the modified students' records
  MODIFY ENTITIES OF znm_student1_cds
    IN LOCAL MODE
    ENTITY Student
    UPDATE FIELDS ( attendpercent )
    WITH lt_update.

ENDMETHOD.




ENDCLASS.

CLASS lhc_library DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS CalculateFine FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Library~CalculateFine.

ENDCLASS.

CLASS lhc_library IMPLEMENTATION.

 METHOD CalculateFine.


ENDMETHOD.


ENDCLASS.

CLASS lhc_marks DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS CalculateAvgMarks FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Marks~CalculateAvgMarks.

ENDCLASS.

CLASS lhc_marks IMPLEMENTATION.

 METHOD CalculateAvgMarks.

  DATA: lt_marks TYPE TABLE OF znm_marks1,
        lt_update TYPE TABLE FOR UPDATE znm_student1_cds,
        lt_student_ids TYPE TABLE OF znm_marks1-student_id.

  " Using floating-point or decimal types
  DATA: lv_avg   TYPE P LENGTH 10 DECIMALS 2, " Packed number with 2 decimal places
        lv_sum   TYPE P LENGTH 10 DECIMALS 2, " Sum should also be decimal to avoid truncation
        lv_count TYPE I.

  LOOP AT keys INTO DATA(ls_key).
    APPEND ls_key-StudentId TO lt_student_ids.
  ENDLOOP.

  SORT lt_update BY studentid.
DELETE ADJACENT DUPLICATES FROM lt_update COMPARING studentid.


  LOOP AT lt_student_ids INTO DATA(lv_studentid).

    CLEAR: lv_avg, lv_count, lv_sum.
    CLEAR lt_marks.

    " Fetch student marks
    SELECT *
      FROM znm_marks1
      WHERE student_id = @lv_studentid
      INTO TABLE @lt_marks.

    IF lt_marks IS NOT INITIAL.
      LOOP AT lt_marks INTO DATA(ls_mark).
        lv_sum = lv_sum + ls_mark-marks.
        lv_count = lv_count + 1.
      ENDLOOP.

      " Ensure division happens with decimal precision
      IF lv_count > 0.
        lv_avg = lv_sum / lv_count.  " Ensures decimal division
      ELSE.
        lv_avg = 0.
      ENDIF.

      APPEND VALUE #( studentid = lv_studentid avgmarks = lv_avg ) TO lt_update.
    ENDIF.

  ENDLOOP.

  " Update student table
  IF lt_update IS NOT INITIAL.
    MODIFY ENTITIES OF znm_student1_cds IN LOCAL MODE
      ENTITY Student
      UPDATE FIELDS ( avgmarks )
      WITH lt_update.
  ENDIF.

ENDMETHOD.


ENDCLASS.

CLASS lhc_Student DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Student RESULT result.
    METHODS validateclass FOR VALIDATE ON SAVE
      IMPORTING keys FOR student~validateclass.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR student RESULT result.

    METHODS attendpercent FOR MODIFY
      IMPORTING keys FOR ACTION student~attendpercent RESULT result.
    METHODS getdefaultsforcreate FOR READ
      IMPORTING keys FOR FUNCTION student~getdefaultsforcreate RESULT result.
    METHODS opencreatedialog FOR MODIFY
      IMPORTING keys FOR ACTION student~opencreatedialog RESULT result.





ENDCLASS.

CLASS lhc_Student IMPLEMENTATION.

  METHOD get_instance_authorizations.

  ENDMETHOD.


  METHOD validateclass.

  READ ENTITIES OF znm_student1_cds
   IN LOCAL MODE
   ENTITY Student
    FIELDS ( Class )
    WITH CORRESPONDING #( keys )
    RESULT DATA(studentsClass).

     LOOP AT studentsClass into data(studentClass).
     if studentClass-Class is  INITIAL.
     APPEND VALUE #( %tky = studentClass-%tky ) to failed-student.
     APPEND VALUE #( %tky = keys[ 1 ]-%tky
                     %msg =  new_message_with_text( severity = if_abap_behv_message=>severity-error
                     text = 'Please enter class name '
                     )  ) to reported-student.
     endif.
  ENDLOOP.
  ENDMETHOD.



  METHOD get_instance_features.


    READ ENTITIES OF znm_student1_cds IN LOCAL MODE
    ENTITY Student
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(studenteligible)
    FAILED failed.

    result = VALUE #( FOR stud IN studenteligible
    LET statusVal = COND #( WHEN stud-AttendPercent < 50 or stud-AvgMarks  < 50 or stud-Status = abap_true
    THEN if_abap_behv=>fc-o-disabled
    ELSE if_abap_behv=>fc-o-enabled )
     IN (  %tky = stud-%tky
     %action-AttendPercent = statusval )
     ).



  ENDMETHOD.

   METHOD AttendPercent.

MODIFY ENTITIES OF znm_student1_cds IN LOCAL MODE
       ENTITY Student
       UPDATE
       FIELDS ( Status )
       WITH VALUE #( FOR key IN keys ( %tky = key-%tky Status = abap_true  ) )
       FAILED failed
       REPORTED reported.

    READ ENTITIES OF znm_student1_cds IN LOCAL MODE
    ENTITY Student
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(studentdata).
    result = VALUE #( FOR studentrec IN studentdata
    ( %tky = studentrec-%tky %param = studentrec )
    ).

  ENDMETHOD.

  METHOD GetDefaultsForCreate.
  result = VALUE #(
        FOR key IN keys
        (
            %cid = key-%cid
            %param = VALUE #(
                StudentId = '1'  "
                StudentName = 'Nagamani'
                Class = '1'

            )
        )
    ).

  ENDMETHOD.


METHOD openCreateDialog.


ENDMETHOD.

ENDCLASS.
