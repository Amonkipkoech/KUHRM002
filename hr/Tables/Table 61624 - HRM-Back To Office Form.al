table 61624 "HRM-Back To Office Form"
{
    DrillDownPageID = "HRM-Appraisal Header";
    LookupPageID = "HRM-Appraisal Header";

    fields
    {
        field(1; "Document No"; Code[20])
        {
            Editable = true;

            trigger OnValidate()
            begin
                HRSetup.Get;
                NoSeriesMgt.TestManual(HRSetup."Back To Office Nos.");
                "No. Series" := '';
            end;
        }
        field(2; "Course Title"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HRM-Training Courses"."Course Code" WHERE(Closed = CONST(false),
                                                                        "Individual Course" = CONST(false));

            trigger OnValidate()
            begin

                HRTrainingNeeds.Reset;
                HRTrainingNeeds.SetRange(HRTrainingNeeds."Course Code", "Course Title");
                if HRTrainingNeeds.Get("Course Title") then
                    //"Course Title":=HRTrainingNeeds.Code;
                    Description := HRTrainingNeeds."Course Tittle";
                "From Date" := HRTrainingNeeds."Start Date";
                "To Date" := HRTrainingNeeds."End Date";
                "Duration Units" := HRTrainingNeeds."Duration Units";
                Duration := HRTrainingNeeds.Duration;
                "Cost Of Training" := HRTrainingNeeds."Cost Of Training";
                Location := HRTrainingNeeds.Location;
                Trainer := HRTrainingNeeds.Provider;
                "Training Institution" := HRTrainingNeeds."Provider Name";
                "Training Status" := HRTrainingNeeds."Closing Status";


                //"No of Required Participants":=HRTrainingNeeds."No of Participants Required";

                HRTrainingNeeds.SetRange(HRTrainingNeeds."Course Code", "Course Title");
                //IFTraining category"<> "Training category"::Group THEN

                //  ERROR(mcontent3);
            end;
        }
        field(3; "From Date"; Date)
        {
            Editable = true;
        }
        field(4; "To Date"; Date)
        {
            Editable = true;
        }
        field(5; "Duration Units"; Option)
        {
            Editable = true;
            OptionMembers = Hours,Days,Weeks,Months,Years;
        }
        field(6; Duration; Decimal)
        {
            Editable = true;

            trigger OnValidate()
            begin

                begin
                    if (Duration <> 0) and ("From Date" <> 0D) then
                        "To Date" := HRTrainApp.DetermineLeaveReturnDate("From Date", Duration);
                    Modify;
                end;
            end;
        }
        field(7; "Cost Of Training"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Editable = true;
        }
        field(8; Location; Text[30])
        {
            Editable = true;
        }
        field(12; Description; Text[250])
        {
            Editable = true;
        }
        field(28; "Training Evaluation Results"; Option)
        {
            OptionMembers = "Not Evaluated",Passed,Failed;

            trigger OnValidate()
            begin
                if "Training Status" <> "Training Status"::"Completed Successfully" then
                    Error(mcontent4);
            end;
        }
        field(30; Trainer; Code[10])
        {
            Editable = true;
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                Vend.Reset;
                Vend.SetRange(Vend."No.", Trainer);
                if Vend.Find('-') then begin
                    "Training Institution" := Vend.Name;
                end;
            end;
        }
        field(31; "Purpose of Training"; Text[100])
        {
        }
        field(32; Status; Option)
        {
            Editable = false;
            OptionMembers = New,"Pending Approval",Approved;
        }
        field(33; "Employee No."; Code[10])
        {
            NotBlank = false;
            TableRelation = "HRM-Employee (D)"."No.";

            trigger OnValidate()
            begin
                if "Training category" <> "Training category"::Group then begin
                    HREmp.Get("Employee No.");
                    //Directorate:=HREmp."Department Name";
                    "Employee Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                end;
            end;
        }
        field(36; "No. Series"; Code[10])
        {
        }
        field(40; "User ID"; Code[50])
        {
        }
        field(41; "Responsibility Center"; Code[10])
        {
            //TableRelation = "FIN-Responsibility Center BR".Code;
        }
        field(42; Directorate; Code[10])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(43; "Employee Name"; Text[50])
        {
        }
        field(44; "Training Institution"; Text[50])
        {
        }
        field(45; "Training category"; Option)
        {
            OptionCaption = 'Individual,Group';
            OptionMembers = Individual,Group;
        }
        field(46; "Table ID"; Integer)
        {
        }
        field(47; Supervisor; Code[50])
        {
        }
        field(48; "Supervisor Name"; Text[100])
        {
        }
        field(50000; Department; Code[30])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                HREmp.Reset;
                HREmp.SetRange(HREmp."No.", "Employee No.");
                HREmp.SetRange(HREmp."Department Code", Directorate);
                HREmp.SetRange(HREmp.County, Department);
                if HREmp.Find() then begin
                    if TranPart.Get("Document No") then begin
                        TranPart.Init;
                        TranPart."Employee Code" := HREmp."No.";
                        TranPart."Employee name" := HREmp."First Name" + '-' + HREmp."Middle Name" + '-' + HREmp."Last Name";
                        TranPart.Insert;
                    end;
                end;
            end;
        }
        field(50002; Station; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50003; "Period Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50005; "Training Status"; Option)
        {
            OptionCaption = ' ,Suspended,Deferred,Cancelled,Completed Successfully';
            OptionMembers = " ",Suspended,Deferred,Cancelled,"Completed Successfully";

            trigger OnValidate()
            begin
                if Status <> Status::Approved then
                    Error(mcontent5);
            end;
        }
        field(50006; "Text 1"; Text[200])
        {
        }
        field(50007; "Text 2"; Text[200])
        {
        }
        field(50008; "Text 3"; Text[200])
        {
        }
        field(50009; "Text 4"; Text[200])
        {
        }
        field(50010; "Text 5"; Text[200])
        {
        }
        field(50011; "Text 6"; Text[200])
        {
        }
        field(50012; "Text 9"; Text[200])
        {
        }
        field(50013; "Text 10"; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; "Document No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Status <> Status::New then
            Error(mcontent);
    end;

    trigger OnInsert()
    begin
        if "Document No" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Back To Office Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Back To Office Nos.", xRec."No. Series", 0D, "Document No", "No. Series");
        end;

        "User ID" := UserId;


        "Table ID" := 39005627;
        "User ID" := UserId;
        /*
       IF "Training category"<>"Training category"::Group THEN BEGIN
       //TESTFIELD("Employee No.");
       IF UserSetup.GET(USERID) THEN BEGIN
       IF HREmp.GET(UserSetup."Employee No.") THEN BEGIN
       "Employee No.":=HREmp."No.";
       "Employee Name":=HREmp."First Name"+' '+HREmp."Middle Name"+' '+HREmp."Last Name";

       "User ID":=USERID;
       END ELSE BEGIN
       ERROR('User Must be Setup as an employee first. Consult the HR Officer so as to be setup as an employee')
       END;
       END ELSE ERROR('You are not a valid system user!');
       END;

       UserSetup.RESET;
       IF UserSetup.GET(USERID)THEN BEGIN
       Supervisor:=UserSetup."Approver ID";
       UserSetup.RESET;
       IF UserSetup.GET(Supervisor) THEN
       "Supervisor Name":=UserSetup."E-Mail";

       END;
       */

    end;

    trigger OnModify()
    begin
        //CALCFIELDS("Occupied Positions");
        //IF "Occupied Positions">0 THEN
        //ERROR('Cannot modify job if it has occupants');
        //IF Status <> Status::New THEN
        //ERROR(mcontent2);
    end;

    var
        HRTrainingNeeds: Record "HRM-Training Courses";
        HRSetup: Record "HRM-Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        mcontent: Label 'Status must be new on Training Application No.';
        mcontent2: Label 'You cannot modify approved request, Please cancel the approval request and try again';
        HREmp: Record "HRM-Employee (D)";
        Vend: Record Vendor;
        UserSetup: Record "User Setup";
        mcontent3: Label 'Training category must be ''Group'' to allow for training application';
        HRTrainApp: Record "HRM-Leave Requisition";
        TranPart: Record "HRM-Training Participants";
        mcontent4: Label 'You cannot evaluate a training which is not successfully completed.';
        mcontent5: Label 'You cannot change training status if the status is not approved';
}

