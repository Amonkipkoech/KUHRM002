page 70095 "HRM CLearing Staff List"
{
    Caption = 'Clearing Staff List';
    PageType = List;
    ModifyAllowed = false;
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    CardPageId = "HRM-Clearing Staff Card";
    SourceTable = "HRM-Employee (D)";
    SourceTableView = where("clearance initiated" = filter(true));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the Payroll Number field.';
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field.';
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ToolTip = 'Specifies the value of the Middle Name field.';
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ToolTip = 'Specifies the value of the First Name field.';
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ToolTip = 'Specifies the value of the Department Code field.';
                    ApplicationArea = All;
                }
                field("Date Of Join"; Rec."Date Of Join")
                {
                    ToolTip = 'Specifies the value of the Date Of Join field.';
                    ApplicationArea = All;
                }
                field("Contract End Date"; Rec."Contract End Date")
                {
                    ToolTip = 'Specifies the value of the Contract End Date field.';
                    ApplicationArea = All;
                }
                field("Employee Category"; Rec."Employee Category")
                {
                    ToolTip = 'Specifies the value of the Employee Category field.';
                    ApplicationArea = All;
                }
                field("Length Of Service"; Rec."Length Of Service")
                {
                    ToolTip = 'Specifies the value of the Length Of Service field.';
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
            action(ActionName)
            {


                trigger OnAction();
                begin

                end;
            }
        }
    }
}