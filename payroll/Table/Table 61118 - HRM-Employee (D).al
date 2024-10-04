// table 61118 "HRM-Employee (D)"
// {
//     Caption = 'Employee';
//     DataCaptionFields = "No.", "First Name", "Middle Name", "Last Name", "Job Title", "Search Name";
//     DrillDownPageID = "HRM-Employee-List2";
//     LookupPageID = "HRM-Employee-List2";

//     fields
//     {
//         field(1; "No."; Code[20])
//         {
//             NotBlank = false;

//             trigger OnValidate()
//             begin
//                 /*
//                 IF "No." <> xRec."No." THEN BEGIN
//                   HumanResSetup.GET;
//                   NoSeriesMgt.TestManual(HumanResSetup."Employee Nos.");
//                   "No. Series" := '';
//                 END;
                
//                 //This is for staff to Library Dataport don't Delete!
//                 IF "No." <> '' THEN
//                    Category:='STAFF';
//                  */

//             end;
//         }
//         field(2; "First Name"; Text[30])
//         {
//         }
//         field(3; "Middle Name"; Text[50])
//         {
//         }
//         field(4; "Last Name"; Text[50])
//         {

//             trigger OnValidate()
//             var
//                 Reason: Text[30];
//             begin
//             end;
//         }
//         field(5; Initials; Text[30])
//         {

//             trigger OnValidate()
//             begin
//                 if ("Search Name" = UpperCase(xRec.Initials)) or ("Search Name" = '') then
//                     "Search Name" := Initials;
//             end;
//         }
//         field(7; "Search Name"; Code[50])
//         {
//         }
//         field(8; "Postal Address"; Text[100])
//         {
//         }
//         field(9; "Residential Address"; Text[20])
//         {
//         }
//         field(10; City; Text[30])
//         {
//         }
//         field(11; "Post Code"; Code[20])
//         {
//             TableRelation = "Post Code";
//             //This property is currently not supported
//             //TestTableRelation = false;
//             ValidateTableRelation = false;
//         }
//         field(12; County; Text[30])
//         {
//             Caption = 'Home County';

//         }
//         field(13; "Home Phone Number"; Text[30])
//         {
//             Caption = 'Alt. Phone Number';

//         }
//         field(14; "Cellular Phone Number"; Text[30])
//         {
//             Caption = 'Primary Phone Number';
//         }
//         field(15; "Work Phone Number"; Text[30])
//         {
//         }
//         field(16; "Ext."; Text[1])
//         {
//         }
//         field(17; "E-Mail"; Text[100])
//         {
//             Caption = 'Personal E-Mail';
//         }
//         field(19; Picture; BLOB)
//         {
//             SubType = Bitmap;
//         }
//         field(21; "ID Number"; Text[20])
//         {
//         }
//         field(22; "Union Code"; Code[5])
//         {
//             TableRelation = Union;
//         }
//         field(23; "UIF Number"; Text[30])
//         {
//         }
//         field(24; Gender; Option)
//         {
//             OptionMembers = Female,Male;
//         }
//         field(25; "Country Code"; Code[10])
//         {
//             Caption = 'Home Country';

//             TableRelation = "Country/Region";
//         }
//         field(28; "Statistics Group Code"; Code[10])
//         {
//             TableRelation = "Employee Statistics Group";
//         }
//         field(31; Status; Option)
//         {
//             OptionCaption = 'Normal,Resigned,Discharged,Retrenched,Pension,Disabled,Suspended,Deceased';
//             OptionMembers = Normal,Resigned,Discharged,Retrenched,Pension,Disabled,Suspended,Deceased;
//         }
//         field(36; "Department Code"; Code[20])
//         {
//             CaptionClass = '1,2,2';
//             TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

//             trigger OnValidate()
//             begin
//                 Dimn.SetRange(Dimn.Code, "Department Code");
//                 if Dimn.Find('-') then begin
//                     "Department Name" := Dimn.Name;
//                 end;
//             end;
//         }

//         field(37; Office; Code[10])
//         {
//             TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('BRANCH'));
//         }
//         field(38; "Resource No."; Code[20])
//         {
//             TableRelation = Resource;
//         }
//         field(39; Comment; Boolean)
//         {
//             Editable = false;
//         }
//         field(40; "Last Date Modified"; Date)
//         {
//             Editable = false;
//         }
//         field(41; "Date Filter"; Date)
//         {
//             FieldClass = FlowFilter;
//         }
//         field(42; "Department Filter"; Code[10])
//         {
//             FieldClass = FlowFilter;
//             TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
//         }
//         field(43; "Office Filter"; Code[10])
//         {
//             FieldClass = FlowFilter;
//             TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
//         }
//         field(47; "Employee No. Filter"; Code[20])
//         {
//             FieldClass = FlowFilter;
//             TableRelation = Employee;
//         }
//         field(49; "Fax Number"; Text[30])
//         {
//         }
//         field(50; "Company E-Mail"; Text[30])
//         {
//         }
//         field(51; Title; Option)
//         {
//             OptionMembers = "MR.","MRS.","MISS.",MS,"DR."," ENG. ",DR,CC,"PROF.",PROF;
//         }
//         field(52; "Salespers./Purch. Code"; Code[10])
//         {
//         }
//         field(53; "No. Series"; Code[10])
//         {
//             Editable = false;
//             TableRelation = "No. Series";
//         }
//         field(54; "Known As"; Text[30])
//         {
//         }
//         field(55; Position; Text[20])
//         {

//             trigger OnValidate()
//             begin
//                 /*
//                     IF ((Position <> xRec.Position) AND (xRec.Position <> '')) THEN BEGIN
//                       Jobs.RESET;
//                       Jobs.SETRANGE(Jobs."Job ID",Position);
//                       IF Jobs.FIND('-') THEN BEGIN
//                           Payroll.RESET;
//                           Payroll.SETRANGE(Payroll.Code,"No.");
//                           IF Payroll.FIND('-') THEN BEGIN
//                               Payroll."Salary Scheme Category":=Jobs.Category;
//                               Payroll."Salary Steps":=Jobs.Grade;
//                               Payroll.VALIDATE(Payroll."Salary Steps");
//                               Payroll.MODIFY;
//                           END
//                       END



