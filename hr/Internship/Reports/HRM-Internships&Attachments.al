report 51723 "HRM-Internships&Attachments"
{
    DefaultLayout = RDLC;
    RDLCLayout = './hr/Internship/Reports/SSR/HRMInternshipsAttachments.rdl';

    dataset
    {
        dataitem(intern; "HRM-Internships&Attachments")
        {
            RequestFilterFields = "Ref No";
            column(Name; intern.Name)
            {
            }
            column(Campus; intern.Institution)
            {
            }
            column(Id; intern."ID No")
            {
            }
            column(Ref; intern."Ref No")
            {
            }
            column(Yos; intern."Year Of Study")
            {
            }
            column(DOB; intern."Date of Birth")
            {
            }
            column(Course; intern.Course)
            {
            }
            column(Dept; intern.Department)
            {
            }
            column(Period; intern.Period)
            {
            }
            column(Sdate; FORMAT(intern."Start Date"))
            {
            }
            column(Edate; FORMAT(intern."End Date"))
            {
            }
            column(Speriod; intern."Period Of Service")
            {
            }
            column(Status; intern.Active)
            {
            }
            column(Today; FORMAT(TODAY))
            {
            }
            column(logo; info.Picture)
            {

            }
            column(cname; info.Name)
            {

            }
            column(cname2; info."Name 2")
            {

            }
            column(caddress; info.Address)
            {

            }
            column(caddress2; info."Address 2")
            {

            }
            column(mail; info."E-Mail")
            {

            }
            column(url; info."Home Page")
            {

            }
            column(cphone; info."Phone No.")
            {

            }

            trigger OnPreDataItem()
            begin
                //IF ref.GETFILTER(ref."Ref No")='' THEN ERROR('You must specify the Reference number of the attachee');
                info.get();
                info.CalcFields(Picture);
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

    var
        ref: Record "HRM-Internships&Attachments";
        info: Record "Company Information";
}