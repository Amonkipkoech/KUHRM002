table 61621 "HRM-Transport Request"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Requester; Text[30])
        {
        }
        field(3; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(4; From; Text[30])
        {
        }
        field(5; "Purpose of Request"; Text[100])
        {
        }
        field(6; "Requisition Date"; Date)
        {
        }
        field(8; "User ID"; Code[40])
        {
        }
        field(9; "No. Series"; Code[20])
        {
        }
        field(10; "Requisition Time"; Time)
        {
        }
        field(11; Status; Option)
        {
            OptionMembers = New,"Pending Approval",Approved,Closed,Cancelled;
        }
        field(12; "To"; Text[30])
        {
        }
        field(13; "Responsibility Center"; Code[10])
        {
            //TableRelation = "FIN-Responsibility Center BR".Code;
        }
        field(14; "Requester Code"; Code[10])
        {
        }
        field(15; "Allocation Done"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        //GENERATE NEW NUMBER FOR THE DOCUMENT
        if Code = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Transport Req Nos");
            NoSeriesMgt.InitSeries(HRSetup."Transport Req Nos", xRec."No. Series", 0D, Code, "No. Series");
        end;

        //GET APPLICANT DETAILS FROM HR EMPLOYEES TABLE AND COPY THEM TO THE TRANSPORT TABLE
        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", UserId);
        if HREmp.Find('-') then begin
            "Requester Code" := HREmp."No.";
            Requester := HREmp.FullName;
            "Global Dimension 2 Code" := HREmp."Department Code";
            "User ID" := UserId;
            "Requisition Date" := Today;
            "Requisition Time" := Time;
        end else begin
            Error('User ID' + ' ' + UserId + ' ' + 'has not been mapped to any employee')
        end;
    end;

    var
        HRSetup: Record "HRM-Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HREmp: Record "HRM-Employee (D)";
}

