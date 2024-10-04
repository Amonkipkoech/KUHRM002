page 80005 "Journal Batches"
{
    PageType = List;
    CardPageId = "Payroll Journal Card";
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Payroll Journal Batches";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(payrollPeriod; Rec.payrollPeriod)
                {
                    ApplicationArea = All;

                }
                field(periodName; Rec.periodName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the periodName field.';
                }
                field(createdBy; Rec.createdBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the createdBy field.';
                }
                field(dateCreated; Rec.dateCreated)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the dateCreated field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}