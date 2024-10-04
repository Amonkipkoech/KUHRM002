report 85529 "HRM Interview Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './payroll/Report/SSR/interviewSumm.rdl';

    dataset
    {
        dataitem(interView; "HRM-Job Applications (B)")
        {

            DataItemTableView = SORTING("Interview Marks")
                                ORDER(descending);
            RequestFilterFields ="Employee Requisition No", "Interview Status";

            column(JobAppliedforDescription_interView; "Job Applied for Description")
            {
            }
            column(FirstName_interView; "First Name")
            {
            }
            column(LastName_interView; "Last Name")
            {
            }
            column(MiddleName_interView; "Middle Name")
            {
            }
            column(DateOfBirth_interView; "Date Of Birth")
            {
            }
            column(Citizenship_interView; Citizenship)
            {
            }
            column(IDNumber_interView; "ID Number")
            {
            }
            column(PassportNumber_interView; "Passport Number")
            {
            }
            column(CellPhoneNumber_interView; "Cell Phone Number")
            {
            }
            column(EMail_interView; "E-Mail")
            {
            }
            column(Religion_interView; Religion)
            {
            }
            column(Denomination_interView; Denomination)
            {
            }
            column(MaritalStatus_interView; "Marital Status")
            {
            }
            column(Interview_Marks; "Interview Marks")
            {

            }
            column(CompanyInformation; CompanyInformation.Picture)
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

            }
        }
    }
    trigger OnInitReport()
    begin
        CompanyInformation.RESET;
        IF CompanyInformation.FIND('-') THEN BEGIN
            CompanyInformation.CALCFIELDS(Picture);
        END;
    end;

    var
        myInt: Integer;
        CompanyInformation: Record 79;
}