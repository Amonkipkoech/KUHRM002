report 51176 "HR Leave Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './hr/Reports/SSR/HRLeaveStatement.rdl';

    dataset
    {
        dataitem(DataItem6075; "HRM-Employee (D)")
        {
            RequestFilterFields = "No.", "Leave Type Filter";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CI_name; CI.Name)
            {
            }
#pragma warning disable AL0667
            column(CurrReport_PAGENO; CurrReport.PAGENO)
#pragma warning restore AL0667
            {
            }
            column(USERID; USERID)
            {
            }
            column(CI_Picture; CI.Picture)
            {
            }
            column(CI_City; CI.City)
            {
            }
            column(CI__Address_2______CI__Post_Code_; CI."Address 2" + ' ' + CI."Post Code")
            {
            }
            column(CI_Address; CI.Address)
            {
            }
            column(HR_Employees__No__; "No.")
            {
            }
            column(HR_Employees__FullName; FullName)
            {
            }
            column(FNames; "First Name" + ' ' + "Middle Name" + ' ' + "Last Name")
            {
            }
            column(HR_Employees__HR_Employees___Leave_Balance_; "Leave Balance")
            {
            }
            column(EmployeeCaption; EmployeeCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Employee_Leave_StatementCaption; Employee_Leave_StatementCaptionLbl)
            {
            }
            column(P_O__BoxCaption; P_O__BoxCaptionLbl)
            {
            }
            column(HR_Employees__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Leave_BalanceCaption; Leave_BalanceCaptionLbl)
            {
            }
            column(Day_s_Caption; Day_s_CaptionLbl)
            {
            }
            column(No; No)
            {
            }
            dataitem(DataItem4961; 61659)
            {
                DataItemLink = "Employee No" = FIELD("No.");
                DataItemTableView = WHERE("Leave Type" = const('AL'));
                column(HR_Leave_Ledger_Entries__Leave_Period_;
                "Leave Period")
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Entry_Type_; "Entry Type")
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Type_; "Leave Type")
                {
                }
                column(HR_Leave_Ledger_Entries__No__of_days_; "No. of Days")
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Posting_Description_; "Transaction Description")
                {
                }
                column(HR_Leave_Ledger_Entries__Posting_Date_; format("Transaction Date"))
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Entry_Type_Caption; FIELDCAPTION("Entry Type"))
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Type_Caption; FIELDCAPTION("Leave Type"))
                {
                }
                column(HR_Leave_Ledger_Entries__No__of_days_Caption; FIELDCAPTION("No. of Days"))
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Posting_Description_Caption; FIELDCAPTION("Transaction Description"))
                {
                }
                column(HR_Leave_Ledger_Entries__Posting_Date_Caption; FIELDCAPTION("Transaction Date"))
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Period_Caption; FIELDCAPTION("Leave Period"))
                {
                }
                column(HR_Leave_Ledger_Entries_Entry_No_; "Entry No.")
                {
                }
                column(HR_Leave_Ledger_Entries_Staff_No_; "Employee No")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    No := No + 1;
                end;

                trigger OnPreDataItem()
                var
                    hrm: Record "HRM-Employee (D)";
                begin
                    //SETFILTER(hrm."Leave Type", GETFILTER(hrm."Leave Type Filter"));
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //"HR Employee c".VALIDATE("HR Employee c"."Allocated Leave Days");
                //LeaveBalance:="HR Employee c"."Leave Balance";
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

    trigger OnPreReport()
    begin
        CI.GET();
        CI.CALCFIELDS(CI.Picture);
    end;

    var
        CI: Record 79;
        LeaveBalance: Decimal;
        EmployeeCaptionLbl: Label 'Employee';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Employee_Leave_StatementCaptionLbl: Label 'Employee Leave Statement';
        P_O__BoxCaptionLbl: Label 'P.O. Box';
        NameCaptionLbl: Label 'Name';
        Leave_BalanceCaptionLbl: Label 'Leave Balance';
        Day_s_CaptionLbl: Label 'Day(s)';
        No: Decimal;
}

