page 75038 "HRM-Appraisal Sup. Emp Card"
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
                    Caption = 'Payroll No';
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
                field("Division Code"; Rec."Division Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                    Caption = 'Division';
                }
                field("Department Code"; Rec."Department Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                    Caption = 'Department';
                }
                field("Job Title"; Rec."Job Title")
                {
                    Editable = false;
                    ApplicationArea = All;
                    Caption = 'Current Designation/Title';
                }
                field("Terms of Service"; Rec."Terms of Service")
                {
                    Editable = false;
                    ApplicationArea = All;

                }
                field("Salary Category"; Rec."Salary Category")
                {
                    Editable = False;
                    ApplicationArea = All;
                }
                field("Salary Grade"; Rec."Salary Grade")
                {
                    editable = false;
                    ApplicationArea = All;
                }
                field("Special Duty"; Rec."Special Duty")
                {
                    Editable = false;
                    ApplicationArea = All;
                    Caption = 'Acting Appointment/Special Duty(If any)';
                }
                field("Head of Department"; Rec."Head of Department")
                {
                    Editable = false;
                    ApplicationArea = All;

                }
                field(supDesignation; Rec.supDesignation)
                {
                    Editable = false;
                    ApplicationArea = All;
                }

            }
            group(depTargets)

            {
                Caption = 'Departmental Targets';
                part(pg3; "Individual Appraisal Lines")
                {
                    SubPageLink = employeeNo = FIELD("No.");
                    ApplicationArea = All;
                }
            }

            group(EmployeeTargets)
            {
                Caption = 'Performance Targets';
                part(pg; 75036)
                {
                    SubPageLink = "PF. No." = FIELD("No.");
                    ApplicationArea = All;
                }
            }
            group(supComm)
            {
                Caption = 'Comments';
                field(SupervisorComm; Rec.SupervisorComm)
                {
                    ApplicationArea = All;
                    Caption = 'Supervisor Comments';
                }
                field(apprComm; Rec.apprComm)
                {
                    ApplicationArea = All;
                    Caption = 'Appraisee Comments';
                }
            }
            group(Training)
            {
                Caption = 'Appraisee Training Needs';
                part(pg2; 75042)
                {
                    SubPageLink = "PF. No." = FIELD("No.");
                    ApplicationArea = All;
                }
            }
            // group(coreValues)
            // {
            //     Caption = 'CUEA core Values';
            //     part(pg4; 85517)
            //     {
            //         SubPageLink = "PF. No." = FIELD("No.");
            //         ApplicationArea = All;
            //     }
            // }
            // group(comPetence)
            // {
            //     Caption = 'Core Competences';
            //     part(pg5; 85518)
            //     {
            //         SubPageLink = "PF. No." = FIELD("No.");
            //         ApplicationArea = All;
            //     }
            // }
            // group(mngcomPetence)
            // {
            //     Caption = 'Managerial Competency';
            //     part(pg6; 85519)
            //     {
            //         SubPageLink = "PF. No." = FIELD("No.");
            //         ApplicationArea = All;
            //     }
            // }
            group(Bisem)
            {
                Caption = 'Bisemester/Trimester Staff Performance Review';
                field(appraisal; appraisal."Bisemester Review")
                {
                    Caption = 'Comments on performance';
                    ApplicationArea = All;
                }
            }
            group(midYr)
            {
                Caption = 'Targets Varied Mid Year';
                part(pg7; 85520)
                {
                    SubPageLink = "PF. No." = FIELD("No.");
                    ApplicationArea = All;
                }
            }

        }
    }
    actions
    {
        area(Processing)
        {
            action("Get Targets")
            {

                Image = Filter;
                PromotedCategory = Category4;
                Promoted = true;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    getTargets();
                end;
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
        appraisal: Record "HRM Apprisal Values";

    procedure getTargets()
    var
        hrmD: Record "HRM-Employee (D)";
        appraisalLines: Record AppraisaLines;
        targets: Record "HRM-Departmental Tragets";
    begin
        targets.Reset();
        targets.SetRange("Department Code", Rec."Responsibility Center");
        if targets.Find('-') then begin
            repeat
                appraisalLines.init;
                appraisalLines.lineNo := appraisalLines.lineNo + 1000;
                appraisalLines.employeeNo := Rec."No.";
                appraisalLines.objective := targets.Objective;
                appraisalLines.Insert();
            until targets.Next() = 0;
        end;
    end;
}

