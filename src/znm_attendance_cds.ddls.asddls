@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cds for attendance'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZNM_ATTENDANCE_cds as select from znm_attendance
association to parent znm_student1_cds as _student 
 on $projection.StudentId = _student.StudentId
{
    key student_id as StudentId,
    key name_of_month as NameOfMonth,
    total_classes as TotalClasses,
    attended_classes as AttendedClasses,
    attendance_percent as AttendancePercent,
    _student  
}