//                         {
//                       CareerEvent.SetMessage('Job Title Changed');
//                      CareerEvent.RUNMODAL;
//                      OK:= CareerEvent.ReturnResult;
//                       IF OK THEN BEGIN
//                          CareerHistory.INIT;
//                          IF NOT CareerHistory.FIND('-') THEN
//                           CareerHistory."Line No.":=1
//                         ELSE BEGIN
//                           CareerHistory.FIND('+');
//                           CareerHistory."Line No.":=CareerHistory."Line No."+1;
//                         END;

//                          CareerHistory."Employee No.":= "No.";
//                          CareerHistory."Date Of Event":= WORKDATE;
//                          CareerHistory."Career Event":= 'Job Title Changed';
//                          CareerHistory."Job Title":= "Position Title";
//                          CareerHistory."Employee First Name":= "Known As";
//                          CareerHistory."Employee Last Name":= "Last Name";
//                          CareerHistory.INSERT;
//                       END;
//                       }

//                   END;
//                */

//             end;
//         }
//         field(57; "Full / Part Time"; Option)
//         {
//             OptionMembers = " ","Full Time"," Part Time",Contract;
//         }
//         field(58; "Contract Type"; Option)
//         {
//             Caption = 'Contract Status';
//             OptionMembers = Permanent,"Temporary",Voluntary,Probation,Contract;
//         }
//         field(59; "Contract End Date"; Date)
//         {
//         }
//         field(60; "Notice Period"; Code[10])
//         {
//         }
//         field(61; "Union Member?"; Boolean)
//         {
//         }
//         field(62; "Shift Worker?"; Boolean)
//         {
//         }
//         field(63; "Contracted Hours"; Decimal)
//         {
//         }
//         field(64; "Pay Period"; Option)
//         {
//             OptionMembers = Weekly,"2 Weekly","4 Weekly",Monthly," ";
//         }
//         field(65; "Pay Per Period"; Decimal)
//         {
//         }
//         field(66; "Cost Code"; Code[10])
//         {
//         }
//         field(68; "PAYE Number"; Text[30])
//         {
//         }
//         field(69; "UIF Contributor?"; Boolean)
//         {
//         }
//         field(73; "Marital Status"; Option)
//         {
//             OptionCaption = ' ,Single,Married,Separated,Divorced,Widow(er),Other';
//             OptionMembers = " ",Single,Married,Separated,Divorced,"Widow(er)",Other;
//         }
//         field(74; "Ethnic Origin"; Code[20])
//         {
//             TableRelation = "HRM-Ethnicity";
//         }
//         field(75; "First Language (R/W/S)"; Code[10])
//         {
//         }
//         field(76; "Driving Licence"; Code[10])
//         {
//         }
//         field(77; "Vehicle Registration Number"; Code[10])
//         {
//         }
//         field(78; Disabled; Option)
//         {
//             OptionMembers = No,Yes," ";

//             trigger OnValidate()
//             begin
//                 if (Disabled = Disabled::Yes) then
//                     Status := Status::Disabled;
//             end;
//         }
//         field(79; "Health Assesment?"; Boolean)
//         {
//         }
//         field(80; "Health Assesment Date"; Date)
//         {
//         }
//         field(81; "Date Of Birth"; Date)
//         {
//         }
//         field(82; Age; Text[80])
//         {
//         }
//         field(83; "Date Of Join"; Date)
//         {

//             trigger OnValidate()
//             begin

//                 //    IF ("Date Of Join" <> 0D) THEN BEGIN
//                 //       CareerEvent.SetMessage('Joined The Company');
//                 //       CareerEvent.RUNMODAL;
//                 //       OK:= CareerEvent.ReturnResult;
//                 //        IF OK THEN BEGIN
//                 //           CareerHistory.INIT;
//                 //           CareerHistory."Employee No.":= "No.";
//                 //           CareerHistory."Date Of Event":= "Date Of Join";
//                 //           CareerHistory."Career Event":= 'Joined The Company';
//                 //           CareerHistory.Joined:= TRUE;
//                 //           CareerHistory."Employee First Name":= "Known As";
//                 //           CareerHistory."Employee Last Name":= "Last Name";
//                 //           CareerHistory.INSERT;
//                 //        END;
//                 //    END;
//             end;
//         }
//         field(84; "Length Of Service"; Text[20])
//         {
//         }
//         field(85; "End Of Probation Date"; Date)
//         {
//         }
//         field(86; "Pension Scheme Join"; Date)
//         {
//         }
//         field(87; "Time Pension Scheme"; Text[20])
//         {
//         }
//         field(88; "Medical Scheme Join"; Date)
//         {
//         }
//         field(89; "Time Medical Scheme"; Text[20])
//         {
//             //This property is currently not supported
//             //TestTableRelation = true;
//             //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
//             //ValidateTableRelation = true;
//         }
//         field(90; "Date Of Leaving"; Date)
//         {
//         }
//         field(91; Paterson; Code[10])
//         {
//         }
//         field(92; Peromnes; Code[10])
//         {
//         }
//         field(93; Hay; Code[10])
//         {
//         }
//         field(94; Castellion; Code[10])
//         {
//         }
//         field(95; "Per Annum"; Decimal)
//         {
//         }
//         field(96; "Allow Overtime"; Option)
//         {
//             OptionMembers = Yes,No," ";
//         }
//         field(97; "Medical Scheme No."; Text[30])
//         {

//             trigger OnValidate()
//             begin
//                 //MedicalAidBenefit.SETRANGE("Employee No.","No.");
//             end;
//         }
//         field(98; "Medical Scheme Head Member"; Text[60])
//         {

//             trigger OnValidate()
//             begin
//                 //  MedicalAidBenefit.SETRANGE("Employee No.","No.");
//                 //   OK := MedicalAidBenefit.FIND('+');
//                 //  IF OK THEN BEGIN
//                 //  REPEAT
//                 //   MedicalAidBenefit."Medical Aid Head Member":= "Medical Aid Head Member";
//                 //    MedicalAidBenefit.MODIFY;
//                 //  UNTIL MedicalAidBenefit.NEXT = 0;
//                 // END;
//             end;
//         }
//         field(99; "Number Of Dependants"; Integer)
//         {

