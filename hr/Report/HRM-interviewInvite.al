report 85525 "HRM-InterviewInv"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './hr/Report/SSR/hrmIntrw.rdl';

    dataset
    {
        dataitem(DataItemName; "HRM-Job Applications (B)")
        {
            column(Application_No; "Application No")
            {

            }
            column(Job_Applied_for_Description; "Job Applied for Description")
            {

            }
            column(CompanyInformation; CompanyInformation.Picture)
            {

            }
            column(setUp; setUp."HR Interview")
            {

            }
            column(First_Name; "First Name")
            {

            }
            column(Last_Name; "Last Name")
            {

            }
            column(Middle_Name; "Middle Name")
            {

            }
            column(Interview_venue; "Interview venue")
            {

            }

            column(Interview_date; Format("Interview date"))
            {

            }
            column(Interview_Time; "Interview Time")
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
        setUp: Record "HRM-Setup";
        CompanyInformation: Record 79;

}