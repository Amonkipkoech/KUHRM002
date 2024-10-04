page 69042 "HRM-Role Centre"
{
    Caption = 'HRM-Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control29)
            {
                ShowCaption = false;
                /*tdodo part("Employees Cue";"HRM-Employee Cue")
                 {
                     Caption = 'Employees Cue';
                 }
                 todo*/
                systempart(Control27; Outlook)
                {
                }
            }
            group(Control26)
            {
                ShowCaption = false;

                systempart(Control24; Links)
                {
                }
                systempart(Control23; MyNotes)
                {
                }
            }
        }
    }

    actions
    {
        area(Creation)
        {
            action(HRMJobs)
            {
                ApplicationArea = all;
                Caption = 'Jobs List';
                Image = Job;
               
                RunObject = Page "HRM-Jobs List";

            }

            action(HRMemployee)
            {
                ApplicationArea = all;
                Caption = 'Employee List';
                RunObject = Page "HRM-Employee List";
            }
            action(HRMEmployees)
            {
                ApplicationArea = all;
                Caption = 'Inactive Employee List';
                Image = Job;
               
                RunObject = Page "HRM-Employee-List (Inactive)";

            }
            action(LeaveJournal)
            {
                ApplicationArea = all;
                Caption = 'Leave Journals';
                Image = Journals;
               
                ToolTip = 'Allocate and Post leave days for Employees';
                RunObject = Page "HRM-Emp. Leave Journal Lines";

            }
            action(HRMLeaves)
            {
                ApplicationArea = all;
                Caption = 'Leave Applications';
                RunObject = Page 68107;
            }
            action(HRMLeavesApplies)
            {
                ApplicationArea = all;
                Caption = 'View Leave Applications';
                RunObject = Page "HRM-View Leave List";
            }
            action(HRMPostedLeaves)
            {
                ApplicationArea = all;
                Caption = 'Posted Leave';
                RunObject = Page "HRM-Leave Requisition Posted";
            }
        }

        area(Reporting)
        {
            group(HRMReport)
            {
                Caption = 'Employee Reports';
                ToolTip = 'Get Reports Related to Employee Manager';
                action(EmployeeList)
                {
                    ApplicationArea = all;
                    Caption = 'Employee List';
                    Image = Employee;
                   
                    
                    RunObject = Report "HR Employee List";
                }
                action(mployeeBeneficiaries)
                {
                    ApplicationArea = all;
                    Caption = 'Employee Beneficiaries';
                    Image = "Report";
                   
                    
                    RunObject = Report "HR Employee Beneficiaries";
                }
                action(EmployeeCVSunmmary)
                {
                    ApplicationArea = all;
                    Caption = 'Employee CV Sunmmary';
                    Image = SuggestGrid;
                   
                    
                    RunObject = Report "Employee Details Summary";
                }
                action(AcademicQualification)
                {
                    ApplicationArea = all;
                    Caption = 'Academic Qualification';
                    Image = SuggestGrid;
                   
                    
                    RunObject = Report "HRMAcademic Qualification";
                }
                action(EmployeeDependants)
                {
                    ApplicationArea = all;
                    Caption = 'Employee Dependents';
                    Image = SuggestGrid;
                   
                    
                    RunObject = Report "HRMEmployee Dependents";
                }
                action(DiscplinaryCases)
                {
                    ApplicationArea = all;
                    Caption = 'Employee Disciplinary';
                    Image = SuggestGrid;
                   
                    
                    RunObject = Report "HRMDisciplinary Cases";
                }

                action(EmployeeMedicalInsuarance)
                {
                    ApplicationArea = all;
                    Caption = 'Employee Medical Insuarance';
                    Image = SuggestGrid;
                   
                    
                    RunObject = Report "HRMEmployee Medical Insuarance";
                }
                action(employeeSeparation)
                {
                    ApplicationArea = all;
                    Caption = 'Employee Separation';
                    Image = SuggestGrid;
                   
                    
                    RunObject = Report "HRMEmployee Separation";
                }
                action(employeeHistory)
                {
                    ApplicationArea = all;
                    Caption = 'Employee History';
                    Image = SuggestGrid;
                   
                    
                    RunObject = Report "HRMEmployment History";
                }
                action(jobGroup)
                {
                    ApplicationArea = all;
                    Caption = 'Job Group';
                    Image = SuggestGrid;
                   
                    
                    RunObject = Report "HRMJob Group";
                }
                action(LeaveSummary)
                {
                    ApplicationArea = all;
                    Caption = 'Leave Summary';
                    Image = SuggestGrid;
                   
                    
                    RunObject = Report "HRMLeave Summary";
                }

                action(ProffesionalQualification)
                {
                    ApplicationArea = all;
                    Caption = 'Proffesional Qualification';
                    Image = SuggestGrid;
                   
                    
                    RunObject = Report "HRMProffesional Qualification";
                }
                action(ResponsibilityContract)
                {
                    ApplicationArea = all;
                    Caption = 'Responsibility Contract';
                    Image = SuggestCustomerPayments;
                   
                    
                    RunObject = Report "HRMResponsibility Contract";
                }
                action(trainingSummary)
                {
                    ApplicationArea = all;
                    Caption = 'Training Summary';
                    Image = SuggestGrid;
                   
                    
                    RunObject = Report "HRMTraining Summary";
                }



            }
            group(LeavReports)
            {
                Caption = 'Employee Leave Report';
                action(LeaveBalances)
                {
                    Caption = 'Employee Leave Balances';
                    ApplicationArea = all;
                    Image = Balance;
                   
                    
                    RunObject = Report "Employee Leaves";
                }
                action(LeaveTransactions)
                {
                    Caption = 'Employee Leave Tansaction';
                    ApplicationArea = all;
                    Image = Translation;
                   
                    
                    RunObject = Report "Standard Leave Balance Report";
                }
                action(LeaveStatement)
                {
                    Caption = 'Employee Leave Statement';
                    ApplicationArea = all;
                    Image = LedgerEntries;
                   
                    
                    RunObject = Report "HR Leave Statement";
                }

            }


            /*  action(CommissionReport)
             {
                 ApplicationArea = all;
                 Caption = 'Commission Report';
                 Image = Report2;
                
                 
                 RunObject = Report "HRM-Commission For Univ. Rep.";
             }
  */


            /* action(Commission_Report)
            {
                ApplicationArea = all;
                Caption = 'Commission Report';
                Image = Report2;
               
                
                ///RunObject = Report "HRM-Commission For Univ. Rep.";
            } */



        }
        area(Embedding)
        {
            action(employeelsting)
            {
                ApplicationArea = all;
                Caption = 'Employee List';
                RunObject = Page "HRM-Employee List";
            }
            action(leaveapplication)
            {
                ApplicationArea = all;
                Caption = 'Leave Applications';
                RunObject = Page "HRM-Leave Requisition List";
            }
            action(payrolldata)
            {
                ApplicationArea = all;
                Caption = 'Payroll data';
                RunObject = Page "PRL-Payroll Raw Data";
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
                action(Casuals)
                {
                    ApplicationArea = all;
                    Caption = 'Casuals';
                    RunObject = Page "HRM-Casuals Lists";
                }
                action(HRMEmployeesInactive)
                {
                    ApplicationArea = all;
                    Caption = 'Inactive Employee List';
                    Image = Job;
                   
                    RunObject = Page "HRM-Employee-List (Inactive)";
                    ToolTip = 'Executes the Inactive Employee List action.';

                }
            }
            group(Payroll)
            {
                Visible = false;
                Caption = 'Payroll';
                Image = SNInfo;
                action("Salary Card")
                {

                    Caption = 'Salary Card';
                    Image = Employee;
                   
                    RunObject = Page "HRM-Employee-List";
                }
                action("Transcation Codes")
                {

                    Caption = 'Transcation Codes';
                    Image = Setup;
                   
                    RunObject = Page "PRL-Transaction Codes List";
                }
                action("NHIF Setup")
                {

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
            group("Salary Increaments")
            {
                Caption = 'Salary Increaments';
                Image = Intrastat;
                Visible = false;
                action("Salary Increament Process")
                {

                    Caption = 'Salary Increament Process';
                    Image = AddAction;
                   
                    RunObject = Page "HRM-Emp. Categories";
                }
                action("Salary Increament Register")
                {

                    Caption = 'Salary Increament Register';
                    Image = Register;
                   
                    RunObject = Page "HRM-Salary Increament Register";
                }
                action("Un-Afected Salary Increaments")
                {

                    Caption = 'Un-Afected Salary Increaments';
                    Image = UndoCategory;
                   
                    RunObject = Page "HRM-Unaffected Sal. Increament";
                }
                action("Leave Allowance Buffer")
                {

                    Caption = 'Leave Allowance Buffer';
                    Image = Bins;
                   
                    RunObject = Page "HRM-Leave Allowance Buffer";
                }
            }

            group(SalaryAdvance)
            {
                Caption = 'Salary Advance';
                Image = Intrastat;
                action("Salary Advance List")
                {

                    Caption = 'Advance List';
                    Image = AddAction;
                   
                    //  RunObject = Page "FIN-Staff Advance List";
                }
                action("Salary Advance Surrender")
                {

                    Caption = 'Advance Surrender';
                    Image = AddAction;
                   
                    // RunObject = Page "FIN-Staff Advance Surr. List";
                }

            }


            group(LeaveMan)
            {
                Caption = 'Leave Management';
                Image = Capacities;
                action(LeaveTypes)
                {
                    ApplicationArea = all;
                    Caption = 'Leave Types';
                    Image = Register;
                   
                    RunObject = Page "HRM-Leave Types";
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
                action("Staff Back To Office")
                {
                    ApplicationArea = all;
                    RunObject = Page "HRM-Return to Office";
                    ToolTip = 'Is filled by staff when they return from leave';
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
                    Caption = 'Posted Leave Journals';
                    RunObject = Page "HRM-Posted Leave Journal";
                }
                /* action("Leave Carry Forward")
                {
                    ApplicationArea = All;
                    Caption = 'Leave Carry Forward';
                    ToolTip = 'Carry forward a maximum of 15 days';
                    //RunObject = page "";

                } */
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
            group(Internships)
            {
                Caption = 'Internships';

                // action("InternshipLst")
                // {
                //     Caption = 'Internship List';
                //     ApplicationArea = All;
                //     //RunObject = Page "HRM-Intern&Attach List";
                //     RunObject = Page "Attachment Applic List";
                // }
                action("InternshipLst2")
                {
                    Caption = 'Internship List';
                    ApplicationArea = All;
                    RunObject = Page "HRM-Intern&Attach List";
                }
            }
            group(Welfare)
            {
                Caption = 'Welfare Management';
                Image = Capacities;
                action("Company Activity")
                {
                    ApplicationArea = all;
                    Caption = 'Company Activity';
                    RunObject = Page "HRM-Company Activities List";
                }
            }
            group(PerformanceAppraisal)
            {
                Caption = 'Performance Appraisal';
                Image = Capacities;
                action("Appraisal Years")
                {
                    ApplicationArea = all;
                    Caption = 'Appraisal Years';
                    RunObject = Page "HRM-Appraisal Years List";
                }
                action("Supervisor Appraisal List")
                {
                    ApplicationArea = all;
                    Caption = 'Supervisor Appraisal List';
                    RunObject = Page "HRM-Appraisal Sup. Emp. List";

                }
                action("Appraisee Self Targets")
                {
                    ApplicationArea = all;
                    Caption = 'Appraisee Self Targets';
                    RunObject = Page "HRM-Appraisee Self Targets";
                }

                action("Appraisal HR List")
                {
                    ApplicationArea = all;
                    Caption = 'Appraisal HR List';
                    RunObject = Page "HRM-Appraisal HR Emp. List";
                }
            }
            group(setus)
            {
                Caption = 'Setups';
                Image = HRSetup;
                action("Institutions List")
                {
                    ApplicationArea = all;
                    Caption = 'Institutions List';
                    Image = Line;
                   
                    RunObject = Page "HRM-Institutions List";
                }
                action(County)
                {
                    ApplicationArea = all;
                    Caption = 'County List';
                    Image = Line;
                   
                    RunObject = Page "County List";
                }
                action("Base Calendar")
                {
                    ApplicationArea = all;
                    Caption = 'Base Calendar';
                    RunObject = Page "Base Calendar List";
                }
                action("HRM Religion")
                {
                    ApplicationArea = all;
                    Caption = 'HRM Religion';
                    RunObject = Page "Religion List";
                }

                action("Hr Setups")
                {
                    ApplicationArea = all;
                    Caption = 'Hr Setups';
                    RunObject = Page "HRM-SetUp List";
                }
                action("Hr Number Series")
                {
                    ApplicationArea = all;
                    Caption = 'Hr Number Series';
                    RunObject = Page "Human Resource Setup";
                }
                action(Committees)
                {
                    ApplicationArea = all;
                    Caption = 'Committees';
                    RunObject = Page "HRM-Committees";
                }
                action("Look Up Values")
                {
                    ApplicationArea = all;
                    Caption = 'Look Up Values';
                    RunObject = Page "HRM-Lookup Values List";
                }
                action("Hr Calendar")
                {
                    ApplicationArea = all;
                    Caption = 'Hr Calendar';
                    RunObject = Page "Base Calendar List";
                }
                action(" Email Parameters List")
                {
                    ApplicationArea = all;
                    Caption = ' Email Parameters List';
                    RunObject = Page "HRM-Email Parameters List";
                }
                action("No.Series")
                {
                    ApplicationArea = all;
                    Caption = 'No.Series';
                    RunObject = Page "No. Series";
                }
                action("Salary Steps")
                {
                    ApplicationArea = all;
                    Caption = 'Salary Steps';
                    RunObject = Page "HRM-Job_Salary Grade/Steps";
                }
            }



            // group(PayrollPeoro)
            // {   //Visible = false;
            //     Caption = 'Periodic Reports';
            //     Image = RegisteredDocs;
            //     action("P9 Report")
            //     {
            //         Caption = 'P9 Report';
            //         Image = PrintForm;
            //        
            //         
            //         RunObject = Report "P9 Report (Final)";
            //     }
            //     action(Transactions)
            //     {
            //         Caption = 'Transactions';
            //         Image = "Report";
            //        
            //         RunObject = Report "pr Transactions";

            //     }
            //     action("Company Payslip")
            //     {
            //         Caption = 'Company Payslip';
            //         Image = "Report";
            //        
            //         RunObject = Report "PRL-Company Payslip";
            //     }
            //     action("bank Schedule2")
            //     {
            //         Caption = 'bank Schedule';
            //         Image = "Report";
            //        

            //         RunObject = Report "pr Bank Schedule";
            //     }
            //     /*  action("Employer Certificate")
            //      {
            //          Caption = 'Employer Certificate';
            //          Image = "Report";
            //         
            //          
            //          //RunObject = Report "Employer Certificate P.10 mst";
            //      }
            //      action("P.10")
            //      {
            //          Caption = 'P.10';
            //          Image = "Report";
            //         
            //          //RunObject = Report "P.10 A mst";
            //      } */
            //     action("Paye Scheule")
            //     {
            //         Caption = 'Paye Scheule';
            //         Image = "Report";
            //        
            //         RunObject = Report "prPaye Schedule mst";
            //     }
            //     /*  action("NHIF Schedult")
            //      {
            //          Caption = 'NHIF Schedule';
            //          Image = "Report";
            //         
            //          //RunObject = Report "prNHIF mst";
            //      } */
            //     action("NSSF Schedule")
            //     {
            //         Caption = 'NSSF Schedule';
            //         Image = "Report";
            //        
            //         RunObject = Report "prNSSF mst";
            //     }
            //     action("Third Rule")
            //     {
            //         Caption = 'Third Rule';
            //         Image = AddWatch;
            //         RunObject = Report "A third Rule Report";
            //     }
            //     action("Co_op Remittance")
            //     {
            //         Caption = 'Co_op Remittance';
            //         Image = CreateForm;
            //         RunObject = Report "prCoop remmitance";
            //     }
            //     action("payroll Journal Transfer")
            //     {
            //         Caption = 'payroll Journal Transfer';
            //         Image = Journals;
            //        
            //         RunObject = Report prPayrollJournalTransfer;
            //     }
            //     action("mass update Transactions")
            //     {
            //         Caption = 'mass update Transactions';
            //         Image = PostBatch;
            //        
            //         //RunObject = Report "Mass Update Transactions";
            //     }
            //     action("Pension Report")
            //     {
            //         Caption = 'Pension Report';
            //         Image = PrintForm;
            //        
            //         
            //         RunObject = Report "PRL-Pension Report";
            //     }
            //     action("Bank Schedule")
            //     {
            //         Caption = 'Bank Schedule';
            //         Image = "Report";
            //        
            //         RunObject = Report "PRL-Bank Schedule";
            //     }
            //     action("NHIF Report")
            //     {
            //         Caption = 'NHIF Report';
            //         Image = "Report";
            //        
            //         RunObject = Report "PRL-NHIF Report";
            //     }
            //     action("SACCO Report")
            //     {
            //         Caption = 'SACCO Report';
            //         Image = "Report";
            //        
            //         RunObject = Report "PRL-Welfare Report";
            //     }
            //     action("HELB Report")
            //     {
            //         Caption = 'HELB Report';
            //         Image = "Report";
            //        
            //         
            //         RunObject = Report "PRL-HELB Report";
            //     }
            //     action("NSSF Report (A)")
            //     {
            //         Caption = 'NSSF Report (A)';
            //         Image = "Report";
            //        
            //         RunObject = Report "PRL-NSSF Report (A)";
            //     }
            //     action("NSSF Report (B)")
            //     {
            //         Caption = 'NSSF Report (B)';
            //         Image = "Report";
            //        
            //         RunObject = Report "PRL-NSSF Report (B)";
            //     }
            //     action("NSSF Report (Combined)")
            //     {
            //         Caption = 'NSSF Report (Combined)';
            //         Image = "Report";
            //        
            //         RunObject = Report "PRL-NSSF Report Combined";
            //     }
            // }



            group(pension)
            {
                Caption = 'Pension Management';
                Image = History;
                action(Action40)
                {
                    ApplicationArea = all;
                    Caption = 'Employee Beneficiaries';
                    RunObject = Page "HRM-Emp. Beneficiaries List";
                }
                action("Pension Payments List")
                {
                    ApplicationArea = all;
                    Caption = 'Pension Payments List';
                    RunObject = Page "HRM-Pension Payments List";
                }
            }
            group(train)
            {
                Caption = 'Training Management';
                action("Training Applications")
                {
                    ApplicationArea = all;
                    Caption = 'Training Applications';
                    RunObject = Page "HRM-Training Application List";
                }
                action("Training Courses")
                {
                    ApplicationArea = all;
                    Caption = 'Training Courses';
                    RunObject = Page "HRM-Course List";
                }
                action("Training Providers")
                {
                    ApplicationArea = all;
                    Caption = 'Training Providers';
                    RunObject = Page "HRM-Training Providers List";
                }
                action("Training Needs")
                {
                    ApplicationArea = all;
                    Caption = 'Training Needs';
                    RunObject = Page "HRM-Train Need Analysis List";
                }
                action("Back To Office")
                {
                    ApplicationArea = all;
                    Caption = 'Back To Office';
                    RunObject = Page "HRM-Back To Office List";
                }
            }
            group(exitInterview)
            {
                Caption = 'Employee Exit';
                Image = Alerts;
                action(" Exit Interview")
                {
                    ApplicationArea = all;
                    Caption = 'Employee Exit';
                    RunObject = Page "HRM-Exit Interview List";
                }
            }

            group(Grievance)
            {
                Caption = 'Grievance Management';
                Image = Alerts;

                action(DisciplineRegister)
                {
                    ApplicationArea = all;
                    Caption = 'Discipline Register';
                    RunObject = Page "HRM-Disciplinary Cases List";
                }
                action(Grievances)
                {
                    Visible = false;
                    ApplicationArea = all;
                    Caption = 'Grievances';
                    RunObject = Page "Complaints List";
                }
                action(Pending)
                {
                    Visible = false;
                    ApplicationArea = all;
                    Caption = 'Pending Grievances';
                    RunObject = Page "Complaints Pending";
                }
                action(ClosedCasesEnd)
                {
                    Visible = false;
                    ApplicationArea = all;
                    Caption = 'Closed Cases';
                    RunObject = Page "Complaints Closed";
                }

                action(DisciplineCasesEnd)
                {
                    ApplicationArea = all;
                    Caption = 'Discipline Setup';
                    RunObject = Page "Discipline Cases Page Setup";
                }

                action(DisciplineYears)
                {
                    Visible = false;
                    ApplicationArea = all;
                    Caption = 'Discipline Years';
                    RunObject = Page "Discipline Years List";
                }

            }
            group(Approvals)
            {
                Caption = 'Approvals';
                Image = Alerts;

                action("Pending Approval")
                {
                    ApplicationArea = all;
                    Caption = 'Requests to Approval';
                    RunObject = Page 654;
                }
                action("Pending My Approval")
                {
                    ApplicationArea = all;
                    Caption = 'Pending My Approval';
                    RunObject = Page "Approval Entries";
                }
                action("My Approval requests")
                {
                    ApplicationArea = all;
                    Caption = 'My Approval requests';
                    RunObject = Page "Approval Request Entries";
                }

            }
            group(Common_req)
            {
                Caption = 'Common Requisitions';
                Image = LotInfo;
                action("Stores Requisitions")
                {
                    ApplicationArea = all;
                    Caption = 'Stores Requisitions';
                    //  RunObject = Page "PROC-Store Requisition";
                }

                action(Action1000000003)
                {
                    ApplicationArea = all;
                    Caption = 'Leave Applications';
                    RunObject = Page "HRM-Leave Requisition List";
                }
                action("My Approved Leaves")
                {
                    ApplicationArea = all;
                    Caption = 'My Approved Leaves';
                    Image = History;
                    RunObject = Page "HRM-My Approved Leaves List";
                }
            }
            group(ATT)
            {
                Caption = 'Attendance';
                action("Staff Register")
                {
                    ApplicationArea = all;
                    Caption = 'Staff Register';
                    RunObject = Page "Staff Reg.Ledger List";
                }
                action("Staff Register History")
                {
                    ApplicationArea = all;
                    Caption = 'Staff Register History';
                    RunObject = Page "Staff Ledger History";
                }
                action("Casuals Register")
                {
                    ApplicationArea = all;
                    Caption = 'Casuals Register';
                    RunObject = Page "Casuals  Reg.Ledger List";
                }
                action("Casuals History")
                {
                    ApplicationArea = all;
                    Caption = 'Casuals History';
                    RunObject = Page "Casuals Ledger History";
                }
            }
            group(Attnd)
            {
                Caption = 'Staff Attendance';
                Image = Statistics;
                action(ParmStaffCurr)
                {
                    ApplicationArea = all;
                    Caption = 'Permanent Staff (Present)';
                    Image = AddContacts;
                   
                    
                    RunObject = Page "Staff Attendance (Current)";
                    ToolTip = 'Open List of Staff register (Daily Attendance)';
                }
                action(CasualStaffCurr)
                {
                    ApplicationArea = all;
                    Caption = 'Casual Staff (Present)';
                    Image = Purchasing;
                   
                    
                    RunObject = Page "Casual Attendance (Current)";
                    ToolTip = 'Open Attendance List for Casual Employees';
                }
                action(ParmStaff)
                {
                    ApplicationArea = all;
                    Caption = 'Permanent Staff (History)';
                    Image = AddContacts;
                   
                    
                    RunObject = Page "Staff Attendance View";
                    ToolTip = 'Open List of Staff register (Daily Attendance)';
                }
                action(CasualStaff)
                {
                    ApplicationArea = all;
                    Caption = 'Casual Staff (History)';
                    Image = Purchasing;
                   
                    
                    RunObject = Page "Casual Staff Attendance View";
                    ToolTip = 'Open Attendance List for Casual Employees';
                }
            }
        }


        /*        area(creation)
                {
                    group(Payroll_Setups)
                    {Visible = false;
                        Caption = 'Payroll Setups';
                        Image = HRSetup;
                        action("Payroll Period")
                        {
                            Caption = 'Payroll Period';
                            Image = Period;
                            RunObject = Page "PRL-Payroll Periods";
                        }
                        action("Pr Rates")
                        {
                            Caption = 'Pr Rates';
                            Image = SetupColumns;
                           
                            RunObject = Page "PRL-Rates & Ceilings";
                        }
                        action("NSSF Tiers")
                        {
                            Caption = 'NSSF Tiers';
                            Image = Agreement;
                           
                            RunObject = Page "prNSSF List";
                        }
                        action("paye Setup")
                        {
                            Caption = 'paye Setup';
                            Image = SetupPayment;
                           
                            RunObject = Page "PRL-P.A.Y.E Setup";
                        }
                        action(Action1000000070)
                        {
                            Caption = 'Transcation Codes';
                            Image = Setup;
                           
                            RunObject = Page "PRL-Transaction Codes List";
                        }
                        action(Action1000000069)
                        {
                            Caption = 'NHIF Setup';
                            Image = SetupLines;
                           
                            RunObject = Page "PRL-NHIF SetUp";
                        }
                        action("Hr Employee Card")
                        {
                        Image = Employee;
                            //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                            //
                            RunObject = Page "HRM-Employee (C)";
                        }
                        action("Bank Structure")
                        {
                            Caption = 'Bank Structure';
                            Image = Bank;
                           
                            RunObject = Page "PRL-Bank Structure (B)";
                        }
                        action("control information")
                        {
                            Caption = 'control information';
                            Image = CompanyInformation;
                           
                            RunObject = Page "GEN-Control-Information";
                        }
                        action("Salary Grades")
                        {
                            Caption = 'Salary Grades';
                            Image = EmployeeAgreement;
                           
                            RunObject = Page "PRL-Salary Grades";
                        }
                        action("posting group")
                        {
                            Caption = 'posting group';
                            Image = PostingEntries;
                           
                            RunObject = Page "PRL-Employee Posting Group";
                        }
                        action(Action1000000063)
                        {
                            Caption = 'Salary Increament Process';
                            Image = AddAction;
                           
                            RunObject = Page "HRM-Emp. Categories";
                        }
                        action(Action1000000062)
                        {
                            Caption = 'Salary Increament Register';
                            Image = Register;
                           
                            RunObject = Page "HRM-Salary Increament Register";
                        }
                        action(Action1000000061)
                        {
                            Caption = 'Un-Afected Salary Increaments';
                            Image = UndoCategory;
                           
                            RunObject = Page "HRM-Unaffected Sal. Increament";
                        }
                        action(Action1000000060)
                        {
                            Caption = ' payment Vouchers';
                            RunObject = Page "FIN-Payment Vouchers";
                        }
                    }
                    group(PayRepts2)
                    {Visible = false;
                        Caption = 'Payroll Reports';
                        Image = ResourcePlanning;
                        action("Detailed Payroll Summary")
                        {
                            Caption = 'Detailed Payroll Summary';
                            Image = Report2;
                           
                            
                            //todo RunObject = Report "Payroll Summary 3";
                        }
                        action("Departmental Summary")
                        {
                            Caption = 'Departmental Summary';
                            Image = "Report";
                           
                            
                            //todo RunObject = Report "Payroll Summary (Depts)";
                        }
                        action("vew payslip")
                        {                    Caption = 'vew payslip';
                            Image = "Report";
                           
                            RunObject = Report "Individual Payslips V.1.1.3";
                        }
                        action("Master Payroll Summary")
                        {
                            Caption = 'Master Payroll Summary';
                            Image = "Report";
                           
                            RunObject = Report "PRL-Company Payroll Summary 3";
                        }
                        action("Payroll summary")
                        {
                            Caption = 'Payroll summary';
                            Image = Report;
                            RunObject = Report "PRL-Company Payroll Summary 3";
                        }
                        action("Deductions Summary")
                        {
                            Caption = 'Deductions Summary';
                            Image = Report;
                            //todo  RunObject = Report "PRL-Deductions Summary";
                        }
                        action("Earnings Summary")
                        {
                            Caption = 'Earnings Summary';
                            Image = DepositSlip;
                            //todo RunObject = Report "PRL-Earnings Summary";
                        }
                        action("Deductions Summary 2")
                        {
                            Caption = 'Deductions Summary 2';
                            Image = "Report";
                           
                            //todo RunObject = Report "PRL-Deductions Summary 2";
                        }
                        action("Earnings Summary 2")
                        {
                            Caption = 'Earnings Summary 2';
                            Image = "Report";
                           
                            //todo RunObject = Report "PRL-Payments Summary 2";
                        }
                        action("Staff pension")
                        {
                            Caption = 'Staff pension';
                            Image = Aging;
                            //todo  RunObject = Report "prStaff Pension Contrib";
                        }
                        action("Gross Netpay")
                        {
                            Caption = 'Gross Netpay';
                            Image = Giro;
                            RunObject = Report prGrossNetPay;
                        }
                        action("Hrm credit Sales")
                        {
                            Caption = 'Hrm credit Sales';
                            Image = AddContacts;
                            //RunObject = Report "HRM- Credit Sales";
                        }
                    }





                    





                }
                */
    }
}

