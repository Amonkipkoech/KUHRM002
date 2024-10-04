page 75048 "HRM-Appraisal Emps List"
{
    Caption = 'All Students List';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HRM-Employee (D)";

    layout
    {
        area(content)
        {
            repeater(rep)
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
                field(Initials; Rec.Initials)
                {
                    ApplicationArea = All;
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
                field("Postal Address"; Rec."Postal Address")
                {
                    Caption = 'Town';
                    ApplicationArea = All;
                }
                field("Residential Address"; Rec."Residential Address")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
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
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Student)
            {
                Caption = 'Student';
                action("Appraisal Registrations")
                {
                    Caption = 'Appraisal Registrations';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "HRM-Appraisal Registration";
                    RunPageLink = "PF No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Appraisal Targets")
                {
                    Caption = 'Appraisal Targers';
                    Image = BOMRegisters;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "HRM-Appraisal Appraisee Target";
                    RunPageLink = "PF. No." = FIELD("No.");
                    ApplicationArea = All;
                }
                /* action("Previous Appraisals")
                {
                    Caption = 'Previous Appraisals';
                    Image = Info;
                    RunObject = Page "HRM-Appraisal Registration 2";
                    RunPageLink = "No." = FIELD("No.");
                } */
            }
        }
    }

    var
        stud: Record 18;
        CourseRegistration: Record "HRM-Appraisal Registration";
        PictureExists: Boolean;
        StudentRec: Record 18;
        CourseReg: Record "HRM-Appraisal Registration";
        districtname: Text[50];
        Cust: Record 18;
        GenJnl: Record 81;
        PDate: Date;
        CReg: Record "HRM-Appraisal Registration";
        Prog: Record "HRM-Appraisal Jobs";
        TransInv: Boolean;
        TransRec: Boolean;
        CustL: Record 21;
        Units: Record "HRM-Appraisal Targets";
        GenSetUp: Record "HRM-Appraisal Gen. Setup";
        CurrentBill: Decimal;
        GLEntry: Record 17;
        CustLed: Record 21;
        BankLedg: Record 271;
        DCustLedg: Record 379;
        VendLedg: Record 25;
        DVendLedg: Record 380;
        VATEntry: Record 254;
        CustLed2: Record 21;
        CustPostGroup: Record 92;
        window: Dialog;
        GLPosting: Codeunit 12;
        CustLedg: Record 21;
        DueDate: Date;
        Sems: Record "HRM-Appraisal Periods";
        ChangeLog: Record 405;
        CurrentBal: Decimal;
        "Settlement Type": Record "HRM-Employee Category";
        AccPayment: Boolean;
        SettlementType: Code[20];


    procedure GetSelectionFilter(): Code[80]
    var
        Cust: Record 18;
        FirstCust: Code[30];
        LastCust: Code[30];
        SelectionFilter: Code[250];
        CustCount: Integer;
        More: Boolean;
    begin
        CurrPage.SETSELECTIONFILTER(Cust);
        CustCount := Cust.COUNT;
        IF CustCount > 0 THEN BEGIN
            Cust.FIND('-');
            WHILE CustCount > 0 DO BEGIN
                CustCount := CustCount - 1;
                Cust.MARKEDONLY(FALSE);
                FirstCust := Cust."No.";
                LastCust := FirstCust;
                More := (CustCount > 0);
                WHILE More DO
                    IF Cust.NEXT = 0 THEN
                        More := FALSE
                    ELSE
                        IF NOT Cust.MARK THEN
                            More := FALSE
                        ELSE BEGIN
                            LastCust := Cust."No.";
                            CustCount := CustCount - 1;
                            IF CustCount = 0 THEN
                                More := FALSE;
                        END;
                IF SelectionFilter <> '' THEN
                    SelectionFilter := SelectionFilter + '|';
                IF FirstCust = LastCust THEN
                    SelectionFilter := SelectionFilter + FirstCust
                ELSE
                    SelectionFilter := SelectionFilter + FirstCust + '..' + LastCust;
                IF CustCount > 0 THEN BEGIN
                    Cust.MARKEDONLY(TRUE);
                    Cust.NEXT;
                END;
            END;
        END;
        EXIT(SelectionFilter);
    end;


    procedure SetSelection(var Cust: Record 18)
    begin
        CurrPage.SETSELECTIONFILTER(Cust);
    end;
}

