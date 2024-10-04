page 70098 "HRM Clearance Template"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "HRM Clearance Template";

    layout
    {
        area(Content)
        {
            repeater(Template)
            {


                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.';
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.';
                    ApplicationArea = All;
                }
                field("Clearance Area"; Rec."Clearance Area")
                {
                    ToolTip = 'Specifies the value of the Clearance Area field.';
                    ApplicationArea = All;
                }
                field(Sequence; Rec.Sequence)
                {
                    ToolTip = 'Specifies the value of the Sequence field.';
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Line No. field.';
                    ApplicationArea = All;
                }
                field("Clearance Form No."; Rec."Clearance Form No.")
                {
                    ToolTip = 'Specifies the value of the Clearance Form No. field.';
                    ApplicationArea = All;
                }
                field("Form Created"; Rec."Form Created")
                {
                    ToolTip = 'Specifies the value of the Form Created field.';
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action("Generate Clearing Templates")
            {
                ApplicationArea = All;
                Caption = 'Generate Clearing Templates';

                trigger OnAction();
                begin

                end;
            }
        }
    }
}