page 68224 "HRM-Leave Ledger View"
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HRM-Leave Ledger";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = all;
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = all;
                }
                field("Leave Type"; Rec."Leave Type")
                {
                    ApplicationArea = all;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = all;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = all;
                }
                field("No. of Days"; Rec."No. of Days")
                {
                    ApplicationArea = all;
                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                    ApplicationArea = all;
                }
                field("Leave Period"; Rec."Leave Period")
                {
                    ApplicationArea = all;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Reverse Leave Entry")
            {
                ApplicationArea = all;
                Caption = 'Reverse Leave Entry';
                Image = ReverseLines;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Rec."Entry Type" = Rec."Entry Type"::Allocation then Error('The selected entry has already been involved in a reversal.\Please select another entry to reverse...');
                    if Confirm('This will reverse the selected Ledger entry, continue?', false) = false then exit;
                    leaveLedger.Reset;
                    if leaveLedger.Find('+') then
                        lastNo := leaveLedger."Entry No." + 10
                    else
                        lastNo := 10;

                    Rec."Entry Type" := Rec."Entry Type"::Allocation;
                    Rec."Reversed By" := UserId;
                    Rec.Modify;

                    leaveLedger.Init;
                    leaveLedger."Entry No." := lastNo;
                    leaveLedger."Employee No" := Rec."Employee No";
                    leaveLedger."Document No" := Rec."Document No";
                    leaveLedger."Leave Type" := Rec."Leave Type";
                    leaveLedger."Transaction Date" := Rec."Transaction Date";
                    leaveLedger."Transaction Type" := Rec."Transaction Type";
                    leaveLedger."No. of Days" := ((Rec."No. of Days") * (-1));
                    leaveLedger."Transaction Description" := Rec."Transaction Description";
                    leaveLedger."Leave Period" := Rec."Leave Period";
                    leaveLedger."Entry Type" := leaveLedger."Entry Type"::Allocation;
                    leaveLedger."Reversed By" := UserId;
                    leaveLedger.Insert;
                end;
            }
        }
    }

    var
        leaveLedger: Record "HRM-Leave Ledger";
        lastNo: Integer;
}

