CLASS lhc_Student DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Student RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Student RESULT result.

    METHODS setAdmitted FOR MODIFY
      IMPORTING keys FOR ACTION Student~setAdmitted RESULT result.

    METHODS updateCourseDuration FOR DETERMINE ON SAVE
      IMPORTING keys FOR Student~updateCourseDuration.

    METHODS validateAge FOR VALIDATE ON SAVE
      IMPORTING keys FOR Student~validateAge.
    METHODS precheck_update FOR PRECHECK
      IMPORTING entities FOR UPDATE Student.

ENDCLASS.

CLASS lhc_Student IMPLEMENTATION.

  METHOD get_instance_features.
  READ ENTITIES OF zi_student_rap IN LOCAL MODE
    ENTITY Student
    FIELDS ( Status ) WITH CORRESPONDING #( keys )
    RESULT DATA(Studentadmitted)
    FAILED failed.
    result = VALUE #(
    FOR Stud IN Studentadmitted
    LET Statusval = COND #( WHEN Stud-Status = abap_true
                             THEN if_abap_behv=>fc-o-disabled
                             ELSE if_abap_behv=>fc-o-enabled )
                      IN ( %tky = stud-%tky
                      %action-setAdmitted = statusval )
    ).
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD setAdmitted.
  MODIFY ENTITIES OF zi_student_rap IN LOCAL MODE
       ENTITY Student
       UPDATE
       FIELDS ( Status )
       WITH VALUE #( FOR key IN keys ( %tky = key-%tky Status = abap_true  ) )
       FAILED failed
       REPORTED reported.

    READ ENTITIES OF zi_student_rap IN LOCAL MODE
    ENTITY Student
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(studentdata).
    result = VALUE #( FOR studentrec IN studentdata
    ( %tky = studentrec-%tky %param = studentrec )
    ).
  ENDMETHOD.

  METHOD updateCourseDuration.
  READ ENTITIES OF zi_student_rap IN LOCAL MODE
    ENTITY Student
     FIELDS ( Course ) WITH CORRESPONDING #( keys )
     RESULT DATA(studentsCourse).
     LOOP AT studentsCourse into data(studentCourse).
     IF studentCourse-Course = 'C'.

     modify ENTITIES OF zi_student_rap IN LOCAL MODE
     ENTITY Student
     update fields ( Courseduration ) with value #( ( %tky = studentcourse-%tky Courseduration = 5 ) ).

     endif.
     IF studentCourse-Course = 'E'.

     modify ENTITIES OF zi_student_rap IN LOCAL MODE
     ENTITY Student
     update fields ( Courseduration ) with value #( ( %tky = studentcourse-%tky Courseduration = 4 ) ).

     endif.
     IF studentCourse-Course = 'M'.

     modify ENTITIES OF zi_student_rap IN LOCAL MODE
     ENTITY Student
     update fields ( Courseduration ) with value #( ( %tky = studentcourse-%tky Courseduration = 6 ) ).

     endif.
     ENDLOOP.
  ENDMETHOD.

  METHOD validateAge.
  READ ENTITIES OF zi_student_rap IN LOCAL MODE
    ENTITY Student
     FIELDS ( Age ) WITH CORRESPONDING #( keys )
     RESULT DATA(studentsAge).

     LOOP AT studentsAge into data(studentAge).
     if studentage-Age < 21.
     APPEND VALUE #( %tky = studentage-%tky ) to failed-student.
     APPEND VALUE #( %tky = keys[ 1 ]-%tky
                     %msg =  new_message_with_text( severity = if_abap_behv_message=>severity-error
                     text = 'Age cannot be less than 21'
                     )  ) to reported-student.
     endif.
  ENDLOOP.
  ENDMETHOD.

  METHOD precheck_update.

  LOOP AT entities ASSIGNING FIELD-SYMBOL(<lfs_entity>).

    " 01 = value is updated / Changed , 00 = value is not changed
    CHECK <lfs_entity>-%control-Courseduration EQ '01'
          OR <lfs_entity>-%control-Courseduration EQ '01'.

    READ ENTITIES OF ZI_STUDENT_RAP IN LOCAL MODE
      ENTITY Student
      FIELDS ( Course Courseduration )
      WITH VALUE #( (  %key = <lfs_entity>-%key ) )
      RESULT DATA(lt_studentsCourse).

    IF sy-subrc IS INITIAL.
      READ TABLE lt_studentsCourse ASSIGNING FIELD-SYMBOL(<lfs_db_course>) INDEX 1.
      IF sy-subrc IS INITIAL.

        <lfs_db_course>-Course = COND #(
          WHEN <lfs_entity>-%control-Course EQ '01'
          THEN <lfs_entity>-Course
          ELSE <lfs_db_course>-Course ).

        <lfs_db_course>-Courseduration = COND #(
          WHEN <lfs_entity>-%control-Courseduration EQ '01'
          THEN <lfs_entity>-Courseduration
          ELSE <lfs_db_course>-Courseduration ).

        IF <lfs_db_course>-Courseduration < 5.
          IF <lfs_db_course>-Course = 'C'.

            APPEND VALUE #( %key = <lfs_entity>-%key ) TO failed-student.

            APPEND VALUE #(
              %tky = <lfs_entity>-%tky
              %msg = new_message_with_text(
                severity = if_abap_behv_message=>severity-error
                text = 'Invalid Course duration...'
              )
            ) TO reported-student.

          ENDIF.
        ENDIF.

      ENDIF.
    ENDIF.

  ENDLOOP.

ENDMETHOD.


ENDCLASS.
