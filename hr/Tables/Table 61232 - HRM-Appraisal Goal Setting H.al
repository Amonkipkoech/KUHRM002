table 61232 "HRM-Appraisal Goal Setting H"
{

    fields
    {
        field(1; "Appraisal No"; Code[30])
        {
        }
        field(2; Supervisor; Code[50])
        {

            trigger OnValidate()
            begin
                /*
                Sup.RESET;
                Sup.SETRANGE(Sup."No.","Supervisor No.");
                IF Sup.FIND('-') THEN
                  BEGIN
                   "Supervisor Name":=Sup."First Name"+' '+Sup."Middle Name"+' '+Sup."Last Name";
                  END;
                */

            end;
        }
        field(3; "Appraisal Type"; Code[30])
        {
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = FILTER("Appraisal Type"));
        }
        field(4; "Appraisal Period"; Code[30])
        {
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = FILTER("Appraisal Period"));

            trigger OnValidate()
            begin
                HRAppraisalGoalSettingH.Reset;
                HRAppraisalGoalSettingH.SetRange(HRAppraisalGoalSettingH."Appraisal Period", "Appraisal Period");
                HRAppraisalGoalSettingH.SetRange("Employee No", "Employee No");
                if HRAppraisalGoalSettingH.Find('-') then
                    Error('Goals for the current Appraisal period have already been filled');
            end;
        }
        field(5; Status; Option)
        {
            Editable = false;
            OptionMembers = Open,Approved,Closed;
        }
        field(6; Recommendations; Text[250])
        {
        }
        field(7; "No Series"; Code[20])
        {
        }
        field(8; "Appraisal Stage"; Option)
        {
            Editable = true;
            OptionMembers = "Target Setting",EndYearEvaluation;
        }
        field(9; Sent; Option)
        {
            Editable = true;
            OptionMembers = "At Appraisee","At Supervisor";
        }
        field(10; "User ID"; Code[50])
        {
        }
        field(11; Picture; BLOB)
        {
            SubType = Bitmap;
        }
        field(12; "Employee No"; Code[30])
        {
            Editable = false;

            trigger OnValidate()
            begin
                /*
                Objectives.RESET;
                Objectives.SETRANGE(Objectives."No.","No.");
                Objectives.SETRANGE(Objectives.Status,Objectives.Status::Open);
                IF Objectives.FIND('-') THEN
                  BEGIN
                  ERROR('Please close precceding period first');
                  END

                ELSE BEGIN
               Emp.RESET;
               Emp.SETRANGE(Emp."No.","No.");
               IF Emp.FIND('-') THEN
               BEGIN
                  "Employee Name":=Emp."First Name"+' '+Emp."Middle Name"+' '+Emp."Last Name";
                   Department:=Emp."HR Department Name";
                  "Job Tittle":=Emp."Job Title";
                  //Gender:=Emp.Gender;
                  "Date of Join":=Emp."Date Of Join";

                 END;
                 END;
                */

            end;
        }
        field(13; "Employee Name"; Text[30])
        {
            Editable = false;
        }
        field(15; "Job Title"; Code[30])
        {
            Editable = false;
        }
        field(16; "Supervisors Overal Rating"; Code[10])
        {
            TableRelation = "HRM-Appraisal Ratings (B)".Code;

            trigger OnValidate()
            begin

                if HRAppraisalRatings.Get("Supervisors Overal Rating") then
                    "Overal Rating Desc" := HRAppraisalRatings.Description;
                Recommendations := HRAppraisalRatings.Recommendations;
            end;
        }
        field(17; "Any Additional Comments"; Text[250])
        {
        }
        field(18; "Overal Rating Desc"; Text[30])
        {
        }
        field(19; "SuperVisor Email"; Text[100])
        {
        }
        field(20; "Total Score of Targets(%)"; Decimal)
        {
        }
        field(21; "Total Score of Targets(Points)"; Integer)
        {
        }
        field(24; SendToApprover; Boolean)
        {
            Editable = true;

            trigger OnValidate()
            begin
                /*IF "Job ID"<>'CHRO' THEN
                     Status:=Status::Open
                 ELSE
               Status:=Status::"Under Review";*/

                if SendToApprover <> true then
                    SendToApprover := true
                else
                    Error('you cannot Send the request twice');

            end;
        }
        field(25; "Training Needs"; Text[250])
        {
        }
        field(26; "Career Aspirations"; Text[250])
        {
        }
        field(27; "Exceptional Issues"; Text[250])
        {
        }
        field(28; "Begin Closed"; Boolean)
        {
            Editable = true;
            InitValue = false;
        }
        field(29; "Mid Closed"; Boolean)
        {
            Editable = true;
            InitValue = false;
        }
        field(30; "End Closed"; Boolean)
        {
            Editable = true;
            InitValue = false;
        }
        field(31; "User Name"; Text[50])
        {
        }
        field(32; Requested; Boolean)
        {
        }
        field(33; "MY Appraiser Comments"; Text[150])
        {
        }
        field(35; "MY Appraisee Comments"; Text[100])
        {
        }
        field(50000; "Act.Appointment ID"; Code[20])
        {
            Caption = 'Acting Appointments/Special duty';
        }
        field(50001; "Job Scale"; Code[10])
        {
        }
        field(50002; "HOD Approver"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(50003; "HR Approver"; Code[10])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(50004; "Manager Reviewer Comments"; Text[50])
        {
        }
        field(50005; MaximumTagets; Decimal)
        {
            CalcFormula = Sum("HRM-Emp. Performance Target"."Maximum Rating" WHERE("Employee No" = FIELD("Employee No"),
                                                                                    "Appraisal Period" = FIELD("Appraisal Period")));
            FieldClass = FlowField;
        }
        field(50006; Names; Text[60])
        {
        }
        field(50007; "Period inCurrent JG"; DateFormula)
        {
        }
        field(50008; "Total PTarget Score"; Decimal)
        {
            CalcFormula = Sum("HRM-Emp. Performance Target"."Agreed Rating" WHERE("Employee No" = FIELD("Employee No"),
                                                                                   "Appraisal Period" = FIELD("Appraisal Period")));
            FieldClass = FlowField;
        }
        field(50009; "Total Value Assessment Score"; Decimal)
        {
            CalcFormula = Sum("HRM-Appraisal Values assesment"."Agreed Rating New" WHERE("Employee No" = FIELD("Employee No"), "Appraisal Period" = FIELD("Appraisal Type"),
                                                                                          "Appraisal Period" = FIELD("Appraisal Period")));
            FieldClass = FlowField;
        }
        field(50010; "Date of Promotion"; Date)
        {
        }
        field(50011; Position; Code[30])
        {
        }
        field(50012; "App ID"; Code[30])
        {
        }
        field(50013; "No. Series"; Code[20])
        {
        }
        field(50014; "MY Comments"; Text[250])
        {
            Caption = 'Mid Year Comments';
        }
        field(50015; "MY Performance Rating"; Decimal)
        {
            Caption = 'Mid Year Performance Rating';
        }
        field(50016; "EY Appraiser Comments"; Text[250])
        {
        }
        field(50017; "EY Appraisee Comments"; Text[250])
        {
        }
        field(50018; "EY Performance Rating"; Decimal)
        {
        }
        field(50019; "Total Perfm Targets Score (%)"; Decimal)
        {
        }
        field(50020; "Total VaTargets Score (%)"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Appraisal No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Sent <> Sent::"At Appraisee" then
            Error(Mcontent1);


        HRGoalSettingL.SetRange(HRGoalSettingL."Appraisal No", "Appraisal No");
        if HRGoalSettingL.Find('-') then
            HRGoalSettingL.DeleteAll;
    end;

    trigger OnInsert()
    begin
        /*
        IF UserSetup.GET(USERID)THEN BEGIN
        "Supervisor No.":=UserSetup."Approver ID";
        "Supervisor Name":=UserSetup.Approvername;
        //ApprMail:=UserSetup.Approvermail;
        "No.":=UserSetup."Staff No";
        "Employee Name":=UserSetup.UserName;
        "Job Tittle":=UserSetup."Job Tittle";
        Department:=UserSetup."Global Dimension 1 Code";
        "User ID":=UserSetup."User ID";
        END
        */
        //GENERATE NEW NUMBER FOR THE DOCUMENT
        if "Appraisal No" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Appraisal Nos");
            NoSeriesMgt.InitSeries(HRSetup."Appraisal Nos", xRec."No Series", 0D, "Appraisal No", "No Series");
        end;

        //GET APPLICANT DETAILS FROM HR EMPLOYEES TABLE AND COPY THEM TO THE GOAL SETTING TABLE
        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", UserId);
        if HREmp.Find('-') then begin
            "Employee No" := HREmp."No.";
            "Employee Name" := HREmp.FullName;
            "Job Title" := HREmp."Job Title";
            "User ID" := UserId;
            Supervisor := HREmpF.GetSupervisor("User ID");
            HREmp.Get(HREmp."No.");
            HREmp.CalcFields(HREmp.Picture);
            Picture := HREmp.Picture;
            UserSetup.Reset;
            if UserSetup.Get(Supervisor) then
                "SuperVisor Email" := UserSetup."E-Mail";


        end else begin
            Error('User ID' + ' ' + UserId + ' ' + 'is not assigned to any employee. Consult the HR Officer so as to be setup as an employee')
        end;

    end;

    trigger OnModify()
    begin
        if Sent <> Sent::"At Appraisee" then
            Error(Mcontent);


        HRAppraisalGoalSettingH.SetRange(HRAppraisalGoalSettingH."Appraisal No", "Appraisal No");
        if Sent <> Sent::"At Appraisee" then
            Error(Mcontent);
    end;

    var
        HREmp: Record "HRM-Employee (D)";
        HRSetup: Record "HRM-Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HREmpF: Page "HRM-Employee";
        HRAppraisalRatings: Record "HRM-Appraisal Ratings (B)";
        HRAppraisalGoalSettingH: Record "HRM-Appraisal Goal Setting H";
        HRGoalSettingL: Record "HRM-Appraisal Goal Setting L";
        Mcontent: Label 'You cannot modify the appraisal form, Kindly ask your supervisor to send it back for editing';
        Mcontent1: Label 'You cannot delete this appraisal while at Supervisor';
        UserSetup: Record "User Setup";
}

