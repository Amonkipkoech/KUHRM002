page 75040 "HRM-Appraisal HR Emp Card"
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Document;
    SourceTable = 61188;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = true;
                field("No."; Rec."No.")
                {
                    Caption = 'No.(*)';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Initials; Rec.Initials)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Search Name"; Rec."Search Name")
                {
                    Caption = 'County';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Postal Address"; Rec."Postal Address")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Residential Address"; Rec."Residential Address")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Home Phone Number"; Rec."Home Phone Number")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Cellular Phone Number"; Rec."Cellular Phone Number")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Work Phone Number"; Rec."Work Phone Number")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group(EmployeeTargets)
            {
                Caption = 'Employee Targets';
                part(pg; 75037)
                {
                    SubPageLink = "PF. No." = FIELD("No.");
                    ApplicationArea = All;
                }
            }
            group(Training)
            {
                Caption = 'Appraisee Training Needs';
                part(pg3; 75042)
                {
                    SubPageLink = "PF. No." = FIELD("No.");
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Supervisor Comments")
            {
                Caption = 'Supervisor Comments';
                Image = CalculateWIP;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page 75044;
                RunPageLink = "PF. No." = FIELD("No.");
                ApplicationArea = All;
            }
        }
    }

    var
        stud: Record 18;
        PictureExists: Boolean;
        GenJnl: Record 81;
        Units: Record 75004;
        GenSetUp: Record 75008;
        CourseReg: Record 75007;
        CurrentBill: Decimal;
        GLEntry: Record 17;
        CustLed: Record 21;
        BankLedg: Record 271;
        DCustLedg: Record 379;
        PDate: Date;
        DocNo: Code[20];
        VendLedg: Record 25;
        DVendLedg: Record 380;
        VATEntry: Record 254;
        CReg: Record 75007;
        CustLed2: Record 21;
        Cont: Boolean;
        Cust: Record 18;
        CustPostGroup: Record 92;
        window: Dialog;
        GLPosting: Codeunit 12;
        CustLedg: Record 21;
        DueDate: Date;
        Sems: Record 75016;
        ChangeLog: Record 405;
        CurrentBal: Decimal;
        Prog: Record 75003;
        "Settlement Type": Record 75006;
        AccPayment: Boolean;
        SettlementType: Code[20];
        CustL: Record 21;
        Units3: Record 75004;
}

