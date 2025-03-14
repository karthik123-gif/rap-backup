CLASS lhc_Student DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Student RESULT result.

    METHODS copyStudent FOR MODIFY
      IMPORTING keys FOR ACTION Student~copyStudent.

    METHODS createStudent FOR MODIFY
      IMPORTING keys FOR ACTION Student~createStudent.

ENDCLASS.

CLASS lhc_Student IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD copyStudent.

   DATA: lt_student TYPE TABLE FOR CREATE zstudent_fu_i.

    " Reading selected data from frontend

    READ ENTITIES OF zstudent_fu_i IN LOCAL MODE
    ENTITY Student
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(students)
    FAILED failed.

    LOOP AT students ASSIGNING FIELD-SYMBOL(<lfs_students>).

      APPEND VALUE #( %cid = keys[ KEY entity %key = <lfs_students>-%key ]-%cid
                     " %is_draft = keys[ KEY entity %key = <lfs_students>-%key ]-%param-%is_draft
                      %data = CORRESPONDING #( <lfs_students> EXCEPT id )

       )  TO lt_student ASSIGNING FIELD-SYMBOL(<lfs_newStudent>).

    ENDLOOP.

    "Create BO Instance by COpy

    MODIFY ENTITIES OF zstudent_fu_i IN LOCAL MODE
    ENTITY Student
    CREATE FIELDS ( Firstname Lastname Age Course Courseduration Status Gender Dob )
    WITH lt_student
    MAPPED DATA(mapped_create).

    mapped-student = mapped_create-student.


  ENDMETHOD.

  METHOD createStudent.
  MODIFY ENTITIES OF zstudent_fu_i IN LOCAL MODE
    ENTITY Student
      CREATE FROM VALUE #( FOR <instance> IN keys (
                          %cid = <instance>-%cid
                          Age = 1
                          Course = 'C1'
                          Courseduration = 1
                          Firstname = 'FNM'
                          Lastname = 'LNM'
                          Dob = sy-datum
                          %control =
                          VALUE #(
                              Age = if_abap_behv=>mk-on
                              Course = if_abap_behv=>mk-on
                              Courseduration = if_abap_behv=>mk-off
                              Firstname = if_abap_behv=>mk-on
                              Lastname = if_abap_behv=>mk-off
                              Dob = if_abap_behv=>mk-on
                          )
       ) )
       MAPPED mapped
       FAILED failed
       REPORTED reported.

  ENDMETHOD.

ENDCLASS.
