page 75039 "HRM-Appraisal Sup. Emp. List"
{
    Caption = 'Appraisal Supervisor Employee List';
    CardPageID = "HRM-Appraisal Sup. Emp Card";
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 61188;

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
            group(Appraisal)
            {
                Caption = 'Appraisal';
                action("Appraisal Targets")
                {
                    Caption = 'Appraisal Targets';
                    Image = BOMRegisters;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page 75036;
                    RunPageLink = "PF. No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Appraisee Training Requirements")
                {
                    Caption = 'Appraisee Training Requirements';
                    Image = Translation;
                    Promoted = true;
                    ApplicationArea = All;
                    PromotedIsBig = true;
                    RunObject = Page 75042;
                    RunPageLink = "PF. No." = FIELD("No.");
                }
                action("Supervisor Comments")
                {
                    Caption = 'Supervisor Comments';
                    Image = CalculateWIP;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page 75044;
                    RunPageLink = "PF. No." = FIELD("No.");
                }
                action(TrainingNeeds)
                {
                    Caption = 'Training needs';
                    Image = Translations;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = report "HRM-Training Needs";
                }
                action(AppraisalStaff)
                {
                    Caption = 'Appraisals Targets';
                    Image = Translations;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = report "HRM Appraisal Targets";
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.SETFILTER("Job Title", HRMJobs."Job ID");
    end;

    /*  trigger OnOpenPage()
     begin
         IF NOT UserSetup.GET(USERID) THEN ERROR('Access Denied');
         UserSetup.TESTFIELD("Employee No.");
         HRMJobs.RESET;
         HRMJobs.SETRANGE("Supervisor/Manager", UserSetup."Employee No.");
         IF NOT HRMJobs.FIND('-') THEN ERROR('You are not an HOD. \**Access denied');
         Rec.SETFILTER("Job Title", HRMJobs."Job ID");
     end;
  */
    var
        stud: Record 18;
        CourseRegistration: Record 75007;
        PictureExists: Boolean;
        StudentRec: Record 18;
        CourseReg: Record 75007;
        districtname: Text[50];
        Cust: Record 18;
        GenJnl: Record 81;
        PDate: Date;
        CReg: Record 75007;
        Prog: Record 75003;
        TransInv: Boolean;
        TransRec: Boolean;
        CustL: Record 21;
        Units: Record 75004;
        GenSetUp: Record 75008;
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
        Sems: Record 75016;
        ChangeLog: Record 405;
        CurrentBal: Decimal;
        "Settlement Type": Record 75006;
        AccPayment: Boolean;
        SettlementType: Code[20];
        UserSetup: Record 91;
        HRMJobs: Record 61193;


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

