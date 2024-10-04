table 61619 "HRM-Employee"
{
    Caption = 'HR Employee';
    DataCaptionFields = "No.", "First Name", "Middle Name", "Last Name", "Job Title", "Search Name";
    //todo DrillDownPageID = "SWF-Club Event List";
    //todo  LookupPageID = "SWF-Club Event List";

    fields
    {
        field(1; "No."; Code[100])
        {
            NotBlank = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    HumanResSetup.Get;
                    NoSeriesMgt.TestManual(HumanResSetup."Employee Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "First Name"; Text[80])
        {

            trigger OnValidate()
            begin
                if Rec."First Name" <> xRec."First Name" then begin
                    //ValueChangeManagement.ManageHRFieldChange("No.",11,FORMAT(xRec."First Name"),FORMAT(Rec."First Name"),"Text 011");
                    if not Confirm('Are You Sure You Want to Change The Employee First Name?') then
                        Error('First Name Not Changed');
                    if Payroll.Get("No.") then begin
                        Payroll."First Name" := "First Name";
                        Payroll.Modify;
                    end;

                end;
            end;
        }
        field(3; "Middle Name"; Text[50])
        {

            trigger OnValidate()
            begin
                if Rec."Middle Name" <> xRec."Middle Name" then begin
                    //ValueChangeManagement.ManageHRFieldChange("No.",11,FORMAT(xRec."Middle Name"),FORMAT(Rec."Middle Name"),"Text 011");
                    if not Confirm('Are You Sure You Want to Change The Employee Middle Name?') then
                        Error('First Name Not Changed');
                    if Payroll.Get("No.") then begin
                        Payroll."Middle Name" := "Middle Name";
                        Payroll.Modify;
                    end;

                end;
            end;
        }
        field(4; "Last Name"; Text[50])
        {

            trigger OnValidate()
            var
                Reason: Text[30];
            begin
                if Rec."Last Name" <> xRec."Last Name" then begin
                    //ValueChangeManagement.ManageHRFieldChange("No.",11,FORMAT(xRec."Last Name"),FORMAT(Rec."Last Name"),"Text 011");
                    if not Confirm('Are You Sure You Want to Change The Employee Last Name?') then
                        Error('First Name Not Changed');
                    if Payroll.Get("No.") then begin
                        Payroll."Last Name" := "Last Name";
                        Payroll.Modify;
                    end;

                end;
            end;
        }
        field(5; Initials; Text[50])
        {

            trigger OnValidate()
            begin
                if ("Search Name" = UpperCase(xRec.Initials)) or ("Search Name" = '') then
                    "Search Name" := Initials;
            end;
        }
        field(7; "Search Name"; Code[50])
        {
        }
        field(8; "Postal Address"; Text[80])
        {
        }
        field(9; "Residential Address"; Text[80])
        {
        }
        field(10; City; Text[30])
        {

            trigger OnLookup()
            begin
                //PostCode.LookUpCity(City,"Post Code",TRUE);
            end;

            trigger OnValidate()
            begin
                //PostCode.ValidateCity(City,"Post Code");
            end;
        }
        field(11; "Post Code"; Code[20])
        {
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                //PostCode.LookUpPostCode(City,"Post Code",TRUE);
            end;

            trigger OnValidate()
            begin
                //PostCode.ValidatePostCode(City,"Post Code");
            end;
        }
        field(12; County; Text[30])
        {
        }
        field(13; "Home Phone Number"; Text[30])
        {
        }
        field(14; "Cellular Phone Number"; Text[30])
        {
        }
        field(15; "Work Phone Number"; Text[30])
        {
        }
        field(16; "Ext."; Text[7])
        {
        }
        field(17; "E-Mail"; Text[80])
        {
        }
        field(19; Picture; BLOB)
        {
            SubType = Bitmap;
        }
        field(21; "ID Number"; Text[30])
        {

            trigger OnValidate()
            begin
                if Rec."ID Number" <> xRec."ID Number" then begin
                    if not Confirm('Are You Sure You Want to Change the Employee ID Number?') then
                        Error('ID Number Not Changed');
                    if Payroll.Get("No.") then begin
                        Payroll."ID Number" := "ID Number";
                        Payroll.Modify;
                    end;
                end;
            end;
        }
        field(22; "Union Code"; Code[10])
        {
            TableRelation = Union;
        }
        field(23; "UIF Number"; Text[30])
        {
        }
        field(24; Gender; Option)
        {
            OptionMembers = Female,Male;
        }
        field(25; "Country Code"; Code[10])
        {
            TableRelation = "Country/Region".Code;
        }
        field(31; Status; Option)
        {
            OptionMembers = Normal,Resigned,Discharged,Retrenched,Pension,Disabled;

            trigger OnValidate()
            begin
                /*
                IF Rec.Status <> xRec.Status THEN BEGIN
                  ValueChangeManagement.ManageHRFieldChange("No.",4,FORMAT(xRec.Status),FORMAT(Rec.Status),"Text 002")
                END;
                
                //Added to change Status
                //employee payroll
                IF NOT CONFIRM('Are You Sure You Want to Change The Employee Status? This will delete the Assigned deductions and Earnings') THEN
                  ERROR('Status Not Changed');
                
                IF Payroll.GET("No.") THEN BEGIN
                IF Status=Status::Normal THEN BEGIN
                  Payroll.Status:=Payroll.Status::Active;
                  Payroll.MODIFY;
                END;
                IF Status<>Status::Normal THEN BEGIN
                  Payroll.Status:=Payroll.Status::Terminated;
                  Payroll.MODIFY;
                END;
                
                END;
                
                GetPayPeriod;
                IF Status<>Status::Normal THEN BEGIN
                AssMatrix.RESET;
                AssMatrix.SETRANGE("Employee No","No.");
                AssMatrix.SETRANGE("Payroll Period",PayStartDate);
                IF AssMatrix.FIND('-') THEN BEGIN
                 REPEAT
                  AssMatrix.DELETE;
                 UNTIL AssMatrix.NEXT=0;
                END;
                END;
                */

            end;
        }
        field(36; "Department Code"; Code[30])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('DEPARTMENT'));

            trigger OnValidate()
            begin
                if Rec."Department Code" <> xRec."Department Code" then begin
                    // ValueChangeManagement.ManageHRFieldChange("No.",1,xRec."Department Code",Rec."Department Code","Text 001")
                end;


                /******************************************************************************************/

                //Added to change dept on employee table and assignment matrix table
                //employee payroll
                if Payroll.Get("No.") then begin
                    Payroll."Department Code" := "Department Code";
                    Payroll.Modify;
                end;

                //
                GetPayPeriod;
                // "Payroll Period":=PayStartDate;
                //  "Pay Period":=PayPeriodText;

                //Employee No,Type,Code,Payroll Period,Department Code

                /*
                AssMatrix.RESET;
                AssMatrix.SETRANGE("Employee No","No.");
                AssMatrix.SETRANGE("Payroll Period",PayStartDate);
                IF AssMatrix.FIND('-') THEN BEGIN
                 REPEAT
                  AssMatrixTemp.TRANSFERFIELDS(AssMatrix);
                  AssMatrixTemp."Department Code":="Department Code";
                  AssMatrixTemp.INSERT;
                  AssMatrix.DELETE;
                 UNTIL AssMatrix.NEXT=0;
                END;
                
                
                AssMatrixTemp.RESET;
                AssMatrixTemp.SETRANGE("Employee No","No.");
                AssMatrixTemp.SETRANGE("Payroll Period",PayStartDate);
                IF AssMatrixTemp.FIND('-') THEN BEGIN
                 REPEAT
                  AssMatrix.TRANSFERFIELDS(AssMatrixTemp);
                  //AssMatrix."Department Code":="Department Code";
                  AssMatrix.INSERT;
                 AssMatrixTemp.DELETE;
                 UNTIL AssMatrixTemp.NEXT=0;
                END;
                {****************************************************************************************}
                */

            end;
        }
        field(37; Office; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('BRANCH'));
        }
        field(39; Comment; Boolean)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(40; "Last Date Modified"; Date)
        {
            Editable = false;
        }
        field(41; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(42; "Department Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(47; "Employee No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = Employee;
        }
        field(49; "Fax Number"; Text[30])
        {
        }
        field(50; "Company E-Mail"; Text[50])
        {
        }
        field(51; Title; Option)
        {
            OptionMembers = MR,MRS,MISS,MS,DR,"  ",CC;
        }
        field(53; "No. Series"; Code[50])
        {
            Editable = false;
            TableRelation = "No. Series";
        }
        field(54; "Known As"; Text[30])
        {
        }
        field(55; Position; Text[30])
        {
            Caption = 'Job Title';
            //todo TableRelation = "HRM-Transport Request";

            trigger OnValidate()
            begin
                if Jobs.Get(Position) then begin
                    "Job Title" := Jobs.Requester;
                    //todo    JobsEntry.Reset;
                    //todo  JobsEntry.SetRange(JobsEntry."Employee Requisition No", Position);
                    //todo  if JobsEntry.Find('-') then
                    //todo      "HR Department" := JobsEntry."ID No";

                end;
                //todo   JobsEntry.SetRange(JobsEntry."Employee Requisition No", Position);
                //IF JobsEntry.FIND('-') THEN
                //   Grade := JobsEntry.Grade;

                //IF Grades.GET(Grade) THEN
                // "Allocated Leave Days" := Grades.Location;



                if Rec.Position <> xRec.Position then begin
                    // ValueChangeManagement.ManageHRFieldChange("No.",8,FORMAT(xRec.Position),FORMAT(Rec.Position),"Text 008")
                end;

                //PKK MODIFY;
            end;
        }
        field(57; "Full / Part Time"; Option)
        {
            OptionMembers = "Full Time","Part Time";
        }
        field(58; "Contract Type"; Code[50])
        {
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = CONST("Qualification Type"));

            trigger OnValidate()
            begin
                TestField("Date Of Join");
                if Rec."Contract Type" <> xRec."Contract Type" then begin
                    //ValueChangeManagement.ManageHRFieldChange("No.",14,FORMAT(xRec."Contract Type"),FORMAT(Rec.  "Contract Type"),"Text 016")
                end;
                /*
                Contracts.RESET;
                Contracts.SETRANGE(Contracts.Type,Contracts.Type::"5");
                Contracts.SETRANGE(Contracts.Code,Rec."Contract Type");
                IF Contracts.FIND('-') THEN BEGIN
                 EVALUATE(CLen,(FORMAT(Contracts.Months)+'M'));
                 CDate := CALCDATE(CLen,"Date Of Join");
                 "End Of Probation Date" := CDate;
                END;*/

            end;
        }
        field(59; "Contract End Date"; Date)
        {
        }
        field(60; "Notice Period"; Code[10])
        {
        }
        field(61; "Union Member?"; Boolean)
        {
        }
        field(64; "Pay Period"; Option)
        {
            OptionMembers = Weekly,"2 Weekly","4 Weekly",Monthly," ";
        }
        field(65; "Pay Per Period"; Decimal)
        {
        }
        field(66; "Cost Code"; Code[50])
        {
            TableRelation = Company;
        }
        field(68; "PAYE Number"; Text[30])
        {
        }
        field(69; "UIF Contributor?"; Boolean)
        {
        }
        field(73; "Marital Status"; Option)
        {
            OptionMembers = " ",Single,Married,Separated,Divorced,"Widow(er)",Other;

            trigger OnValidate()
            begin
                if Rec."Marital Status" <> xRec."Marital Status" then begin
                    // ValueChangeManagement.ManageHRFieldChange("No.",13,FORMAT(xRec."Marital Status"),FORMAT(Rec."Marital Status"),"Text 013")
                end;
            end;
        }
        field(74; "Ethnic Origin"; Option)
        {
            OptionMembers = African,Indian,White,Coloured;
        }
        field(75; "First Language (R/W/S)"; Code[10])
        {
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = CONST(Language));
        }
        field(76; "Driving Licence"; Code[10])
        {
        }
        field(77; "Vehicle Registration Number"; Code[10])
        {
        }
        field(78; Disabled; Option)
        {
            OptionMembers = No,Yes," ";

            trigger OnValidate()
            begin
                if (Disabled = Disabled::Yes) then
                    Status := Status::Disabled;
            end;
        }
        field(79; "Health Assesment?"; Boolean)
        {
        }
        field(80; "Health Assesment Date"; Date)
        {
        }
        field(81; "Date Of Birth"; Date)
        {
        }
        field(82; Age; Text[80])
        {
        }
        field(83; "Date Of Join"; Date)
        {

            trigger OnValidate()
            begin
                Age := Dates.DetermineAge("Date Of Birth", "Date Of Join");
                if ("Date Of Leaving" <> 0D) and ("Date Of Join" <> 0D) then
                    "Length Of Service" := Dates.DetermineAge("Date Of Join", "Date Of Leaving");
            end;
        }
        field(84; "Length Of Service"; Text[80])
        {
        }
        field(85; "End Of Probation Date"; Date)
        {
        }
        field(86; "Pension Scheme Join"; Date)
        {

            trigger OnValidate()
            begin
                if ("Date Of Leaving" <> 0D) and ("Pension Scheme Join" <> 0D) then
                    "Time Pension Scheme" := Dates.DetermineAge("Pension Scheme Join", "Date Of Leaving");
            end;
        }
        field(87; "Time Pension Scheme"; Text[80])
        {
        }
        field(88; "Medical Scheme Join"; Date)
        {

            trigger OnValidate()
            begin
                if ("Date Of Leaving" <> 0D) and ("Medical Scheme Join" <> 0D) then
                    "Time Medical Scheme" := Dates.DetermineAge("Medical Scheme Join", "Date Of Leaving");
            end;
        }
        field(89; "Time Medical Scheme"; Text[80])
        {
            //This property is currently not supported
            //TestTableRelation = true;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = true;
        }
        field(90; "Date Of Leaving"; Date)
        {

            trigger OnValidate()
            begin
                /*
                     IF ("Date Of Join" <> 0D) AND ("Date Of Leaving" <> 0D) THEN
                      "Length Of Service":= Dates.DetermineAge("Date Of Join","Date Of Leaving");
                     IF ("Pension Scheme Join" <> 0D) AND ("Date Of Leaving" <> 0D) THEN
                      "Time Pension Scheme":= Dates.DetermineAge("Pension Scheme Join","Date Of Leaving");
                     IF ("Medical Scheme Join" <> 0D) AND ("Date Of Leaving" <> 0D) THEN
                      "Time Medical Scheme":= Dates.DetermineAge("Medical Scheme Join","Date Of Leaving");
                
                
                     IF ("Date Of Leaving" <> 0D) AND ("Date Of Leaving" <> xRec."Date Of Leaving") THEN BEGIN
                        ExitInterviews.SETRANGE("Employee No.","No.");
                        OK:= ExitInterviews.FIND('-');
                        IF OK THEN BEGIN
                          ExitInterviews."Date Of Leaving":= "Date Of Leaving";
                          ExitInterviews.MODIFY;
                        END;
                        COMMIT();
                     END;
                
                */

            end;
        }
        field(94; Castellion; Code[10])
        {
        }
        field(95; "Per Annum"; Decimal)
        {
        }
        field(96; "Allow Overtime"; Option)
        {
            OptionMembers = Yes,No," ";
        }
        field(97; "Medical Scheme No."; Text[30])
        {
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = CONST("Medical Scheme"));
        }
        field(98; "Medical Scheme Head Member"; Text[60])
        {
        }
        field(99; "Number Of Dependants"; Integer)
        {
        }
        field(100; "Medical Scheme Name"; Text[30])
        {
        }
        field(101; "Amount Paid By Employee"; Decimal)
        {
        }
        field(102; "Amount Paid By Company"; Decimal)
        {
        }
        field(103; "Receiving Car Allowance ?"; Boolean)
        {
        }
        field(104; "Second Language (R/W/S)"; Code[10])
        {
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = CONST(Language));
        }
        field(105; "Additional Language"; Code[10])
        {
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = CONST(Language));
        }
        field(106; "Cell Phone Reimbursement?"; Boolean)
        {
        }
        field(107; "Amount Reimbursed"; Decimal)
        {
        }
        field(108; "UIF Country"; Code[10])
        {
            TableRelation = "Country/Region".Code;
        }
        field(109; "Direct/Indirect"; Option)
        {
            OptionMembers = Direct,Indirect;
        }
        field(110; "Primary Skills Category"; Option)
        {
            OptionMembers = Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(111; Level; Option)
        {
            OptionMembers = " ","Level 1","Level 2","Level 3","Level 4","Level 5","Level 6","Level 7";
        }
        field(112; "Termination Category"; Option)
        {
            OptionMembers = " ",Resignation,"Non-Renewal Of Contract",Dismissal,Retirement,Death,Other;

            trigger OnValidate()
            var
                "Lrec Resource": Record Resource;
                OK: Boolean;
            begin
            end;
        }
        field(113; "Job Specification"; Code[30])
        {
        }
        field(114; DateOfBirth; Text[8])
        {
        }
        field(115; DateEngaged; Text[8])
        {
        }
        field(116; "Postal Address2"; Text[30])
        {
        }
        field(117; "Postal Address3"; Text[20])
        {
        }
        field(118; "Residential Address2"; Text[30])
        {
        }
        field(119; "Residential Address3"; Text[20])
        {
        }
        field(120; "Post Code2"; Code[20])
        {
            TableRelation = "Post Code";
        }
        field(121; Citizenship; Code[10])
        {
            TableRelation = "Country/Region".Code;
        }
        field(122; "Name Of Manager"; Text[45])
        {
            TableRelation = "HRM-Employee";

            trigger OnValidate()
            begin
                if Rec."Name Of Manager" <> xRec."Name Of Manager" then begin
                    // ValueChangeManagement.ManageHRFieldChange("No.",9,FORMAT(xRec."Name Of Manager"),FORMAT(Rec."Name Of Manager"),"Text 009")
                end;
            end;
        }
        field(123; "User ID"; Code[20])
        {
            //todo TableRelation = Table2000000002.Field1;
            //This property is currently not supported
            //TestTableRelation = true;
        }
        field(124; "Disabling Details"; Text[50])
        {
        }
        field(125; "Disability Grade"; Text[30])
        {
        }
        field(126; "Passport Number"; Text[30])
        {
        }
        field(127; "2nd Skills Category"; Option)
        {
            OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(128; "3rd Skills Category"; Option)
        {
            OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(129; PensionJoin; Text[8])
        {
        }
        field(130; DateLeaving; Text[30])
        {
        }
        field(131; Region; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('REGION'));
        }
        field(132; "Manager Emp No"; Code[30])
        {
        }
        field(133; Temp; Text[50])
        {
        }
        field(136; "Employee Act. Qty"; Integer)
        {
            CalcFormula = Count("HRM-Employee" WHERE(Status = FILTER(= Normal)));
            FieldClass = FlowField;
        }
        field(137; "Contract Location"; Text[20])
        {
            Description = 'Location where contract was closed';
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = CONST("Contract Type"));
        }
        field(138; "First Language Read"; Boolean)
        {
        }
        field(139; "First Language Write"; Boolean)
        {
        }
        field(140; "First Language Speak"; Boolean)
        {
        }
        field(141; "Second Language Read"; Boolean)
        {
        }
        field(142; "Second Language Write"; Boolean)
        {
        }
        field(143; "Second Language Speak"; Boolean)
        {
        }
        field(144; "Custom Grading"; Code[10])
        {
            //todo  TableRelation = Table0.Field1027;
        }
        field(145; "PIN Number"; Code[20])
        {

            trigger OnValidate()
            begin
                if Rec."PIN Number" <> xRec."PIN Number" then begin
                    if not Confirm('Are You Sure You Want to Change the Employee PIN Number?') then
                        Error('PIN Number Not Changed');
                    if Payroll.Get("No.") then begin
                        Payroll."PIN Number" := "PIN Number";
                        Payroll.Modify;
                    end;
                end;
            end;
        }
        field(146; "NSSF No."; Code[20])
        {

            trigger OnValidate()
            begin
                if Rec."NSSF No." <> xRec."NSSF No." then begin
                    if not Confirm('Are You Sure You Want to Change the Employee NSSF NO?') then
                        Error('NSSF NO Not Changed');
                    if Payroll.Get("No.") then begin
                        Payroll."NSSF No." := "NSSF No.";
                        Payroll.Modify;
                    end;
                end;
            end;
        }
        field(147; "NHIF No."; Code[20])
        {

            trigger OnValidate()
            begin
                if Rec."NHIF No." <> xRec."NHIF No." then begin
                    if not Confirm('Are You Sure You Want to Change the Employee NHIF No?') then
                        Error('NHIF No Not Changed');
                    if Payroll.Get("No.") then begin
                        Payroll."NHIF No." := "NHIF No.";
                        Payroll.Modify;
                    end;
                end;
            end;
        }
        field(148; "Cause of Inactivity Code"; Code[10])
        {
            Caption = 'Cause of Inactivity Code';
            TableRelation = "Cause of Inactivity";
        }
        field(149; "Grounds for Term. Code"; Code[10])
        {
            Caption = 'Grounds for Term. Code';
            TableRelation = "Grounds for Termination";
        }
        field(150; "PAYROLL NO"; Code[20])
        {
        }
        field(151; "Period Filter"; Code[50])
        {
            FieldClass = FlowFilter;
        }
        field(152; "HELB No"; Text[30])
        {
        }
        field(153; "Co-Operative No"; Text[30])
        {
        }
        field(154; "Wedding Anniversary"; Date)
        {
        }
        field(156; "Competency Area"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(157; "Cost Center Code"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('COST CENTER'));
        }
        field(158; "Position To Succeed"; Code[20])
        {
            TableRelation = "HRM-Transport Request".Code;

            trigger OnValidate()
            begin
                /*
                IF Rec."Position To Succeed" <> '' THEN
                IF CONFIRM('Confirm Employee No %1 to succeed the Job position %2?',FALSE,"No.","Position To Succeed") THEN BEGIN
                  JQualifications.SETRANGE(JQualifications."Job Id","Position To Succeed");
                  IF JQualifications.FIND('-') THEN REPEAT
                    EQualifications.SETRANGE(EQualifications.Code,"No.");
                 //   EQualifications.SETRANGE(EQualifications."Qualification Type",JQualifications."Qualification Type");
                    EQualifications.SETRANGE(EQualifications."Up To",JQualifications."Qualification Code");
                    IF NOT EQualifications.FIND('-') THEN BEGIN
                      QGaps.Code := "No.";
                      QGaps."Qualification Type" := JQualifications."Qualification Type";
                      QGaps.Description := RANDOM(500);
                      QGaps."Up To" := JQualifications."Qualification Code";
                      QGaps.Gap := TRUE;
                      QGaps.Description := JQualifications.Qualification;
                      QGaps.INSERT;
                    END;
                  UNTIL JQualifications.NEXT = 0;
                END;
                */

            end;
        }
        field(159; "Succesion Date"; Date)
        {
        }
        field(160; "Send Alert to"; Code[20])
        {
            TableRelation = "HRM-Employee"."No.";
        }
        field(161; Tribe; Code[20])
        {
        }
        field(162; Religion; Code[20])
        {
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = CONST(Religion));

            trigger OnValidate()
            begin
                if Rec.Religion <> xRec.Religion then begin
                    // ValueChangeManagement.ManageHRFieldChange("No.",12,FORMAT(xRec.Religion),FORMAT(Rec.Religion),"Text 012")
                end;
            end;
        }
        field(163; "Job Title"; Text[50])
        {

            trigger OnValidate()
            begin
                if Rec."Job Title" <> xRec."Job Title" then begin
                    //  ValueChangeManagement.ManageHRFieldChange("No.",6,FORMAT(xRec."Job Title"),FORMAT(Rec."Job Title"),"Text 014")
                end;
            end;
        }
        field(164; "Post Office No"; Text[30])
        {
        }
        field(165; "Posting Group"; Code[50])
        {
            NotBlank = false;
            //todo TableRelation = "HRM-Appraisal Training Develop"."No Series";
        }
        field(166; "Payroll Posting Group"; Code[10])
        {
        }
        field(167; "Served Notice Period"; Boolean)
        {

            trigger OnValidate()
            begin
                /*IF "Served Notice Period" = TRUE THEN
                IF CONFIRM('Do you want to create a Recruitment oppurtunity from this termination process',FALSE) = TRUE THEN BEGIN
                  IF Recruitment.FIND('+') THEN
                  NextID := INCSTR(Recruitment.Code)
                  ELSE
                  NextID := 'RN0001';
                  Recruitment.INIT;
                  Recruitment.Code := NextID; */
                //Recruitment.Date := Position;
                // IF Jobs.GET(Position) THEN
                // Recruitment.Type := Jobs.Requester;
                // Recruitment."Rules & Regulations" := TODAY;
                // Recruitment.Remarks := 1;
                /// Recruitment.Source := 1;
                // Recruitment.INSERT(TRUE);
                //END;

            end;
        }
        field(168; "Exit Interview Date"; Date)
        {
        }
        field(169; "Exit Interview Done by"; Code[20])
        {
            TableRelation = "HRM-Employee"."No.";
        }
        field(170; "Allow Re-Employment In Future"; Boolean)
        {
        }
        field(171; "Medical Scheme Name #2"; Text[50])
        {
        }
        field(172; "Resignation Date"; Date)
        {
        }
        field(173; "Suspension Date"; Date)
        {
        }
        field(174; "Demised Date"; Date)
        {
        }
        field(175; "Retirement date"; Date)
        {
        }
        field(176; "Retrenchment date"; Date)
        {
        }
        field(177; "Cost Center Units"; Boolean)
        {
            //todo TableRelation = Table50079.Field1;
        }
        field(2000; "HR Department"; Code[40])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Code" = CONST('2'));

            trigger OnValidate()
            begin
                if Rec."HR Department" <> xRec."HR Department" then begin
                    //  ValueChangeManagement.ManageHRFieldChange("No.",1,xRec."HR Department",Rec."HR Department","Text 001")
                end;
            end;
        }
        field(2001; "Allocated Leave Days"; Integer)
        {

            trigger OnValidate()
            begin
                Rec."Earned Leave Days" := Rec."Allocated Leave Days" + Rec."Reimbursed Leave Days";
                Rec.CalcFields(Rec."Total Leave Taken");
                Rec."Leave Balance" := Rec."Earned Leave Days" - Rec."Total Leave Taken";
                Rec.TotalDaysVal := Rec."Total Leave Taken";
            end;
        }
        field(2002; "Leave Balance"; Integer)
        {
        }
        field(2003; "Total Leave Taken"; Decimal)
        {
            //todo   CalcFormula = Sum("HRM-Back To Office Form".Field13 WHERE(Description = CONST('2')));
            //todo FieldClass = FlowField;

            trigger OnValidate()
            begin
                Rec."Earned Leave Days" := Rec."Allocated Leave Days" + Rec."Reimbursed Leave Days";
                Rec.CalcFields(Rec."Total Leave Taken");
                Rec."Leave Balance" := Rec."Earned Leave Days" - Rec."Total Leave Taken";
                Rec.TotalDaysVal := Rec."Total Leave Taken";
            end;
        }
        field(2004; "Notice Send Date"; Date)
        {
        }
        field(2005; "Notice Send"; Boolean)
        {
        }
        field(2006; "Earned Leave Days"; Integer)
        {
        }
        field(2007; "Cash - Leave Earned"; Decimal)
        {

            trigger OnValidate()
            begin
                Rec."Earned Leave Days" := Rec."Allocated Leave Days" + Rec."Reimbursed Leave Days";
                Rec.CalcFields(Rec."Total Leave Taken");
                Rec."Leave Balance" := Rec."Earned Leave Days" - Rec."Total Leave Taken";
                Rec.TotalDaysVal := Rec."Total Leave Taken";
            end;
        }
        field(2008; "Reimbursed Leave Days"; Decimal)
        {

            trigger OnValidate()
            begin
                Rec."Earned Leave Days" := Rec."Allocated Leave Days" + Rec."Reimbursed Leave Days";
                Rec.CalcFields(Rec."Total Leave Taken");
                Rec."Leave Balance" := Rec."Earned Leave Days" - Rec."Total Leave Taken";
                "New Earned" := (Rec."Allocated Leave Days" + "New Bal B/F");
                "New Balance" := "New Earned" - Rec."Total Leave Taken";
                Rec.TotalDaysVal := Rec."Total Leave Taken";
            end;
        }
        field(2009; "Cash per Leave Day"; Decimal)
        {

            trigger OnValidate()
            begin
                Rec."Earned Leave Days" := Rec."Allocated Leave Days" + Rec."Reimbursed Leave Days";
                Rec.CalcFields(Rec."Total Leave Taken");
                Rec."Leave Balance" := Rec."Earned Leave Days" - Rec."Total Leave Taken";
                Rec.TotalDaysVal := Rec."Total Leave Taken";
            end;
        }
        field(2010; "Leave CateSgory"; Option)
        {
            NotBlank = false;
            OptionCaption = 'Normal,Managerial';
            OptionMembers = Normal,Managerial;
        }
        field(2011; "Portal Password"; Text[250])
        {
        }
        field(2012; "Application No"; Code[20])
        {
        }
        field(2013; "Dimension 3"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(2014; "Dimension 4"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
        field(2015; "Dimension 5"; Code[20])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
        }
        field(2016; "Dimension 6"; Code[20])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));
        }
        field(2017; "Dimension 7"; Code[20])
        {
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));
        }
        field(2018; "Dimension 8"; Code[20])
        {
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8));
        }
        field(2019; "Dimension 2"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(2020; "Employee Qty"; Integer)
        {
            CalcFormula = Count("HRM-Employee");
            FieldClass = FlowField;
        }
        field(2021; "Employee Arc. Qty"; Integer)
        {
            CalcFormula = Count("HRM-Employee" WHERE(Status = FILTER(<> Normal)));
            FieldClass = FlowField;
        }
        field(2022; Approver; Boolean)
        {
        }
        field(2023; "Alert Date"; Date)
        {
        }
        field(2024; Grade; Code[20])
        {
            //todo  TableRelation = "HRM-Medical Facility".Code;

            trigger OnValidate()
            begin
                //JobsEntry.SETRANGE(JobsEntry."Job ID",Position);
                //IF JobsEntry.FIND('-') THEN
                //Grade := JobsEntry.Grade;


                /*Grades.RESET;
                Grades.SETRANGE(Grades.Code,Grade);
                IF Grades.FIND('-') THEN BEGIN
                "Allocated Leave Days" := Grades.Location;
                END;
                
                IF Rec.Grade <> xRec.Grade THEN BEGIN
                 // ValueChangeManagement.ManageHRFieldChange("No.",15,FORMAT(xRec.Grade),FORMAT(Rec.Grade),"Text 017")
                END; */

            end;
        }
        field(2025; "Leave Date Filter"; Text[30])
        {
        }
        field(2026; TotalLeaveTaken; Integer)
        {
        }
        field(2027; EverLogged; Boolean)
        {
        }
        field(2028; "Disable Portal"; Boolean)
        {
        }
        field(2029; "Reason for Joining"; Text[50])
        {
        }
        field(2030; "Reason for Leaving"; Text[50])
        {
        }
        field(2031; MD; Boolean)
        {
        }
        field(2032; TotalDaysVal; Decimal)
        {
        }
        field(2033; "Actual Job ID"; Code[10])
        {
            //todo   TableRelation = "HRM-Final Applicants Shortlist".Field20012 WHERE("Employee Requisition No" = FIELD(Position));

            trigger OnValidate()
            begin
                /*IF Jobs.GET(Position) THEN BEGIN
                  "Job Title":= Jobs.Requester;
                  JobsEntry.RESET;
                  JobsEntry.SETRANGE(JobsEntry."Employee Requisition No",Position);
                  JobsEntry.SETRANGE(JobsEntry."Act Job ID","Actual Job ID");
                  IF JobsEntry.FIND('-') THEN
                  "HR Department" := JobsEntry."ID No";
                
                END;
                
                JobsEntry.RESET;
                JobsEntry.SETRANGE(JobsEntry."Employee Requisition No",Position);
                JobsEntry.SETRANGE(JobsEntry."Act Job ID","Actual Job ID");
                IF JobsEntry.FIND('-') THEN
                   Grade := JobsEntry.Grade;
                
                IF Grades.GET(Grade) THEN
                  "Allocated Leave Days" := Grades.Location;
                           */
                //PKK MODIFY;

            end;
        }
        field(2034; "Loan Filter"; Code[10])
        {
            //todo FieldClass = FlowFilter;
            //todo  TableRelation = "HRM-Job Applic. - 1st Int.".Field9;
        }
        field(2035; CurrentYearFilter; Date)
        {
            Description = 'To filter the leave days as per the year';
            FieldClass = FlowFilter;
        }
        field(2036; "New Bal B/F"; Integer)
        {
        }
        field(2037; "New Balance"; Integer)
        {
        }
        field(2038; "New Earned"; Integer)
        {
        }
        field(2039; "Leave Bal Val"; Integer)
        {
        }
        field(2040; "Activate Terminated"; Boolean)
        {

            trigger OnValidate()
            begin
                if Status = Status::Normal then
                    Error('Your can ONLY REACTIVATE Terminated Employees');

                if not Confirm('Are You Sure You Want to Update this employees Status?') then
                    Error('Employee NOT REACTIVATED');

                if Rec."Activate Terminated" <> xRec."Activate Terminated" then begin
                    // ValueChangeManagement.ManageHRFieldChange("No.",1,FORMAT(xRec."Activate Terminated"),FORMAT(Rec."Activate Terminated"),
                    //"Text 001")
                end;

                if not Confirm('Are You Sure You STILL Want to update this employees Status?') then
                    Error('Employee NOT REACTIVATED');


                if Rec."Activate Terminated" = true then begin
                    Payroll.Reset;
                    if Payroll.Get("No.") then begin
                        Payroll.Status := Payroll.Status::Active;
                        Payroll.Modify;
                    end;
                end else begin
                    Payroll.Reset;
                    if Payroll.Get("No.") then begin
                        Payroll.Status := Payroll.Status::Discharged;
                        Payroll.Modify;
                    end;
                end;
            end;
        }
        field(2041; Lecturer; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "First Name")
        {
        }
        key(Key3; "Last Name")
        {
        }
        key(Key4; "ID Number")
        {
        }
        key(Key5; "Known As")
        {
        }
        key(Key6; "User ID")
        {
        }
        key(Key7; "Cost Code")
        {
        }
        key(Key8; "Date Of Join", "Date Of Leaving")
        {
        }
        key(Key9; "Termination Category")
        {
        }
        key(Key10; "Department Code")
        {
        }
        key(Key11; "HR Department")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        /*
        EmployeeImages.SETRANGE("Employee No.","No.");
        EmployeeImages.DELETEALL;
        
        EmployeeNotes.SETRANGE("Employee No.","No.");
        EmployeeNotes.DELETEALL;
        
        EmployeeRelative.SETRANGE("Employee No.","No.");
        EmployeeRelative.DELETEALL;
        
        
        CorrespondHistory.SETRANGE("Employee No.","No.");
        CorrespondHistory.DELETEALL;
        
        EmployeeEquity.SETRANGE("Employee No.","No.");
        EmployeeEquity.DELETEALL;
        
        HumanResComment.SETRANGE("No.","No.");
        HumanResComment.DELETEALL;
        
        //AssignAbsence.SETRANGE("Employee No.","No.");
        //AssignAbsence.DELETEALL;
        
        AbsenceHoliday.SETRANGE("Employee No.","No.");
        AbsenceHoliday.DELETEALL;
        
        EmployeePayment.SETRANGE("Employee No.","No.");
        EmployeePayment.DELETEALL;
        
        EmployeeBankDetails.SETRANGE("Employee No.","No.");
        EmployeeBankDetails.DELETEALL;
        
        EmployeeMaternity.SETRANGE("Employee No.","No.");
        EmployeeMaternity.DELETEALL;
        
        SAQATrainingHistory.SETRANGE("Employee No.","No.");
        SAQATrainingHistory.DELETEALL;
        
        EmploymentHistory.SETRANGE("Employee No.","No.");
        EmploymentHistory.DELETEALL;
        
        MedicalHistory.SETRANGE("Employee No.","No.");
        MedicalHistory.DELETEALL;
        
        CareerHistory.SETRANGE("Employee No.","No.");
        CareerHistory.DELETEALL;
        
        Appraisal.SETRANGE("Employee No.","No.");
        Appraisal.DELETEALL;
        
        Disciplinary.SETRANGE("Employee No.","No.");
        Disciplinary.DELETEALL;
        
        ExitInterviews.SETRANGE("Employee No.","No.");
        ExitInterviews.DELETEALL;
        
        Grievances.SETRANGE("Employee No.","No.");
        Grievances.DELETEALL;
        
        Appraisal.SETRANGE("Employee No.","No.");
        Appraisal.DELETEALL;
        
        //MedicalAidBenefit.SETRANGE("Employee No.","No.");
        //MedicalAidBenefit.DELETEALL;
        
        //PensionBenefit.SETRANGE("Employee No.","No.");
        //PensionBenefit.DELETEALL;
        
        //CarBenefit.SETRANGE("Employee No.","No.");
        //CarBenefit.DELETEALL;
        
        SAQATraining.SETRANGE("Employee No.","No.");
        SAQATraining.DELETEALL;
        
        LearningIntervention.SETRANGE("Employee No.","No.");
        LearningIntervention.DELETEALL;
        
        ExistingQualification.SETRANGE("Employee No.","No.");
        ExistingQualification.DELETEALL;
        
        ProfessionalMembership.SETRANGE("Employee No.","No.");
        ProfessionalMembership.DELETEALL;
        
        EducationAssistance.SETRANGE("Employee No.","No.");
        EducationAssistance.DELETEALL;
        
        InformalTraining.SETRANGE("Employee No.","No.");
        InformalTraining.DELETEALL;
        
        EmployeeSkillsLines.SETRANGE("Employee No.","No.");
        EmployeeSkillsLines.DELETEALL;
        
        EmployeeSkillsPlan.SETRANGE("Employee No.","No.");
        EmployeeSkillsPlan.DELETEALL;
        */

    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            HumanResSetup.Get;
            HumanResSetup.TestField("Employee Nos.");
            NoSeriesMgt.InitSeries(HumanResSetup."Employee Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        if "No." <> xRec."No." then begin
            HumanResSetup.Get;
            HumanResSetup.TestField("Employee Nos.");
            NoSeriesMgt.TestManual(HumanResSetup."Employee Nos.");
            "No. Series" := '';
        end;

        //todo  JobsEntry.SetRange(JobsEntry."Employee Requisition No", Position);
        //todo if JobsEntry.Find('-') then
        //  Grade := JobsEntry.Grade;
        //IF Grades.GET(Grade) THEN
        // "Allocated Leave Days" := Grades.Location
        //CurrentPayDetails;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today;
    end;

    trigger OnRename()
    begin
        //"Last Date Modified" := TODAY;
    end;

    var
        HumanResSetup: Record "HRM-Human Resources Setup.";
        //todo HRValueChange: Record "HRM-Medical Dependants";
        PMEmployee: Record "HRM-Employee";
        PostCode: Record "Post Code";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        //todo  EmployeeResUpdate: Codeunit "HR Employee/Resource";
        //todo  EmployeeSalespersonUpdate: Codeunit "HR Employee/SalespersonUpdate";
        Dates: Codeunit "HR Dates";
        OK: Boolean;
        User: Record User;
        ERROR1: Label 'Employee Career History Starting Information already exist.';
        MSG1: Label 'Employee Career History Starting Information successfully created.';
        ReasonDiaglog: Dialog;
        ValueChangeManagement: Codeunit prPayrollProcessing;
        "Text 001": Label 'Change of Employee''s Department';
        //todo  Recruitment: Record "HRM-Policies";
        NextID: Code[10];
        Jobs: Record "HRM-Transport Request";
        //todo  JobsEntry: Record "HRM-Final Applicants Shortlist";
        "Text 002": Label 'Change of Employee''s Status';
        "Text 008": Label 'Change of Employee''s Job Position';
        "Text 009": Label 'Change of Employee''s Job Manager';
        "Text 010": Label 'Change of Employee''s Job Category';
        "Text 011": Label 'Change of Employee''s Names';
        "Text 012": Label 'Change of Employee''s Religion';
        "Text 013": Label 'Change of Employee''s Marital Status';
        "Text 014": Label 'Change of Employee''s Job Title';
        //todo Grades: Record "HRM-Medical Facility";
        //todo  EQualifications: Record "HRM-Appraisal Ratings";
        //todo  QGaps: Record "HRM-Appraisal Ratings";
        "Text 016": Label 'Change of Employee''s Contract Type';
        "Text 017": Label 'Change of Employee''s Job Grade';
        Payroll: Record "HRM-Employee (D)";
        PayStartDate: Date;
        PayPeriodText: Text[30];
        Contracts: Record "HRM-Lookup Values";
        CLen: DateFormula;
        CDate: Date;
        "Leave Applications": Record "HRM-Leave Requisition";

    procedure AssistEdit(OldEmployee: Record "HRM-Employee"): Boolean
    begin
        /*//PKK
        WITH PMEmployee DO BEGIN
          PMEmployee := Rec;
          HumanResSetup.GET;
          HumanResSetup.TESTFIELD("Employee Nos.");
          IF NoSeriesMgt.SelectSeries(HumanResSetup."Employee Nos.",OldEmployee."No. Series","No. Series") THEN BEGIN
            HumanResSetup.GET;
            HumanResSetup.TESTFIELD("Employee Nos.");
            NoSeriesMgt.SetSeries("No.");
            Rec := PMEmployee;
            EXIT(TRUE);
          END;
        END;
        *///PKK

    end;

    procedure UpdtResUsersetp(var HREmpl: Record "HRM-Employee")
    var
        Res: Record Resource;
        Usersetup: Record "User Setup";
    begin
    end;

    procedure GetPayPeriod()
    begin
        /*
        PayPeriod.SETRANGE(PayPeriod."Close Pay",FALSE);
        IF PayPeriod.FIND('-') THEN
        PayStartDate:=PayPeriod."Starting Date";
        PayPeriodText:=PayPeriod.Name;
        */

    end;
}

