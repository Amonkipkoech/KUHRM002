report 51200 "HR Employee Beneficiaries"
{
    DefaultLayout = RDLC;
    RDLCLayout = './hr/Reports/SSR/HREmployeeBeneficiaries.rdlc';
    Caption = 'Employee Beneficiaries';

    dataset
    {
        dataitem(DataItem1000000000; 61188)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", Status;
            column(No_HREmployees; "No.")
            {
            }
            column(FullName_HREmployees; "Full Name")
            {
            }
            column(CI_Name; CI.Name)
            {
            }
            column(CI_Picture; CI.Picture)
            {
            }
            dataitem(DataItem1000000001; 61323)
            {
                DataItemLink = "Employee Code" = FIELD("No.");
                PrintOnlyIfDetail = false;
                column(Relationship_HREmployeeKin; Relationship)
                {
                }
                column(SurName_HREmployeeKin; SurName)
                {
                }
                column(OtherNames_HREmployeeKin; "Other Names")
                {
                }
                column(IDNoPassportNo_HREmployeeKin; "ID No/Passport No")
                {
                }
                column(DateOfBirth_HREmployeeKin; "Date Of Birth")
                {
                }
                column(Occupation_HREmployeeKin; Occupation)
                {
                }
                column(Address_HREmployeeKin; Address)
                {
                }
                column(OfficeTelNo_HREmployeeKin; "Office Tel No")
                {
                }
                column(HomeTelNo_HREmployeeKin; "Home Tel No")
                {
                }
                column(Type_HREmployeeKin; Type)
                {
                }

                /* trigger OnAfterGetRecord()
                begin
                    HRemp.RESET;
                    HRemp.SETRANGE(HRemp."No.", "Employee Code");
                    IF HRemp.FIND('-') THEN
                        CurrReport.SHOWOUTPUT := TRUE;
                end; */
            }
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
        CI.RESET;
        CI.GET();
        CI.CALCFIELDS(CI.Picture);
    end;

    var
        CI: Record 79;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        HRemp: Record 61188;
}