//             trigger OnValidate()
//             begin
//                 // MedicalAidBenefit.SETRANGE("Employee No.","No.");
//                 // OK := MedicalAidBenefit.FIND('+');
//                 // IF OK THEN BEGIN
//                 //REPEAT
//                 //  MedicalAidBenefit."Number Of Dependants":= "Number Of Dependants";
//                 //  MedicalAidBenefit.MODIFY;
//                 //UNTIL MedicalAidBenefit.NEXT = 0;
//                 // END;
//             end;
//         }
//         field(100; "Medical Scheme Name"; Text[10])
//         {

//             trigger OnValidate()
//             begin
//                 //MedicalAidBenefit.SETRANGE("Employee No.","No.");
//                 //OK := MedicalAidBenefit.FIND('+');
//                 //IF OK THEN BEGIN
//                 // REPEAT
//                 // MedicalAidBenefit."Medical Aid Name":= "Medical Aid Name";
//                 //  MedicalAidBenefit.MODIFY;
//                 // UNTIL MedicalAidBenefit.NEXT = 0;
//                 // END;
//             end;
//         }
//         field(101; "Amount Paid By Employee"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 //  MedicalAidBenefit.SETRANGE("Employee No.","No.");
//                 //  OK := MedicalAidBenefit.FIND('+');
//                 //   IF OK THEN BEGIN
//                 //     REPEAT
//                 //      MedicalAidBenefit."Amount Paid By Employee":= "Amount Paid By Employee";
//                 //       MedicalAidBenefit.MODIFY;
//                 //     UNTIL MedicalAidBenefit.NEXT = 0;
//                 //    END;
//             end;
//         }
//         field(102; "Amount Paid By Company"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 //  MedicalAidBenefit.SETRANGE("Employee No.","No.");
//                 //   OK := MedicalAidBenefit.FIND('+');
//                 //  IF OK THEN BEGIN
//                 // REPEAT
//                 //      MedicalAidBenefit."Amount Paid By Company":= "Amount Paid By Company";
//                 //      MedicalAidBenefit.MODIFY;
//                 // UNTIL MedicalAidBenefit.NEXT = 0;
//                 //   END;
//             end;
//         }
//         field(103; "Receiving Car Allowance ?"; Boolean)
//         {
//         }
//         field(104; "Second Language (R/W/S)"; Code[10])
//         {
//         }
//         field(105; "Additional Language"; Code[10])
//         {
//         }
//         field(106; "Cell Phone Reimbursement?"; Boolean)
//         {
//         }
//         field(107; "Amount Reimbursed"; Decimal)
//         {
//         }
//         field(108; "UIF Country"; Code[10])
//         {
//             TableRelation = "Country/Region".Code;
//         }
//         field(109; "Direct/Indirect"; Option)
//         {
//             OptionMembers = Direct,Indirect;
//         }
//         field(110; "Primary Skills Category"; Option)
//         {
//             OptionMembers = Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
//         }
//         field(111; Level; Option)
//         {
//             OptionMembers = " ","Level 1","Level 2","Level 3","Level 4","Level 5","Level 6","Level 7";
//         }
//         field(112; "Termination Category"; Option)
//         {
//             OptionMembers = " ",Resignation,"Non-Renewal Of Contract",Dismissal,Retirement,Death,Other;

//             trigger OnValidate()
//             var
//                 "Lrec Resource": Record Resource;
//                 OK: Boolean;
//             begin
//             end;
//         }
//         field(113; "Job Specification"; Code[30])
//         {
//         }
//         field(114; DateOfBirth; Text[8])
//         {
//         }
//         field(115; DateEngaged; Text[8])
//         {
//         }
//         field(116; "Postal Address2"; Text[30])
//         {
//         }
//         field(117; "Postal Address3"; Text[20])
//         {
//         }
//         field(118; "Residential Address2"; Text[30])
//         {
//         }
//         field(119; "Residential Address3"; Text[20])
//         {
//         }
//         field(120; "Post Code2"; Code[20])
//         {
//             TableRelation = "Post Code";
//         }
//         field(121; Citizenship; Code[10])
//         {

//             TableRelation = "Country/Region".Code;
//         }
//         field(122; "Name Of Manager"; Text[45])
//         {
//         }
//         field(123; "User ID"; Code[30])
//         {

