table 61246 "HRM-Induction Schedule"
{

    fields
    {
        field(1; "Induction Code"; Code[10])
        {

            trigger OnValidate()
            begin
                if "Induction Code" <> xRec."Induction Code" then begin
                    HRSetup.Get;
                    NoSeriesMgt.TestManual(HRSetup."Induction Nos");
                    "No series" := '';
                end;
            end;
        }
        field(2; "Staff Code"; Code[20])
        {
            TableRelation = "HRM-Employee (D)"."No.";

            trigger OnValidate()
            begin
                Staff.Reset;
                Staff.SetRange(Staff."No.", "Staff Code");
                if Staff.Find('-') then begin
                    "Staff Names" := Staff."First Name" + ' ' + Staff."Middle Name" + ' ' + Staff."Last Name";
                    "Date of Join" := Staff."Date Of Join";
                end;
            end;
        }
        field(3; "Staff Names"; Text[100])
        {
        }
        field(4; "Staff Department"; Text[100])
        {
        }
        field(5; "Date of Join"; Date)
        {
        }
        field(6; "Department Code"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                Department.Reset;
                Department.SetRange(Department.Code, "Department Code");
                if Department.Find('-') then begin
                    "Department Name" := Department.Name;
                end;
            end;
        }
        field(7; "Department Name"; Text[100])
        {
        }
        field(8; "Induction Period"; Integer)
        {
        }
        field(9; "Induction Start date"; Date)
        {

            trigger OnValidate()
            begin
                Induction.Reset;
                Induction.SetRange(Induction."Staff Code", "Staff Code");

                if Induction.Find('-') then begin
                    Evaluate(RLen, (Format(Induction."Induction Period") + 'D'));
                    Rdate := CalcDate(RLen, "Induction Start date");
                    "Induction End  date" := Rdate;
                end;
            end;
        }
        field(10; "Induction End  date"; Date)
        {
        }
        field(11; Comments; Text[100])
        {
        }
        field(12; Status; Option)
        {
            OptionCaption = 'New,Pending Approval,Approved';
            OptionMembers = New,"Pending Approval",Approved;
        }
        field(13; "Document Type"; Option)
        {
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,None,Payment Voucher,Petty Cash,Imprest,Requisition,ImprestSurrender,Interbank,Receipt,Staff Claim,Staff Advance,AdvanceSurrender,Budget Transfer,Employee Requisition,Leave Application,Transport Requisition,Training Requisition,Job Approval,Induction Approval';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Budget Transfer","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval";
        }
        field(38; "Table ID"; Integer)
        {
        }
        field(40; "User ID"; Code[50])
        {
        }
        field(41; Selected; Boolean)
        {
        }
        field(42; "No series"; Code[10])
        {
        }
        field(43; Supervisor; Code[10])
        {
        }
        field(44; "Application Date"; Date)
        {
        }
        field(45; "Responsibility Center"; Code[10])
        {
            //TableRelation = "FIN-Responsibility Center BR";
        }
    }

    keys
    {
        key(Key1; "Induction Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Induction Code" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Induction Nos");
            NoSeriesMgt.InitSeries(HRSetup."Induction Nos", xRec."No series", 0D, "Induction Code", xRec."No series");
        end;


        "Table ID" := DATABASE::"HRM-Employee (D)";
        "User ID" := UserId;
        //IF "Training category"<>"Training category"::Group THEN BEGIN
        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", UserId);
        if HREmp.Find('-') then begin
            "Staff Code" := HREmp."No.";
            //"Job Title":=HREmp."Job Title";
            HREmp.Get(HREmp."No.");
            //HREmp.CALCFIELDS(HREmp.Picture);
            //Picture:=HREmp.Picture;
            "User ID" := UserId;
        end else begin
            Error('User Must be Setup as an employee first. Consult the HR Officer so as to be setup as an employee')
        end;
        //END;

        UserSetup.Reset;
        if UserSetup.Get(UserId) then begin
            Supervisor := UserSetup."Approver ID";
            UserSetup.Reset;
            if UserSetup.Get(Supervisor) then
                //"Supervisor Name":=UserSetup."E-Mail";
                //END;

                //POPULATE FIELDS
                "Application Date" := Today;
        end;
    end;

    var
        Induction: Record "HRM-Induction Schedule";
        CLen: DateFormula;
        CDate: Date;
        RLen: DateFormula;
        Rdate: Date;
        Staff: Record "HRM-Employee (D)";
        HRSetup: Record "HRM-Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HREmp: Record "HRM-Employee (D)";
        UserSetup: Record "User Setup";
        Department: Record "Dimension Value";
}

