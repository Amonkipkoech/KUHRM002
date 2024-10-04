page 50071 "Staff Ledger Card"
{
    PageType = Card;
    SourceTable = "Staff Attendance Ledger";

    layout
    {
        area(content)
        {
            group("Visitor Ledger Edit")
            {
                field("Visit No."; Rec."Visit No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = all;
                    Editable = editableBool;
                    Enabled = true;
                }
                field(StaffNo; staffNo)
                {
                    ApplicationArea = all;
                    Caption = 'Staff No.';

                    trigger OnValidate()
                    begin
                        if staffNo <> '' then
                            Rec.Validate("Staff No.", 'ST' + staffNo);
                    end;
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = all;
                    Editable = editableBool;
                    Visible = false;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = all;
                    Editable = editableBool;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = all;
                }
                field("Time In"; Rec."Time In")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Signed in by"; Rec."Signed in by")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Time Out"; Rec."Time Out")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Signed Out By"; Rec."Signed Out By")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = all;
                    Editable = editableBool;
                }
                field("Comment By"; Rec."Comment By")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Checked Out"; Rec."Checked Out")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
            group(Det)
            {
                Caption = 'Personal Items Recording';
                part(Control1000000021; "Staff Personal Items")
                {
                    ApplicationArea = all;
                    SubPageLink = "Staff Code" = FIELD("Staff No."), "Staff ID" = FIELD("Visit No.");
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Check In")
            {
                ApplicationArea = all;
                Image = Approve;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    readMessage: Text[100];
                begin
                    Clear(readMessage);
                    if Rec."Time In" <> 0T then Error('Already Checked in!');
                    users1.Reset;
                    users1.SetRange("User Name", UserId);
                    if users1.Find('-') then begin end;
                    //TESTFIELD(Rec.Company);
                    Rec.TestField("Staff No.");
                    //TESTFIELD(Rec."Phone No.");
                    //TESTFIELD(Rec."Full Name");
                    if Confirm('Register ' + Rec."Full Name", true) = false then Error('Registration Cancelled by ' + UserId);
                    Rec."Transaction Date" := Today;
                    Rec."Time In" := Time;
                    if users1."Full Name" = '' then
                        Rec."Signed in by" := UserId
                    else
                        Rec."Signed in by" := users1."Full Name";
                    Rec.Modify;
                    readMessage := 'Clocked in Successfully!';
                    Message(readMessage);
                end;
            }
            action("Check Out")
            {
                ApplicationArea = all;
                Image = Close;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ItemstoCheckOut: Record "Staff Personal Items";
                begin

                    if Rec."Time In" = 0T then Error('Not Checked in!');
                    //TESTFIELD(Comment);
                    if Rec."Checked Out" = true then Error('Already Checked out!');

                    ItemstoCheckOut.Reset;
                    ItemstoCheckOut.SetRange(ItemstoCheckOut."Staff Code", Rec."Visit No.");
                    ItemstoCheckOut.SetRange(ItemstoCheckOut."Staff ID", Rec."Staff No.");
                    ItemstoCheckOut.SetRange(ItemstoCheckOut.Cleared, false);
                    ItemstoCheckOut.SetFilter(ItemstoCheckOut."Item Description", '<>%1', '');
                    if ItemstoCheckOut.Find('-') then begin
                        Error('Please Check out all Peronal Items First');
                    end;

                    users1.Reset;
                    users1.SetRange("User Name", UserId);
                    if users1.Find('-') then begin end;
                    if Confirm('Check-out ' + Rec."Full Name" + '?', true) = false then Error('Check-out Cancelled by ' + UserId);
                    Rec."Time Out" := Time;
                    Rec."Checked Out" := true;
                    if users1."Full Name" = '' then
                        Rec."Signed Out By" := UserId
                    else
                        Rec."Signed Out By" := users1."Full Name";
                    Rec.Modify;
                    CurrPage.Update;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if ((Rec."Checked Out" = true) or (Rec."Signed in by" <> '')) then editableBool := false else editableBool := true;
    end;

    trigger OnInit()
    begin
        editableBool := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Clear(staffNo);
    end;

    var
        users1: Record User;
        editableBool: Boolean;
        StaffCard: Record "HRM-Employee (D)";
        staffNo: Code[20];
}

