page 68331 "HRM-Employee Leaves"
{
    PageType = Document;
    SourceTable = "HRM-Employee (D)";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;
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
                field(Initials; Rec.Initials)
                {
                    ApplicationArea = All;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = All;
                }
                field("Contract Type"; Rec."Contract Type")
                {
                    ApplicationArea = All;
                }
                field("Date Of Join"; Rec."Date Of Join")
                {
                    ApplicationArea = All;
                }
            }
            part(Control1000000028; "HRM-Employee Leave Assignment")
            {
                SubPageLink = "Employee No" = FIELD("No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Post)
            {
                Caption = 'Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    /*IF CONFIRM('Do really want to post the Allocation?') THEN BEGIN
                    EmpLeave.RESET;
                    EmpLeave.SETRANGE(EmpLeave."Employee No","No.");
                    EmpLeave.SETRANGE(EmpLeave.Posted,FALSE);
                    IF EmpLeave.FIND('-') THEN BEGIN
                    REPEAT
                    LeaveEntry.INIT;
                    LeaveEntry."Document No":=EmpLeave."Employee No";
                    LeaveEntry."To Date":=EmpLeave."Leave Code";
                    LeaveEntry."Duration Units":=TODAY;
                    LeaveEntry.Duration:=EmpLeave.Balance;
                    LeaveEntry."Cost Of Training":=LeaveEntry."Cost Of Training"::"1";
                    LeaveEntry.INSERT(TRUE);
                    EmpLeave.Posted:=TRUE;
                    EmpLeave."Posting Date":=TODAY;
                    EmpLeave.UserID:=USERID;
                    EmpLeave.MODIFY;
                    UNTIL EmpLeave.NEXT=0;
                    END;
                    END;
                                        */

                end;
            }
        }
    }

    var
        LeaveEntry: Record "HRM-Back To Office Form";
        EmpLeave: Record "HRM-Emp. Leaves";
}

