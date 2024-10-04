page 68079 "HRM-Employee"
{
    Caption = 'Employee Card';
    DelayedInsert = false;
    PageType = Document;
    RefreshOnActivate = true;
    SaveValues = true;
    SourceTable = "HRM-Employee (D)";

    layout
    {
        area(content)
        {
            group(Control206)
            {
                Editable = false;
                ShowCaption = false;
                field("gOpt Active"; "gOpt Active")
                {
                    OptionCaption = 'Show Active Employees,Show Archived Employees,Show All Employees';
                    ShowCaption = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if "gOpt Active" = "gOpt Active"::All then
                            AllgOptActiveOnValidate;
                        if "gOpt Active" = "gOpt Active"::Archive then
                            ArchivegOptActiveOnValidate;
                        if "gOpt Active" = "gOpt Active"::Active then
                            ActivegOptActiveOnValidate;
                    end;
                }
                field("Employee Act. Qty"; Rec."Employee Act. Qty")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Employee Arc. Qty"; Rec."Employee Arc. Qty")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Employee Qty"; Rec."Employee Qty")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group("General Information")
            {
                Caption = 'General Information';
                field("No."; Rec."No.")
                {
                    AssistEdit = true;
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                }
                field("Known As"; Rec."Known As")
                {
                    ApplicationArea = All;
                }
                field(Initials; Rec.Initials)
                {
                    ApplicationArea = All;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = All;
                }
                field("Passport Number"; Rec."Passport Number")
                {
                    ApplicationArea = All;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                }
                field(Citizenship; Rec.Citizenship)
                {
                    ApplicationArea = All;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                }
                field("Postal Address"; Rec."Postal Address")
                {
                    ApplicationArea = All;
                }
                field("Postal Address2"; Rec."Postal Address2")
                {
                    ApplicationArea = All;
                }
                field("Postal Address3"; Rec."Postal Address3")
                {
                    ApplicationArea = All;
                }
                field("Post Code2"; Rec."Post Code2")
                {
                    Caption = 'Post Code';
                    LookupPageID = "Post Codes";
                    ApplicationArea = All;
                }
                field("Residential Address"; Rec."Residential Address")
                {
                    ApplicationArea = All;
                }
                field("Residential Address2"; Rec."Residential Address2")
                {
                    ApplicationArea = All;
                }
                field("Residential Address3"; Rec."Residential Address3")
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = All;
                }
            }
            group("Personal Details")
            {
                Caption = 'Personal Details';
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = All;
                }
                field(Religion; Rec.Religion)
                {
                    ApplicationArea = All;
                }
                field("Ethnic Origin"; Rec."Ethnic Origin")
                {
                    ApplicationArea = All;
                }
                field(Tribe; Rec.Tribe)
                {
                    ApplicationArea = All;
                }
                field("First Language (R/W/S)"; Rec."First Language (R/W/S)")
                {
                    ApplicationArea = All;
                }
                field("Second Language (R/W/S)"; Rec."Second Language (R/W/S)")
                {
                    ApplicationArea = All;
                }
                field("Additional Language"; Rec."Additional Language")
                {
                    ApplicationArea = All;
                }
                field("First Language Write"; Rec."First Language Write")
                {
                    ApplicationArea = All;
                }
                field("Second Language Write"; Rec."Second Language Write")
                {
                    ApplicationArea = All;
                }
                field("Driving Licence"; Rec."Driving Licence")
                {
                    ApplicationArea = All;
                }
                field("First Language Speak"; Rec."First Language Speak")
                {
                    ApplicationArea = All;
                }
                field("Second Language Speak"; Rec."Second Language Speak")
                {
                    ApplicationArea = All;
                }
                field(Disabled; Rec.Disabled)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if Rec.Disabled = Rec.Disabled::No then begin
                            "Disabling DetailsEditable" := false;
                            "Disability GradeEditable" := false;
                        end
                        else
                            "Disabling DetailsEditable" := true;
                        "Disability GradeEditable" := true;
                    end;
                }
                field("Disabling Details"; Rec."Disabling Details")
                {
                    Editable = "Disabling DetailsEditable";
                    ApplicationArea = All;
                }
                field("Disability Grade"; Rec."Disability Grade")
                {
                    Editable = "Disability GradeEditable";
                    ApplicationArea = All;
                }
                field("Health Assesment?"; Rec."Health Assesment?")
                {
                    Caption = 'Health Assessment?';
                    ApplicationArea = All;
                }
                field("Medical Scheme No."; Rec."Medical Scheme No.")
                {
                    ApplicationArea = All;
                }
                field("Medical Scheme Head Member"; Rec."Medical Scheme Head Member")
                {
                    ApplicationArea = All;
                }
                field("Number Of Dependants"; Rec."Number Of Dependants")
                {
                    ApplicationArea = All;
                }
                field("Medical Scheme Name"; Rec."Medical Scheme Name")
                {
                    ApplicationArea = All;
                }
                field("Medical Scheme Name #2"; Rec."Medical Scheme Name #2")
                {
                    ApplicationArea = All;
                }
                field("Health Assesment Date"; Rec."Health Assesment Date")
                {
                    Caption = 'Health Assessment Date';
                    ApplicationArea = All;
                }
                group("  R      W     S")
                {
                    Caption = '  R      W     S';
                    field("First Language Read"; Rec."First Language Read")
                    {
                        ApplicationArea = All;
                    }
                    field("Second Language Read"; Rec."Second Language Read")
                    {
                        ApplicationArea = All;
                    }
                }
            }
            group("Important Dates")
            {
                Caption = 'Important Dates';
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = All;
                }
                field(DAge; DAge)
                {
                    Caption = 'Age';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Date Of Join"; Rec."Date Of Join")
                {
                    Caption = 'Date Of Joining The Company';
                    ApplicationArea = All;
                }
                field(DService; DService)
                {
                    Caption = 'Length of Service';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("End Of Probation Date"; Rec."End Of Probation Date")
                {
                    ApplicationArea = All;
                }
                field("Pension Scheme Join"; Rec."Pension Scheme Join")
                {
                    Caption = 'Pension Scheme Join Date';
                    ApplicationArea = All;
                }
                field(DPension; DPension)
                {
                    Caption = 'Time On Pension Scheme';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Medical Scheme Join"; Rec."Medical Scheme Join")
                {
                    Caption = 'Medical Aid Scheme Join Date';
                    ApplicationArea = All;
                }
                field(DMedical; DMedical)
                {
                    Editable = false;
                    ShowCaption = false;
                    ApplicationArea = All;
                }
                field("Wedding Anniversary"; Rec."Wedding Anniversary")
                {
                    ApplicationArea = All;
                }
            }
            group("Contact Numbers")
            {
                Caption = 'Contact Numbers';
                field("Home Phone Number"; Rec."Home Phone Number")
                {
                    ApplicationArea = All;
                }
                field("Cellular Phone Number"; Rec."Cellular Phone Number")
                {
                    ApplicationArea = All;
                }
                field("Fax Number"; Rec."Fax Number")
                {
                    ApplicationArea = All;
                }
                field("Work Phone Number"; Rec."Work Phone Number")
                {
                    ApplicationArea = All;
                }
                field("Ext."; Rec."Ext.")
                {
                    ApplicationArea = All;
                }
                field("Post Office No"; Rec."Post Office No")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    ApplicationArea = All;
                }
            }
            group("Job Information")
            {
                Caption = 'Job Information';
                field(Position; Rec.Position)
                {
                    Caption = 'Job Position';
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
                field("Name Of Manager"; Rec."Name Of Manager")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        "Rec HR Employee": Record "HRM-Employee (D)";
                    begin
                        /*
                        "Form HR Employee".LOOKUPMODE(TRUE);
                        IF ("Form HR Employee".RUNMODAL = ACTION::LookupOK) THEN
                           "Form HR Employee".GETRECORD("Rec HR Employee");
                        
                        "Name Of Manager" := "Rec HR Employee"."Known As" + ' ' + "Rec HR Employee"."Last Name";
                        "Manager Emp No":="Rec HR Employee"."No.";
                         */

                    end;
                }
                field("Grade Level"; Rec."Grade Level")
                {
                    ApplicationArea = All;
                }
                field("2nd Skills Category"; Rec."2nd Skills Category")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("3rd Skills Category"; Rec."3rd Skills Category")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Primary Skills Category"; Rec."Primary Skills Category")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
            group("Contract Information")
            {
                Caption = 'Contract Information';
                field("Contract Location"; Rec."Contract Location")
                {
                    Caption = 'Location';
                    ApplicationArea = All;
                }
                field("Full / Part Time"; Rec."Full / Part Time")
                {
                    ApplicationArea = All;
                }
                field(Permanent; Rec.Permanent)
                {
                    Caption = 'Payroll Permanent';
                    ApplicationArea = All;
                }
                field("Contract Type"; Rec."Contract Type")
                {
                    ApplicationArea = All;
                }
                field("Contract End Date"; Rec."Contract End Date")
                {
                    ApplicationArea = All;
                }
                field("Notice Period"; Rec."Notice Period")
                {
                    ApplicationArea = All;
                }
                field("Send Alert to"; Rec."Send Alert to")
                {
                    ApplicationArea = All;
                }
            }
            group("Payment Information")
            {
                Caption = 'Payment Information';
                field("Department Code"; Rec."Department Code")
                {
                    Caption = 'Department';
                    ApplicationArea = All;
                }
                field("Payroll Departments"; Rec."Payroll Departments")
                {
                    Caption = 'Cost Center';
                    ApplicationArea = All;
                }
                field("PIN Number"; Rec."PIN Number")
                {
                    ApplicationArea = All;
                }
                field("NSSF No."; Rec."NSSF No.")
                {
                    ApplicationArea = All;
                }
                field("NHIF No."; Rec."NHIF No.")
                {
                    ApplicationArea = All;
                }
                field("HELB No"; Rec."HELB No")
                {
                    ApplicationArea = All;
                }
                field("Co-Operative No"; Rec."Co-Operative No")
                {
                    ApplicationArea = All;
                }
                field("Bank Account Number"; Rec."Bank Account Number")
                {
                    ApplicationArea = All;
                }
                field("Main Bank"; Rec."Main Bank")
                {
                    ApplicationArea = All;
                }
                field("Branch Bank"; Rec."Branch Bank")
                {
                    ApplicationArea = All;
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    Caption = 'HR Posting Group';
                    ApplicationArea = All;
                }
                field("Payroll Posting Group"; Rec."Payroll Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Payroll Code"; Rec."Payroll Code")
                {
                    ApplicationArea = All;
                }
                field("Holiday Days Entitlement"; Rec."Holiday Days Entitlement")
                {
                    ApplicationArea = All;
                }
                field("Holiday Days Used"; Rec."Holiday Days Used")
                {
                    ApplicationArea = All;
                }
                field("Hourly Rate"; Rec."Hourly Rate")
                {
                    ApplicationArea = All;
                }
                field("Daily Rate"; Rec."Daily Rate")
                {
                    ApplicationArea = All;
                }
            }
            group(Separation)
            {
                Caption = 'Separation';
                field("Contract Type1"; Rec."Contract Type")
                {
                    ApplicationArea = All;
                }
                field("Contract End Date1"; Rec."Contract End Date")
                {
                    ApplicationArea = All;
                }
                field("Notice Period1"; Rec."Notice Period")
                {
                    ApplicationArea = All;
                }
                field("Send Alert to1"; Rec."Send Alert to")
                {
                    ApplicationArea = All;
                }
                field("Served Notice Period"; Rec."Served Notice Period")
                {
                    ApplicationArea = All;
                }
                field("Date Of Leaving"; Rec."Date Of Leaving")
                {
                    Caption = 'Date Of Leaving The Company';
                    ApplicationArea = All;
                }
                field("Termination Category"; Rec."Termination Category")
                {
                    Caption = 'Exit Category';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if Rec."Termination Category" <> Rec."Termination Category"::" " then
                            Rec.Status := Rec.Status::Disabled;
                    end;
                }
                field("Grounds for Term. Code"; Rec."Grounds for Term. Code")
                {
                    Caption = 'Grounds for Exit';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Exit Interview Date"; Rec."Exit Interview Date")
                {
                    ApplicationArea = All;
                }
                field("Exit Interview Done by"; Rec."Exit Interview Done by")
                {
                    ApplicationArea = All;
                }
                field("Allow Re-Employment In Future"; Rec."Allow Re-Employment In Future")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        DAge := '';
        DService := '';
        DPension := '';
        DMedical := '';

        //Recalculate Important Dates
        /* IF ("Date Of Leaving" = 0D) THEN BEGIN
           IF  ("Date Of Birth" <> 0D) THEN
           DAge:= Dates.DetermineAge("Date Of Birth",TODAY);
           IF  ("Date Of Join" <> 0D) THEN
           DService:= Dates.DetermineAge("Date Of Join",TODAY);
           IF  ("Pension Scheme Join" <> 0D) THEN
           DPension:= Dates.DetermineAge("Pension Scheme Join",TODAY);
           IF  ("Medical Scheme Join" <> 0D) THEN
           DMedical:= Dates.DetermineAge("Medical Scheme Join",TODAY);
           //MODIFY;
         END ELSE BEGIN
           IF  ("Date Of Birth" <> 0D) THEN
           DAge:= Dates.DetermineAge("Date Of Birth","Date Of Leaving");
           IF  ("Date Of Join" <> 0D) THEN
           DService:= Dates.DetermineAge("Date Of Join","Date Of Leaving");
           IF  ("Pension Scheme Join" <> 0D) THEN
           DPension:= Dates.DetermineAge("Pension Scheme Join","Date Of Leaving");
           IF  ("Medical Scheme Join" <> 0D) THEN
           DMedical:= Dates.DetermineAge("Medical Scheme Join","Date Of Leaving");
          // MODIFY;
         END; */

    end;

    trigger OnInit()
    begin
        "Disability GradeEditable" := true;
        "Disabling DetailsEditable" := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        //RESET;
        "gOpt Active" := "gOpt Active"::All;
        //MESSAGE('All employee information must be completed.')
    end;

    trigger OnOpenPage()
    begin
        "gOpt Active" := "gOpt Active"::Active;
        Rec.SetCurrentKey("Termination Category");
        "Filter Employees"(0);
        DAge := '';
        DService := '';
        DPension := '';
        DMedical := '';

        //Recalculate Important Dates
        /*IF ("Date Of Leaving" = 0D) THEN BEGIN
          IF  ("Date Of Birth" <> 0D) THEN
          DAge:= Dates.DetermineAge("Date Of Birth",TODAY);
          IF  ("Date Of Join" <> 0D) THEN
          DService:= Dates.DetermineAge("Date Of Join",TODAY);
          IF  ("Pension Scheme Join" <> 0D) THEN
          DPension:= Dates.DetermineAge("Pension Scheme Join",TODAY);
          IF  ("Medical Scheme Join" <> 0D) THEN
          DMedical:= Dates.DetermineAge("Medical Scheme Join",TODAY);
          //MODIFY;
        END ELSE BEGIN
          IF  ("Date Of Birth" <> 0D) THEN
          DAge:= Dates.DetermineAge("Date Of Birth","Date Of Leaving");
          IF  ("Date Of Join" <> 0D) THEN
          DService:= Dates.DetermineAge("Date Of Join","Date Of Leaving");
          IF  ("Pension Scheme Join" <> 0D) THEN
          DPension:= Dates.DetermineAge("Pension Scheme Join","Date Of Leaving");
          IF  ("Medical Scheme Join" <> 0D) THEN
          DMedical:= Dates.DetermineAge("Medical Scheme Join","Date Of Leaving");
          //MODIFY;
        END;*/
        //VALIDATE("Contract End Date");

    end;

    var
        //Mail: Codeunit Mail;
        PictureExists: Boolean;
        "gOpt Active": Option Active,Archive,All;
        D: Date;
        DAge: Text[100];
        DService: Text[100];
        DPension: Text[100];
        DMedical: Text[100];
        currentmonth: Date;
        [InDataSet]
        "Disabling DetailsEditable": Boolean;
        [InDataSet]
        "Disability GradeEditable": Boolean;

    procedure "Filter Employees"(Type: Option Active,Archive,All)
    begin


        if Type = Type::Active then begin
            Rec.Reset;
            Rec.SetFilter("Termination Category", '=%1', Rec."Termination Category"::" ");
        end
        else
            if Type = Type::Archive then begin
                Rec.Reset;
                Rec.SetFilter("Termination Category", '>%1', Rec."Termination Category"::" ");
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

    procedure GetSupervisor(var sUserID: Code[20]) SupervisorName: Text[200]
    var
        UserSetup: Record "User Setup";
        HREmp: Record "HRM-Employee (D)";
    begin
        if sUserID <> '' then begin
            UserSetup.Reset;
            if UserSetup.Get(sUserID) then begin

                SupervisorName := UserSetup."Approver ID";
                if SupervisorName <> '' then begin

                    HREmp.SetRange(HREmp."User ID", SupervisorName);
                    if HREmp.Find('-') then
                        SupervisorName := HREmp.FullName;

                end else begin
                    SupervisorName := '';
                end;


            end else begin
                Error('User' + ' ' + sUserID + ' ' + 'does not exist in the user setup table');
                SupervisorName := '';
            end;
        end;
    end;
}

