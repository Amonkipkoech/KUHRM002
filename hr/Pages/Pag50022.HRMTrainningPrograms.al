page 50022 "HRM-Trainning Programs"
{
    Caption = 'HRM-Trainning Programs';
    PageType = List;
    SourceTable = hrmTrainingPrograms;

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field(PayrollNo; Rec.PayrollNo)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Trainning Programme"; Rec."Trainning Programme")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Trainning Programme field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }


                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Priority field.';
                }
                field(otherFactors1; Rec.otherFactors1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the otherFactors1 field.';
                }
                field(otherFactors2; Rec.otherFactors2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the otherFactors2 field.';
                }
                field(otherFactors3; Rec.otherFactors3)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the otherFactors3 field.';
                }
            }
        }
    }
}
