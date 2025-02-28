CLASS znm_cl_mockdata DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZNM_CL_MOCKDATA IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  DATA: lt_sub   TYPE STANDARD TABLE OF znm_scl_sub WITH EMPTY KEY,
          lt_exams TYPE STANDARD TABLE OF znm_scl_exams WITH EMPTY KEY.
    TRY.
        lt_sub = VALUE #( ( sub_no = '1' sub_name = 'English' )
                           ( sub_no = '2' sub_name = 'Sanskrit'  )
                           ( sub_no = '3' sub_name = 'Maths' )
                           ( sub_no = '4' sub_name = 'Physics' )
                           ( sub_no = '5' sub_name = 'Chemistry' )

                           ).

        lt_exams = VALUE #( ( exam_no = '1' exam_name = 'Assesment1' )
                   ( exam_no = '2' exam_name = 'Assesment2' )
                   ( exam_no = '3' exam_name = 'Assesment3' )
                   ).
        delete from znm_scl_sub.
        delete from znm_scl_exams.

        INSERT znm_scl_sub FROM TABLE @lt_sub.
        INSERT znm_scl_exams FROM TABLE @lt_exams.
        COMMIT WORK.
        out->write( |{ sy-dbcnt } entries in tables are created successfully| ).
    ENDTRY .
  ENDMETHOD.
ENDCLASS.
