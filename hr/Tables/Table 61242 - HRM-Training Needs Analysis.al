table 61242 "HRM-Training Needs Analysis"
{
    //todo  DrillDownPageID = "PROC-Procurement Plan Lines";
    //todo LookupPageID = "PROC-Procurement Plan Lines";

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = false;
            Editable = false;
        }
        field(2; Description; Text[200])
        {
        }
        field(3; "Proposed Start Date"; Date)
        {
        }
        field(4; "Proposed End Date"; Date)
        {
        }
        field(5; "Duration Units"; Option)
        {
            OptionMembers = Hours,Days,Weeks,Months,Years;
        }
        field(6; Duration; Decimal)
        {

            trigger OnValidate()
            begin
                begin
                    if (Duration <> 0) and ("Proposed Start Date" <> 0D) then
                        //"Return Date" := DetermineLeaveReturnDate("Start Date","Days Applied");
                        //"End Date" := DeterminethisLeaveEndDate("Return Date");
                        "Proposed End Date" := HRLeaveApp.DetermineLeaveReturnDate("Proposed Start Date", Duration);
                    Modify;
                end;
            end;
        }
        field(7; "Cost Of Training"; Decimal)
        {

            trigger OnValidate()
            begin
                /*IF Posted THEN BEGIN
                IF Duration <> xRec.Duration THEN BEGIN
                MESSAGE('%1','You cannot change the costs after posting');
                Duration := xRec.Duration;
                END
                END
                */

            end;
        }
        field(8; Location; Text[100])
        {
        }
        field(12; "Need Source"; Option)
        {
            OptionCaption = 'Appraisal,Succesion,Training,Employee,Employee Skill Plan';
            OptionMembers = Appraisal,Succesion,Training,Employee,"Employee Skill Plan";
        }
        field(16; Directorate; Code[20])
        {
            Caption = 'Campus';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                Dimn.SetRange(Dimn.Code, Directorate);
                if Dimn.Find('-') then begin
                    "Directorate Name" := Dimn.Name;
                end;
            end;
        }
        field(17; Department; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                Dimn.SetRange(Dimn.Code, Department);
                if Dimn.Find('-') then begin
                    "Department Name" := Dimn.Name;
                end;
            end;
        }
        field(18; Closed; Boolean)
        {
            Editable = false;
        }
        field(19; "Qualification Code"; Code[20])
        {
            TableRelation = "HRM-Qualifications".Code WHERE("Qualification Type" = FIELD("Qualification Type"));

            trigger OnValidate()
            begin
                HRQualifications.SetRange(HRQualifications.Code, "Qualification Code");
                if HRQualifications.Find('-') then
                    "Qualification Description" := HRQualifications.Description;
            end;
        }
        field(20; "Qualification Type"; Code[30])
        {
            NotBlank = true;
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = CONST("Qualification Type"));
        }
        field(21; "Qualification Description"; Text[80])
        {
        }
        field(22; "Training Applicants"; Integer)
        {
            CalcFormula = Count("HRM-Training Applications" WHERE("Course Title" = FIELD(Code)));
            FieldClass = FlowField;
        }
        field(23; "Training Applicants (Passed)"; Integer)
        {
            CalcFormula = Count("HRM-Training Applications" WHERE("Course Title" = FIELD(Code),
                                                                   "Training Evaluation Results" = CONST(Passed)));
            FieldClass = FlowField;
        }
        field(24; "Training Applicants (Failed)"; Integer)
        {
            CalcFormula = Count("HRM-Training Applications" WHERE("Course Title" = FIELD(Code),
                                                                   "Training Evaluation Results" = CONST(Failed)));
            FieldClass = FlowField;
        }
        field(26; "No of Required Participants"; Integer)
        {
        }
        field(27; "Nature of Training"; Option)
        {
            OptionCaption = ' ,Internal,External,Self,E-Learning';
            OptionMembers = " ",Internal,External,Self,"E-Learning";
        }
        field(28; "Training Type"; Option)
        {
            OptionCaption = ',Long course,Short Course,Seminar,Workshop';
            OptionMembers = ,"Long course","Short Course",Seminar,Workshop;
        }
        field(29; "Course Version"; Code[20])
        {
        }
        field(30; "Course Version Description"; Text[200])
        {
        }
        field(31; "Individual Course"; Boolean)
        {
        }
        field(32; Status; Option)
        {
            Editable = false;
            OptionMembers = New,"Pending Approval",Approved;
        }
        field(33; "Quarter Offered"; Option)
        {
            OptionCaption = ' 1st Quarter,2nd Quarter,3rd Quarter,4th Quarter';
            OptionMembers = " 1st Quarter","2nd Quarter","3rd Quarter","4th Quarter";
        }
        field(35; "Application Date"; Date)
        {
            Editable = false;
        }
        field(40; "User ID"; Code[50])
        {
        }
        field(45; "Training category"; Option)
        {
            OptionCaption = 'Individual,Group';
            OptionMembers = Individual,Group;
        }
        field(51; "No of Participants"; Integer)
        {
            CalcFormula = Count("HRM-Training Participants" WHERE("Training Code" = FIELD(Code)));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                CalcFields("No of Participants");
                if "No of Participants" > "No of Required Participants" then begin
                    Error('Nominated Participants cannot exceed the Number of Participants Required 1111111 ');
                end;
                if "No of Participants" <= 0 then begin
                    Error('Required positions cannot be Less Than or Equal to Zero');
                end;
            end;
        }
        field(50000; "Directorate Name"; Text[100])
        {
            Caption = 'Campus Name';
            Editable = false;
        }
        field(50001; "Department Name"; Text[100])
        {
            Editable = false;
        }
        field(50002; "Employee Name"; Text[50])
        {
        }
        field(50003; Station; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                Dimn.SetRange(Dimn.Code, Station);
                if Dimn.Find('-') then begin
                    "Station Name" := Dimn.Name;
                end;
            end;
        }
        field(50004; "Course Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HRM-Training Courses"."Course Code" WHERE(Closed = CONST(false),
                                                                        "Individual Course" = CONST(false));

            trigger OnValidate()
            begin

                HRTrainingNeeds.Reset;
                HRTrainingNeeds.SetRange(HRTrainingNeeds."Course Code", "Course Code");
                if HRTrainingNeeds.Find('-') then begin
                    "No of Required Participants" := HRTrainingNeeds."No of Participants Required";

                end;
                if HRTrainingNeeds.Get("Course Code") then
                    //"Course Title":=HRTrainingNeeds.Code;
                    Description := HRTrainingNeeds."Course Tittle";
                //"From Date":=HRTrainingNeeds."Start Date";
                //"To Date":=HRTrainingNeeds."End Date";
                "Duration Units" := HRTrainingNeeds."Duration Units";
                Duration := HRTrainingNeeds.Duration;
                "Cost Of Training" := HRTrainingNeeds."Cost Of Training";
                "No of Participants" := HRTrainingNeeds."No of Participants Required";
                Location := HRTrainingNeeds.Location;
                //Provider:=HRTrainingNeeds.Provider;
                //"Provider Name":=HRTrainingNeeds."Provider Name";
                "Training Status" := HRTrainingNeeds."Closing Status";


                //"No of Required Participants":=HRTrainingNeeds."No of Participants Required";

                HRTrainingNeeds.SetRange(HRTrainingNeeds."Course Code", "Course Code");
                if "No of Participants" > HRTrainingNeeds."No of Participants Required" then
                    Error('The No of participants exceed the required Number');
                //IFTraining category"<> "Training category"::Group THEN

                //  ERROR(mcontent3);
            end;
        }
        field(50005; "Training Status"; Option)
        {
            OptionCaption = ' ,Suspended,Deferred,Cancelled,Completed Successfully';
            OptionMembers = " ",Suspended,Deferred,Cancelled,"Completed Successfully";

            trigger OnValidate()
            begin
                /*
                IF Status <> Status::Approved THEN
                ERROR(mcontent5);
                */

            end;
        }
        field(50006; "Table ID"; Integer)
        {
        }
        field(50007; "Employee No."; Code[10])
        {
            NotBlank = false;
            TableRelation = "HRM-Employee (D)"."No.";

            trigger OnValidate()
            begin
                if "Training category" <> "Training category"::Group then begin
                    HREmp.Get("Employee No.");
                    Directorate := HREmp."Department Code";
                    "Employee Name" := HREmp.FullName;
                end;
            end;
        }
        field(50008; "Station Name"; Text[50])
        {
            Editable = false;
        }
        field(50009; "No. Series"; Code[30])
        {
        }
        field(50010; "Entry No"; Integer)
        {
            AutoIncrement = true;
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
        if Code = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."TNA Nos.");
            NoSeriesMgt.InitSeries(HRSetup."TNA Nos.", xRec.Code, 0D, Code, HRSetup."TNA Nos.");
        end;

        "Application Date" := Today;
        "User ID" := UserId;
        "Table ID" := DATABASE::"HRM-Employee (D)";
        "User ID" := UserId;

        if UserSetup.Get(UserId) then begin
            /* if UserSetup."Employee No." = '' then
                Error('User Must be Setup as an employee first. Consult the HR Officer so as to be setup as an employee');
            if HREmp.Get(UserSetup."Employee No.") then begin
                "Employee No." := HREmp."No.";
                HREmp.Get(HREmp."No.");
                "Employee Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";

                "User ID" := UserId;
            end else begin
                Error('User Must be Setup as an employee first. Consult the HR Officer so as to be setup as an employee')
            end; */
        end else
            Error('You are not a valid user. Consult the system admin.');
        //END;

        UserSetup.Reset;
        if UserSetup.Get(UserId) then begin
            //Supervisor:=UserSetup."Approver ID";
            UserSetup.Reset;
            //IF UserSetup.GET(Supervisor) THEN
            //"Supervisor Name":=UserSetup."E-Mail";
            //END;

            CalcFields("No of Participants");
            /*
            IF "No of Participants" > "No of Required Participants" THEN
            BEGIN
                ERROR('Nominated Participants cannot exceed the Number of Participants Required 1111111 ');
            END;
            IF "No of Participants" <= 0 THEN
            BEGIN
                ERROR('Required positions cannot be Less Than or Equal to Zero');
            END;
             */
        end;

    end;

    var
        HRLeaveApp: Record "HRM-Leave Requisition";
        HRQualifications: Record "HRM-Qualifications";
        Dimn: Record "Dimension Value";
        HRTrainingNeeds: Record "HRM-Training Courses";
        HRSetup: Record "HRM-Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HREmp: Record "HRM-Employee (D)";
        Vend: Record Vendor;
        UserSetup: Record "User Setup";
        HRTrainApp: Record "HRM-Leave Requisition";
        TranPart: Record "HRM-Training Participants";
}

