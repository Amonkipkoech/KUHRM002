page 64608 "HRM-Other Payees"
{
    CardPageID = "HRM-Payee Card";
    DataCaptionFields = "No.", "First Name", "Middle Name", "Last Name";
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = 77797;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field("PIN Number"; Rec."PIN Number")
                {
                    ApplicationArea = All;
                }
                field("Home Phone Number"; Rec."Home Phone Number")
                {
                    ApplicationArea = All;
                }
                field("Cellular Phone Number"; Rec."Cellular Phone Number")
                {
                    ApplicationArea = All;
                }
                field("Work Phone Number"; Rec."Work Phone Number")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
                field("Main Bank"; Rec."Main Bank")
                {
                    ApplicationArea = All;
                }
                field("Branch Bank"; Rec."Branch Bank")
                {
                    ApplicationArea = All;
                }
                field("Bank Account Number"; Rec."Bank Account Number")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Update Payee Memo")
            {
                Image = Users;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                var
                    Customer: Record 18;
                    HRMOtherPayees: Record 77797;
                begin
                    /*
                    Customer.RESET;
                    Customer.SETRANGE("No.", HRMOtherPayees."No.");
                    
                    
                    IF NOT Customer.FIND
                     THEN BEGIN
                     REPEAT
                       Customer.INIT;
                       Customer."No." := HRMOtherPayees."No.";
                       Customer.Name := HRMOtherPayees.Names;
                       Customer."Customer Posting Group" := 'PAYEE';
                       Customer."Phone No.":=  HRMOtherPayees."Cellular Phone Number";
                       Customer."Gen. Bus. Posting Group" := 'LOCAL';
                       Customer."E-Mail" := HRMOtherPayees."E-Mail";
                       VALIDATE("No.");
                       Customer.INSERT;
                       //MESSAGE('update ' + "No.");
                       UNTIL  HRMOtherPayees.NEXT = 0;
                       END;
                    
                    */

                end;
            }
        }
    }
}