//         }
//         field(124; "Disabling Details"; Text[50])
//         {
//         }
//         field(125; "Disability Grade"; Text[30])
//         {
//         }
//         field(126; "Passport Number"; Text[30])
//         {
//         }
//         field(127; "2nd Skills Category"; Option)
//         {
//             OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
//         }
//         field(128; "3rd Skills Category"; Option)
//         {
//             OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
//         }
//         field(129; PensionJoin; Text[8])
//         {
//         }
//         field(130; DateLeaving; Text[30])
//         {
//         }
//         field(131; Region; Code[10])
//         {
//             TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('REGION'));
//         }
//         field(132; "Manager Emp No"; Code[30])
//         {
//         }
//         field(133; Temp; Text[2])
//         {
//         }
//         field(134; "Employee Qty"; Integer)
//         {
//             CalcFormula = Count("HRM-Employee (D)");
//             FieldClass = FlowField;
//         }
//         field(135; "Employee Act. Qty"; Integer)
//         {
//             CalcFormula = Count("HRM-Employee (D)");
//             FieldClass = FlowField;
//         }
//         field(136; "Employee Arc. Qty"; Integer)
//         {
//             CalcFormula = Count("HRM-Employee (D)");
//             FieldClass = FlowField;
//         }
//         field(137; "Contract Location"; Text[20])
//         {
//             Description = 'Location where contract was closed';
//         }
//         field(138; "First Language Read"; Boolean)
//         {
//         }
//         field(139; "First Language Write"; Boolean)
//         {
//         }
//         field(140; "First Language Speak"; Boolean)
//         {
//         }
//         field(141; "Second Language Read"; Boolean)
//         {
//         }
//         field(142; "Second Language Write"; Boolean)
//         {
//         }
//         field(143; "Second Language Speak"; Boolean)
//         {
//         }
//         field(144; "Custom Grading"; Code[10])
//         {
//         }
//         field(145; "PIN Number"; Code[20])
//         {
//             Caption = 'KRA PIN No.';
//         }
//         field(146; "NSSF No."; Code[20])
//         {
//         }
//         field(147; "NHIF No."; Code[20])
//         {
//         }
//         field(148; "Cause of Inactivity Code"; Code[10])
//         {
//             Caption = 'Cause of Inactivity Code';
//             TableRelation = "Cause of Inactivity";
//         }
//         field(149; "Grounds for Term. Code"; Code[10])
//         {
//             Caption = 'Grounds for Term. Code';
//             TableRelation = "Grounds for Termination";
//         }
//         field(150; "Sacco Staff No"; Code[10])
//         {
//         }
//         field(151; "Period Filter"; Date)
//         {
//             FieldClass = FlowFilter;
//             TableRelation = "PRL-Payroll Periods"."Date Opened";
//         }
//         field(152; "HELB No"; Text[30])
//         {
//         }
//         field(153; "Co-Operative No"; Text[30])
//         {
//         }
//         field(154; "Wedding Anniversary"; Date)
//         {
//         }
//         field(155; "KPA Code"; Code[20])
//         {
//             FieldClass = FlowFilter;
//         }
//         field(156; "Competency Area"; Code[20])
//         {
//             FieldClass = FlowFilter;
//         }
//         field(157; "Cost Center Code"; Code[10])
//         {
//             TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('COURSE'));
//         }
//         field(158; "Position To Succeed"; Code[20])
//         {
//         }
//         field(159; "Succesion Date"; Date)
//         {
//         }
//         field(160; "Send Alert to"; Code[20])
//         {
//         }
//         field(161; Tribe; Code[20])
//         {
//         }
//         field(162; Religion; Code[20])
//         {
//         }
//         field(163; "Job Title"; Text[50])
//         {
//             TableRelation = "HRM-Jobs"."Job ID";
//             trigger OnValidate()

//             Var
//                 jobDesc: Record "HRM-Jobs";
//             begin
//                 if jobDesc.GET("Job Title") then
//                     "Job Name" := jobDesc."Job Description"
//             end;
//         }
//         field(338; "Job Name"; Text[100])
//         {

//         }
//         field(164; "Post Office No"; Text[50])
//         {
//         }
//         field(165; "Posting Group"; Code[50])
//         {
//             NotBlank = true;
//             TableRelation = "PRL-Employee Posting Group".Code;
//         }
//         field(166; "Payroll Posting Group"; Code[10])
//         {
//             TableRelation = "PRL-Employee Posting Group";
//         }
//         field(167; "Served Notice Period"; Boolean)
//         {
//         }
//         field(168; "Exit Interview Date"; Date)
//         {
//         }
//         field(169; "Exit Interview Done by"; Code[20])
//         {
//             TableRelation = "HRM-Employee (D)"."No.";
//         }
//         field(170; "Allow Re-Employment In Future"; Boolean)
//         {
//         }
//         field(171; "Medical Scheme Name #2"; Text[30])
//         {

//             trigger OnValidate()
//             begin
//                 //MedicalAidBenefit.SETRANGE("Employee No.","No.");
//                 //OK := MedicalAidBenefit.FIND('+');
//                 //IF OK THEN BEGIN
//                 // REPEAT
//                 // MedicalAidBenefit."Medical Aid Name":= "Medical Aid Name";
//                 //  MedicalAidBenefit.MODIFY;
//                 // UNTIL MedicalAidBenefit.NEXT = 0;
//                 // END;
//             end;
//         }
//         field(172; "Resignation Date"; Date)
//         {
//         }
//         field(173; "Suspension Date"; Date)
//         {
//         }
//         field(174; "Demised Date"; Date)
//         {
//         }
//         field(175; "Retirement date"; Date)
//         {
//         }
//         field(176; "Retrenchment date"; Date)
//         {
//         }
//         field(177; Campus; Code[20])
//         {
//             TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
//         }
//         field(178; Permanent; Boolean)
//         {
//         }
//         field(179; "Library Category"; Option)
//         {
//             OptionMembers = "ADMIN STAFF","TEACHING STAFF",DIRECTORS;
//         }
//         field(180; Category; Code[10])
//         {
//         }
//         field(181; "Payroll Departments"; Code[10])
//         {
//             TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
//         }
//         field(188; "Grade Level"; Code[20])
//         {

//         }
//         field(189; "Company Type"; Option)
//         {
//             OptionCaption = 'KRC Staff,RTI Staff';
//             OptionMembers = "KRC Staff","RTI Staff";
//         }
//         field(190; "Main Bank"; Code[50])
//         {
//             TableRelation = "PRL-Bank Structure"."Bank Code";
//         }
//         field(191; "Branch Bank"; Code[50])
//         {
//             TableRelation = "PRL-Bank Structure"."Branch Code" where("Bank Code" = field("Main Bank"));
//             trigger OnValidate()
//             var
//                 prlBankStructure: Record "PRL-Bank Structure";
//             begin
//                 prlBankStructure.Reset();
//                 prlBankStructure.SetRange("Bank Code", "Main Bank");
//                 prlBankStructure.SetRange("Branch Code", "Branch Bank");
//                 if prlBankStructure.FindFirst() then begin
//                     "Bank Name" := prlBankStructure."Bank Name";
//                     "Branch Name" := prlBankStructure."Branch Name";
//                 end;
//             end;
//         }
//         field(192; "Lock Bank Details"; Boolean)
//         {
//         }
//         field(193; "Bank Account Number"; Code[30])
//         {
//         }
//         field(6; "Salary Step"; Integer)
//         {
//             trigger OnValidate()
//             var
//                 Sgrade: Record "HRM-Auto Inreament Sal. Steps";
//                 PrPeriod: Record "PRL-Payroll Periods";
//                 SalCard1: Record "PRL-Salary Card";
//             begin


