report 51330 "Employee Leaves"
{
    DefaultLayout = RDLC;
    RDLCLayout = './hr/Reports/SSR/EmployeeLeaves.rdl';

    dataset
    {
        dataitem(DataItem3372; 61188)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "On Leave", "No.", "Employee Type", "Terms of Service", "Leave Type";
            column(compName; CompanyInformation.Name)
            {
            }
            column(addresses; CompanyInformation.Address + ',' + CompanyInformation."Address 2")
            {
            }
            column(phones; CompanyInformation."Phone No." + '/' + CompanyInformation."Phone No. 2")
            {
            }
            column(emails; CompanyInformation."E-Mail" + '/' + CompanyInformation."Home Page")
            {
            }
            column(pics; CompanyInformation.Picture)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            /*  column(CurrReport_PAGENO; CurrReport.PAGENO)
             {
             } */
            column(USERID; USERID)
            {
            }
            column(Names; "First Name" + ' ' + "Middle Name" + ' ' + "Last Name")
            {
            }
            column(HR_Employee_C__No__; "No.")
            {
            }
            column(StartDate; "Current Leave Start")
            {
            }
            column(Enddates; "Current Leave End")
            {
            }
            column(LeaveType; "Current Leave Type")
            {
            }
            column(currdays; "Current Leave Applied Days")
            {
            }
            column(ReportFilters; ReportFilters)
            {
            }
            column(seq; seq)
            {
            }
            column(LeaveBal; "Leave Balance")
            {
            }
            column(Grade; Grade)
            {
            }
            column(Category; "Library Category")
            {
            }
            column(Status; Status)
            {
            }

            trigger OnAfterGetRecord()
            begin
                seq := seq + 1;
            end;

            trigger OnPreDataItem()
            begin
                CLEAR(ReportFilters);
                ReportFilters := GETFILTERS;
                CLEAR(seq);
            end;
        }
        // dataitem{ entitled; "HRM-Employee Leave Journal"}
        // {

        // }
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

    trigger OnInitReport()
    begin
        CompanyInformation.RESET;
        IF CompanyInformation.FIND('-') THEN CompanyInformation.CALCFIELDS(Picture);
    end;

    trigger OnPreReport()
    begin
        // REPORT.RUN(77711, FALSE, FALSE);
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        CompanyInformation: Record 79;
        ReportFilters: Text[1024];
        seq: Integer;
}

