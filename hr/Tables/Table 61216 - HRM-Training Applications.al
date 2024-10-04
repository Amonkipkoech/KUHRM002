table 61216 "HRM-Training Applications"
{
    DrillDownPageID = "HRM-Appraisal Header";
    LookupPageID = "HRM-Appraisal Header";

    fields
    {
        field(1; "Application No"; Code[20])
        {
            Editable = true;

            trigger OnValidate()
            begin
                if "Employee No." <> xRec."Employee No." then begin
                    HRSetup.Get;
                    NoSeriesMgt.TestManual(HRSetup."Training Application Nos.");
                    "No. Series" := '';
                end;
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
                if HRTrainingNeeds.Find('-') then begin
                    "No of Required Participants" := HRTrainingNeeds."No of Participants Required";

                end;
                if HRTrainingNeeds.Get("Course Title") then
                    //"Course Title":=HRTrainingNeeds.Code;
                    Description := HRTrainingNeeds."Course Tittle";
                "From Date" := HRTrainingNeeds."Start Date";
                "To Date" := HRTrainingNeeds."End Date";
                "Duration Units" := HRTrainingNeeds."Duration Units";
                Duration := HRTrainingNeeds.Duration;
                "Cost Of Training" := HRTrainingNeeds."Cost Of Training";
                "No of Participants" := HRTrainingNeeds."No of Participants Required";
                //Location:=HRTrainingNeeds.Location;
                Trainer := HRTrainingNeeds.Provider;
                "Training Institution" := HRTrainingNeeds."Provider Name";
                "Training Status" := HRTrainingNeeds."Closing Status";


                //"No of Required Participants":=HRTrainingNeeds."No of Participants Required";

                HRTrainingNeeds.SetRange(HRTrainingNeeds."Course Code", "Course Title");
                if "No of Participants" > HRTrainingNeeds."No of Participants Required" then
                    Error('The No of participants exceed the required Number');
                //IFTraining category"<> "Training category"::Group THEN

                //  ERROR(mcontent3);
                TrainingApp.Reset;
                TrainingApp.SetRange(TrainingApp."Employee No.", "Employee No.");
                TrainingApp.SetRange(TrainingApp."Course Title", "Course Title");

                if TrainingApp.Find('-') then
                    Error('You have applied for this Course before');
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
            OptionMembers = " ",Hours,Days,Weeks,Months,Years;
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
            CalcFormula = Sum("HRM-Training Cost".Cost WHERE("Training Id" = FIELD("Application No")));
            DecimalPlaces = 0 : 0;
            Editable = true;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                if Posted then begin
                    if Duration <> xRec.Duration then begin
                        Message('%1', 'You cannot change the costs after posting');
                        Duration := xRec.Duration;
                    end
                end
            end;
        }
        field(8; Location; Option)
        {
            Editable = true;
            OptionMembers = "Local",International;
        }
        field(11; Posted; Boolean)
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
        field(29; Year; Integer)
        {
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

                HREmp.Get("Employee No.");
                // Directorate := HREmp."Department Code";
                "Employee Name" := HREmp.FullName;

            end;
        }
        field(35; "Application Date"; Date)
        {
            Editable = false;
        }
        field(36; "No. Series"; Code[10])
        {
        }
        field(37; Address; Text[50])
        {
            Caption = 'Address';
        }
        field(39; Recommendations; Code[20])
        {
        }
        field(40; "User ID"; Code[50])
        {
        }
        field(41; "Responsibility Center"; Code[20])
        {
            //TableRelation = "FIN-Responsibility Center BR".Code;
        }
        field(42; Directorate; Code[30])
        {
            Caption = 'Campus';
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = const(1));
            trigger OnValidate()
            begin
                Dimn.SetRange(Dimn.Code, Directorate);
                if Dimn.Find('-') then begin
                    "Directorate Name" := Dimn.Name;
                end;
            end;
        }
        field(43; "Employee Name"; Text[50])
        {
        }
        field(44; "Training Institution"; Text[50])
        {
        }
        field(45; "Training Category"; Option)
        {
            OptionCaption = ' ,Individual,Group';
            OptionMembers = " ",Individual,Group;
        }
        field(46; "Table ID"; Integer)
        {
        }
        field(47; Supervisor; Code[50])
        {
            TableRelation = "HRM-Employee (D)"."No." where(Status = filter(Active));
        }
        field(48; "Supervisor Name"; Text[100])
        {
        }
        field(49; "Individual Course Code"; Code[50])
        {
            TableRelation = "HRM-Training Courses"."Course Code" WHERE("Individual Course" = CONST(true));
        }
        field(50; "Individual Course Description"; Text[250])
        {
        }
        field(51; "No of Participants"; Integer)
        {
            CalcFormula = Count("HRM-Training Participants" WHERE("Training Code" = FIELD("Application No")));
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
        field(50000; Department; Code[30])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                Dimn.Reset();
                Dimn.SetRange(Dimn.Code, Department);
                if Dimn.FindFirst() then begin
                    "Department Name" := Dimn.Name;
                end;


                /*
                HREmp.RESET;
                HREmp.SETRANGE(HREmp."No.","Employee No.");
                HREmp.SETRANGE(HREmp."Department Code",Directorate);
                HREmp.SETRANGE(HREmp.County,Department);
                IF HREmp.FIND() THEN BEGIN
                IF TranPart.GET("Application No")THEN BEGIN
                 TranPart.INIT;
                 TranPart."Employee Code":=HREmp."No.";
                 TranPart."Employee name":=HREmp."First Name"+'-'+HREmp."Middle Name"+'-'+HREmp."Last Name";
                 TranPart.INSERT;
                END;
                END;
                */

            end;
        }
        field(50001; "No of Required Participants"; Integer)
        {
            FieldClass = Normal;
        }
        field(50002; Station; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('location|Locations'));

            trigger OnValidate()
            begin
                Dimn.SetRange(Dimn.Code, Station);
                if Dimn.Find('-') then begin
                    "Station Name" := Dimn.Name;
                end;
            end;
        }
        field(50003; "Period Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50004; "Quarter Offered"; Option)
        {
            OptionCaption = ' 1st Quarter,2nd Quarter,3rd Quarter';
            OptionMembers = " 1st Quarter","2nd Quarter","3rd Quarter";
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
        field(50006; "Department Name"; Text[50])
        {
        }
        field(50007; "Station Name"; Text[50])
        {
        }
        field(50008; "Directorate Name"; Text[50])
        {
        }
        field(50009; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50010; Sponsor; Option)
        {
            OptionMembers = Self,KNCHR,Donor,Other;
        }
        field(50011; Specify; Text[80])
        {
        }
        field(50012; Country; Code[20])
        {
            TableRelation = "Country/Region".Code;
        }
        field(50013; "Academic Year"; Code[15])
        {

        }
        field(50014; "Bonding Required"; Boolean)
        {

        }
        field(50015; "Bonding Period"; Boolean)
        {

        }
        field(50016; "Scholarship Type"; Code[10])
        {

        }
        field(50017; "Scholarship Duration(Months)"; Integer)
        {

        }
        field(50018; Completed; Boolean)
        {

        }
        field(50019; County; Code[20])
        {

        }

    }

    keys
    {
        key(Key1; "Application No", "Employee No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Course Title")
        {
        }
    }

    trigger OnDelete()
    begin
        if Status <> Status::New then
            Error(mcontent);
    end;

    trigger OnInsert()
    begin
        if "Application No" = '' then begin
            HRSetup.Reset;
            if HRSetup.Find('-') then begin end;
            //HRSetup.GET;
            HRSetup.TestField(HRSetup."Training Application Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Training Application Nos.", xRec."No. Series", 0D, "Application No", "No. Series");
        end;

        "User ID" := UserId;
        "Application Date" := Today;

        "Table ID" := DATABASE::"HRM-Employee (D)";
        "User ID" := UserId;

        if "Training Category" <> "Training Category"::Group then begin
            //TESTFIELD("Employee No.");
            //IF userseups.GET(USERID) THEN BEGIN
            //IF userseups."Employee No."='' THEN ERROR('Your Login is not associated with any employee. Consult the system Admin.');
            //IF HREmp.GET(userseups."Employee No.") THEN BEGIN
            //"Employee No.":=HREmp."No.";
            //"User ID":=USERID;
            //END ELSE BEGIN
            //ERROR('User Must be Setup as an employee first. Consult the HR Officer so as to be setup as an employee')
            //END;

        end else
            Error('You are not a legitimate user! Consult the system Admin.');
        //END;

        if UserSetup.Get(UserId) then begin
            Supervisor := UserSetup."Approver ID";
            UserSetup.Reset;
            if UserSetup.Get(Supervisor) then
                "Supervisor Name" := UserSetup."E-Mail";
        end;

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
        Dimn: Record "Dimension Value";
        TrainingApp: Record "HRM-Training Applications";
        userseups: Record "User Setup";
}

