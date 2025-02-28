@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'demo student data'
@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define root view entity zdemo_v4 as select from znm_student1
//composition[1..*] of zdemo1_v4 as _exams 
{

@UI.facet: [
        {
            id: 'Student',
            purpose: #STANDARD,
            type: #IDENTIFICATION_REFERENCE,
            label: 'Student Details',
            position: 10
        }]
//        {
//            id: 'Exams',
//            purpose: #STANDARD,
//            type:#LINEITEM_REFERENCE,
//            label: 'List of Exams',
//            position: 20,
//            targetElement: '_exams'
//        }]
                 
@EndUserText.label: 'StudentId'
 @UI:{ lineItem: [{position:10, label:'Student ID' } ],
            identification: [ { position:10, label:'Student ID' } ],
            selectionField: [{ position:10  }]  
            }
@Consumption.valueHelpDefinition: [ {
        entity: { name: 'zdemo_student', element: 'StudentId'
        },
        additionalBinding: [{ localElement: 'StudentName', element: 'StudentName', usage: #FILTER_AND_RESULT }]
//                            { localElement: 'Class', element: 'Class', usage: #FILTER_AND_RESULT } ]
}]
    key student_id as StudentId,
    @EndUserText.label: 'StudentName'
 @UI:{ lineItem: [{position:20, label:'StudentName' } ],
            identification: [ { position:20, label:'StudentName' } ],
            selectionField: [{ position:20  }]  
            }
            @Consumption.valueHelpDefinition: [ {
        entity: { name: 'zdemo_student', element: 'StudentName'
        },
       additionalBinding: [{ localElement: 'Class', element: 'Class', usage: #FILTER_AND_RESULT }]
    }]

    student_name as StudentName,
    @EndUserText.label: 'Class'
    @UI:{ lineItem: [{position:30, label:'Class' } ],
            identification: [ { position:30, label:'Class' } ],
            selectionField: [{ position:30  }]  
            }
//    @Consumption.valueHelpDefinition: [ {
//        entity: { name: 'znm_class_dom', element: 'Value'
//        },
// additionalBinding: [{ localElement: 'StudentName', element: 'StudentName', usage: #FILTER_AND_RESULT }]
//    }]
    @Consumption.valueHelpDefinition: [ {
        entity: { name: 'zdemo_student', element: 'Class'
        },
       additionalBinding: [{ localElement: 'StudentName', element: 'StudentName', usage: #FILTER_AND_RESULT }]
       
    }]
    
    class as Class,
    @EndUserText.label: 'ClassSection'
    @UI:{ lineItem: [{position:40, label:'ClassSection' } ],
            identification: [ { position:40, label:'ClassSection' } ],
            selectionField: [{ position:40  }]  
            }
    @Consumption.valueHelpDefinition: [ {
        entity: { name: 'znm_class_cds', element: 'Value' },
        additionalBinding: [{ localElement: 'Class', element: 'Class' ,
       usage: #FILTER_AND_RESULT }]
    }]
    class_section as ClassSection,
    //@EndUserText.label: 'AvgMarks'
    avg_marks as AvgMarks,
    //@EndUserText.label: 'AttendPercent'
    attend_percent as AttendPercent,
   // @EndUserText.label: 'Status'
    status as Status,
    lastchangedat as LastChangedAt,
    locallastchangedat as Locallastchangedat
//   _exams 
}