//                 Sgrade.Reset();
//                 Sgrade.SetRange("Employee Category", Rec."Salary Category");
//                 Sgrade.SetRange("Salary Grade", Rec."Salary Grade");
//                 Sgrade.SetRange(STEP, Rec."Salary Step");
//                 if Sgrade.find('-') then begin
//                     PrPeriod.Reset();
//                     PrPeriod.SetRange(Closed, false);
//                     if PrPeriod.find('-') then begin
//                         SalCard1.Reset();
//                         SalCard1.SetRange("Employee Code", Rec."No.");
//                         SalCard1.SetRange("Payroll Period", PrPeriod."Date Opened");
//                         if SalCard1.find('-') then begin
//                             SalCard1."Basic Pay" := Sgrade."Basic Salary";
//                             SalCard1."Payment Mode" := SalCard1."Payment Mode"::"Bank Transfer";
//                             SalCard1."Pays PAYE" := true;
//                             SalCard1."Pays NSSF" := true;
//                             SalCard1."Pays NHIF" := true;
//                             SalCard1.Modify();
//                         end else begin
//                             SalCard1."Employee Code" := Rec."No.";
//                             SalCard1."Payment Mode" := SalCard1."Payment Mode"::"Bank Transfer";
//                             SalCard1."Basic Pay" := Sgrade."Basic Salary";
//                             SalCard1."Pays PAYE" := true;
//                             SalCard1."Pays NSSF" := true;
//                             SalCard1."Pays NHIF" := true;
//                             SalCard1."Payroll Period" := PrPeriod."Date Opened";
//                             SalCard1.Insert();
//                         end;
//                         Message('Successfully Changed the salary');
//                     end;

//                 end;
//             end;



//         }
//         field(195; "Payroll Code"; Code[20])
//         {
//             TableRelation = "PRL-Payroll Type";
//         }
//         field(196; "Holiday Days Entitlement"; Decimal)
//         {
//         }
//         field(197; "Holiday Days Used"; Decimal)
//         {
//         }
//         field(198; "Payment Mode"; Option)
//         {
//             Description = 'Bank Transfer,Cheque,Cash,SACCO';
//             OptionMembers = " ","Bank Transfer",Cheque,Cash,FOSA;
//         }
//         field(199; "Hourly Rate"; Decimal)
//         {
//         }
//         field(200; "Daily Rate"; Decimal)
//         {
//         }
//         field(201; "Other Names"; Text[50])
//         {
//         }
//         field(300; "Social Security No."; Code[20])
//         {
//         }
//         field(301; "Pension House"; Code[20])
//         {
//             TableRelation = "PRL-Institutional Membership"."Institution No" WHERE("Group No" = CONST('PENSION'));
//         }
//         field(302; "Salary Notch/Step"; Code[20])
//         {

//             trigger OnValidate()
//             begin

//                 if SalCard.Get("No.") then begin
//                     //IF SalGrade.GET("Salary Grade") THEN
//                     //SalaryGrades."Pays NHF":=SalGrade."Pays NHF";
//                     //SalCard."Salary Notch":="Salary Notch/Step";

//                     /*SalNotch.RESET;
//                     SalNotch.SETRANGE(SalNotch."Salary Grade","Salary Grade");
//                     SalNotch.SETRANGE(SalNotch."Salary Notch","Salary Notch/Step");
//                     IF SalNotch.FIND('-') THEN BEGIN
//                     IF SalNotch."Salary Amount"<>0 THEN BEGIN
//                     IF SalCard.GET("No.") THEN BEGIN
//                     SalCard."Basic Pay":=SalNotch."Salary Amount";
//                     END;
//                     END;
//                     END;

//                     SalCard.MODIFY;
//                     END ELSE BEGIN
//                     SalCard.INIT;
//                     SalCard."Employee Code":="No.";
//                     SalCard."Pays PAYE":=TRUE;
//                     SalCard."Location/Division":="Location/Division Code";
//                     SalCard.Department:="Department Code";
//                     SalCard."Cost Centre":="Cost Center Code";
//                     SalCard."Salary Grade":="Salary Grade";
//                     SalCard."Salary Notch":="Salary Notch/Step";
//                     IF SalGrade.GET("Salary Grade") THEN
//                     SalaryGrades."Pays NHF":=SalGrade."Pays NHF";

//                     SalNotch.RESET;
//                     SalNotch.SETRANGE(SalNotch."Salary Grade","Salary Grade");
//                     SalNotch.SETRANGE(SalNotch."Salary Notch","Salary Notch/Step");
//                     IF SalNotch.FIND('-') THEN BEGIN
//                     IF SalNotch."Salary Amount"<>0 THEN BEGIN
//                     SalCard."Basic Pay":=SalNotch."Salary Amount";
//                     END;
//                     END;
//                     SalCard.INSERT;

//                     END;

//                     objPayrollPeriod.RESET;
//                     objPayrollPeriod.SETRANGE(objPayrollPeriod.Closed,FALSE);
//                     IF objPayrollPeriod.FIND('-') THEN BEGIN
//                     NotchTrans.RESET;
//                     NotchTrans.SETRANGE(NotchTrans."Salary Grade","Salary Grade");
//                     NotchTrans.SETRANGE(NotchTrans."Salary Step/Notch","Salary Notch/Step");
//                     IF NotchTrans.FIND('-') THEN BEGIN
//                     REPEAT
//                     EmpTrans.RESET;
//                     EmpTrans.SETCURRENTKEY(EmpTrans."Employee Code",EmpTrans."Transaction Code");
//                     EmpTrans.SETRANGE(EmpTrans."Employee Code","No.");
//                     EmpTrans.SETRANGE(EmpTrans."Transaction Code",NotchTrans."Transaction Code");
//                     EmpTrans.SETRANGE(EmpTrans."Payroll Period",objPayrollPeriod."Date Opened");
//                     IF EmpTrans.FIND('-') THEN BEGIN
//                     EmpTrans.Amount:=NotchTrans.Amount;
//                     EmpTrans.MODIFY;
//                     END ELSE BEGIN
//                     EmpTransR.INIT;
//                     EmpTransR."Employee Code":="No.";
//                     EmpTransR."Transaction Code":=NotchTrans."Transaction Code";
//                     EmpTransR."Period Month":=objPayrollPeriod."Period Month";
//                     EmpTransR."Period Year":=objPayrollPeriod."Period Year";
//                     EmpTransR."Payroll Period":=objPayrollPeriod."Date Opened";
//                     EmpTransR."Transaction Name":=NotchTrans."Transaction Name";
//                     EmpTransR.Amount:=NotchTrans.Amount;
//                     EmpTransR.INSERT;

