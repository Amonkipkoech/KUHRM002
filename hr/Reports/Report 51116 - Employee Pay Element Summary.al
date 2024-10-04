report 51116 "Employee Pay Element Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './hr/Report/SSR/Employee Pay Element Summary.rdlc';

    dataset
    {
        dataitem("HRM-Employee (D)"; "HRM-Employee (D)")
        {
            RequestFilterFields = "No.";
            column(HR_Employee_No_; "No.")
            {
            }
            dataitem("PRL-Period Transactions"; "PRL-Period Transactions")
            {
                DataItemLink = "Employee Code" = FIELD("No.");
                DataItemTableView = SORTING("Employee Code", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No");
                column(CompanyInfo_Picture; CompanyInfo.Picture)
                {
                }
                column(USERID; UserId)
                {
                }
                column(TODAY; Today)
                {
                }

                column(prPeriod_Transactions__Employee_Code_; "Employee Code")
                {
                }
                column(Names; Names)
                {
                }
                column(prPeriod_Transactions_Amount; Amount)
                {
                }
                column(prPeriod_Transactions__Transaction_Code_; "Transaction Code")
                {
                }
                column(prPeriod_Transactions__Transaction_Name_; "Transaction Name")
                {
                }
                column(User_Name_Caption; User_Name_CaptionLbl)
                {
                }
                column(Print_Date_Caption; Print_Date_CaptionLbl)
                {
                }
                column(Page_No_Caption; Page_No_CaptionLbl)
                {
                }
                column(Employee_Pay_Elements_to_DateCaption; Employee_Pay_Elements_to_DateCaptionLbl)
                {
                }
                column(AmountCaption; AmountCaptionLbl)
                {
                }
                column(prPeriod_Transactions__Transaction_Name_Caption; FieldCaption("Transaction Name"))
                {
                }
                column(prPeriod_Transactions__Transaction_Code_Caption; FieldCaption("Transaction Code"))
                {
                }
                column(Prepared_by_______________________________________Date_________________Caption; Prepared_by_______________________________________Date_________________CaptionLbl)
                {
                }
                column(Checked_by________________________________________Date_________________Caption; Checked_by________________________________________Date_________________CaptionLbl)
                {
                }
                column(Authorized_by____________________________________Date_________________Caption; Authorized_by____________________________________Date_________________CaptionLbl)
                {
                }
                column(Approved_by______________________________________Date_________________Caption; Approved_by______________________________________Date_________________CaptionLbl)
                {
                }
                column(prPeriod_Transactions_Period_Month; "Period Month")
                {
                }
                column(prPeriod_Transactions_Period_Year; "Period Year")
                {
                }
                column(prPeriod_Transactions_Membership; Membership)
                {
                }
                column(prPeriod_Transactions_Reference_No; "Reference No")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if ("PRL-Period Transactions"."Group Order" = 8) and ("PRL-Period Transactions"."Sub Group Order" = 9) then
                        CurrReport.Skip;
                    if "PRL-Period Transactions"."Group Order" = 6 then
                        CurrReport.Skip;

                    if ("PRL-Period Transactions"."Group Order" = 4) then
                        CurrReport.Skip;
                end;

                trigger OnPreDataItem()
                begin
                    LastFieldNo := FieldNo("Transaction Code");
                    if CompanyInfo.Get() then
                        CompanyInfo.CalcFields(CompanyInfo.Picture);
                end;
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

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label 'Total for ';
        CompanyInfo: Record "Company Information";
        HrEmp: Record "HRM-Employee (D)";
        Names: Text[250];
        User_Name_CaptionLbl: Label 'User Name:';
        Print_Date_CaptionLbl: Label 'Print Date:';
        Page_No_CaptionLbl: Label 'Page No:';
        Employee_Pay_Elements_to_DateCaptionLbl: Label 'Employee Pay Elements to Date';
        AmountCaptionLbl: Label 'Amount';
        Prepared_by_______________________________________Date_________________CaptionLbl: Label 'Prepared byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                 DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Checked_by________________________________________Date_________________CaptionLbl: Label 'Checked byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                   DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Authorized_by____________________________________Date_________________CaptionLbl: Label 'Authorized byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..              DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Approved_by______________________________________Date_________________CaptionLbl: Label 'Approved byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
}

