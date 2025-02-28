@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'interface view for academic results'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZI_AR_RAP as select from zacademicdetails
association to parent ZI_STUDENT_RAP as _student on $projection.Id = _student.Id
association[1..1] to ZI_COURSE_RAP as _course on $projection.Course = _course.Value
association[1..1] to ZI_SEM_RAP as _semester on $projection.Semester = _semester.Value
association[1..1] to ZI_SEMRES_RAP as _semres on $projection.Semresult = _semres.Value

{
  key id as Id,
  key course as Course,
  key semester as Semester,
  _course.Description as Course_desc,
  _semester.Description as Semester_desc,
  semresult as Semresult,
  _semres.Description as Semres_desc,
  _student 
}