//                     END;


//                     UNTIL NotchTrans.NEXT = 0;
//                     END;
//                           */
//                 end;

//             end;
//         }
//         field(303; "Status Change Date"; Date)
//         {
//         }
//         field(304; "Previous Month Filter"; Date)
//         {
//             FieldClass = FlowFilter;
//             TableRelation = "PRL-Payroll Periods"."Date Opened";
//         }
//         field(305; "Current Month Filter"; Date)
//         {
//             FieldClass = FlowFilter;
//         }
//         field(306; "Prev. Basic Pay"; Decimal)
//         {
//             CalcFormula = Sum("PRL-Period Transactions".Amount WHERE("Employee Code" = FIELD("No."),
//                                                                       "Transaction Code" = CONST('BPAY'),
//                                                                       "Payroll Period" = FIELD("Previous Month Filter")));
//             FieldClass = FlowField;
//         }
//         field(307; "Curr. Basic Pay"; Decimal)
//         {
//             CalcFormula = Sum("PRL-Period Transactions".Amount WHERE("Employee Code" = FIELD("No."),
//                                                                       "Transaction Code" = CONST('BPAY'),
//                                                                       "Payroll Period" = FIELD("Current Month Filter")));
//             FieldClass = FlowField;
//         }
//         field(308; "Prev. Gross Pay"; Decimal)
//         {
//             CalcFormula = Sum("PRL-Period Transactions".Amount WHERE("Employee Code" = FIELD("No."),
//                                                                       "Transaction Code" = CONST('GPAY'),
//                                                                       "Payroll Period" = FIELD("Previous Month Filter")));
//             FieldClass = FlowField;
//         }
//         field(309; "Curr. Gross Pay"; Decimal)
//         {
//             CalcFormula = Sum("PRL-Period Transactions".Amount WHERE("Employee Code" = FIELD("No."),
//                                                                       "Transaction Code" = CONST('GPAY'),
//                                                                       "Payroll Period" = FIELD("Current Month Filter")));
//             FieldClass = FlowField;
//         }
//         field(310; "Gross Income Variation"; Decimal)
//         {
//         }
//         field(311; "Basic Pay"; Decimal)
//         {
//             CalcFormula = Sum("PRL-Salary Card"."Basic Pay" WHERE("Employee Code" = FIELD("No.")));
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(312; "Net Pay"; Decimal)
//         {
//             CalcFormula = Sum("PRL-Period Transactions".Amount WHERE("Employee Code" = FIELD("No."),
//                                                                       "Transaction Code" = CONST('NPAY'),
//                                                                       "Payroll Period" = FIELD("Current Month Filter")));
//             FieldClass = FlowField;
//         }
//         field(313; "Transaction Amount"; Decimal)
//         {
//             CalcFormula = Sum("PRL-Period Transactions".Amount WHERE("Employee Code" = FIELD("No."),
//                                                                       "Transaction Code" = FIELD("Transaction Code Filter"),
//                                                                       "Payroll Period" = FIELD("Current Month Filter")));
//             FieldClass = FlowField;
//         }
//         field(314; "Transaction Code Filter"; Text[30])
//         {
//             FieldClass = FlowFilter;
//             TableRelation = "PRL-Transaction Codes"."Transaction Code";
//         }
//         field(315; "NHF No."; Code[20])
//         {
//         }
//         field(316; "NSITF No."; Code[20])
//         {
//         }
//         field(317; "Account Type"; Option)
//         {
//             OptionCaption = ' ,Savings,Current';
//             OptionMembers = " ",Savings,Current;
//         }
//         field(318; "Location/Division Filter"; Code[20])
//         {
//             FieldClass = FlowFilter;
//             TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('LOC/DIV'));
//         }
//         field(320; "Cost Centre Filter"; Code[20])
//         {
//             FieldClass = FlowFilter;
//             TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('COSTCENTRE'));
//         }
//         field(321; "Salary Grade Filter"; Code[20])
//         {
//             FieldClass = FlowFilter;
//         }
//         field(322; "Salary Notch Filter"; Code[20])
//         {
//             FieldClass = FlowFilter;
//         }
//         field(323; "Payroll Type"; Option)
//         {
//             OptionCaption = 'General,Directors';
//             OptionMembers = General,Directors;
//         }
//         field(324; "Employee Classification"; Code[20])
//         {
//         }
//         field(325; "Transaction AUtil"; Decimal)
//         {
//             CalcFormula = Sum("PRL-Period Transactions".Amount WHERE("Employee Code" = FIELD("No."),
//                                                                       "Transaction Code" = CONST('UTILJN'),
//                                                                       "Payroll Period" = FIELD("Current Month Filter")));
//             FieldClass = FlowField;
//         }
//         field(326; "Transaction AEdu"; Decimal)
//         {
//             CalcFormula = Sum("PRL-Period Transactions".Amount WHERE("Employee Code" = FIELD("No."),
//                                                                       "Transaction Code" = CONST('EDUJN'),
//                                                                       "Payroll Period" = FIELD("Current Month Filter")));
//             FieldClass = FlowField;
//         }
//         field(327; "Transaction AFurn"; Decimal)
//         {
//             CalcFormula = Sum("PRL-Period Transactions".Amount WHERE("Employee Code" = FIELD("No."),
//                                                                       "Transaction Code" = CONST('FURNJN'),
//                                                                       "Payroll Period" = FIELD("Current Month Filter")));
//             FieldClass = FlowField;
//         }
//         field(328; "Department Name"; Text[70])
//         {
//             Editable = false;
//         }
//         field(329; "ECA Contrib"; Decimal)
//         {
//             CalcFormula = Sum("PRL-Employee Transactions"."Employer Amount" WHERE("Transaction Code" = CONST('ECA'),
//                                                                                    "Employee Code" = FIELD("No."),
//                                                                                    "Payroll Period" = FIELD("Current Month Filter")));
//             FieldClass = FlowField;
//         }
//         field(330; "Prev. Net Pay"; Decimal)
//         {
//             CalcFormula = Sum("PRL-Period Transactions".Amount WHERE("Transaction Code" = CONST('NPAY'),
//                                                                       "Payroll Period" = CONST(20140101D)));
//             FieldClass = FlowField;
//         }
//         field(331; "Curr. Net Pay"; Decimal)
//         {
//             CalcFormula = Sum("PRL-Period Transactions".Amount WHERE("Transaction Code" = CONST('NPAY'),
//                                                                       "Payroll Period" = CONST(20140201D)));
//             FieldClass = FlowField;
//         }
//         field(332; "Gross Net Pay Variation"; Decimal)
//         {
//         }
//         field(333; "Prev net Pay"; Decimal)
//         {
//             CalcFormula = Sum("PRL-Period Transactions".Amount WHERE("Employee Code" = FIELD("No."),
//                                                                       "Transaction Code" = CONST('NPAY'),
//                                                                       "Payroll Period" = FIELD("Previous Month Filter")));
//             FieldClass = FlowField;
//         }
//         field(334; "Curr net Pay"; Decimal)
//         {
//             CalcFormula = Sum("PRL-Period Transactions".Amount WHERE("Employee Code" = FIELD("No."),
//                                                                       "Transaction Code" = CONST('NPAY'),
//                                                                       "Payroll Period" = FIELD("Current Month Filter")));
//             FieldClass = FlowField;
//         }
//         field(335; "Gross Net Variation"; Decimal)
//         {
//         }
//         field(336; "New Departmental Code"; Code[20])
//         {
//             TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
//         }
//         field(337; "Selected Period"; Date)
//         {
//         }

