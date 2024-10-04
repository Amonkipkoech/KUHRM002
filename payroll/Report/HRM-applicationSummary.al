report 85532 "HRM Applicants Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './payroll/Report/SSR/applicantSuMM.rdl';

    dataset
    {
        dataitem(appLi; "HRM-Job Applications (B)")
        {
            RequestFilterFields = Sifted,"Job Applied For";

            column(JobAppliedforDescription_appLi; "Job Applied for Description")
            {
            }
            column(FirstName_appLi; "First Name")
            {
            }
            column(MiddleName_appLi; "Middle Name")
            {
            }
            column(LastName_appLi; "Last Name")
            {
            }
            column(DateOfBirth_appLi; "Date Of Birth")
            {
            }
            column(Citizenship_appLi; Citizenship)
            {
            }
            column(IDNumber_appLi; "ID Number")
            {
            }
            column(PassportNumber_appLi; "Passport Number")
            {
            }
            column(CellPhoneNumber_appLi; "Cell Phone Number")
            {
            }
            column(EMail_appLi; "E-Mail")
            {
            }
            column(Religion_appLi; Religion)
            {
            }
            column(Denomination_appLi; Denomination)
            {
            }
            column(MaritalStatus_appLi; "Marital Status")
            {
            }
            column(info; info.Picture)
            {

            }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {

            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    trigger OnInitReport()
    begin
        info.reset;
        if info.get(info.Picture) then
            Info.CalcFields(Info.Picture);
        info.name := Info.Name;

    end;

    var
        myInt: Integer;
        info: Record "Company Information";
}