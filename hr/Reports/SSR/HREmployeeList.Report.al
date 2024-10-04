report 51161 "HR Employee List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './hr/Reports/SSR/HREmployeeList.rdl';

    dataset
    {
        dataitem(DataItem6075; "HRM-Employee (D)")
        {
            RequestFilterFields = "No.", Status, Lecturer, "Head of Department", "Department Code";
            column(No_DataItem6075; "No.")
            {
            }
            column(FirstName_DataItem6075; "First Name")
            {
            }
            column(MiddleName_DataItem6075; "Middle Name")
            {
            }

            column(LastName_DataItem6075; "Last Name")
            {
            }
            column(Gender_DataItem6075; Gender)
            {
            }
            column(DateOfBirth_DataItem6075; format("Date Of Birth"))
            {
            }
            column(DateofAppointment_DataItem6075; format("Date of Appointment"))
            {
            }
            column(PINNumber_DataItem6075; "PIN Number")
            {
            }
            column(NSSFNo_DataItem6075; "NSSF No.")
            {
            }
            column(NHIFNo_DataItem6075; "NHIF No.")
            {
            }
            column(MaritalStatus_DataItem6075; "Marital Status")
            {
            }
            column(Religion_DataItem6075; Religion)
            {
            }
            column(Denomination_DataItem6075; Denomination)
            {
            }
            column(Nationality_DataItem6075; Nationality)
            {
            }
            column(NationalityCode_DataItem6075; "Nationality Code")
            {
            }
            column(WorkPermitNo_DataItem6075; "Work Permit No.")
            {
            }
            column(WorkPermitExpiry_DataItem6075; "Work Permit Expiry")
            {
            }
            column(EthnicOrigin_DataItem6075; "Ethnic Origin")
            {
            }
            column(County_DataItem6075; County)
            {
            }
            column(Disabled_DataItem6075; Disabled)
            {
            }
            column(NatureofDisability_DataItem6075; "Nature of Disability")
            {
            }
            column(DisabilityRegNo_DataItem6075; "Disability Reg. No.")
            {
            }
            column(CellularPhoneNumber_DataItem6075; "Cellular Phone Number")
            {
            }
            column(HomePhoneNumber_DataItem6075; "Home Phone Number")
            {
            }
            column(EMail_DataItem6075; "E-Mail")
            {
            }
            column(CUEAEmailAddress_DataItem6075; "CUEA Email Address")
            {
            }
            column(PostCode_DataItem6075; "Post Code")
            {
            }
            column(CILogo; CI.Picture)
            {
            }
            column(CIName; CI.Name)
            {
            }

            column(AllEmployees; AllEmployees)
            {
            }
            column(MaleEmployees; MaleEmployees)
            {
            }
            column(FemaleEmployees; FemaleEmployees)
            {
            }
            column(ActiveEmployee; ActiveEmployee)
            {

            }
            column(InactiveEmployee; InactiveEmployee)
            {

            }


            trigger OnAfterGetRecord()
            begin
                CLEAR(LenghtOfServices);
                IF (("Date Of Join" <> 0D) AND ("Date Of Join" <= TODAY)) THEN
                    LenghtOfServices := HrDates.DetermineAge("Date Of Join", TODAY);

                CLEAR(Age);
                IF (("Date Of Birth" <> 0D) AND ("Date Of Birth" <= TODAY)) THEN
                    Age := HrDates.DetermineAge("Date Of Birth", TODAY);





            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CI.GET();
        CI.CALCFIELDS(CI.Picture);

        Clear(AllEmployees);
        Clear(ActiveEmployee);
        Clear(MaleEmployees);
        Clear(FemaleEmployees);
        Clear(EmployeeCountPerDept);

        HRMEmp.Reset();
        if HRMEmp.Find('-') then AllEmployees := HRMEmp.count;

        HRMEmp.Reset();
        HRMEmp.SetRange(Status, HRMEmp.Status::Active);
        if HRMEmp.FindSet() then
            repeat
                DimValue.Reset();
                DimValue.SetRange(Code, HRMEmp."Department Code");
                if DimValue.Find('-')
                then
                    EmployeeCountPerDept := HRMEmp.count;

            until HRMEmp.next = 0;

        HRMEmp.Reset();
        HRMEmp.SetRange(Gender, HRMEmp.Gender::Male);
        HRMEmp.SetRange("Employee Category", 'FULL TIME');
        IF HRMEmp.Find('-') then begin
            MaleEmployees := 0;
            repeat
                MaleEmployees := MaleEmployees + 1
            until HRMEmp.Next() = 0;

        end;

        HRMEmp.Reset();
        HRMEmp.SetRange(Gender, HRMEmp.Gender::Female);
        // HRMEmp.SetRange("Employee Category", 'FULL TIME');
        if HRMEmp.Find('-') then begin
            FemaleEmployees := 0;
            repeat
                FemaleEmployees := FemaleEmployees + 1
            until HRMEmp.Next() = 0
        end;
        HRMEmp.Reset();
        HRMEmp.SetRange(Status, HRMEmp.Status::Active);
        // HRMEmp.SetRange("Employee Category", 'FULL TIME');
        if HRMEmp.Find('-') then begin
            ActiveEmployee := 0;
            repeat
                ActiveEmployee := ActiveEmployee + 1
            until HRMEmp.Next() = 0

        end;
        HRMEmp.Reset();
        HRMEmp.SetRange(Status, HRMEmp.Status::Inactive);
        //HRMEmp.SetRange("Employee Category", 'FULL TIME');
        if HRMEmp.Find('-') then begin
            InactiveEmployee := 0;
            repeat
                InactiveEmployee := ActiveEmployee + 1
            until HRMEmp.Next() = 0

        end;
        HRMEmp.Reset();
        HRMEmp.SetRange(Gender, HRMEmp.Gender::Female);
        HRMEmp.SetRange(Gender, FemaleEmployees);
        if HRMEmp.Find('-') then begin
            ActiveEmployee := 0;
            repeat
                ActiveEmployee := ActiveEmployee + 1
            until HRMEmp.Next() = 0
        end;

        HRMEmp.Reset();
        HRMEmp.SetRange(Gender, HRMEmp.Gender::Male);
        HRMEmp.SetRange(Gender, MaleEmployees);
        if HRMEmp.Find('-') then begin
            ActiveEmployee := 0;
            repeat
                ActiveEmployee := ActiveEmployee + 1
            until HRMEmp.Next() = 0
        end;




    end;


    var
        CI: Record 79;
        EmployeeCaptionLbl: Label 'Employee';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Employee_ListCaptionLbl: Label 'Employee List';
        P_O__BoxCaptionLbl: Label 'P.O. Box';
        Full_NamesCaptionLbl: Label 'Full Names';
        HrDates: Codeunit "HR Dates";
        LenghtOfServices: Text[100];
        Age: Text[100];
        ActiveEmployee: Integer;
        InactiveEmployee: Integer;
        FemaleEmployees: Integer;
        MaleEmployees: Integer;
        AllEmployees: Integer;

        EmployeeCountPerDept: Integer;

        DimValue: Record "Dimension Value";

        HRMEmp: Record "HRM-Employee (D)";
}