//         field(50000; "Exists in HR"; Integer)
//         {
//             CalcFormula = Count("HRM-Employee" WHERE("No." = FIELD("No.")));
//             FieldClass = FlowField;
//         }
//         field(50001; Grade; Code[20])
//         {
//             TableRelation = "HRM-Grades";
//         }
//         field(50002; "Sort No"; Code[20])
//         {
//             SQLDataType = Integer;
//         }
//         field(50003; "Physical Disability"; Boolean)
//         {
//         }
//         field(50004; "Salary Category"; Code[50])
//         {
//             Caption = 'Job Cadre';
//             TableRelation = "HRM-Employee Categories".Code;
//         }
//         field(50005; "Salary Grade"; Code[20])
//         {
//             Caption = 'Job Group';
//             TableRelation = "HRM-Job_Salary grade/steps"."Salary Grade code" WHERE("Employee Category" = FIELD("Salary Category"));
//         }
//         field(50006; "Current Basic"; Decimal)
//         {
//             CalcFormula = Lookup("PRL-Salary Card"."Basic Pay" WHERE("Employee Code" = FIELD("No.")));
//             FieldClass = FlowField;
//         }
//         field(50007; "Grade Filter"; Code[20])
//         {

//         }
//         field(50008; "New Grade Filter"; Code[20])
//         {

//         }
//         field(50009; "Employee Type"; Option)
//         {
//             OptionCaption = ' ,Permanent,Casual,Part Time';
//             OptionMembers = " ",Permanent,Casual,"Part Time";
//         }
//         field(50010; "Basic Salary"; Decimal)
//         {
//             CalcFormula = Lookup("PRL-Salary Card"."Basic Pay" WHERE("Employee Code" = FIELD("No.")));
//             FieldClass = FlowField;
//         }
//         field(50011; "Salary Segment"; Integer)
//         {
//         }
//         field(50012; Section; Code[30])
//         {

//         }
//         field(50013; "Total Days Worked"; Integer)
//         {
//             CalcFormula = Count("Staff Attendance Ledger" WHERE("Staff No." = FIELD("No.")));
//             FieldClass = FlowField;
//         }
//         field(50014; "Based On Hours worked"; Option)
//         {
//             OptionCaption = ' ,BasedOnWorkedHrs';
//             OptionMembers = " ",BasedOnWorkedHrs;
//         }
//         field(50016; "Department NameS"; Code[50])
//         {
//             CalcFormula = Lookup("Dimension Value".Name WHERE("Dimension Code" = FILTER('DEPARTMENT|DEPARTMENTS'),
//                                                                Code = FIELD("Department Code")));
//             FieldClass = FlowField;
//         }
//         field(50017; "Credit Account"; Code[20])
//         {
//             TableRelation = Customer."No." WHERE("Customer Posting Group" = FILTER('EMPLOYEE'));
//         }
//         field(60000; "Returning Officer"; Boolean)
//         {
//         }
//         field(60001; Signature; BLOB)
//         {
//             SubType = Bitmap;
//         }
//         field(60002; Registrar; Boolean)
//         {
//         }
//         field(60003; "Head of Department"; Code[10])
//         {
//             TableRelation = "HRM-Employee (D)"."No.";
//         }
//         field(60004; "Barcode Picture"; BLOB)
//         {
//             SubType = Bitmap;
//         }
//         field(60005; "Leave Type"; Code[30])
//         {
//             FieldClass = FlowFilter;
//             TableRelation = "HRM-Leave Types".Code WHERE(Gender = FIELD(Gender));
//         }
//         field(60006; "Medical Scheme Join Date"; Date)
//         {
//         }
//         field(60010; Profession; Code[20])
//         {
//         }
//         field(60011; "On Leave"; Boolean)
//         {
//         }
//         field(60012; "Current Leave No"; Code[20])
//         {
//         }
//         field(60013; "Part Time"; Boolean)
//         {
//         }
//         field(60014; "Employee Category"; Code[20])
//         {
//             TableRelation = "HRM-Staff Categories"."Category Code";
//         }
//         field(60015; Driver; Boolean)
//         {
//         }
//         field(60016; "Total Hours Worked"; Integer)
//         {
//         }
//         field(60017; "Bank Name"; Text[100])
//         {
//             DataClassification = ToBeClassified;
//             Editable = false;
//         }
//         field(60018; "Branch Name"; Text[100])
//         {
//             DataClassification = ToBeClassified;
//             Editable = false;
//         }
//         field(60019; "Appointment Date"; Date)
//         {
//             DataClassification = ToBeClassified;

