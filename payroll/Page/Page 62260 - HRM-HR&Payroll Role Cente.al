page 62260 "HRM-HR&Payroll Role Cente"
{
    Caption = 'Role Center';
    PageType = RoleCenter;
    UsageCategory = Administration;
    ApplicationArea = All, Basic, Suite, Advance;

    layout
    {
        area(rolecenter)
        {
            group(Control29)
            {
                ShowCaption = false;
                /* part("Employees Cue";"HRM-Employee Cue")
                 {
                     Caption = 'Employees Cue';
                 }
                 */
                systempart(Control27; Outlook)
                {
                    ApplicationArea = All;
                }
            }
            group(Control26)
            {
                ShowCaption = false;
                systempart(Control24; Links)
                {
                    ApplicationArea = All;
                }
                systempart(Control23; MyNotes)
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    actions
    {
        area(Embedding)
        {
            action(timesheet)
            {
                RunObject = page "HRM-Time Register";
                Caption = 'Time Register';
                ApplicationArea = all;
            }
            action(payrol_ldata)
            {
                ApplicationArea = all;
                Caption = 'Payroll data';
                RunObject = Page "PRL-Payroll Raw Data";
            }


        }



        area(reporting)
        {

            group(Reports)
            {
                Visible = false;
                Caption = 'Payroll Reports';
                Image = Payables;
                action(Payslips)
                {
                    ApplicationArea = area;
                    Caption = 'Payslips';
                    Image = "Report";
                    
                    RunObject = Report "Individual Payslips V.1.1.3";
                }
                action("Payroll Summary1")
                {
                    ApplicationArea = all;
                    Caption = 'Departmental Payroll Summary';
                    Image = "Report";
                    
                    RunObject = Report "Detailed Payrol Summary/Dept";
                }
                action("Master Payroll Summary")
                {
                    ApplicationArea = all;
                    Caption = 'Company Payroll Summary';
                    Image = "Report";
                    
                    RunObject = Report "PRL-Company Payroll Summary 3";
                }

                action("Deductions Summary 2")
                {
                    ApplicationArea = all;
                    Caption = 'Deductions Summary 2';
                    Image = "Report";
                    
                    RunObject = Report 51806;
                }
                action("Earnings Summary 2")
                {
                    ApplicationArea = all;
                    Caption = 'Earnings Summary 2';
                    Image = "Report";
                    
                    RunObject = Report "PRL-Payments Summary 2 a";
                }
                action("vew payslip")
                {
                    ApplicationArea = all;
                    Caption = 'vew payslip';
                    Image = "Report";
                    
                    RunObject = Report "Individual Payslips V.1.1.3";
                }
                action("Payroll summary")
                {
                    ApplicationArea = all;
                    Caption = 'Payroll summary';
                    Image = "Report";
                    
                    RunObject = Report "Payroll Summary 2";
                }
                action("Deductions Summary")
                {
                    ApplicationArea = all;
                    Caption = 'Deductions Summary';
                    Image = "Report";
                    
                    RunObject = Report "PRL-Deductions Summary1";
                }
                action("Earnings Summary")
                {
                    ApplicationArea = all;
                    Caption = 'Earnings Summary';
                    Image = "Report";
                    
                    RunObject = Report "PRL-Earnings Summary 5";
                }

                action("Gross Netpay")
                {
                    ApplicationArea = all;
                    Caption = 'Gross Netpay';
                    Image = "Report";
                    RunObject = Report prGrossNetPay;
                }
                action("Third Rule")
                {
                    ApplicationArea = all;
                    Caption = 'Third Rule';
                    Image = "Report";
                    RunObject = Report "A third Rule Report";
                }
                action("P9 Report")
                {
                    ApplicationArea = all;

                    Caption = 'P9 Report';
                    Image = PrintForm;
                    
                    
                    RunObject = Report "P9 Report (Final)";
                }
                action("Co_op Remittance")
                {
                    Caption = 'Co_op Remittance';
                    Image = "Report";
                    ApplicationArea = All;
                    //todo  RunObject = Report "prCoop remmitance";
                }
                action(Transactions)
                {
                    ApplicationArea = all;
                    Caption = 'Transactions';
                    Image = "Report";
                    RunObject = Report "pr Transactions";
                }
                action("bank Schedule")
                {
                    ApplicationArea = all;
                    Caption = 'bank Schedule';
                    Image = "Report";
                    RunObject = Report "pr Bank Schedule";
                }
            }
            group(Reports3)
            {
                Caption = 'HR Reports';
                Image = Payables;
                action("Employee List")
                {
                    ApplicationArea = all;
                    Caption = 'Employee List';
                    Image = "Report";
                    
                    
                    RunObject = Report "HR Employee List";
                }
                action("Employee Beneficiaries")
                {
                    ApplicationArea = all;
                    Caption = 'Employee Beneficiaries';
                    Image = "Report";
                    
                    
                    RunObject = Report "HR Employee Beneficiaries";
                }
                action("Commission Report")
                {
                    ApplicationArea = all;
                    Caption = 'Commission Report';
                    Image = Report2;
                    
                    
                    //RunObject = Report "HRM-Commission For Univ. Rep.";
                }
                action("Leave Balances")
                {
                    ApplicationArea = all;
                    Image = Balance;
                    
                    
                    RunObject = Report "Employee Leaves";
                }
                action("Leave Transactions")
                {
                    ApplicationArea = all;
                    Image = Translation;
                    
                    
                    RunObject = Report "Standard Leave Balance Report";
                }
                action("Leave Statement")
                {
                    ApplicationArea = all;
                    Image = LedgerEntries;
                    
                    
                    RunObject = Report "HR Leave Statement";
                }

                action("Employee CV Sunmmary")
                {
                    ApplicationArea = all;
                    Caption = 'Employee CV Sunmmary';
                    Image = SuggestGrid;
                    
                    
                    RunObject = Report "Employee Details Summary";
                }
            }
        }
        area(Processing)
        {
            group("Data Upload")
            {
                action("employeeupload")
                {
                    RunObject = xmlport "Employee Upload";
                    Caption = 'Employee Details bulk upload';
                    ApplicationArea = all;
                    Image = ImplementRegAbsence;


                }
                action("prltransaction codes")
                {
                    RunObject = xmlport 50022;
                    Caption = 'Transactions Codes';
                    ApplicationArea = all;
                    Image = ImportCodes;


                }
                action("prl employee transaction")
                {
                    RunObject = xmlport 50022;
                    Caption = 'Employee transactions';
                    ApplicationArea = all;
                    Image = ImportCodes;


                }
                action("prl time sheet")
                {
                    RunObject = xmlport "Import TimeSheet";
                    Caption = 'Time Sheet';
                    ApplicationArea = all;
                    Image = ImportCodes;


                }

                action("salarygrade")
                {
                    RunObject = xmlport "Salary Grades";
                    Caption = 'import salary grades';
                    ApplicationArea = all;
                    Image = CashFlow;
                }
            }
        }
        area(sections)
        {
            group(EmployeeMan)
            {
                Caption = 'Employee Manager';
                Image = HumanResources;
                action(Action22)
                {
                    ApplicationArea = all;
                    Caption = 'Employee List';
                    RunObject = Page "HRM-Employee List";
                }
                action("Leave Applications")
                {
                    ApplicationArea = all;
                    Caption = 'Leave Applications';
                    RunObject = Page "HRM-View Leave List";
                }
            }
            group("Payroll Info")
            {
                Visible = false;
                group(PayRollData)
                {


                    Caption = 'Payroll';

                    action("Salary Card")
                    {
                        ApplicationArea = All;
                        Caption = 'Salary Card';
                        Image = Employee;
                        
                        RunObject = Page "HRM-Employee-List";


                    }
                    action("Transcation Codes")
                    {
                        ApplicationArea = All;
                        Caption = 'Transcation Codes';
                        Image = Setup;
                        
                        RunObject = Page "PRL-Transaction Codes List";
                    }
                    action("NHIF Setup")
                    {
                        ApplicationArea = All;
                        Caption = 'NHIF Setup';
                        Image = SetupLines;
                        
                        RunObject = Page "PRL-NHIF SetUp";
                    }
                    action("Payroll Mass Changes")
                    {
                        ApplicationArea = All;
                        Caption = 'Payroll Mass Changes';
                        Image = AddAction;
                        
                        RunObject = Page "HRM-Import Emp. Trans Buff";
                    }
                }
                group(Casuals)
                {

                    Caption = 'Casual Payroll';

                    action("HRM-Casual Pay List")
                    {
                        ApplicationArea = All;
                        Caption = 'Casual Salary Card';
                        Image = Employee;
                        
                        RunObject = Page "HRM-Casual Pay List";
                    }
                    action("PRL-Casual Worked Days ")
                    {
                        ApplicationArea = All;
                        Caption = 'Casuals Worked days';
                        Image = Setup;
                        
                        RunObject = Page "PRL-Casual Worked Days";
                    }
                    action("PRL-Casual Payroll Periods")
                    {
                        ApplicationArea = All;
                        Caption = 'Casuals Payroll Period';
                        Image = SetupLines;
                        
                        RunObject = Page "PRL-Casual Payroll Periods";
                    }

                }
                group(SalInc)
                {
                    Caption = 'Salary Increaments';

                    action("Salary Increament Process")
                    {
                        ApplicationArea = All;
                        Caption = 'Salary Increament Process';
                        Image = AddAction;
                        
                        RunObject = Page "HRM-Emp. Categories";
                    }
                    action("Salary Increament Register")
                    {
                        ApplicationArea = All;
                        Caption = 'Salary Increament Register';
                        Image = Register;
                        
                        RunObject = Page "HRM-Salary Increament Register";
                    }
                    action("Un-Afected Salary Increaments")
                    {
                        ApplicationArea = All;
                        Caption = 'Un-Afected Salary Increaments';
                        Image = UndoCategory;
                        
                        RunObject = Page "HRM-Unaffected Sal. Increament";
                    }
                    action("Leave Allowance Buffer")
                    {
                        ApplicationArea = All;
                        Caption = 'Leave Allowance Buffer';
                        Image = Bins;
                        
                        RunObject = Page "HRM-Leave Allowance Buffer";
                    }
                }
            }
            /* group("Performance Contract")
            {
                Caption = 'Performance Contract';
                Image = Category;
                action(PerformanceContractCorporate)
                {
                    Caption = 'Performance Contract Corporate';
                    Image = AddAction;
                    
                    ApplicationArea = All;
                    RunObject = page "Performance Criterial Line";
                }
                action("Performance Contract HOD's")
                {
                    ApplicationArea = all;
                    Caption = 'Performance Contract HODs';
                    Image = AddAction;
                    
                    RunObject = Page "Performance Criterial Line Cas";
                }
                action("Performance Contract Managers")
                {
                    ApplicationArea = all;
                    Caption = 'Performance Contract Managers';
                    Image = AddAction;
                    
                    RunObject = Page "Criterial Line Cascade 2";
                }
                action("Performance Contract Chief Officers")
                {
                    ApplicationArea = all;
                    Caption = 'Performance Contract Chief Officers';
                    Image = Addaction;
                    
                    RunObject = Page "Criterial Line Cascade 3";
                }
                action("Performance Contract Senior Officers")
                {
                    ApplicationArea = all;
                    Caption = 'Performance Contract Senior Chief Officers';
                    Image = Addaction;
                    
                    RunObject = Page "Criterial Line Cascade 4";
                }
                action("Performance Contract  Officers")
                {
                    ApplicationArea = all;
                    Caption = 'Performance Contract Officers';
                    Image = AddAction;
                    
                    RunObject = Page "Criterial Line Cascade 5";
                }
                action("Contract Setup")
                {
                    ApplicationArea = all;
                    Caption = 'Contract Setup';
                    Image = Category;
                    
                    RunObject = Page "Project Setup";
                }

                Group("Performance Contract Reports")
                {
                    action("Performance_Contract")
                    {
                        ApplicationArea = all;
                        Caption = 'Performance Contract';
                        Image = Report;
                        
                        RunObject = Report "Performance Contract report";
                    }
                    action("Performance_Contract1")
                    {
                        ApplicationArea = all;
                        Caption = 'Performance Contract 1';
                        Image = Report;
                        
                        RunObject = Report "Performance Contract report1";
                    }
                    action("Performance_Contract2")
                    {
                        ApplicationArea = all;
                        Caption = 'Performance Contract 2';
                        Image = Report;
                        
                        RunObject = Report "Performance Contract report2";
                    }
                    action("Performance_Contract3")
                    {
                        ApplicationArea = all;
                        Caption = 'Performance Contract3';
                        Image = Report;
                        
                        RunObject = Report "Performance Contract report3";
                    }
                    action("Performance_Contract4")
                    {
                        ApplicationArea = all;
                        Caption = 'Performance Contract4';
                        Image = Report;
                        
                        RunObject = Report "Performance Contract report4";
                    }
                    action("Performance_Contract5")
                    {
                        ApplicationArea = all;
                        Caption = 'Performance Contract5';
                        Image = Report;
                        
                        RunObject = Report "Performance Contract report5";

                    }
                }
                group(HR_Appraisals)
                {
                    Caption = 'Appraisal Management';
                    Image = Capacities;
                    action(HRAppraisalList)
                    {
                        Caption = 'HR Appraisal List';
                        Image = Category;
                        
                        RunObject = page "Appraisal Appraisee";
                    }

                    action(HRSupervisor)
                    {
                        Caption = 'HR Supervisor Appraisal List';
                        Image = Category;
                        
                        RunObject = page "Appraisal Sup List";
                    }

                    action(HRSHRList)
                    {
                        Caption = 'HR Appraisal List';
                        Image = Category;
                        
                        RunObject = page "Appraisal HRList";
                    }

                    action(HRSClosedAppraisal)
                    {
                        Caption = 'HR Closed Appraisals';
                        Image = Category;
                        
                        RunObject = page "Appraisal  Closed List";
                    }
                }
                group(LeaveMan)
                {
                    Caption = 'Leave Management';
                    Image = Capacities;
                    action(LeaveTypes)
                    {
                        Caption = 'Leave types';
                        Image = Register;
                        
                        ApplicationArea = All;
                        RunObject = page "HRM-Leave Types";
                    }
                    action("Leave Journals")
                    {
                        ApplicationArea = all;
                        Caption = 'Leave Journals';
                        Image = Journals;
                        
                        RunObject = Page "HRM-Emp. Leave Journal Lines";
                    }
                    action("Posted Leave")
                    {
                        ApplicationArea = all;
                        Caption = 'Posted Leave Journal';
                        RunObject = Page "HRM-Posted Leave Journal";
                    }
                    action(Action14)
                    {
                        ApplicationArea = all;
                        Caption = 'Leave Applications';
                        Image = Register;
                        
                        RunObject = Page "HRM-Leave Requisition List";
                    }
                    action("Posted Leaves")
                    {
                        ApplicationArea = all;
                        Caption = 'Posted Leaves';
                        RunObject = Page "HRM-Leave Requisition Posted";
                    }


                    action("Staff Movement Form")
                    {
                        ApplicationArea = all;
                        RunObject = Page "HRM-Back To Office List";
                    }

                }
                group(DisplinaryProcess)
                {
                    Caption = 'Displinary Cases';
                    action(DisplinaryCases)
                    {
                        Caption = 'Displinary Cases List';
                        ApplicationArea = All;
                        Promoted = True;
                        PromotedCategory = Process;
                        RunObject = Page "HRM-Disciplinary Cases New";

                    }

                    action(PendingApproval)
                    {
                        Caption = 'Cases Awaiting Approval';
                        ApplicationArea = All;
                        Promoted = True;
                        PromotedCategory = Process;
                        RunObject = Page "HRM-Disciplinary Cases Pending";

                    }

                    action(UnderInvestigation)
                    {
                        Caption = 'Cases Under Investigation';
                        ApplicationArea = All;
                        Promoted = True;
                        PromotedCategory = Process;
                        RunObject = Page "HRM-Disciplinary Approved";

                    }


                }

                group(JobMan)
                {
                    Caption = 'Jobs Management';
                    Image = ResourcePlanning;
                    action("Jobs List")
                    {
                        ApplicationArea = all;
                        Caption = 'Jobs List';
                        Image = Job;
                        
                        PromotedCategory = Process;
                        
                        RunObject = Page "HRM-Jobs List";
                    }
                }
                group(Recruit)
                {
                    Caption = 'Recruitment Management';
                    action("Employee Requisitions")
                    {
                        ApplicationArea = all;
                        Caption = 'Employee Requisitions';
                        Image = ApplicationWorksheet;
                        
                        
                        RunObject = Page "HRM-Employee Requisitions List";
                    }
                    action("Job Applications List")
                    {
                        ApplicationArea = all;
                        Caption = 'Job Applications List';
                        RunObject = Page "HRM-Job Applications List";
                    }
                    action("Short Listing")
                    {
                        ApplicationArea = all;
                        Caption = 'Short Listing';
                        RunObject = Page "HRM-Shortlisting List";
                    }
                    action("Qualified Job Applicants")
                    {
                        ApplicationArea = all;
                        Caption = 'Qualified Job Applicants';
                        RunObject = Page "HRM-Job Applicants Qualified";
                    }
                    action("Unqualified Applicants")
                    {
                        ApplicationArea = all;
                        Caption = 'Unqualified Applicants';
                        RunObject = Page "HRM-Job Applicants Unqualified";
                    }
                    action("Advertised Jobs")
                    {
                        ApplicationArea = all;
                        Caption = 'Advertised Jobs';
                        RunObject = Page "HRM-Advertised Job List";
                    }
                }
                group(Internship)
                {
                    Caption = 'Internships/Attachment';
                    action(InternshipList)
                    {
                        ApplicationArea = All;
                        Caption = 'Internship List';
                        RunObject = page "HRM-Intern&Attach List";
                    }
                }
                group(train)
                {
                    Caption = 'Training Management';
                    action("Training Applications")
                    {
                        ApplicationArea = All;
                        Caption = 'Training Applications';
                        RunObject = Page "HRM-Training Application List";
                    }
                    action("Training Courses")
                    {
                        ApplicationArea = All;
                        Caption = 'Training Courses';
                        RunObject = Page "HRM-Course List";
                    }
                    action("Training Providers")
                    {
                        ApplicationArea = All;
                        Caption = 'Training Providers';
                        RunObject = Page "HRM-Training Providers List";
                    }
                    action("Training Needs")
                    {
                        ApplicationArea = All;
                        Caption = 'Training Needs';
                        RunObject = Page "HRM-Train Need Analysis List";
                    }
                    action("Back To Office")
                    {
                        ApplicationArea = All;
                        Caption = 'Back To Office';
                        RunObject = Page "HRM-Back To Office List";
                    }
                }
                group(Welfare)
                {
                    Caption = 'Welfare Management';
                    Image = Capacities;
                    action("Company Activity")
                    {
                        ApplicationArea = All;
                        Caption = 'Company Activity';
                        RunObject = Page "HRM-Company Activities List";
                    }
                }
                group(setups)
                {
                    Caption = 'Setups';

                    action("Institutions List")
                    {
                        ApplicationArea = All;
                        Caption = 'Institutions List';
                        Image = Line;
                        
                        RunObject = Page "HRM-Institutions List";
                    }
                    action("Base Calendar")
                    {
                        ApplicationArea = All;
                        Caption = 'Base Calendar';
                        RunObject = Page "Base Calendar List";
                    }
                    action("Hr Setups")
                    {
                        ApplicationArea = All;
                        Caption = 'Hr Setups';
                        RunObject = Page "HRM-SetUp List";
                    }
                    action(Committees)
                    {
                        ApplicationArea = All;
                        Caption = 'Committees';
                        RunObject = Page "HRM-Committees";
                    }
                    action("Look Up Values")
                    {
                        ApplicationArea = All;
                        Caption = 'Look Up Values';
                        RunObject = Page "HRM-Lookup Values List";
                    }
                    action("Hr Calendar")
                    {
                        ApplicationArea = All;
                        Caption = 'Hr Calendar';
                        RunObject = Page "Base Calendar List";
                    }
                    action(" Email Parameters List")
                    {
                        ApplicationArea = All;
                        Caption = ' Email Parameters List';
                        // RunObject = Page "HRM-Email Parameters List";
                    }
                    action("No.Series")
                    {
                        ApplicationArea = All;
                        Caption = 'No.Series';
                        RunObject = Page "No. Series";
                    }
                    group(Functions)
                    {
                        Caption = 'import data';

                        action("salary grade")
                        {
                            RunObject = xmlport "Salary Grades";
                            Caption = 'import employees';
                            ApplicationArea = all;

                        }
                        action("job")
                        {
                            RunObject = xmlport "Employee Upload";
                            Caption = 'Import Employee job';
                            ApplicationArea = all;

                        }

                    }
                }
                group(pension)
                {
                    Caption = 'Pension Management';
                    Image = History;
                    action(Action40)
                    {
                        ApplicationArea = All;
                        Caption = 'Employee Beneficiaries';
                        RunObject = Page "HRM-Emp. Beneficiaries List";
                    }
                    action("Pension Payments List")
                    {
                        ApplicationArea = All;
                        Caption = 'Pension Payments List';
                        RunObject = Page "HRM-Pension Payments List";
                    }
                }
                group(exitInterview)
                {
                    Caption = 'Exit Interviews';
                    Image = Alerts;
                    action(" Exit Interview")
                    {
                        ApplicationArea = All;
                        Caption = ' Exit Interview';
                        RunObject = Page "HRM-Exit Interview List";
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
                    action("Clearance Requests")
                    {

                        Caption = 'Clearance Requests';
                        // RunObject = Page "ACA-Clearance Approval Entries";
                    }
                }
                group(Common_req)
                {
                    Caption = 'Common Requisitions';
                    action("Stores Requisitions")
                    {

                        Caption = 'Stores Requisitions';
                        // RunObject = Page "PROC-Store Requisition";
                    }
                    action("Imprest Requisitions")
                    {
                        Caption = 'Imprest Requisitions';
                        ApplicationArea = All;
                        //  RunObject = Page "FIN-Imprest List UP";
                    }
                    action(Action1000000003)
                    {
                        ApplicationArea = All;
                        Caption = 'Leave Applications';
                        RunObject = Page "HRM-Leave Requisition List";
                    }
                    action("My Approved Leaves")
                    {
                        ApplicationArea = All;
                        Caption = 'My Approved Leaves';
                        Image = History;
                        RunObject = Page "HRM-My Approved Leaves List";
                    }
                    action("Meal Booking")
                    {
                        Caption = 'Meal Booking';
                        //  RunObject = Page "CAT-Meal Booking List";
                    }
                }
            } */
        }
        area(creation)
        {
            action("Change Password")
            {
                ApplicationArea = All;
                Caption = 'Change Password';
                Image = ChangeStatus;
                
                
                
                //  RunObject = Page "Change Password";
            }
            group(Payroll_Setups)
            {
                Visible = false;
                Caption = 'Payroll Setups';
                Image = HRSetup;
                action("Payroll Period")
                {
                    ApplicationArea = All;
                    Caption = 'Payroll Period';
                    Image = Period;
                    RunObject = Page "PRL-Payroll Periods";
                }
                action("Pr Rates")
                {
                    ApplicationArea = All;
                    Caption = 'Payroll  Rates';
                    Image = SetupColumns;
                    
                    RunObject = Page "PRL-Rates & Ceilings";
                }
                action("paye Setup")
                {
                    ApplicationArea = All;
                    Caption = 'PAYE Setup';
                    Image = SetupPayment;
                    
                    RunObject = Page "PRL-P.A.Y.E Setup";
                }
                action(Action1000000046)
                {
                    ApplicationArea = All;
                    Caption = 'NHIF Setup';
                    Image = SetupLines;
                    
                    RunObject = Page "PRL-NHIF SetUp";
                }
                action(nssf)
                {
                    ApplicationArea = All;
                    Caption = 'NSSF Setup';
                    Image = Allocations;
                    
                    RunObject = Page "prNSSF Tiers List";
                }
                action(Action1000000047)
                {
                    ApplicationArea = All;
                    Caption = 'Transcation Codes';
                    Image = Setup;
                    
                    RunObject = Page "PRL-Transaction Codes List";
                }

                action("Hr Employee Card")
                {
                    ApplicationArea = All;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    // 
                    Image = Info;
                    RunObject = Page "HRM-Employee (C)";
                }
                action("Bank Structure")
                {
                    ApplicationArea = All;
                    Caption = 'Bank Structure';
                    Image = Bank;
                    
                    RunObject = Page "PRL-Bank Structure (B)";
                }
                action("control information")
                {
                    ApplicationArea = All;
                    Caption = 'control information';
                    Image = CompanyInformation;
                    
                    RunObject = Page "GEN-Control-Information";
                }
                action("Salary Grades")
                {
                    ApplicationArea = All;
                    Caption = 'Salary Grades';
                    Image = EmployeeAgreement;
                    
                    RunObject = Page "PRL-Salary Grades";
                }
                action("posting group")
                {
                    ApplicationArea = All;
                    Caption = 'posting group';
                    Image = PostingEntries;
                    
                    RunObject = Page "PRL-Employee Posting Group";
                }
                action(Action1000000040)
                {
                    ApplicationArea = All;
                    Caption = 'Employee Categories';
                    Image = AddAction;
                    
                    RunObject = Page "HRM-Emp. Categories";
                }
                action(Action1000000039)
                {
                    ApplicationArea = All;
                    Caption = 'Salary Increament Register';
                    Image = Register;
                    
                    RunObject = Page "HRM-Salary Increament Register";
                }
                action(Action1000000038)
                {
                    ApplicationArea = All;
                    Caption = 'Un-Afected Salary Increaments';
                    Image = UndoCategory;
                    
                    RunObject = Page "HRM-Unaffected Sal. Increament";
                }
                action(Action1000000037)
                {
                    ApplicationArea = All;
                    Caption = ' payment Vouchers';
                    // RunObject = Page "FIN-Payment Vouchers";
                }
            }
            group("Payroll Reports")
            {
                Visible = false;
                Caption = 'Payroll Reports';
                Image = ResourcePlanning;
                action(Action1000000035)
                {
                    ApplicationArea = All;
                    Caption = 'vew payslip';
                    Image = "Report";
                    
                    RunObject = Report "Individual Payslips V.1.1.3";
                }
                action(Action1000000034)
                {
                    ApplicationArea = All;
                    Caption = 'Master Payroll Summary';
                    Image = "Report";
                    
                    RunObject = Report "PRL-Company Payroll Summary 3";
                }
                action(Action1000000033)
                {
                    ApplicationArea = All;
                    Caption = 'Detailed Payroll Summary';
                    Image = Report;
                    RunObject = Report "Detailed Payrol Summary/Dept";
                }
                action(Action1000000032)
                {
                    ApplicationArea = All;
                    Caption = 'Deductions Summary';
                    Image = Report;
                    //  RunObject = Report "PRL-Deductions Summary";
                }
                action(Action1000000031)
                {
                    ApplicationArea = All;
                    Caption = 'Earnings Summary';
                    Image = DepositSlip;
                    //  RunObject = Report "PRL-Earnings Summary";
                }
                action(Action1000000030)
                {
                    ApplicationArea = All;
                    Caption = 'Deductions Summary 2';
                    Image = "Report";
                    
                    //  RunObject = Report "PRL-Deductions Summary 2";
                }
                action(Action1000000029)
                {
                    ApplicationArea = All;
                    Caption = 'Earnings Summary 2';
                    Image = "Report";
                    
                    //   RunObject = Report "PRL-Payments Summary 2";
                }
                action(Action1000000028)
                {
                    ApplicationArea = All;
                    Caption = 'Staff pension';
                    Image = Aging;
                    //  RunObject = Report "prStaff Pension Contrib";
                }
                action(Action1000000027)
                {
                    ApplicationArea = All;
                    Caption = 'Gross Netpay';
                    Image = Giro;
                    // RunObject = Report prGrossNetPay;
                }
            }
            group(PayrollPeoro)
            {
                Visible = false;
                Caption = 'Periodic Reports';
                Image = RegisteredDocs;
                action(Action1000000025)
                {
                    ApplicationArea = All;
                    Caption = 'P9 Report';
                    Image = PrintForm;
                    
                    
                    // RunObject = Report "P9 Report (Final)";
                }
                action(Action1000000024)
                {
                    ApplicationArea = All;
                    Caption = 'Transactions';
                    Image = "Report";
                    
                    // RunObject = Report "pr Transactions";
                }
                action(Action1000000023)
                {
                    ApplicationArea = All;
                    Caption = 'bank Schedule';
                    Image = "Report";
                    
                    // RunObject = Report "pr Bank Schedule";
                }
                action("Employer Certificate")
                {
                    ApplicationArea = All;
                    Caption = 'Employer Certificate';
                    Image = "Report";
                    
                    
                    //  RunObject = Report "Employer Certificate P.10 mst";
                }
                action("P.10")
                {
                    ApplicationArea = All;
                    Caption = 'P.10';
                    Image = "Report";
                    
                    //  RunObject = Report "P.10 A mst";
                }
                action("Paye Scheule")
                {
                    ApplicationArea = All;
                    Caption = 'Paye Scheule';
                    Image = "Report";
                    
                    //  RunObject = Report "prPaye Schedule mst";
                }
                action("NHIF Schedult")
                {
                    ApplicationArea = All;
                    Caption = 'NHIF Schedult';
                    Image = "Report";
                    
                    //   RunObject = Report "prNHIF mst";
                }
                action("NSSF Schedule")
                {
                    ApplicationArea = All;
                    Caption = 'NSSF Schedule';
                    Image = "Report";
                    
                    //  RunObject = Report "prNSSF mst";
                }
                action(Action1000000017)
                {
                    ApplicationArea = All;
                    Caption = 'Third Rule';
                    Image = AddWatch;
                    //  RunObject = Report "A third Rule Report";
                }
                action(Action1000000016)
                {
                    ApplicationArea = All;
                    Caption = 'Co_op Remittance';
                    Image = CreateForm;
                    //  RunObject = Report "prCoop remmitance";
                }
                action("payroll Journal Transfer")
                {
                    ApplicationArea = All;
                    Caption = 'payroll Journal Transfer';
                    Image = Journals;
                    
                    //  RunObject = Report prPayrollJournalTransfer;
                }
            }
            action("mass update Transactions")
            {
                ApplicationArea = All;
                Caption = 'mass update Transactions';
                Image = PostBatch;
                
                // RunObject = Report "Mass Update Transactions";
            }
        }
    }
}

