page 68919 "PRL-Payroll Role Center"
{
    Caption = ' Payroll Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control1900724808)
            {
                ShowCaption = false;
                part(Control1902899408; "PRL-Emp. Cue (Payroll)")
                {
                }
            }
            group(Control1900724708)
            {
                ShowCaption = false;
                part(Control1907692008; "My Customers")
                {
                }
                part(Control1905989608; "My Items")
                {
                }
                part(Control1; "My Job Queue")
                {
                    Visible = false;
                }
                systempart(Control1901377608; MyNotes)
                {
                }
            }
        }
    }

    actions
    {

        area(reporting)
        {

           
            group(PayRepts2)
            {
                Caption = 'Monthly Payroll Reports';
                Image = ResourcePlanning;
                action("Individual Payslip")
                {
                    ApplicationArea = all;
                    Caption = 'Individual Payslip';
                    Image = Report2;
                   
                    
                    RunObject = Report "Individual Payslips V.1.1.3";
                }
                action("Individual Payslip 2")
                {
                    Visible = false;
                    ApplicationArea = all;
                    Caption = 'Individual Payslip 2';
                    Image = Report2;
                   
                    
                    RunObject = Report "Individual Payslips mst";
                }
                action("Detailed Payroll Summary")
                {
                    ApplicationArea = all;
                    Caption = 'Detailed Payroll Summary';
                    Image = Report2;
                   
                    
                    RunObject = Report "Payroll Summary 3";
                }

                action("Departmental Summary")
                {
                    Visible = false;
                    ApplicationArea = all;
                    Caption = 'Departmental Summary';
                    Image = "Report";
                   
                    
                    //RunObject = Report "Payroll Summary (Depts)";
                }

                action(Action1000000047)
                {
                    ApplicationArea = all;
                    Caption = 'Company Payslip';
                    Image = "Report";
                   
                    RunObject = Report "PRL-Company Payroll Summary 3";
                }
                /*  action("Company Payslip")
                 {
                     ApplicationArea = all;
                     Caption = 'Company Payslip 2';
                     Image = "Report";
                    
                     RunObject = Report "PRL-Company Payslip";
                 } */
                action(Action1000000040)
                {
                    ApplicationArea = all;
                    Caption = 'Gross Netpay';
                    Image = Giro;
                    RunObject = Report prGrossNetPay;
                }

                action("Bank Schedule")
                {
                    ApplicationArea = all;
                    Caption = 'Bank Schedule';
                    Image = "Report";
                   
                    RunObject = Report "PRL-Bank Schedule";
                }
                action("NHIF Report")
                {
                    ApplicationArea = all;
                    Caption = 'NHIF Report';
                    Image = "Report";
                   
                    RunObject = Report "PRL-NHIF Report";
                }
                action("HELB Report")
                {
                    ApplicationArea = all;
                    Caption = 'HELB Report';
                    Image = "Report";
                   
                    
                    RunObject = Report "PRL-HELB Report";
                }
                action("SACCO Report")
                {
                    ApplicationArea = all;
                    Caption = 'SACCO Report';
                    Image = "Report";
                   
                    RunObject = Report "PRL-Welfare Report";
                }

                action("NSSF Report (A)")
                {
                    ApplicationArea = all;
                    Caption = 'NSSF Report (A)';
                    Image = "Report";
                   
                    RunObject = Report "PRL-NSSF Report (A)";
                }
                action("NSSF Report (B)")
                {Visible = false;
                    ApplicationArea = all;
                    Caption = 'NSSF Report (B)';
                    Image = "Report";
                   
                    RunObject = Report "PRL-NSSF Report (B)";
                }
                action("NSSF Report (Combined)")
                {
                    ApplicationArea = all;
                    Caption = 'NSSF Report (Combined)';
                    Image = "Report";
                   
                    RunObject = Report "PRL-NSSF Report Combined";
                }

            }
            group(PayrollTransactions)
            {
                Caption = 'Payroll Transactions Report';
                action(Action1000000044)
                {
                    ApplicationArea = all;
                    Caption = 'Earnings Summary';
                    Image = DepositSlip;
                    RunObject = Report "PRL-Earnings Summary 5";
                }
                action(Action1000000042)
                {
                    ApplicationArea = all;
                    Caption = 'Earnings Summary 2';
                    Image = "Report";
                   
                    RunObject = Report "PRL-Payments Summary 2 a";
                }
                action(Action1000000043)
                {
                    ApplicationArea = all;
                    Caption = 'Deductions Summary 2';
                    Image = "Report";
                   
                    RunObject = Report "PRL-Deductions Summary 2 a";
                }
                action(Action1000000045)
                {
                    ApplicationArea = all;
                    Caption = 'Deductions Summary';
                    Image = Report;
                    RunObject = Report "PRL-Deductions Summary1";
                }
                action(Action1000000041)
                {
                    Visible = false;
                    ApplicationArea = all;
                    Caption = 'Staff pension';
                    Image = Aging;
                    //RunObject = Report "prStaff Pension Contrib";
                }
                action(Action1000000037)
                {
                    ApplicationArea = all;
                    Caption = 'Transactions';
                    Image = "Report";
                   
                    RunObject = Report "pr Transactions";
                }
            }
            group(PayrollPeoro)
            {
                Caption = 'Company Payroll Reports';
                Image = RegisteredDocs;
                action(Action1000000038)
                {
                    ApplicationArea = all;
                    Caption = 'P9 Report';
                    Image = PrintForm;
                   
                    
                    RunObject = Report "P9 Report (Final)";
                }


                action("Employer Certificate")
                {

                    Caption = 'Employer Certificate';
                    Image = "Report";
                   
                    
                    //RunObject = Report "Employer Certificate P.10 mst";
                }
                action("P.10")
                {
                    ApplicationArea = all;
                    Caption = 'P.10';
                    Image = "Report";
                   
                    //RunObject = Report "P.10 A mst";
                }

                action(Action1000000028)
                {

                    Caption = 'Co_op Remittance';
                    Image = CreateForm;
                    RunObject = Report "prCoop remmitance";
                }

                action("mass update Transactions")
                {
                    ApplicationArea = all;
                    Caption = 'mass update Transactions';
                    Image = PostBatch;
                   
                    //RunObject = Report "Mass Update Transactions";
                }
                action("Pension Report")
                {
                    ApplicationArea = all;
                    Caption = 'Pension Report';
                    Image = PrintForm;
                   
                    
                    //RunObject = Report "PRL-Pension Report";
                }



            }
            group(prlComparision)
            {
                action(CumAll)
                {
                    ApplicationArea = all;
                    Caption = 'Cummulative Allowances';
                    Image = Aging;
                    //RunObject = Report "PRL-Cummulative Allowances";
                }
                action(cumDed)
                {
                    ApplicationArea = all;
                    Caption = 'Cummulative Allowances';
                    Image = Aging;
                    //RunObject = Report "PRL-Cummulative Deductions";
                }
                action(payrollvar)
                {
                    ApplicationArea = all;
                    Caption = 'Payroll Summary variance';
                    Image = Aging;
                    //RunObject = Report "PR Payroll Summary - Variance";
                }
                action(payrollvariace)
                {
                    ApplicationArea = all;
                    Caption = 'Payroll variance';
                    Image = Aging;
                    //RunObject = Report "PRL-Payroll Variance Report2";
                }
                action(payrollvar2)
                {
                    ApplicationArea = all;
                    Caption = 'Payroll Variance 2';
                    Image = Aging;
                    //RunObject = Report "Payroll Variance Report";
                }
                action(DetPayVar)
                {
                    ApplicationArea = all;
                    Caption = 'Details Payroll Variance';
                    Image = Aging;
                    //RunObject = Report "PRL-Detailed Payroll Variance";
                }
                action(DetailedSimplifiedReport)
                {
                    ApplicationArea = all;
                    Caption = 'Detailed Simplified Payroll Report';
                    Image = Aging;
                    //RunObject = Report "PRL Detailed simplified Report";
                }
            }
            group(PayrollJournal)
            {
                Caption = 'Payroll Journal transfer';
                action("Payroll Journal Transfer")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = Report prPayrollJournalTransfer;

                }
            }
        }
        area(sections)
        {
            group(Payroll)
            {
                Caption = 'Payroll';
                Image = SNInfo;
                action("Salary Card")
                {
                    ApplicationArea = all;
                    Caption = 'Salary Card';
                    Image = Employee;
                   
                    RunObject = Page "HRM-Employee-List";
                    //RunPageView = WHERE(Status = FILTER(Active), "Include In Payroll" = filter(true));
                }
                action("Inactive Employees")
                {
                    ApplicationArea = all;
                    Caption = 'Inactive Employees';
                    Image = Employee;
                   
                    RunObject = Page "HRM-Employee-List";
                    //RunPageView = WHERE(Status = FILTER(<> Normal));
                }
                action("Transcation Codes")
                {
                    ApplicationArea = all;
                    Caption = 'Transcation Codes';
                    Image = Setup;
                   
                    RunObject = Page "PRL-Transaction Codes List";
                }
                action("NHIF Setup")
                {
                    ApplicationArea = all;
                    Caption = 'NHIF Setup';
                    Image = SetupLines;
                   
                    RunObject = Page "PRL-NHIF SetUp";
                }
                action("Payroll Mass Changes")
                {
                    Caption = 'Payroll Mass Changes';
                    Image = AddAction;
                   
                    RunObject = Page "HRM-Import Emp. Trans Buff";
                }

            }

            group(Casual)
            {
                Caption = 'Casual Payroll';
                Image = Payroll;
                action(CasualEmpList)
                {
                    Caption = 'Casual Employee List';
                    Image = CustomerList;
                    RunObject = Page "HRM-Casual Pay List";
                }
                action(CasualWorkDays)
                {
                    Caption = 'Casual Worked Days';
                    Image = Workdays;
                    RunObject = Page "PRL-Casual Worked Days";
                }
                action(CasualPayrollPeriods)
                {
                    Caption = 'Casual Payroll Periods';
                    Image = PaymentPeriod;
                    RunObject = Page "PRL-Casual Payroll Periods";
                }

            }
            group("Salary Increaments")
            {
                Caption = 'Salary Increaments';
                Image = Intrastat;
                action("Salary Increament Process")
                {
                    ApplicationArea = all;
                    Caption = 'Salary Increament Process';
                    Image = AddAction;
                   
                    RunObject = Page "HRM-Emp. Categories";
                }
                action("Salary Increament Register")
                {
                    ApplicationArea = all;
                    Caption = 'Salary Increament Register';
                    Image = Register;
                   
                    RunObject = Page "HRM-Salary Increament Register";
                }
                action("Un-Afected Salary Increaments")
                {
                    ApplicationArea = all;
                    Caption = 'Un-Afected Salary Increaments';
                    Image = UndoCategory;
                   
                    RunObject = Page "HRM-Unaffected Sal. Increament";
                }
                action("Leave Allowance Buffer")
                {
                    ApplicationArea = all;
                    Caption = 'Leave Allowance Buffer';
                    Image = Bins;
                   
                    RunObject = Page "HRM-Leave Allowance Buffer";
                }
            }
            group(ATT)
            {
                Caption = 'Attendance';
                action("Staff Register")
                {

                    Caption = 'Staff Register';
                    RunObject = Page "Staff Reg.Ledger List";
                }
                action("Staff Register History")
                {

                    Caption = 'Staff Register History';
                    RunObject = Page "Staff Ledger History";
                }
                action("Casuals Register")
                {

                    Caption = 'Casuals Register';
                    RunObject = Page "Casuals  Reg.Ledger List";
                }
                action("Casuals History")
                {

                    Caption = 'Casuals History';
                    RunObject = Page "Casuals Ledger History";
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                Image = Alerts;
                action("Pending My Approval")
                {
                    Caption = 'Pending My Approval';
                    RunObject = Page "Approval Entries";
                }
                action("My Approval requests")
                {
                    Caption = 'My Approval requests';
                    RunObject = Page "Approval Request Entries";
                }

            }
            /* group(Common_req)
            {
                Caption = 'Common Requisitions';
                Image = LotInfo;
                action("Stores Requisitions")
                {

                    Caption = 'Stores Requisitions';
                    RunObject = Page "PROC-Store Requisition";
                }
                action("Imprest Requisitions")
                {

                    Caption = 'Imprest Requisitions';
                    RunObject = Page "FIN-Imprest List UP";
                }
                action("Leave Applications")
                {

                    Caption = 'Leave Applications';
                    RunObject = Page "HRM-Leave Requisition List";
                }
                action("My Approved Leaves")
                {

                    Caption = 'My Approved Leaves';
                    Image = History;
                    RunObject = Page "HRM-My Approved Leaves List";
                }
                action("Meal Booking")
                {

                    Caption = 'Meal Booking';
                    RunObject = Page "CAT-Meal Booking List";
                }
            } */
        }
        area(Embedding)
        {
            action("employeeupload")
            {
                Visible = false;
                RunObject = xmlport "Employee Upload";
                Caption = 'Employee Details bulk upload';
                ApplicationArea = all;


            }

            action("salarygrade")
            {
                Visible = false;
                RunObject = xmlport "Salary Grades";
                Caption = 'import salary grades';
                ApplicationArea = all;


            }
        }
        area(creation)
        {
            group(Payroll_Setups)
            {
                Caption = 'Payroll Setups';
                Image = HRSetup;
                action("Payroll Period")
                {
                    ApplicationArea = all;
                    Caption = 'Payroll Period';
                    Image = Period;
                    RunObject = Page "PRL-Payroll Periods";
                }
                action("Pr Rates")
                {
                    ApplicationArea = all;
                    Caption = 'Pr Rates';
                    Image = SetupColumns;
                   
                    RunObject = Page "PRL-Rates & Ceilings";
                }
                action("paye Setup")
                {
                    ApplicationArea = all;
                    Caption = 'paye Setup';
                    Image = SetupPayment;
                   
                    RunObject = Page "PRL-P.A.Y.E Setup";
                }
                action(Action7)
                {
                    ApplicationArea = all;
                    Caption = 'Transcation Codes';
                    Image = Setup;
                   
                    RunObject = Page "PRL-Transaction Codes List";
                }
                action(Action6)
                {
                    ApplicationArea = all;
                    Caption = 'NHIF Setup';
                    Image = SetupLines;
                   
                    RunObject = Page "PRL-NHIF SetUp";
                }
                action("Hr Employee Card")
                {
                    ApplicationArea = all;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //
                    RunObject = Page "HRM-Employee (C)";
                }
                action("Bank Structure")
                {
                    ApplicationArea = all;
                    Caption = 'Bank Structure';
                    Image = Bank;
                   
                    RunObject = Page "PRL-Bank Structure (B)";
                }
                action("control information")
                {
                    ApplicationArea = all;
                    Caption = 'control information';
                    Image = CompanyInformation;
                   
                    RunObject = Page "GEN-Control-Information";
                }
                action("Salary Grades")
                {
                    ApplicationArea = all;
                    Caption = 'Salary Grades';
                    Image = EmployeeAgreement;
                   
                    RunObject = Page "PRL-Salary Grades";
                }
                action("posting group")
                {
                    ApplicationArea = all;
                    Caption = 'posting group';
                    Image = PostingEntries;
                   
                    RunObject = Page "PRL-Employee Posting Group";
                }
                action(Action69)
                {
                    ApplicationArea = all;
                    Caption = 'Salary Increament Process';
                    Image = AddAction;
                   
                    RunObject = Page "HRM-Emp. Categories";
                }
                action(Action68)
                {
                    ApplicationArea = all;
                    Caption = 'Salary Increament Register';
                    Image = Register;
                   
                    RunObject = Page "HRM-Salary Increament Register";
                }
                action(Action66)
                {
                    ApplicationArea = all;
                    Caption = 'Un-Afected Salary Increaments';
                    Image = UndoCategory;
                   
                    RunObject = Page "HRM-Unaffected Sal. Increament";
                }

                action("Staff Welfare Loan Tires")
                {
                    ApplicationArea = all;
                    Caption = 'Staff Welfare Loan Tires';
                    RunObject = Page "HRM Welfare Loan Tiers";
                }
            }

        }
    }
}

