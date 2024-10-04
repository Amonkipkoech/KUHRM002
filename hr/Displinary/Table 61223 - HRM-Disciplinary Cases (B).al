table 61223 "HRM-Disciplinary Cases (B)"
{
    LookupPageID = "HRM-Disciplinary Cases List";
    DrillDownPageId = "HRM-Disciplinary Cases List";

    fields
    {
        field(1; "Case Number"; Code[20])
        {
            Editable = false;
        }
        field(3; "Date of Complaint"; Date)
        {
        }
        field(4; "Type Complaint"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = CONST("Disciplinary Case"));
        }
        field(5; "Recommended Action"; Code[20])
        {
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = CONST("Disciplinary Action"));
        }
        field(6; "Description of Complaint"; Text[250])
        {
        }
        field(7; Accuser; Code[10])
        {
            TableRelation = "HRM-Employee (D)"."No.";

            trigger OnValidate()
            begin
                if "Accused Employee" = Accuser then
                    Error('An employee cannot accuse his/her self');

                Emp.Reset;
                Emp.SetRange(Emp."No.", Accuser);
                if Emp.Find('-') then
                    "Accuser Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
            end;
        }
        field(8; "Witness #1"; Code[20])
        {
            TableRelation = "HRM-Employee (D)"."No.";

            trigger OnValidate()
            begin
                Emp.Reset;
                Emp.SetRange(Emp."No.", "Witness #1");
                if Emp.Find('-') then
                    "Witness #1 Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
            end;
        }
        field(9; "Witness #2"; Code[20])
        {
            TableRelation = "HRM-Employee (D)"."No.";

            trigger OnValidate()
            begin
                Emp.Reset;
                Emp.SetRange(Emp."No.", "Witness #2");
                if Emp.Find('-') then
                    "Witness #2  Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
            end;
        }
        field(10; "Action Taken"; Code[20])
        {
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = CONST("Disciplinary Action"));
        }
        field(11; "Date To Discuss Case"; Date)
        {
        }
        field(12; "Document Link"; Text[200])
        {
        }
        field(13; "Disciplinary Remarks"; Code[50])
        {
        }
        field(14; Comments; Text[250])
        {
        }
        field(15; "Case Discussion"; Boolean)
        {
        }
        field(16; "Body Handling The Complaint"; Code[100])
        {
            TableRelation = "HRM-Committees (B)".Code;
        }
        field(17; Recomendations; Code[10])
        {
        }
        field(18; "HR/Payroll Implications"; Integer)
        {
        }
        field(19; "Support Documents"; Option)
        {
            OptionMembers = Yes,No;
        }
        field(20; "Policy Guidlines In Effect"; Code[10])
        {
            //TableRelation = "HR Policies".Chapter;
        }
        field(21; Status; Option)
        {
            Editable = false;
            OptionCaption = 'New,Pending Approval,Approved';
            OptionMembers = New,"Pending Approval",Approved;
        }
        field(22; "Mode of Lodging the Complaint"; Text[30])
        {
        }
        field(23; "No. Series"; Code[20])
        {
        }
        field(24; "Accused Employee"; Code[30])
        {
            TableRelation = "HRM-Employee (D)"."No.";

            trigger OnValidate()
            begin
                Emp.Reset;
                Emp.SetRange(Emp."No.", "Accused Employee");
                if Emp.FindFirst() then
                    "Accused Employee Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
            end;
        }
        field(25; Selected; Boolean)
        {
        }
        field(26; "Closed By"; Code[20])
        {
        }
        field(27; "Department Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            trigger OnValidate()
            var
                dimV: Record "Dimension Value";
            begin
                if dimV.Get("Department Code") then
                    Department := Dimv.Name;
            end;
        }
        field(28; "Department"; Text[200])
        {

        }
        field(3963; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility Center";
        }
        field(3964; "Accuser Name"; Text[40])
        {
        }
        field(3965; "Witness #1 Name"; Text[50])
        {
        }
        field(3966; "Witness #2  Name"; Text[50])
        {
        }
        field(3967; "Disciplinary Stage Status"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Reported,Investigation ,Inprogress,Closed,Under review';
            OptionMembers = " ",Reported,"Investigation ",Inprogress,Closed,"Under review";
        }
        field(3968; "Document Type"; Option)
        {
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,None,Payment Voucher,Petty Cash,Imprest,Requisition,ImprestSurrender,Interbank,Receipt,Staff Claim,Staff Advance,AdvanceSurrender,Store Requisition,Employee Requisition,Leave Application,Transport Requisition,Training Requisition,Job Approval,Induction Approval,Disciplinary Approvals,Activity Approval';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Store Requisition","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval","Disciplinary Approvals","Activity Approval";
        }
        field(3969; "User ID"; Code[50])
        {
        }
        field(3970; "Accused Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
        }
        field(3971; "Accussed By"; Option)
        {
            OptionMembers = Employee,"Non-Employee";
        }
        field(3972; "Non Employee Name"; Text[100])
        {

            trigger OnValidate()
            begin
                if "Accussed By" = "Accussed By"::Employee then
                    Error('You are not allowed to Type Name if accused is an employee');
            end;
        }
        field(3973; Appealed; Boolean)
        {
        }
        field(50000; "Date of Complaint was Reported"; Date)
        {
        }
        field(50001; "Severity Of the Complain"; Option)
        {
            OptionMembers = Major,Minor;
        }
        field(50002; "Campus"; Code[20])
        {

        }
        field(50003; "Case Category"; Option)
        {
            OptionMembers = " ",General,"Gross Misconduct";
            //  TableRelation = "HRM-Lookup Values".Code WHERE(Type = CONST("Disciplinary Case"));

        }
        field(50004; "Case Description"; Text[200])
        {

        }
        field(50005; "Incident Date"; Date)
        {

        }


        field(50006; "Disc. Committee Case Date"; Date)
        {
            Caption = 'Disciplinary Committee Case Date';
        }
        field(50007; "Disciplinary Committee Verdict"; Text[100])
        {
            Caption = 'Disciplinary Committee Verdict';
        }
        field(50008; "Appeal (Yes/No)"; Boolean)
        {
            Caption = 'Appeal (Yes/No)';
        }
        field(50009; "Appeal Date"; Date)
        {
            Caption = 'Appeal Date';
        }
        field(50010; "Verdict on Appeal"; Text[200])
        {
            Caption = 'Verdict on Appeal';
        }
        field(50011; "Letter Date"; Date)
        {

        }


    }

    keys
    {
        key(Key1; "Accused Employee", "Case Number")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //GENERATE NEW NUMBER FOR THE DOCUMENT
        if "Case Number" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Disciplinary Cases Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Disciplinary Cases Nos.", xRec."No. Series", 0D, "Case Number", "No. Series");
        end;

        "User ID" := UserId;
        "Date of Complaint" := Today;
    end;

    trigger OnModify()
    begin
        /*IF Status=Status::"" THEN
        ERROR('You cannot modify a case Under Investigation');
         */

    end;

    var
        HRSetup: Record "HRM-Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Emp: Record "HRM-Employee (D)";
}

