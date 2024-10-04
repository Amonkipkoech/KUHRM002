page 68167 "HRM-Employee List"
{
    Caption = 'Employee List';
    CardPageID = "HRM-Employee (B)";
    DeleteAllowed = false;
    //Editable = false;
    // InsertAllowed = False;
    PageType = List;
    SourceTable = "HRM-Employee (D)";
    PromotedActionCategories = 'New,Process,Functions,Reports,Action,General Information';

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    Applicationarea = all;
                }
                field("Last Name"; Rec."Last Name")
                {
                    Applicationarea = all;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    Applicationarea = all;
                }
                field("First Name"; Rec."First Name")
                {
                    Applicationarea = all;
                }
                field("Job Name"; Rec."Job Name")
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field.';
                    ApplicationArea = All;
                }
                field("Appointment Date"; Rec."Appointment Date")
                {
                    ApplicationArea = All;
                }

                field("PIN Number"; Rec."PIN Number")
                {
                    ToolTip = 'Specifies the value of the PIN Number field.';
                    ApplicationArea = All;
                }
                field("NSSF No."; Rec."NSSF No.")
                {
                    ToolTip = 'Specifies the value of the NSSF No. field.';
                    ApplicationArea = All;
                }
                field("NHIF No."; Rec."NHIF No.")
                {
                    ToolTip = 'Specifies the value of the NHIF No. field.';
                    ApplicationArea = All;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ToolTip = 'Specifies the value of the Marital Status field.';
                    ApplicationArea = All;
                }
                field(Religion; Rec.Religion)
                {
                    ToolTip = 'Specifies the value of the Religion field.';
                    ApplicationArea = All;
                }
                field(Denomination; Rec.Denomination)
                {
                    ToolTip = 'Specifies the value of the Denomination field.';
                    ApplicationArea = All;
                }
                field("Nationality Code"; Rec."Nationality Code")
                {
                    ToolTip = 'Specifies the value of the Nationality Code field.';
                    ApplicationArea = All;
                }
                field(Nationality; Rec.Nationality)
                {
                    ToolTip = 'Specifies the value of the Nationality field.';
                    ApplicationArea = All;
                }
                field("Work Permit No."; Rec."Work Permit No.")
                {
                    ToolTip = 'Specifies the value of the Work Permit No. field.';
                    ApplicationArea = All;
                }
                field("Work Permit Expiry"; Rec."Work Permit Expiry")
                {
                    ToolTip = 'Specifies the value of the Work Permit Expiry Date field.';
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    ToolTip = 'Specifies the value of the County field.';
                    ApplicationArea = All;

                }
                field("Country Code"; Rec."Country Code")
                {
                    ToolTip = 'Specifies the value of the Country Code field.';
                    ApplicationArea = All;
                }
                field(Disabled; Rec.Disabled)
                {
                    ToolTip = 'Specifies the value of the Disabled field.';
                    ApplicationArea = All;
                }
                field("Nature of Disability"; Rec."Nature of Disability")
                {
                    ToolTip = 'Specifies the value of the Work Permit Expiry Date field.';
                    ApplicationArea = All;
                }
                field("Cellular Phone Number"; Rec."Cellular Phone Number")
                {
                    ToolTip = 'Specifies the value of the Cellular Phone Number field.';
                    ApplicationArea = All;
                }
                field("Home Phone Number"; Rec."Home Phone Number")
                {
                    ToolTip = 'Specifies the value of the Home Phone Number field.';
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the value of the E-Mail field.';
                    ApplicationArea = All;
                }




            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Print")
            {
                Caption = '&Print';
                action("Personal Information File")
                {

                    Caption = 'Personal Information File';
                    Image = PrintReport;
                    Promoted = true;
                    PromotedCategory = Report;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        /*HREmp.RESET;
                        HREmp.SETRANGE(HREmp."No.","No.");
                        IF HREmp.FIND('-') THEN
                        REPORT.RUN(39005489,TRUE,TRUE,HREmp);
                          */

                    end;
                }
                action(updateNames)
                {
                    Image = XMLFileGroup;
                    Promoted = True;
                    PromotedCategory = Category4;
                    ApplicationArea = All;
                    trigger onAction()
                    begin
                        GenerateFullNames();
                    end;


                }
                action(updateLeaves)
                {
                    Image = XMLFileGroup;
                    Promoted = True;
                    PromotedCategory = Category4;
                    ApplicationArea = All;
                    trigger onAction()
                    begin
                        LeaveCorrect();
                    end;


                }
                action("Misc. Article Info")
                {
                    visible = false;

                    Caption = 'Misc. Article Info';
                    Image = PrintReport;
                    Promoted = false;
                    ApplicationArea = All;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        /*Misc.RESET;
                        Misc.SETRANGE(Misc."Employee No.","No.");
                        IF Misc.FIND('-') THEN
                        REPORT.RUN(5202,TRUE,TRUE,Misc);*/

                    end;
                }
                action("Confidential Info")
                {

                    Caption = 'Confidential Info';
                    Image = PrintReport;
                    Promoted = false;
                    ApplicationArea = All;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        /*Conf.RESET;
                        Conf.SETRANGE(Conf."Employee No.","No.");
                        IF Conf.FIND('-') THEN
                        REPORT.RUN(5203,TRUE,TRUE,Conf);
                        */

                    end;
                }
                action(Label)
                {

                    Caption = 'Label';
                    Image = PrintReport;
                    Promoted = false;
                    ApplicationArea = All;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        /*HREmp.RESET;
                        HREmp.SETRANGE(HREmp."No.","No.");
                        IF HREmp.FIND('-') THEN
                        REPORT.RUN(5200,TRUE,TRUE,HREmp);
                        */

                    end;
                }
                action(Addresses)
                {
                    ApplicationArea = all;
                    Caption = 'Addresses';
                    Image = PrintReport;
                    Promoted = true;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    PromotedCategory = Report;

                    trigger OnAction()
                    var
                        Hremp2: Record Employee;
                    begin
                        Hremp2.RESET;
                        Hremp2.SETRANGE(Hremp2."No.", Rec."No.");
                        IF Hremp2.FIND('-') THEN
                            REPORT.RUN(5207, TRUE, TRUE, Hremp2);


                    end;
                }
                action("Alt. Addresses")
                {

                    Caption = 'Alt. Addresses';
                    Image = PrintReport;
                    Promoted = false;
                    ApplicationArea = All;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        /*HREmp.RESET;
                        HREmp.SETRANGE(HREmp."No.","No.");
                        IF HREmp.FIND('-') THEN
                        REPORT.RUN(5213,TRUE,TRUE,HREmp);  */

                    end;
                }
                action("Phone Nos")
                {

                    Caption = 'Phone Nos';
                    Image = PrintReport;
                    Promoted = false;
                    ApplicationArea = All;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        /*HREmp.RESET;
                        HREmp.SETRANGE(HREmp."No.","No.");
                        IF HREmp.FIND('-') THEN
                        REPORT.RUN(5210,TRUE,TRUE,HREmp); */

                    end;
                }
                action("Value Change Report")
                {
                    ApplicationArea = all;
                    Caption = 'Value Change Report';
                    Image = PrintReport;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        HRValueChange.Reset;
                        HRValueChange.SetRange(HRValueChange."Employee No", Rec."No.");
                        if HRValueChange.Find('-') then
                            REPORT.Run(39003910, true, true, HRValueChange)
                        else
                            Error('No value changes have been recorded for this employee');
                    end;
                }
            }
            group("&Functions")
            {
                Caption = '&Functions';
                action("Update Payroll Data")
                {
                    ApplicationArea = all;
                    Caption = 'Update Payroll Data';
                    Image = PayrollStatistics;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Visible = false;

                    trigger OnAction()
                    begin

                        if Confirm('Update Payroll Data?', true) = false then exit;

                        HREmp.Reset;
                        HREmp.SetRange(HREmp.Status, HREmp.Status::Active);
                        if HREmp.Find('-') then begin

                            repeat

                            begin
                                //CHECK IF EMPLOYEE IS ALREADY IN THE PAYROLL TABLE
                                //IF HE IS MODIFY INFORMATION TO REFLECT ANY CHANGES MADE
                                prEmployees.Reset;
                                prEmployees.SetRange(prEmployees."No.", HREmp."No.");
                                if prEmployees.Find('-') then begin
                                    if HREmp."First Name" <> '' then
                                        prEmployees."First Name" := HREmp."First Name";
                                    if HREmp."Middle Name" <> '' then
                                        prEmployees."Middle Name" := HREmp."Middle Name";
                                    if HREmp."Last Name" <> '' then
                                        prEmployees."Last Name" := HREmp."Last Name";
                                    if HREmp."Search Name" <> '' then
                                        prEmployees."Search Name" := HREmp."Search Name";
                                    if HREmp."Postal Address" <> '' then
                                        prEmployees."Postal Address" := HREmp."Postal Address";
                                    if HREmp."Residential Address" <> '' then
                                        prEmployees."Residential Address" := HREmp."Residential Address";
                                    if HREmp."Employee Category" <> '' then
                                        prEmployees."Employee Category" := HREmp."Employee Category";
                                    if HREmp."Employee Category" <> '' then
                                        prEmployees."Date Of Join" := HREmp."Appointment Date";


                                    /////chnages for salary grades
                                    // if HREmp."Salary Category" <> '' then
                                    //     prEmployees."Salary Category" := HREmp."Salary Category";
                                    // if HREmp."Salary Grade" <> '' then
                                    //     prEmployees."Salary Grade" := HREmp."Salary Grade";
                                    // prEmployees."Salary Step" := HREmp.Steps;
                                    /* if HREmp.Steps <> ''then
                                        prEmployees."Salary Step" := HREmp.Steps; */
                                    //Job title to salary card
                                    if HREmp."Job Title" <> '' then
                                        prEmployees."Job Title" := HREmp."Job Title";
                                    if HREmp."Job Name" <> '' then
                                        prEmployees."Job Name" := HREmp."Job Name";


                                    ////changes for salary grades        
                                    if HREmp.City <> '' then
                                        prEmployees.City := HREmp.City;
                                    if HREmp."Post Code" <> '' then
                                        prEmployees."Post Code" := HREmp."Post Code";
                                    if HREmp.County <> '' then
                                        prEmployees.County := HREmp.County;
                                    if HREmp."Home Phone Number" <> '' then
                                        prEmployees."Home Phone Number" := HREmp."Home Phone Number";
                                    if HREmp."Work Phone Number" <> '' then
                                        prEmployees."Work Phone Number" := HREmp."Work Phone Number";
                                    if HREmp."Ext." <> '' then
                                        prEmployees."Ext." := HREmp."Ext.";
                                    if HREmp."E-Mail" <> '' then
                                        prEmployees."E-Mail" := HREmp."E-Mail";
                                    if HREmp."ID Number" <> '' then
                                        prEmployees."ID Number" := HREmp."ID Number";
                                    //    IF HREmp."First Name"<>'' THEN
                                    //   HREmp.GET(HREmp."No.");
                                    // IF HREmp."First Name"<>'' THEN
                                    HREmp.CalcFields(HREmp.Picture);
                                    if HREmp.Picture.HasValue then
                                        prEmployees.Picture := HREmp.Picture;
                                    if HREmp."Union Code" <> '' then
                                        prEmployees."Union Code" := HREmp."Union Code";
                                    if HREmp."UIF Number" <> '' then
                                        prEmployees."UIF Number" := HREmp."UIF Number";
                                    //    IF HREmp.Gender<>HREmp.Gender:: THEN
                                    prEmployees.Gender := HREmp.Gender;
                                    //  IF HREmp.Status<>'' THEN
                                    prEmployees.Status := HREmp.Status;
                                    if HREmp."Resource No." <> '' then
                                        prEmployees."Resource No." := HREmp."Resource No.";
                                    // IF HREmp."Last Date Modified"<>'' THEN
                                    //prEmployees."Last Date Modified":=HREmp."Last Date Modified";
                                    if HREmp."Fax Number" <> '' then
                                        prEmployees."Fax Number" := HREmp."Fax Number";
                                    if HREmp."Company E-Mail" <> '' then
                                        prEmployees."Company E-Mail" := HREmp."Company E-Mail";
                                    //  IF HREmp.Title<>'' THEN
                                    prEmployees.Title := HREmp.Title;
                                    if HREmp."Salespers./Purch. Code" <> '' then
                                        prEmployees."Salespers./Purch. Code" := HREmp."Salespers./Purch. Code";
                                    if HREmp."No. Series" <> '' then
                                        prEmployees."No. Series" := HREmp."No. Series";
                                    if HREmp."Known As" <> '' then
                                        prEmployees."Known As" := HREmp."Known As";
                                    //   IF HREmp."Full / Part Time"<>'' THEN
                                    prEmployees."Full / Part Time" := HREmp."Full / Part Time";
                                    if HREmp."Contract End Date" <> 0D then
                                        prEmployees."Contract End Date" := HREmp."Contract End Date";
                                    if HREmp."Notice Period" <> '' then
                                        prEmployees."Notice Period" := HREmp."Notice Period";
                                    // IF HREmp."Union Member?"<>'' THEN
                                    prEmployees."Union Member?" := HREmp."Union Member?";
                                    //  IF HREmp."Shift Worker?"<>'' THEN
                                    prEmployees."Shift Worker?" := HREmp."Shift Worker?";
                                    //   IF HREmp."Contracted Hours"<>'' THEN
                                    prEmployees."Contracted Hours" := HREmp."Contracted Hours";
                                    //  IF HREmp."Pay Period"<>'' THEN
                                    prEmployees."Pay Period" := HREmp."Pay Period";
                                    // IF HREmp."Pay Per Period"<>'' THEN
                                    prEmployees."Pay Per Period" := HREmp."Pay Per Period";
                                    if HREmp."Cost Code" <> '' then
                                        prEmployees."Cost Code" := HREmp."Cost Code";
                                    if HREmp."PAYE Number" <> '' then
                                        prEmployees."PAYE Number" := HREmp."PAYE Number";
                                    //IF HREmp."Marital Status"<>'' THEN
                                    prEmployees."Marital Status" := HREmp."Marital Status";
                                    //IF HREmp."Ethnic Origin"<>'' THEN
                                    prEmployees."Ethnic Origin" := HREmp."Ethnic Origin";
                                    if HREmp."First Language (R/W/S)" <> '' then
                                        prEmployees."First Language (R/W/S)" := HREmp."First Language (R/W/S)";
                                    if HREmp."Vehicle Registration Number" <> '' then
                                        prEmployees."Vehicle Registration Number" := HREmp."Vehicle Registration Number";
                                    //IF HREmp.Disabled<>'' THEN
                                    prEmployees.Disabled := HREmp.Disabled;
                                    //IF HREmp."Health Assesment?"<>'' THEN
                                    prEmployees."Health Assesment?" := HREmp."Health Assesment?";
                                    //IF HREmp."Health Assesment Date"<>'' THEN
                                    prEmployees."Health Assesment Date" := HREmp."Health Assesment Date";
                                    //IF HREmp."Date Of Birth"<>'' THEN
                                    prEmployees."Date Of Birth" := HREmp."Date Of Birth";
                                    if HREmp.Age <> '' then
                                        prEmployees.Age := HREmp.Age;
                                    //IF HREmp."Date Of Join"<>'' THEN
                                    // prEmployees."Date Of Join" := HREmp."Date Of Join";
                                    if HREmp."Length Of Service" <> '' then
                                        prEmployees."Length Of Service" := HREmp."Length Of Service";
                                    //IF HREmp."End Of Probation Date"<>'' THEN
                                    prEmployees."End Of Probation Date" := HREmp."End Of Probation Date";
                                    if HREmp."Main Bank" <> '' then
                                        prEmployees."Branch Bank" := HREmp."Main Bank";
                                    if HREmp."Main Bank" <> '' then
                                        prEmployees."Main Bank" := HREmp."Main Bank";
                                    if HREmp."Bank Account Number" <> '' then
                                        prEmployees."Bank Account Number" := HREmp."Bank Account Number";
                                    //IF HREmp."Per Annum"<>'' THEN
                                    prEmployees."Per Annum" := HREmp."Per Annum";
                                    if HREmp."Medical Scheme No." <> '' then
                                        //prEmployees."Allow Overtime":=HREmp."Medical Scheme No.";
                                        if HREmp."Medical Scheme No." <> '' then
                                            prEmployees."Medical Scheme No." := HREmp."Medical Scheme No.";
                                    if HREmp."Medical Scheme Head Member" <> '' then
                                        prEmployees."Medical Scheme Head Member" := HREmp."Medical Scheme Head Member";
                                    //IF HREmp."Number Of Dependants"<>'' THEN
                                    prEmployees."Number Of Dependants" := HREmp."Number Of Dependants";
                                    if HREmp."Medical Scheme Name" <> '' then
                                        prEmployees."Medical Scheme Name" := HREmp."Medical Scheme Name";
                                    //IF HREmp."Amount Paid By Employee"<>'' THEN
                                    prEmployees."Amount Paid By Employee" := HREmp."Amount Paid By Employee";
                                    //IF HREmp."Amount Paid By Company"<>'' THEN
                                    prEmployees."Amount Paid By Company" := HREmp."Amount Paid By Company";
                                    if HREmp."Second Language (R/W/S)" <> '' then
                                        prEmployees."Second Language (R/W/S)" := HREmp."Second Language (R/W/S)";
                                    if HREmp."Additional Language" <> '' then
                                        prEmployees."Additional Language" := HREmp."Additional Language";
                                    if HREmp."First Name" <> '' then
                                        prEmployees."UIF Country" := HREmp."UIF Country";
                                    //IF HREmp."Primary Skills Category"<>'' THEN
                                    prEmployees."Primary Skills Category" := HREmp."Primary Skills Category";
                                    //IF HREmp.Level<>'' THEN
                                    prEmployees.Level := HREmp.Level;
                                    //IF HREmp."Termination Category"<>'' THEN
                                    prEmployees."Termination Category" := HREmp."Termination Category";
                                    if HREmp."Job Title" <> '' then
                                        prEmployees."Job Specification" := HREmp."Job Title";
                                    if HREmp."Postal Address2" <> '' then
                                        prEmployees."Postal Address2" := HREmp."Postal Address2";
                                    if HREmp."Postal Address3" <> '' then
                                        prEmployees."Postal Address3" := HREmp."Postal Address3";
                                    if HREmp."Residential Address2" <> '' then
                                        prEmployees."Residential Address2" := HREmp."Residential Address2";
                                    if HREmp."Residential Address3" <> '' then
                                        prEmployees."Residential Address3" := HREmp."Residential Address3";
                                    if HREmp."Post Code2" <> '' then
                                        prEmployees."Post Code2" := HREmp."Post Code2";
                                    if HREmp.Citizenship <> '' then
                                        prEmployees.Citizenship := HREmp.Citizenship;
                                    if HREmp."Name Of Manager" <> '' then
                                        prEmployees."Name Of Manager" := HREmp."Name Of Manager";
                                    if HREmp."User ID" <> '' then
                                        prEmployees."User ID" := HREmp."User ID";
                                    if HREmp."Disabling Details" <> '' then
                                        prEmployees."Disabling Details" := HREmp."Disabling Details";
                                    if HREmp."Passport Number" <> '' then
                                        prEmployees."Passport Number" := HREmp."Passport Number";
                                    //IF HREmp."2nd Skills Category"<>'' THEN
                                    prEmployees."2nd Skills Category" := HREmp."2nd Skills Category";
                                    //IF HREmp."3rd Skills Category"<>'' THEN
                                    prEmployees."3rd Skills Category" := HREmp."3rd Skills Category";
                                    if HREmp.PensionJoin <> '' then
                                        prEmployees.PensionJoin := HREmp.PensionJoin;
                                    if HREmp.Temp <> '' then
                                        prEmployees.Temp := HREmp.Temp;
                                    if HREmp."Contract Location" <> '' then
                                        prEmployees."Contract Location" := HREmp."Contract Location";
                                    //IF HREmp."First Language Read"<>'' THEN
                                    prEmployees."First Language Read" := HREmp."First Language Read";
                                    //IF HREmp."First Language Write"<>'' THEN
                                    prEmployees."First Language Write" := HREmp."First Language Write";
                                    //IF HREmp."First Language Speak"<>'' THEN
                                    prEmployees."First Language Speak" := HREmp."First Language Speak";
                                    //IF HREmp."Second Language Read"<>'' THEN
                                    prEmployees."Second Language Read" := HREmp."Second Language Read";
                                    //IF HREmp."Second Language Write"<>'' THEN
                                    prEmployees."Second Language Write" := HREmp."Second Language Write";
                                    //IF HREmp."Second Language Speak"<>'' THEN
                                    prEmployees."Second Language Speak" := HREmp."Second Language Speak";
                                    if HREmp."Custom Grading" <> '' then
                                        prEmployees."Custom Grading" := HREmp."Custom Grading";
                                    if HREmp."PIN Number" <> '' then
                                        prEmployees."PIN Number" := HREmp."PIN Number";
                                    if HREmp."NSSF No." <> '' then
                                        prEmployees."NSSF No." := HREmp."NSSF No.";
                                    if HREmp."NHIF No." <> '' then
                                        prEmployees."NHIF No." := HREmp."NHIF No.";
                                    if HREmp."Cause of Inactivity Code" <> '' then
                                        prEmployees."Cause of Inactivity Code" := HREmp."Cause of Inactivity Code";
                                    // IF HREmp."No."<>'' THEN
                                    prEmployees."Payroll Code" := 'PAYROLL';
                                    if HREmp."HELB No" <> '' then
                                        prEmployees."HELB No" := HREmp."HELB No";
                                    if HREmp."Co-Operative No" <> '' then
                                        prEmployees."Co-Operative No" := HREmp."Co-Operative No";
                                    //IF HREmp."Wedding Anniversary"<>'' THEN
                                    prEmployees."Wedding Anniversary" := HREmp."Wedding Anniversary";
                                    if HREmp."Position To Succeed" <> '' then
                                        prEmployees."Position To Succeed" := HREmp."Position To Succeed";
                                    //IF HREmp."Succesion Date"<>'' THEN
                                    prEmployees."Succesion Date" := HREmp."Succesion Date";
                                    if HREmp."Send Alert to" <> '' then
                                        prEmployees."Send Alert to" := HREmp."Send Alert to";
                                    if HREmp.Tribe <> '' then
                                        prEmployees.Tribe := HREmp.Tribe;
                                    if HREmp.Religion <> '' then
                                        prEmployees.Religion := HREmp.Religion;
                                    if HREmp."Job Title" <> '' then
                                        prEmployees."Job Title" := HREmp."Job Title";
                                    if HREmp."Posting Group" <> '' then
                                        prEmployees."Posting Group" := HREmp."Posting Group";
                                    if HREmp."Payroll Posting Group" <> '' then
                                        prEmployees."Payroll Posting Group" := HREmp."Payroll Posting Group";
                                    //IF HREmp."Served Notice Period"<>'' THEN
                                    prEmployees."Served Notice Period" := HREmp."Served Notice Period";
                                    //IF HREmp."Exit Interview Date"<>'' THEN
                                    prEmployees."Exit Interview Date" := HREmp."Exit Interview Date";
                                    if HREmp."Exit Interview Done by" <> '' then
                                        prEmployees."Exit Interview Done by" := HREmp."Exit Interview Done by";
                                    //IF HREmp."Allow Re-Employment In Future"<>'' THEN
                                    prEmployees."Allow Re-Employment In Future" := HREmp."Allow Re-Employment In Future";
                                    if HREmp."Medical Scheme Name #2" <> '' then
                                        prEmployees."Medical Scheme Name #2" := HREmp."Medical Scheme Name #2";
                                    if HREmp."Payroll Departments" <> '' then
                                        prEmployees."Payroll Departments" := HREmp."Payroll Departments";
                                    //IF HREmp.Comment<>'' THEN
                                    prEmployees.Comment := HREmp.Comment;
                                    if HREmp."Competency Area" <> '' then
                                        prEmployees."Competency Area" := HREmp."Competency Area";
                                    //IF HREmp."Employee Qty"<>'' THEN
                                    prEmployees."Employee Qty" := HREmp."Employee Qty";
                                    //IF HREmp."Employee Act. Qty"<>'' THEN
                                    prEmployees."Employee Act. Qty" := HREmp."Employee Act. Qty";
                                    //IF HREmp."Employee Arc. Qty"<>'' THEN
                                    prEmployees."Employee Arc. Qty" := HREmp."Employee Arc. Qty";
                                    //  IF HREmp."First Name"<>'' THEN
                                    prEmployees."Payroll Code" := 'PAYROLL';
                                    prEmployees.Modify;
                                    prEmployees.Validate("No.");

                                end else begin
                                    prEmployees.Init;
                                    prEmployees."No." := HREmp."No.";
                                    prEmployees."First Name" := HREmp."First Name";
                                    prEmployees."Middle Name" := HREmp."Middle Name";
                                    prEmployees."Last Name" := HREmp."Last Name";
                                    prEmployees."Search Name" := HREmp."Search Name";
                                    prEmployees."Postal Address" := HREmp."Postal Address";
                                    prEmployees."Residential Address" := HREmp."Residential Address";
                                    prEmployees."Employee Category" := HREmp."Employee Category";
                                    prEmployees."Date Of Join" := HREmp."Appointment Date";
                                    prEmployees.City := HREmp.City;
                                    prEmployees."Post Code" := HREmp."Post Code";
                                    prEmployees.County := HREmp.County;
                                    prEmployees."Home Phone Number" := HREmp."Home Phone Number";
                                    prEmployees."Work Phone Number" := HREmp."Work Phone Number";
                                    prEmployees."Ext." := HREmp."Ext.";
                                    prEmployees."E-Mail" := HREmp."E-Mail";
                                    prEmployees."ID Number" := HREmp."ID Number";
                                    prEmployees.Picture := HREmp.Picture;
                                    prEmployees."Union Code" := HREmp."Union Code";
                                    prEmployees."UIF Number" := HREmp."UIF Number";
                                    prEmployees.Gender := HREmp.Gender;
                                    prEmployees.Status := HREmp.Status;
                                    prEmployees."Resource No." := HREmp."Resource No.";
                                    prEmployees."Last Date Modified" := HREmp."Last Date Modified";
                                    prEmployees."Fax Number" := HREmp."Fax Number";
                                    prEmployees."Company E-Mail" := HREmp."Company E-Mail";
                                    prEmployees."Branch Bank" := HREmp."Main Bank";
                                    prEmployees."Main Bank" := HREmp."Main Bank";
                                    prEmployees."Bank Account Number" := HREmp."Bank Account Number";
                                    prEmployees.Title := HREmp.Title;
                                    prEmployees."Salespers./Purch. Code" := HREmp."Salespers./Purch. Code";
                                    prEmployees."No. Series" := HREmp."No. Series";
                                    prEmployees."Known As" := HREmp."Known As";
                                    prEmployees."Full / Part Time" := HREmp."Full / Part Time";
                                    prEmployees."Contract End Date" := HREmp."Contract End Date";
                                    prEmployees."Notice Period" := HREmp."Notice Period";
                                    prEmployees."Union Member?" := HREmp."Union Member?";
                                    prEmployees."Shift Worker?" := HREmp."Shift Worker?";
                                    prEmployees."Contracted Hours" := HREmp."Contracted Hours";
                                    prEmployees."Pay Period" := HREmp."Pay Period";
                                    prEmployees."Pay Per Period" := HREmp."Pay Per Period";
                                    prEmployees."Cost Code" := HREmp."Cost Code";
                                    prEmployees."PAYE Number" := HREmp."PAYE Number";
                                    prEmployees."Marital Status" := HREmp."Marital Status";
                                    prEmployees."Ethnic Origin" := HREmp."Ethnic Origin";
                                    prEmployees."First Language (R/W/S)" := HREmp."First Language (R/W/S)";
                                    prEmployees."Vehicle Registration Number" := HREmp."Vehicle Registration Number";
                                    prEmployees.Disabled := HREmp.Disabled;
                                    prEmployees."Health Assesment?" := HREmp."Health Assesment?";
                                    prEmployees."Health Assesment Date" := HREmp."Health Assesment Date";
                                    prEmployees."Date Of Birth" := HREmp."Date Of Birth";
                                    prEmployees.Age := HREmp.Age;
                                    prEmployees."Length Of Service" := HREmp."Length Of Service";
                                    prEmployees."End Of Probation Date" := HREmp."End Of Probation Date";
                                    prEmployees."Per Annum" := HREmp."Per Annum";
                                    prEmployees."Allow Overtime" := HREmp."Allow Overtime";
                                    prEmployees."Medical Scheme No." := HREmp."Medical Scheme No.";
                                    prEmployees."Medical Scheme Head Member" := HREmp."Medical Scheme Head Member";
                                    prEmployees."Number Of Dependants" := HREmp."Number Of Dependants";
                                    prEmployees."Medical Scheme Name" := HREmp."Medical Scheme Name";
                                    prEmployees."Amount Paid By Employee" := HREmp."Amount Paid By Employee";
                                    prEmployees."Amount Paid By Company" := HREmp."Amount Paid By Company";
                                    prEmployees."Second Language (R/W/S)" := HREmp."Second Language (R/W/S)";
                                    prEmployees."Additional Language" := HREmp."Additional Language";
                                    prEmployees."UIF Country" := HREmp."UIF Country";
                                    prEmployees."Primary Skills Category" := HREmp."Primary Skills Category";
                                    prEmployees.Level := HREmp.Level;
                                    prEmployees."Termination Category" := HREmp."Termination Category";
                                    prEmployees."Job Specification" := HREmp."Job Title";
                                    prEmployees."Postal Address2" := HREmp."Postal Address2";
                                    prEmployees."Postal Address3" := HREmp."Postal Address3";
                                    prEmployees."Residential Address2" := HREmp."Residential Address2";
                                    prEmployees."Residential Address3" := HREmp."Residential Address3";
                                    prEmployees."Post Code2" := HREmp."Post Code2";
                                    prEmployees.Citizenship := HREmp.Citizenship;
                                    prEmployees."Name Of Manager" := HREmp."Name Of Manager";
                                    prEmployees."User ID" := HREmp."User ID";
                                    prEmployees."Disabling Details" := HREmp."Disabling Details";
                                    prEmployees."Passport Number" := HREmp."Passport Number";
                                    prEmployees."2nd Skills Category" := HREmp."2nd Skills Category";
                                    prEmployees."3rd Skills Category" := HREmp."3rd Skills Category";
                                    prEmployees.PensionJoin := HREmp.PensionJoin;
                                    prEmployees.Temp := HREmp.Temp;
                                    prEmployees."Contract Location" := HREmp."Contract Location";
                                    prEmployees."First Language Read" := HREmp."First Language Read";
                                    prEmployees."First Language Write" := HREmp."First Language Write";
                                    prEmployees."First Language Speak" := HREmp."First Language Speak";
                                    prEmployees."Second Language Read" := HREmp."Second Language Read";
                                    prEmployees."Second Language Write" := HREmp."Second Language Write";
                                    prEmployees."Second Language Speak" := HREmp."Second Language Speak";
                                    prEmployees."Custom Grading" := HREmp."Custom Grading";
                                    prEmployees."PIN Number" := HREmp."PIN Number";
                                    prEmployees."NSSF No." := HREmp."NSSF No.";
                                    prEmployees."NHIF No." := HREmp."NHIF No.";
                                    prEmployees."Cause of Inactivity Code" := HREmp."Cause of Inactivity Code";
                                    prEmployees."Payroll Code" := HREmp."PAYROLL NO";
                                    //prEmployees."HELB No":=HREmp."HELB No";
                                    prEmployees."Co-Operative No" := HREmp."Co-Operative No";
                                    prEmployees."Wedding Anniversary" := HREmp."Wedding Anniversary";
                                    prEmployees."Position To Succeed" := HREmp."Position To Succeed";
                                    prEmployees."Succesion Date" := HREmp."Succesion Date";
                                    prEmployees."Send Alert to" := HREmp."Send Alert to";
                                    prEmployees.Tribe := HREmp.Tribe;
                                    prEmployees.Religion := HREmp.Religion;
                                    prEmployees."Job Title" := HREmp."Job Title";
                                    //changes to salary grades
                                    prEmployees."Salary Category" := HREmp."Salary Category";
                                    prEmployees."Salary Grade" := HREmp."Salary Grade";
                                    //prEmployees."Salary Step" := HREmp.Steps;
                                    //prEmployees."Posting Group" := HREmp."Posting Group";
                                    prEmployees."Posting Group" := 'PAYROLL';
                                    prEmployees."Payroll Posting Group" := 'PAYROLL';
                                    prEmployees."Payroll Posting Group" := HREmp."Payroll Posting Group";
                                    prEmployees."Served Notice Period" := HREmp."Served Notice Period";
                                    prEmployees."Exit Interview Date" := HREmp."Exit Interview Date";
                                    prEmployees."Exit Interview Done by" := HREmp."Exit Interview Done by";
                                    prEmployees."Allow Re-Employment In Future" := HREmp."Allow Re-Employment In Future";
                                    prEmployees."Medical Scheme Name #2" := HREmp."Medical Scheme Name #2";
                                    prEmployees."Payroll Departments" := HREmp."Payroll Departments";
                                    prEmployees.Comment := HREmp.Comment;
                                    prEmployees."Competency Area" := HREmp."Competency Area";
                                    prEmployees."Employee Qty" := HREmp."Employee Qty";
                                    prEmployees."Employee Act. Qty" := HREmp."Employee Act. Qty";
                                    prEmployees."Employee Arc. Qty" := HREmp."Employee Arc. Qty";
                                    prEmployees."Payroll Code" := HREmp."No.";
                                    prEmployees.Insert;
                                    prEmployees.Validate("No.");
                                    // Create A SalaryCard Entry

                                    prPayrollType.Reset;
                                    prPayrollType.SetRange(prPayrollType."Payroll Code", HREmp."No.");
                                    if prPayrollType.Find('-') then begin
                                        prPayrollType."Payroll Code" := HREmp."No.";
                                        prPayrollType."Payroll Name" := HREmp."First Name" + '' + HREmp."Middle Name" + '' + HREmp."Last Name";
                                        prPayrollType.Modify;
                                    end else begin
                                        prPayrollType.Init;
                                        prPayrollType."Payroll Code" := HREmp."No.";
                                        prPayrollType."Payroll Name" := HREmp."First Name" + '' + HREmp."Middle Name" + '' + HREmp."Last Name";
                                        prPayrollType.Insert;
                                    end;


                                end;

                            end;
                            until HREmp.Next = 0;
                        end;

                        Message('Payroll data Successfully Updated.');
                    end;
                }

                action("Validate Title")
                {
                    Image = UpdateXML;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ApplicationArea = All;
                    RunObject = Report "Validate Title";


                }
                action("Update Retirement Age")
                {
                    Image = UpdateXML;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        updateRetirement();

                    end;


                }

            }
            group("&Employee")
            {
                Caption = '&Employee';
                action("Employee Summary")
                {
                    ApplicationArea = all;
                    Caption = 'Employee Summary';
                    Image = SuggestGrid;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Report;

                    trigger OnAction()
                    begin
                        if HREmp.Get(Rec."No.") then begin
                            REPORT.Run(51829, true, true, HREmp);
                        end;
                    end;
                }
                action("Upload Attachments")
                {
                    ApplicationArea = all;
                    Caption = 'Upload Attachments';
                    Image = Attachments;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HRM- Emp. Attachments (B)";
                    RunPageLink = "Employee No" = FIELD("No.");
                }
                action("Next of Kin")
                {
                    ApplicationArea = All;
                    Caption = 'Next of Kin';
                    Image = Relatives;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HRM-Employees Kin";
                    RunPageLink = "Employee Code" = FIELD("No."), Type = FILTER("Next of Kin");
                    RunPageView = WHERE(Type = FILTER("Next of Kin"));
                }
                action("Employee Medical Insurance")
                {

                    ApplicationArea = all;
                    Caption = 'Employee Medical Insurance';
                    Image = Relatives;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HRM-Employee Insurance";
                    RunPageLink = "Payroll No." = FIELD("No.");
                }
                action("Insurance Dependents")
                {

                    ApplicationArea = all;
                    Caption = 'Insurance Dependents';
                    Image = Relatives;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HRM-Insurance Dependents List";
                    RunPageLink = "Payroll No." = FIELD("No.");
                }
                action(Beneficiaries)
                {
                    Visible = false;
                    ApplicationArea = All;
                    Caption = 'Beneficiaries';
                    Image = Opportunity;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HRM-Emp. Beneficiary";
                    RunPageLink = "Employee Code" = FIELD("No."), Type = FILTER(Beneficiary);
                    RunPageView = WHERE(Type = FILTER(Beneficiary));
                }
                action(Dependants)
                {
                    ApplicationArea = All;
                    Caption = 'Dependants';
                    Image = Relatives;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HRM-Employees Dependants";
                    RunPageLink = "Employee Code" = FIELD("No."), Type = FILTER(Dependant);
                    RunPageView = WHERE(Type = FILTER(Dependant));
                }
                action(Qualifications)
                {
                    ApplicationArea = All;
                    Caption = 'Academics Qualifications';
                    Image = QualificationOverview;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HRM-Emp. Qualifications (B)";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Professional Qualification")
                {
                    ApplicationArea = All;
                    Caption = 'Professional Qualification';
                    Image = QualificationOverview;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HRM-Professional Qualification";
                    RunPageLink = "Payroll No." = FIELD("No.");
                }
                action("Employment History")
                {
                    ApplicationArea = All;
                    Caption = 'Employment History';
                    Image = History;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HRM-Employment History (B)";
                    RunPageLink = "No." = FIELD("No.");
                }
                action("Proffessional Membership")
                {
                    ApplicationArea = all;
                    Caption = 'Proffessional Membership';
                    Image = Group;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HRM-Proffessional Membership";
                    RunPageLink = "Employee Code" = FIELD("No.");
                }
                action("Training History")
                {
                    ApplicationArea = all;
                    Caption = 'Training History';
                    Image = Certificate;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = false;
                    RunObject = Page "HRM-Training Partcipants";
                    RunPageLink = "Employee Code" = FIELD("No.");
                }
                action("Employee Responsibilities")
                {
                    ApplicationArea = all;
                    Caption = 'Employee Responsibilities';
                    Image = ResourcePlanning;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = false;
                    RunObject = Page "HRM-Job Responsiblities (B)";
                    RunPageLink = "Payroll No." = FIELD("No.");
                }
                action("Assign Clearance Items")
                {
                    ApplicationArea = all;
                    Caption = 'Assign Clearance Items';
                    Image = ExternalDocument;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "Misc. Article Information";
                    RunPageLink = "Employee No." = FIELD("No.");
                    Visible = false;
                }
                action("View Clearance Details")
                {
                    ApplicationArea = all;
                    Caption = 'View Clearance Details';
                    Image = ExternalDocument;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HRM-Asset Return Form";
                    RunPageLink = "Employee No." = FIELD("No.");
                    Visible = false;
                }
                action("Misc. Articles Overview")
                {
                    ApplicationArea = All;
                    Caption = 'Misc. Articles Overview';
                    Image = ViewSourceDocumentLine;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "Misc. Articles Overview";
                }
                action("&Confidential Information")
                {
                    ApplicationArea = All;
                    Caption = '&Confidential Information';
                    Image = SNInfo;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Confidential Information";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Co&nfidential Info. Overview")
                {
                    ApplicationArea = All;
                    Caption = 'Co&nfidential Info. Overview';
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Confidential Info. Overview";
                }
                action("A&bsences")
                {
                    ApplicationArea = All;
                    Caption = 'A&bsences';
                    Image = AbsenceCalendar;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Employee Absences";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action(Dimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(5200),
                                  "No." = FIELD("No.");
                }
                action("Employee Picture")
                {
                    Caption = 'Employee Picture';
                    Image = Picture;
                    RunObject = Page "HRM-Emp. Picture";
                    ApplicationArea = All;
                }
                action("Hiring Details")
                {
                    Caption = 'Hiring Details';
                    Image = Answers;
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Page "HRM-Job Interview";
                    RunPageLink = "Applicant No" = FIELD("Job Application No");
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Employee Disciplinary Cases")
                {
                    Caption = 'Employee Disciplinary Cases';
                    Image = Components;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HRM-Disciplinary Cases List";
                    RunPageLink = "Accused Employee" = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Committe Membership")
                {
                    ApplicationArea = All;
                    Caption = 'Committe Membership';
                    Image = Calls;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HRM-Commitee Membership";
                    RunPageLink = "Member No." = FIELD("No.");
                }
            }
        }
    }

    var
        PictureExists: Boolean;
        //CheckList: Codeunit "HR CheckList";
        ACheckListTable: Record "HRM-Induction Schedule";
        SICNumbersTable: Record "HRM-Appraisal Evaluation Areas";
        //SICNumbersList: Codeunit "HR SIC Numbers";
        Dates: Codeunit "HR Dates";
        "gOpt Active": Option Active,Archive,All;
        D: Date;
        DAge: Text[100];
        DService: Text[100];
        DPension: Text[100];
        DMedical: Text[100];
        [InDataSet]
        "Disabling DetailsEditable": Boolean;
        [InDataSet]
        "Disability GradeEditable": Boolean;
        FrmCalendar: Page "GEN--Calendar Small";
        "FORM HR Employee": Page "HRM-Employee-List";
        HREmp: Record "HRM-Employee (D)";
        RetirementDur: Text[250];
        DoclLink: Record "HRM-Employee Attachments";
        "Filter": Boolean;
        prEmployees: Record "HRM-Employee (D)";
        prPayrollType: Record "PRL-Payroll Type";
        //Mail: Codeunit Mail;
        SupervisorNames: Text[30];
        HRValueChange: Record "HRM-Value Change";
        Dretirement: Text;
        DRetire: Text;
        Text19004462: Label 'Union Worker?';
        Text19012299: Label 'Per Week';
        emp: Record "HRM-Employee (D)";
        hrLedger: Record "HRM-Leave Ledger";

    procedure GenerateFullNames() nos: integer
    var
        fullname: Text[200];
    begin
        nos := 0;
        emp.RESET;
        IF emp.FIND('-') THEN begin
            REPEAT
                fullname := '';
                if emp."First Name" <> '' then
                    fullname += emp."First Name";
                if emp."Middle Name" <> '' then begin
                    if fullname <> '' then begin
                        fullname += ' ' + emp."Middle Name";
                    end else
                        fullname += emp."Middle Name";
                end;
                if emp."Last Name" <> '' then
                    fullname += ' ' + emp."Last Name";
                emp."Full Name" := fullname;
                emp.modify;
                nos += 1;
            UNTIL emp.Next = 0;
        end;
    end;

    procedure LeaveCorrect()
    begin
        hrLedger.Reset();
        hrLedger.SetRange("Leave Type", 'ANNUAL');
        IF hrLedger.Find('-') then begin
            repeat
                hrLedger."Leave Type" := 'AL';
                hrLedger.Modify();
            until hrLedger.Next() = 0;
        end;
    end;

    procedure updateRetirement()
    var
        hrmEmp: Record "HRM-Employee (D)";
        salGrades: Record "HRM-Job_Salary grade/steps";
    begin
        salGrades.Reset();
        //salGrades.SetRange();
        if hrmEmp.Find('-') then begin
            repeat
                salGrades.Reset();
                salGrades.SetRange("Salary Grade code", hrmEmp."Salary Grade");
                if salGrades.Find('-') then begin
                    hrmEmp."Retirement Age" := salGrades."Retirement Age";
                end;
            until hrmEmp.Next() = 0;
        end;
    end;

    procedure "Filter Employees"(Type: Option Active,Archive,All)
    begin
        if Type = Type::Active then begin
            Rec.Reset;
            Rec.SetFilter("Termination Category", '=%1', Rec."Termination Category"::" ");
        end
        else
            if Type = Type::Archive then begin
                Rec.Reset;
                Rec.SetFilter("Termination Category", '<>%1', Rec."Termination Category"::" ");
            end
            else
                if Type = Type::All then
                    Rec.Reset;

        CurrPage.Update(false);
        Rec.FilterGroup(20);
    end;

    local procedure ActivegOptActiveOnPush()
    begin
        "Filter Employees"(0); //Active Employees
    end;

    local procedure ArchivegOptActiveOnPush()
    begin
        "Filter Employees"(1); //Archived Employees
    end;

    local procedure AllgOptActiveOnPush()
    begin
        "Filter Employees"(2); //  Show All Employees
    end;

    local procedure ActivegOptActiveOnValidate()
    begin
        ActivegOptActiveOnPush;
    end;

    local procedure ArchivegOptActiveOnValidate()
    begin
        ArchivegOptActiveOnPush;
    end;

    local procedure AllgOptActiveOnValidate()
    begin
        AllgOptActiveOnPush;
    end;
}

