page 68077 "PRL-PeriodTransaction List"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "PRL-Period Transactions";

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                ShowCaption = false;
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = ALL;

                }
                field(department; Rec.department)
                {
                    ApplicationArea = All;
                }
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = All;
                }
                field("Transaction Name"; Rec."Transaction Name")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ApplicationArea = All;
                }
                field("Group Text"; Rec."Group Text")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Group Text field.';
                }
                field("Group Order"; Rec."Group Order")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Group Order field.';
                }
                field("Sub Group Order"; Rec."Sub Group Order")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sub Group Order field.';
                }



            }
        }
    }

    actions
    {
    }
}

