report 85540 "HRM-JobAdvert"
{
    DefaultLayout = RDLC;
    RDLCLayout = './hr/Report/SSR/hrmJobAdvert.rdl';

    dataset
    {
        dataitem(hrmJobReq; "HRM-Employee Requisitions")
        {
            RequestFilterFields = "Requisition No.";
            column(Requisition_No_; "Requisition No.")
            {

            }
            column(Job_ID; "Job ID")
            {

            }
            column(Job_Description; "Job Description")
            {

            }
            column(Reporting_To_; "Reporting To:")
            {

            }
            column(Position_Description; "Position Description")
            {

            }
            column(CompanyInformation; CompanyInformation.Picture)
            {

            }
            column(Closing_Date; format("Closing Date"))
            {

            }
            dataitem(resp; "HRM-Job Responsiblities (B)")

            {

                DataItemLink = "Job ID" = field("Job ID");


                column(Responsibility_Description; "Responsibility Description")
                {

                }
                column(Minimun_Requirement; "Minimun Requirement")
                {

                }

            }
            dataitem(req; "HRM-Minimun Job Requirements")
            {
                DataItemTableView = SORTING(entry);
                DataItemLink = "Job ID" = field("Job ID");
                column(Minimum_Requirements; "Minimum Requirements")
                {

                }
                




            }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    // field(Name; SourceExpression)
                    // {
                    //     ApplicationArea = All;

                    // }
                }
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
        if CompanyInformation.Get() then begin
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        end;
    end;

    var
        myInt: Integer;
        CompanyInformation: Record "Company Information";

}