@EndUserText.label: 'Abstract Create Student'
define abstract entity ZI_CreateStudent {
   
  @EndUserText.label: 'Student ID'
  @Consumption.valueHelpDefinition: [{ entity: { name: 'znm_student1_cds', element: 'StudentId' } }]
   
  key student_id : abap.int1;   // Value help for Student ID
  
  @EndUserText.label: 'Class'
  @Consumption.valueHelpDefinition: [{ entity: { name: 'znm_class_dom', element: 'Value' } }]
  class : abap.int1;  
  @Consumption.valueHelpDefinition: [{ entity: { name: 'znm_scl_exam1', element: 'ExamNo' } }]
  exam_no : abap.dec(2,0);
  @Consumption.valueHelpDefinition: [{ entity: { name: 'znm_scl_exam1', element: 'ExamName' } }]
 exam_name : abap.char(10);
 @Consumption.valueHelpDefinition: [{ entity: { name: 'znm_marks1_cds', element: 'SubNo' } }]
 sub_no     : abap.dec(2,0) ;
  marks          : abap.dec(2,0);
 
}