//         }
//         field(60020; Denomination; Code[20])
//         {
//             DataClassification = ToBeClassified;

//         }

//         field(60021; "Nationality Code"; Code[10])
//         {

//             TableRelation = "Country/Region".Code;
//             trigger OnValidate()
//             var
//                 country: Record "Country/Region";
//             begin
//                 if country.Get("Nationality Code") then
//                     Nationality := country.Name;
//             end;
//         }
//         field(60022; "Nationality"; Code[10])
//         {

//             TableRelation = "Country/Region".Code;
//         }
//         field(60023; "Work Permit No."; Code[10])
//         {

//             TableRelation = "Country/Region".Code;
//         }
//         field(60024; "Work Permit Expiry"; Date)
//         {

//             Caption = 'Work Permit Expiry Date';
//         }
//         field(60025; "Nature of Disability"; Text[50])
//         {

//             Caption = 'Work Permit Expiry Date';
//         }
//         field(60026; "Disability Reg. No."; Code[20])
//         {

//             Caption = 'Disability Registration Number';

//         }
//         field(60027; "CUEA Email Address"; Code[20])
//         {


//         }
//         field(60028; "Leave allowances Payed"; Option)
//         {
//             OptionMembers = " ",Yes,No;
//         }

//     }

//     keys
//     {
//         key(Key1; "No.")
//         {
//         }
//         key(Key2; "First Name")
//         {
//         }
//         key(Key3; "Last Name")
//         {
//         }
//         key(Key4; "ID Number")
//         {
//         }
//         key(Key5; "Known As")
//         {
//         }
//         key(Key6; "User ID")
//         {
//         }
//         key(Key7; "Cost Code")
//         {
//         }
//         key(Key8; "Date Of Join", "Date Of Leaving")
//         {
//         }
//         key(Key9; "Termination Category")
//         {
//         }
//         key(Key10; "Department Code")
//         {
//         }
//     }

//     fieldgroups
//     {
//     }

//     trigger OnInsert()
//     begin
//         /*
//         IF "No." = '' THEN BEGIN
//           HumanResSetup.GET;
//           HumanResSetup.TESTFIELD("Employee Nos.");
//           NoSeriesMgt.InitSeries(HumanResSetup."Employee Nos.",xRec."No. Series",0D,"No.","No. Series");
//         END;
        
//         IF "No." <> xRec."No." THEN BEGIN
//           HumanResSetup.GET;
//           HumanResSetup.TESTFIELD("Employee Nos.");
//           NoSeriesMgt.TestManual(HumanResSetup."Employee Nos.");
//           "No. Series" := '';
//         END;
//         */

//         //CurrentPayDetails;

//     end;

//     trigger OnModify()
//     begin
//         //"Last Date Modified" := TODAY;
//     end;

//     trigger OnRename()
//     begin
//         //"Last Date Modified" := TODAY;
//     end;

//     var
//         Res: Record Resource;
//         PostCode: Record "Post Code";
//         SalespersonPurchaser: Record "Salesperson/Purchaser";
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         OK: Boolean;
//         User: Record User;
//         ERROR1: Label 'Employee Career History Starting Information already exist.';
//         MSG1: Label 'Employee Career History Starting Information successfully created.';
//         ReasonDiaglog: Dialog;
//         EmpQualification: Record "Employee Qualification";
//         PayStartDate: Date;
//         PayPeriodText: Text[30];
//         ToD: Date;
//         CurrentMonth: Date;
//         HrSetup: Record "Human Resources Setup";
//         SalCard: Record "PRL-Salary Card";
//         SalGrade: Record "HRM-Auto Inreament Sal. Steps";
//         Dimn: Record "Dimension Value";

//     procedure AssistEdit(OldEmployee: Record "HRM-Employee (D)"): Boolean
//     begin
//     end;

//     procedure FullName(): Text[100]
//     begin
//         if "Middle Name" = '' then
//             exit("Known As" + ' ' + "Last Name")
//         else
//             exit("Known As" + ' ' + "Middle Name" + ' ' + "Last Name");
//     end;

//     procedure CurrentPayDetails()
//     begin
//     end;

//     procedure UpdtResUsersetp(var HREmpl: Record "HRM-Employee (D)")
//     var
//         Res: Record Resource;
//         Usersetup: Record "User Setup";
//     begin
//         /*
//         ContMgtSetup.GET;
//         IF ContMgtSetup."Customer Integration" =
//            ContMgtSetup."Customer Integration"::"No Integration"
//         THEN
//           EXIT;
//         */
//         /*
//         Res.SETCURRENTKEY("No.");
//         Res.SETRANGE("No.",HREmpl."Resource No.");
//         IF Res.FIND('-') THEN BEGIN
//           Res."Global Dimension 1 Code" := HREmpl."Department Code";
//           Res."Global Dimension 2 Code" := HREmpl.Office;
//           Res.MODIFY;
//         END;
        
//         IF Usersetup.GET(HREmpl."User ID") THEN BEGIN
//           Usersetup.Department := HREmpl."Department Code";
//           Usersetup.Office := HREmpl.Office;
//           Usersetup.MODIFY;
//         END;
//         */

//     end;

//     procedure SetEmployeeHistory()
//     begin
//     end;

//     procedure GetPayPeriod()
//     begin
//     end;

//     trigger OnDelete()

//     begin
//         Error('Action Not Permitted');
//     end;
// }

