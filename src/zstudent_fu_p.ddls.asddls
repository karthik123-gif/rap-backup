@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'projection'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZSTUDENT_FU_p
  provider contract transactional_query as projection on zstudent_fu_i
{
      @UI.facet: [{
           id: 'StudentData',
           purpose: #STANDARD,
           label: 'Student Data',
           type: #IDENTIFICATION_REFERENCE,
           position: 10
       },{
           id: 'Upload',
           purpose: #STANDARD,
           label: 'Upload Attachments',
           type: #LINEITEM_REFERENCE,
           position: 20,
           targetElement: '_Attachments'
       }]

      @UI: {
          selectionField: [{ position: 10 }],
          lineItem: [{ position: 10 , label: 'Student ID'}],
          identification: [{ position: 10, label: 'Student ID' }]
      }

  key Id,
      @UI: {
        lineItem: [{position: 20, label: 'First Name' }],
        identification: [{position: 20, label: 'First Name' }]
        }
      Firstname,
      @UI: {
      lineItem: [{position: 30 , label: 'Last Name'}],
      identification: [{position: 30, label: 'Last Name' }]
      }
      Lastname,
      @UI: {
          lineItem: [{position: 40, label: 'Age' }],
          identification: [{position: 40, label: 'Age' }]
      }
      Age,
      @UI: {
          lineItem: [{position: 50, label: 'Course Name' }],
          identification: [{position: 50 , label: 'Course Name'}]
      }
      Course,
      @UI: {
          lineItem: [{position: 60, label: 'Course Duration' }],
          identification: [{position: 60, label: 'Course Duration' }]
      }
      Courseduration,
      @UI: {
          lineItem: [{position: 70, label: 'Enrollment Status' }],
          identification: [{position: 70, label: 'Enrollment Status' }]
      }
      Status,
      @UI: {
          lineItem: [{position: 80, label: 'Gender' }],
          identification: [{position: 80, label: 'Gender' }]
      }
      Gender,
      @UI: {
          lineItem: [{position: 90, label: 'Date of Birth' }],
          identification: [{position: 90, label: 'Date of Birth' }]
      }
      Dob,
      Lastchangedat,
      Locallastchangedat,
      /* Associations */
      _Attachments : redirected to composition child ZATTACHMENT_FU_p
}
