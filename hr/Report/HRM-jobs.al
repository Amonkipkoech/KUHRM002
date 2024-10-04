report 50944 HRMJobs
{
    DefaultLayout = RDLC;
    RDLCLayout = './hr/Report/SSR/hrmJobs.rdl';
    dataset
    {
        dataitem(jobs; "HRM-Jobs")
        {
            column(JobID_jobs; "Job ID")
            {
            }
            column(JobTitle_jobs; "Job Title")
            {
            }
            column(JobDescription_jobs; "Job Description")
            {
            }
            column(DateCreated_jobs; "Date Created")
            {
            }
            column(PositionReportingto_jobs; "Position Reporting to")
            {
            }
            column(NoofPosts_jobs; "No of Posts")
            {
            }
            column(Occupied_Positions; "Occupied Positions")
            {

            }
            column(VacantPositions_jobs; "Vacant Positions")
            {
            }
            column(pic; CompanyInformation.Picture)
            {

            }
            column(name; CompanyInformation.Name)
            {

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
        if CompanyInformation.Get() then begin
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        end;
    end;


    var

        CompanyInformation: Record "Company Information";

}