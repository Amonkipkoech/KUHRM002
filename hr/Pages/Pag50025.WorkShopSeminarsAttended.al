page 50025 "WorkShop Seminars Attended"
{
    Caption = 'WorkShop Seminars Attended';
    PageType = ListPart;
    SourceTable = "workshopsSeminars.al";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(payrollNo; Rec.payrollNo)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the From Date field.';
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the To Date field.';
                }

                field("Sponsoring Organisation"; Rec."Sponsoring Organisation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sponsoring Organisation field.';
                }
                field(Venue; Rec.Venue)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Venue field.';
                }
                field(WorkshopAtt; Rec.WorkshopAtt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the WorkshopAtt field.';
                }
            }
        }
    }
}
