report 85524 "HRM-Offer letter"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './hr/Report/SSR/hrmOffer.rdl';

    dataset
    {
        dataitem(jobApplic; "HRM-Job Applications (B)")
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
            column(dateOfIntev; Format("Interview date"))
            {

            }
            column(IntervDate; IntervDate)
            {

            }
            trigger OnAfterGetRecord()
            begin
                hrApplic.Reset();
                hrApplic.SetRange("Application No", jobApplic."Application No");
                if hrApplic.Find('-') then begin
                    IntervDate := Format(hrApplic."Interview date", 0, 4);
                end;
            end;
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
        hrApplic: Record "HRM-Job Applications (B)";
        IntervDate: Text;

}