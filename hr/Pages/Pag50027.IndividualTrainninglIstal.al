page 50027 "IndividualTrainninglIst.al"
{
    Caption = 'IndividualTrainninglIst.al';
    PageType = List;
    CardPageId = "Trainning Needs Application";
    SourceTable = "hrmTrainningNeeds.al";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(payrollNo; Rec.payrollNo)
                {
                    ApplicationArea = ALL;
                }
                field(department; Rec.department)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the department field.';
                }
                field("Training AppNo"; Rec."Training AppNo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Training AppNo field.';
                }
                field(designation; Rec.designation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the designation field.';
                }
                field(employeeName; Rec.employeeName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the employeeName field.';
                }
                field(jobGrade; Rec.jobGrade)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the jobGrade field.';
                }
            }
        }
    }
}
