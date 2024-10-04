page 50026 hrmIndividualTrainning
{
    Caption = 'hrmIndividualTrainning';
    CardPageId = "Trainning Needs Application";
    PageType = List;
    SourceTable = "hrmTrainningNeeds.al";
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(payrollNo; Rec.payrollNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the payrollNo field.';
                }
                field(jobGrade; Rec.jobGrade)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the jobGrade field.';
                }
                field(employeeName; Rec.employeeName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the employeeName field.';
                }
                field(designation; Rec.designation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the designation field.';
                }
                field(department; Rec.department)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the department field.';
                }
            }
        }
    }
}
