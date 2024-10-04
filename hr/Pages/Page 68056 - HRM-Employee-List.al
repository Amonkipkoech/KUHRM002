page 68056 "HRM-Employee-List"
{
    CardPageID = "PRL-Header Salary Card";
    //Editable = true;
    //InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "HRM-Employee (D)";
    SourceTableView = SORTING("No.") ORDER(Ascending)
    Where(Status = filter(Active));




    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    Applicationarea = all;
                }
                field("Last Name"; Rec."Last Name")
                {
                    Applicationarea = all;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    Applicationarea = all;
                }
                field("First Name"; Rec."First Name")
                {
                    Applicationarea = all;
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field.';
                    ApplicationArea = All;
                }
                field("Appointment Date"; Rec."Appointment Date")
                {
                    ApplicationArea = All;
                }
                field("PIN Number"; Rec."PIN Number")
                {
                    ToolTip = 'Specifies the value of the PIN Number field.';
                    ApplicationArea = All;
                }
                field("NSSF No."; Rec."NSSF No.")
                {
                    ToolTip = 'Specifies the value of the NSSF No. field.';
                    ApplicationArea = All;
                }
                field("NHIF No."; Rec."NHIF No.")
                {
                    ToolTip = 'Specifies the value of the NHIF No. field.';
                    ApplicationArea = All;
                }
                // field("Marital Status"; Rec."Marital Status")
                // {
                //     ToolTip = 'Specifies the value of the Marital Status field.';
                //     ApplicationArea = All;
                // }
                // field(Religion; Rec.Religion)
                // {
                //     ToolTip = 'Specifies the value of the Religion field.';
                //     ApplicationArea = All;
                // }
                // field(Denomination; Rec.Denomination)
                // {
                //     ToolTip = 'Specifies the value of the Denomination field.';
                //     ApplicationArea = All;
                // }
                // field("Nationality Code"; Rec."Nationality Code")
                // {
                //     ToolTip = 'Specifies the value of the Nationality Code field.';
                //     ApplicationArea = All;
                // }
                // field(Nationality; Rec.Nationality)
                // {
                //     ToolTip = 'Specifies the value of the Nationality field.';
                //     ApplicationArea = All;
                // }
                // field("Work Permit No."; Rec."Work Permit No.")
                // {
                //     ToolTip = 'Specifies the value of the Work Permit No. field.';
                //     ApplicationArea = All;
                // }
                // field("Work Permit Expiry"; Rec."Work Permit Expiry")
                // {
                //     ToolTip = 'Specifies the value of the Work Permit Expiry Date field.';
                //     ApplicationArea = All;
                // }
                // field(County; Rec.County)
                // {
                //     ToolTip = 'Specifies the value of the County field.';
                //     ApplicationArea = All;

                // }
                // field("Country Code"; Rec."Country Code")
                // {
                //     ToolTip = 'Specifies the value of the Country Code field.';
                //     ApplicationArea = All;
                // }
                // field(Disabled; Rec.Disabled)
                // {
                //     ToolTip = 'Specifies the value of the Disabled field.';
                //     ApplicationArea = All;
                // }
                // field("Nature of Disability"; Rec."Nature of Disability")
                // {
                //     ToolTip = 'Specifies the value of the Work Permit Expiry Date field.';
                //     ApplicationArea = All;
                // }
                // field("Cellular Phone Number"; Rec."Cellular Phone Number")
                // {
                //     ToolTip = 'Specifies the value of the Cellular Phone Number field.';
                //     ApplicationArea = All;
                // }
                field("Home Phone Number"; Rec."Home Phone Number")
                {
                    ToolTip = 'Specifies the value of the Home Phone Number field.';
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the value of the E-Mail field.';
                    ApplicationArea = All;
                }




            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Transactions)
            {
                Caption = 'Transactions';
                action("Assign Transaction")
                {
                    ApplicationArea = all;
                    Caption = 'Assign Transaction';
                    Image = ApplyEntries;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "PRL-List Transactions";
                    RunPageLink = "Employee Code" = FIELD("No.");
                }
                separator(Separator18)
                {
                }

                action("View Trans Codes")
                {
                    ApplicationArea = all;
                    Caption = 'View Trans Codes';
                    Image = ViewDetails;
                    Promoted = true;
                    RunObject = Page "PRL-List TransCode";
                }
                action("import ED")
                {
                    ApplicationArea = all;

                    Caption = 'Import Payroll Transactions';
                    Image = ViewDetails;
                    Promoted = true;
                    //RunObject = xmlport "Import ED";

                    trigger OnAction()
                    begin
                        Message(EDformat);
                    end;
                }
                separator(Separator16)
                {
                }
            }
            group("Other Info")
            {
                Caption = 'Other Info';
                action("Banking Details")
                {
                    ApplicationArea = all;
                    Caption = 'Banking Details';
                    Image = BankAccount;
                    RunObject = Page "PRL-Employee Banks";
                    RunPageLink = "Employee Code" = FIELD("No.");
                }
                separator(Separator13)
                {
                }
                action("Pension Details")
                {
                    Caption = 'Pension Details';
                    Image = History;
                    RunObject = Page "PRL-Pension Contrib. Details";
                    RunPageLink = "Employee Code" = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Refresh HR Employees")
                {
                    ApplicationArea = all;
                    Image = UpdateDescription;

                    trigger OnAction()
                    begin
                        i := 0;
                        HREmp.Reset;
                        HREmp.SetRange(HREmp.Status, HREmp.Status::Active);
                        if HREmp.Find('-') then begin
                            repeat
                                if not objEmp.Get(HREmp."No.") then begin
                                    i := i + 1;
                                    objEmp.Init;
                                    objEmp."No." := HREmp."No.";
                                    objEmp."First Name" := HREmp."First Name";
                                    objEmp."Middle Name" := HREmp."Middle Name";
                                    objEmp."Last Name" := HREmp."Last Name";
                                    objEmp.Initials := HREmp.Initials;
                                    objEmp."Search Name" := HREmp."Search Name";
                                    objEmp."Cellular Phone Number" := HREmp."Cellular Phone Number";
                                    objEmp."E-Mail" := HREmp."E-Mail";
                                    objEmp."ID Number" := HREmp."ID Number";
                                    objEmp.Gender := HREmp.Gender;
                                    objEmp.Status := objEmp.Status::Active;
                                    objEmp."Company E-Mail" := HREmp."Company E-Mail";
                                    objEmp."Date Of Birth" := HREmp."Date Of Birth";
                                    objEmp."Date Of Join" := HREmp."Date Of Join";
                                    objEmp."PIN Number" := HREmp."PIN Number";
                                    objEmp."NSSF No." := HREmp."NSSF No.";
                                    objEmp."NHIF No." := HREmp."NHIF No.";
                                    objEmp."Department Code" := HREmp."Department Code";
                                    objEmp."Posting Group" := 'PAYROLL';
                                    objEmp.Insert;
                                end else begin
                                    j := j + 1;
                                    objEmp."First Name" := HREmp."First Name";
                                    objEmp."Middle Name" := HREmp."Middle Name";
                                    objEmp."Last Name" := HREmp."Last Name";
                                    objEmp.Initials := HREmp.Initials;
                                    objEmp."Search Name" := HREmp."Search Name";
                                    objEmp."Cellular Phone Number" := HREmp."Cellular Phone Number";
                                    objEmp."E-Mail" := HREmp."E-Mail";
                                    objEmp."ID Number" := HREmp."ID Number";
                                    objEmp.Gender := HREmp.Gender;
                                    objEmp.Status := objEmp.Status::Active;
                                    objEmp."Company E-Mail" := HREmp."Company E-Mail";
                                    objEmp."Date Of Birth" := HREmp."Date Of Birth";
                                    objEmp."Date Of Join" := HREmp."Date Of Join";
                                    objEmp."PIN Number" := HREmp."PIN Number";
                                    objEmp."NSSF No." := HREmp."NSSF No.";
                                    objEmp."NHIF No." := HREmp."NHIF No.";
                                    objEmp."Department Code" := HREmp."Department Code";
                                    objEmp."Posting Group" := 'PAYROLL';
                                    objEmp.Modify;
                                end;
                            until HREmp.Next = 0;
                        end;
                        Message(Format(i) + ' Employees Created, ' + Format(j) + ' Employees Updated');
                    end;
                }
            }
        }
        area(reporting)
        {
            action(View2PagePayslip)
            {
                ApplicationArea = all;
                Caption = 'Payslip (Horizontal)';
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin

                    objPeriod.Reset;
                    objPeriod.SetRange(objPeriod.Closed, false);
                    if objPeriod.Find('-') then;
                    SelectedPeriod := objPeriod."Date Opened";

                    SalCard.Reset;
                    SalCard.SetRange(SalCard."Employee Code", Rec."No.");
                    SalCard.SetRange(SalCard."Payroll Period", SelectedPeriod);
                    if SalCard.Find('-') then
                        REPORT.Run(51745, true, false, SalCard);
                end;
            }
            action(ViewhorPayslip)
            {
                ApplicationArea = all;
                Caption = 'Payslip';
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    objPeriod.Reset;
                    objPeriod.SetRange(objPeriod.Closed, false);
                    if objPeriod.Find('-') then;
                    SelectedPeriod := objPeriod."Date Opened";

                    objEmp.Reset;
                    objEmp.SetRange(objEmp."No.", Rec."No.");
                    if objEmp.Find('-') then
                        REPORT.Run(64310, true, false, objEmp);
                end;
            }
            action(View3PagePayslip)
            {
                ApplicationArea = all;
                Caption = 'View3 Pages Payslip';
                Image = PaymentHistory;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin

                    objPeriod.Reset;
                    objPeriod.SetRange(objPeriod.Closed, false);
                    if objPeriod.Find('-') then;
                    SelectedPeriod := objPeriod."Date Opened";

                    SalCard.Reset;
                    SalCard.SetRange(SalCard."Employee Code", Rec."No.");
                    SalCard.SetRange(SalCard."Payroll Period", SelectedPeriod);
                    if SalCard.Find('-') then
                        REPORT.Run(51143, true, false, SalCard);
                end;
            }
            action("vew payslip")
            {
                ApplicationArea = all;
                Caption = 'vew payslip';
                Image = "Report";
                Promoted = true;
                //todo  RunObject = Report "Individual Payslips mst";
                Visible = false;
            }
            action("Master Payroll Summary")
            {
                ApplicationArea = all;
                Caption = 'Master Payroll Summary';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "PRL-Company Payroll Summary 3";
            }
            action("Deductions Summary 2")
            {
                ApplicationArea = all;
                Caption = 'Deductions Summary 2';
                Image = "Report";
                Promoted = true;
                RunObject = Report "PRL-Deductions Summary 2 a";
            }
            action("Payroll summary")
            {
                ApplicationArea = all;
                Caption = 'Payroll summary';
                Image = Report;
                RunObject = Report "Payroll Summary 2";
            }
            action("Deductions Summary")
            {
                ApplicationArea = all;
                Caption = 'Deductions Summary';
                Image = Report;
                RunObject = Report "PRL-Deductions Summary1";
            }
            action("Earnings Summary")
            {
                ApplicationArea = all;
                Caption = 'Earnings Summary';
                Image = DepositSlip;
                RunObject = Report "PRL-Earnings Summary 5";
            }
            action("Staff pension")
            {
                Caption = 'Staff pension';
                Image = Aging;
                ApplicationArea = All;
                //  RunObject = Report "prStaff Pension Contrib";
            }
            action("Gross Netpay")
            {
                ApplicationArea = all;
                Caption = 'Gross Netpay';
                Image = Giro;
                //    RunObject = Report prGrossNetPay;
            }
            action("Third Rule")
            {
                ApplicationArea = all;
                Caption = 'Third Rule';
                Image = AddWatch;
                //     RunObject = Report "A third Rule Report";
            }
            action("Co_op Remittance")
            {
                ApplicationArea = all;
                Caption = 'Co_op Remittance';
                Image = CreateForm;
                RunObject = Report "prCoop remmitance";
            }
            separator("setup finance")
            {
                Caption = 'setup finance';
            }
            action("receipt type")
            {
                Caption = 'receipt type';
                Image = ServiceSetup;
                Promoted = true;
                ApplicationArea = All;
                //RunObject = Page "FIN-Receipt Types";
            }
            action(Action39)
            {
                ApplicationArea = all;
                Caption = 'Transactions';
                Image = "Report";
                Promoted = true;
                RunObject = Report "pr Transactions";
            }
            action("bank Schedule")
            {
                ApplicationArea = all;
                Caption = 'bank Schedule';
                Image = "Report";
                Promoted = true;
                RunObject = Report "pr Bank Schedule";
            }
            separator(Separator36)
            {
            }
            action("Employer Certificate")
            {
                Caption = 'Employer Certificate';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;
                // RunObject = Report "Employer Certificate P.10 mst";
            }
            action("P.10")
            {
                ApplicationArea = all;
                Caption = 'P.10';
                Image = "Report";
                Promoted = true;
                //RunObject = Report "P.10 A mst";
            }
            action("P9 Report")
            {
                ApplicationArea = all;
                Caption = 'P9 Report';
                Image = Report2;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "P9 Report (Final)";
            }
            action("Paye Scheule")
            {
                ApplicationArea = all;
                Caption = 'Paye Scheule';
                Image = "Report";
                Promoted = true;
                RunObject = Report "prPaye Schedule mst";
            }
            action("NHIF Schedult")
            {
                ApplicationArea = all;
                Caption = 'NHIF Schedult';
                Image = "Report";
                Promoted = true;
                // RunObject = Report "prNHIF mst";
            }
            action("NSSF Schedule")
            {
                ApplicationArea = all;
                Caption = 'NSSF Schedule';
                Image = "Report";
                Promoted = true;
                RunObject = Report "prNSSF mst";
            }
            separator(Separator29)
            {
            }
            group(periodic)
            {
                Caption = 'periodic';
                action("payroll Journal Transfer")
                {
                    Caption = 'payroll Journal Transfer';
                    Image = Journals;
                    Promoted = true;
                    ApplicationArea = All;
                    //todo  RunObject = Report prPayrollJournalTransfer;
                }
                action("mass update Transactions")
                {
                    Caption = 'mass update Transactions';
                    Image = PostBatch;
                    Promoted = true;
                    ApplicationArea = All;
                    //todo  RunObject = Report "Mass Update Transactions";
                }
                action("Payroll Period")
                {
                    Caption = 'Payroll Period';
                    Image = Period;
                    ApplicationArea = All;
                    //todo RunObject = Page "PRL-Payroll Periods";
                }


            }
        }
        area(processing)
        {
            action("Validate Basic")
            {
                ApplicationArea = All;
                Image = VoidAllChecks;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Report "Validate Salaries";
            }
            action("Validate Allowances")
            {
                ApplicationArea = All;
                Image = ValidateEmailLoggingSetup;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Report "Validate Allowance";
            }
            action(update)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    upDatePayrollData();
                end;
            }
            action(updateHelbs)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    updateHelb();
                end;
            }


            action(ProcessPayroll)
            {
                ApplicationArea = all;
                Caption = 'Process payroll';
                Image = ExecuteBatch;
                Promoted = true;
                PromotedCategory = Process;
                Visible = true;

                trigger OnAction()
                var
                    progre: Dialog;
                    counts: Integer;
                    RecCount1: Text[120];
                    RecCount2: Text[120];
                    RecCount3: Text[120];
                    RecCount4: Text[120];
                    RecCount5: Text[120];
                    RecCount6: Text[120];
                    RecCount7: Text[120];
                    RecCount8: Text[120];
                    RecCount9: Text[120];
                    RecCount10: Text[120];
                    BufferString: Text[1024];
                    Var1: Code[10];
                    prempTrns: Record "PRL-Employee Transactions";
                    progDots: Text[50];
                    counted: Integer;
                    text1: Label '.';
                    text2: Label '.  .';
                    text3: Label '.  .  .';
                    text4: Label '.  .  .  .';
                    text5: Label '.  .  .  .  .';
                    text6: Label '.  .  .  .  .  .';
                    text7: Label '.  .  .  .  .  .  .';
                    text8: Label '.  .  .  .  .  .  .  .';
                    text9: Label '.  .  .  .  .  .  .  .  .';
                    text10: Label '.  .  .  .  .  .  .  .  .  .';
                    FRMVitalSetup: Record "PRL-Vital Setup Info";
                    FrmTransCodes: Record "PRL-Transaction Codes";
                    transName: Text[150];
                    cummCredits: Decimal;
                    HRMCustomerCreditSales: Record "HRM Customer Credit Sales";
                begin
                    ContrInfo.Get;

                    if Confirm('This will process salaries for Permanent Employees, Continue?', false) = false then exit;

                    objPeriod.Reset;
                    objPeriod.SetRange(objPeriod.Closed, false);
                    objPeriod.SetFilter("Payroll Code", '=%1', 'PAYROLL');
                    if objPeriod.Find('-') then begin
                        PeriodName := objPeriod."Period Name";
                        SelectedPeriod := objPeriod."Date Opened";
                    end
                    else
                        Error('No open period!');

                    ///CLEAR(StdDailyRate);
                    //StdDailyRate:=objPeriod."Casual Daily Rate";
                    //SalCard.GET("No.");

                    PeriodTrans.Reset;
                    PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                    PeriodTrans.SetFilter("Employee Category", '<>%1|%2', 'CASUALS', 'CASUAL');
                    if PeriodTrans.Find('-') then
                        PeriodTrans.DeleteAll;


                    //Use CODEUNIT
                    HrEmployee.Reset;
                    HrEmployee.SetRange(HrEmployee.Status, HrEmployee.Status::Active);
                    HrEmployee.SetFilter(HrEmployee."Employee Category", '<>%1|%2', 'CASUALS', 'CASUAL');
                    // IF CONFIRM('Process for the current employee only?',FALSE)=TRUE THEN
                    //   HrEmployee.SETRANGE("No.",Rec."No.");
                    //HrEmployee.SETRANGE(HrEmployee.Status,HrEmployee.Status::Normal);
                    if HrEmployee.Find('-') then begin
                        Clear(progDots);
                        Clear(RecCount1);
                        Clear(RecCount2);
                        Clear(RecCount3);
                        Clear(RecCount4);
                        Clear(RecCount5);
                        Clear(RecCount6);
                        Clear(RecCount7);
                        Clear(RecCount8);
                        Clear(RecCount9);
                        Clear(RecCount10);
                        Clear(counts);
                        progre.Open('Processing Please wait #1#############################' +
                        '\ ' +
                        '\#2###############################################################' +
                        '\#3###############################################################' +
                        '\#4###############################################################' +
                        '\#5###############################################################' +
                        '\#6###############################################################' +
                        '\#7###############################################################' +
                        '\#8###############################################################' +
                        '\#9###############################################################' +
                        '\#10###############################################################' +
                        '\#11###############################################################' +
                        '\#12###############################################################' +
                        '\#13###############################################################' +
                        '\#14###############################################################',
                            progDots,
                            RecCount1,
                            RecCount2,
                            RecCount3,
                            RecCount4,
                            RecCount5,
                            RecCount6,
                            RecCount7,
                            RecCount8,
                            RecCount9,
                            RecCount10,
                            Var1,
                            Var1,
                            BufferString
                        );

                        repeat
                            // Get Basic Salary
                            /*CLEAR(computedBasic);
                            PRLEmployeeDaysWorked.RESET;
                            PRLEmployeeDaysWorked.SETRANGE("Payroll Period",SelectedPeriod);
                            PRLEmployeeDaysWorked.SETRANGE("Employee Code",HrEmployee."No.");
                            IF PRLEmployeeDaysWorked.FIND('-') THEN BEGIN
                              IF HrEmployee."Daily Rate">0 THEN BEGIN
                              IF PRLEmployeeDaysWorked."Days Worked">0 THEN computedBasic:= PRLEmployeeDaysWorked."Days Worked"*HrEmployee."Daily Rate"
                              ELSE IF PRLEmployeeDaysWorked."Computed Days">0 THEN computedBasic:= PRLEmployeeDaysWorked."Computed Days"*HrEmployee."Daily Rate";
                              END ELSE BEGIN
                              IF PRLEmployeeDaysWorked."Days Worked">0 THEN computedBasic:= PRLEmployeeDaysWorked."Days Worked"*StdDailyRate
                              ELSE IF PRLEmployeeDaysWorked."Computed Days">0 THEN computedBasic:= PRLEmployeeDaysWorked."Computed Days"*StdDailyRate;
                                END;
                              END;

                            IF computedBasic>0 THEN BEGIN
                              //update or insert SalaryCard

                             salaryCard.RESET;
                             salaryCard.SETRANGE(salaryCard."Employee Code",HrEmployee."No.");
                             salaryCard.SETRANGE("Payroll Period",SelectedPeriod);
                             IF NOT salaryCard.FIND('-') THEN BEGIN
                               salaryCard.INIT;
                               salaryCard."Employee Code":=HrEmployee."No.";
                               salaryCard."Payroll Period":=SelectedPeriod;
                               salaryCard."Basic Pay":=computedBasic;
                               salaryCard.INSERT(TRUE);
                               END ELSE BEGIN
                               salaryCard."Basic Pay":=computedBasic;
                               salaryCard.MODIFY;
                                 END;
                              END;
                             salaryCard.RESET;
                             salaryCard.SETRANGE(salaryCard."Employee Code",HrEmployee."No.");
                             salaryCard.SETFILTER(salaryCard.Closed,'=%1',FALSE);
                             IF salaryCard.FIND('-') THEN BEGIN
                             END;
                             */
                            dateofJoining := 0D;
                            dateofLeaving := CalcDate('-1M', Today);
                            if HrEmployee."Date Of Join" = 0D then dateofJoining := CalcDate('-1M', Today);
                            //Progress Window
                            PeriodTrans.Reset;
                            PeriodTrans.SetRange(PeriodTrans."Employee Code", HrEmployee."No.");
                            PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                            if PeriodTrans.Find('-') then
                                PeriodTrans.DeleteAll;



                            // Populate Credits Here********************************************************************
                            // Populate Credit Sales for the Month
                            if FRMVitalSetup.Get() then begin
                                FRMVitalSetup.TestField(FRMVitalSetup."Credit Trans. Code");
                                HRMCustomerCreditSales.Reset;
                                HRMCustomerCreditSales.SetRange(HRMCustomerCreditSales."Customer No.", HrEmployee."No.");
                                HRMCustomerCreditSales.SetRange(HRMCustomerCreditSales."Payroll Period", SelectedPeriod);
                                Clear(cummCredits);
                                if HRMCustomerCreditSales.Find('-') then begin
                                    HRMCustomerCreditSales.CalcSums(Amount);
                                    cummCredits := HRMCustomerCreditSales.Amount;
                                end;
                                if cummCredits <> 0 then begin
                                    transName := '';
                                    if FrmTransCodes.Get(FRMVitalSetup."Credit Trans. Code") then transName := FrmTransCodes."Transaction Name";
                                    prempTrns.Reset;
                                    prempTrns.SetRange(prempTrns."Employee Code", HrEmployee."No.");
                                    prempTrns.SetRange(prempTrns."Payroll Period", SelectedPeriod);
                                    prempTrns.SetRange(prempTrns."Transaction Code", FRMVitalSetup."Credit Trans. Code");
                                    if not (prempTrns.Find('-')) then begin
                                        // Insert
                                        prempTrns.Init;
                                        prempTrns."Employee Code" := HrEmployee."No.";
                                        prempTrns."Payroll Period" := SelectedPeriod;
                                        prempTrns."Period Year" := Date2DMY(SelectedPeriod, 3);
                                        prempTrns."Period Month" := Date2DMY(SelectedPeriod, 2);
                                        prempTrns."Transaction Code" := FRMVitalSetup."Credit Trans. Code";
                                        prempTrns."Transaction Name" := transName;
                                        prempTrns.Validate("Transaction Code");
                                        prempTrns."Recurance Index" := 99;
                                        prempTrns.Balance := cummCredits;
                                        prempTrns.Amount := cummCredits;
                                        // prempTrns.INSERT;
                                        prempTrns.Validate("Transaction Code");
                                    end else begin
                                        //Update
                                        prempTrns."Recurance Index" := 99;
                                        prempTrns.Balance := cummCredits;
                                        prempTrns."Transaction Name" := transName;
                                        prempTrns.Amount := cummCredits;
                                        //  prempTrns.MODIFY;
                                        prempTrns.Validate("Transaction Code");
                                    end;

                                end;
                            end;

                            //Populate Credits ********************************************************************END**
                            //  ProgressWindow.UPDATE(1,HrEmployee."No."+':'+HrEmployee."First Name"+' '+HrEmployee."Middle Name"+' '+HrEmployee."Last Name");
                            salaryCard.Reset;
                            salaryCard.SetRange(salaryCard."Employee Code", HrEmployee."No.");
                            salaryCard.SetRange("Payroll Period", SelectedPeriod);
                            if not salaryCard.Find('-') then begin
                                // If employee has no Basic Salary

                                /* prempTrns.RESET;
                                 prempTrns.SETRANGE(prempTrns."Employee Code",HrEmployee."No.");
                                 prempTrns.SETRANGE(prempTrns."Payroll Period",SelectedPeriod);
                                 IF prempTrns.FIND('-') THEN BEGIN
                                      PeriodTrans.RESET;
                                      PeriodTrans.SETRANGE(PeriodTrans."Employee Code",HrEmployee."No.");
                                      PeriodTrans.SETRANGE(PeriodTrans."Payroll Period",SelectedPeriod);
                                      PeriodTrans.DELETEALL; // Delete Processed Transactions
                                      */
                                /* ProcessPayroll.fnProcesspayroll(HrEmployee."No.", DOJ, 0, false
                                    , false, false, SelectedPeriod, SelectedPeriod, '', '',
                                    dateofLeaving, false, HrEmployee."Department Code", HrEmployee."Payroll Posting Group", true); */


                                //END;// Has Transaction
                            end else begin
                                salaryCard.Reset;
                                salaryCard.SetRange(salaryCard."Employee Code", HrEmployee."No.");
                                salaryCard.SetRange("Payroll Period", SelectedPeriod);
                                //IF NOT salaryCard.FIND('-') THEN BEGIN
                                if salaryCard.Find('-') then begin
                                    if salaryCard."Suspend Pay" <> true then begin
                                        //IF salaryCard."Gets Personal Relief"=salaryCard."Gets Personal Relief"::"1" THEN GetsPAYERelief:=TRUE ELSE GetsPAYERelief:=FALSE;
                                        GetsPAYERelief := true;
                                        DOJ := 0D;
                                        if HrEmployee."Date Of Join" = 0D then DOJ := CalcDate('-2M', Today) else DOJ := HrEmployee."Date Of Join";
                                        salaryCard.Reset;
                                        salaryCard.SetRange(salaryCard."Employee Code", HrEmployee."No.");
                                        salaryCard.SetFilter(salaryCard.Closed, '=%1', false);
                                        if salaryCard.Find('-') then begin
                                            if salaryCard."Suspend Pay" = true then begin
                                                PeriodTrans.Reset;
                                                PeriodTrans.SetRange(PeriodTrans."Employee Code", HrEmployee."No.");
                                                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                                                PeriodTrans.DeleteAll;
                                            end// delete stuff from transactions table
                                            else begin
                                                /* ProcessPayroll.fnProcesspayroll(HrEmployee."No.", DOJ, salaryCard."Basic Pay", salaryCard."Pays PAYE"
                                                    , salaryCard."Pays NSSF", salaryCard."Pays NHIF", SelectedPeriod, SelectedPeriod, '', '',
                                                    dateofLeaving, GetsPAYERelief, HrEmployee."Department Code", HrEmployee."Payroll Posting Group", true); */

                                                /* ProcessPayroll.fnProcesspayroll(HrEmployee."No.", DOJ, salaryCard."Basic Pay", salaryCard."Pays PAYE"
                                                    , salaryCard."Pays NSSF", salaryCard."Pays NHIF", SelectedPeriod, SelectedPeriod, '', '',
                                                    dateofLeaving, GetsPAYERelief, HrEmployee."Department Code"); */

                                                ProcessPayroll.fnProcesspayroll(HrEmployee."No.", DOJ, salaryCard."Basic Pay", salaryCard."Pays PAYE"
                    , salaryCard."Pays NSSF", salaryCard."Pays NHIF", SelectedPeriod, SelectedPeriod, '', '',
                    dateofLeaving, GetsPAYERelief, HrEmployee."Department Code", PayrollCode, true);

                                                Clear(Var1);
                                                counts := counts + 1;
                                                if ((counted = 21) or (counted = 11)) then begin
                                                    if counted = 21 then counted := 0;
                                                    // SLEEP(150);
                                                end;
                                                counted := counted + 1;
                                                if counted = 1 then
                                                    progDots := text1
                                                else
                                                    if counted = 2 then
                                                        progDots := text2
                                                    else
                                                        if counted = 3 then
                                                            progDots := text3
                                                        else
                                                            if counted = 4 then
                                                                progDots := text4
                                                            else
                                                                if counted = 5 then
                                                                    progDots := text5
                                                                else
                                                                    if counted = 6 then
                                                                        progDots := text6
                                                                    else
                                                                        if counted = 7 then
                                                                            progDots := text7
                                                                        else
                                                                            if counted = 8 then
                                                                                progDots := text8
                                                                            else
                                                                                if counted = 9 then
                                                                                    progDots := text9
                                                                                else
                                                                                    if counted = 10 then
                                                                                        progDots := text10
                                                                                    else
                                                                                        if counted = 19 then
                                                                                            progDots := text1
                                                                                        else
                                                                                            if counted = 18 then
                                                                                                progDots := text2
                                                                                            else
                                                                                                if counted = 17 then
                                                                                                    progDots := text3
                                                                                                else
                                                                                                    if counted = 16 then
                                                                                                        progDots := text4
                                                                                                    else
                                                                                                        if counted = 15 then
                                                                                                            progDots := text5
                                                                                                        else
                                                                                                            if counted = 14 then
                                                                                                                progDots := text6
                                                                                                            else
                                                                                                                if counted = 13 then
                                                                                                                    progDots := text7
                                                                                                                else
                                                                                                                    if counted = 12 then
                                                                                                                        progDots := text8
                                                                                                                    else
                                                                                                                        if counted = 11 then
                                                                                                                            progDots := text9
                                                                                                                        else
                                                                                                                            progDots := '';

                                                if counts = 1 then
                                                    RecCount1 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                                HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                                else
                                                    if counts = 2 then begin
                                                        RecCount2 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                                    HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                                    end
                                                    else
                                                        if counts = 3 then begin
                                                            RecCount3 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                                        HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                                        end
                                                        else
                                                            if counts = 4 then begin
                                                                RecCount4 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                                            HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                                            end
                                                            else
                                                                if counts = 5 then begin
                                                                    RecCount5 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                                                HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                                                end
                                                                else
                                                                    if counts = 6 then begin
                                                                        RecCount6 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                                                    HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                                                    end
                                                                    else
                                                                        if counts = 7 then begin
                                                                            RecCount7 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                                                        HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                                                        end
                                                                        else
                                                                            if counts = 8 then begin
                                                                                RecCount8 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                                                            HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                                                            end
                                                                            else
                                                                                if counts = 9 then begin
                                                                                    RecCount9 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                                                                HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                                                                end
                                                                                else
                                                                                    if counts = 10 then begin
                                                                                        RecCount10 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                                                                    HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                                                                    end else
                                                                                        if counts > 10 then begin
                                                                                            RecCount1 := RecCount2;
                                                                                            RecCount2 := RecCount3;
                                                                                            RecCount3 := RecCount4;
                                                                                            RecCount4 := RecCount5;
                                                                                            RecCount5 := RecCount6;
                                                                                            RecCount6 := RecCount7;
                                                                                            RecCount7 := RecCount8;
                                                                                            RecCount8 := RecCount9;
                                                                                            RecCount9 := RecCount10;
                                                                                            RecCount10 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                                                                        HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name";
                                                                                        end;
                                                Clear(BufferString);
                                                BufferString := 'Total Records processed = ' + Format(counts);

                                                progre.Update();
                                                // SLEEP(50);
                                            end;
                                        end;
                                        //   END;
                                    end;
                                end;
                            end;
                        until HrEmployee.Next = 0;
                        ////Progress Window
                        progre.Close;
                    end;

                end;
            }
            group(ActionGroup70)
            {
                Caption = 'periodic';
                Description = 'PeriodicActions';
                Image = Administration;
                action(Action69)
                {
                    ApplicationArea = All;
                    Caption = 'payroll Journal Transfer';
                    Image = Journals;
                    Promoted = true;
                    //todo RunObject = Report prPayrollJournalTransfer;
                }
                action(Action67)
                {
                    ApplicationArea = All;
                    Caption = 'mass update Transactions';
                    Image = PostBatch;
                    Promoted = true;
                    //todo    RunObject = Report "Mass Update Transactions";
                }
                action(Action65)
                {
                    ApplicationArea = All;
                    Caption = 'Payroll Period';
                    Image = Period;
                    RunObject = Page "PRL-Payroll Periods";
                }
                action("Salary Increament Register")
                {
                    ApplicationArea = All;
                    Caption = 'Salary Increament Register';
                    Image = Register;
                    Promoted = true;
                    RunObject = Page "HRM-Salary Increament Register";
                }
                action("Un-Afected Salary Increaments")
                {
                    ApplicationArea = All;
                    Caption = 'Un-Afected Salary Increaments';
                    Image = UndoCategory;
                    Promoted = true;
                    RunObject = Page "HRM-Unaffected Sal. Increament";
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        IF (DepCode <> '') THEN
            Rec.SETFILTER("Department Code", ' = %1', DepCode);
        IF (OfficeCode <> '') THEN
            Rec.SETFILTER(Office, ' = %1', OfficeCode);

    end;

    var
        Mail: Codeunit Mail;
        PictureExists: Boolean;
        DepCode: Code[10];
        OfficeCode: Code[10];
        objEmp: Record "HRM-Employee (D)";
        SalCard: Record "PRL-Salary Card";
        objPeriod: Record "PRL-Payroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodMonth: Integer;
        PeriodYear: Integer;
        ProcessPayroll: Codeunit prPayrollProcessing;
        HrEmployee: Record "HRM-Employee (D)";
        ProgressWindow: Dialog;
        prPeriodTransactions: Record "PRL-Period Transactions";
        prEmployerDeductions: Record "PRL-Employer Deductions";
        PayrollType: Record "PRL-Payroll Type";
        Selection: Integer;
        PayrollDefined: Text[30];
        PayrollCode: Code[10];
        NoofRecords: Integer;
        i: Integer;
        ContrInfo: Record "HRM-Control-Information";
        HREmp: Record "HRM-Employee (D)";
        employeeTrans: Record "PRL-Employee Transactions";
        j: Integer;
        PeriodTrans: Record "PRL-Period Transactions";
        salaryCard: Record "PRL-Salary Card";
        dateofJoining: Date;
        dateofLeaving: Date;
        GetsPAYERelief: Boolean;
        DOJ: Date;
        SalCard2: Record "PRL-Salary Card";
        EDformat: Label 'Prepare your csv doucment in this format \column 1 > Employee code(BFL001) \column 2 > Transaction Code(D2001) \ column 3 > Amount(2500)  \ column 4 > Balance(0) \column 5 > Payroll Period(01/11/2021) \column 6 > Payroll month(11) \column 7 > Payroll year(2021) \';
        newData: Record update;


    procedure SetNewFilter(var DepartmentCode: Code[10]; var "Office Code": Code[10])
    begin
        DepCode := DepartmentCode;
        OfficeCode := "Office Code";
    end;

    procedure upDatePayrollData()
    var
        newData: Record update;
        hrEmp: Record "HRM-Employee (D)";
    begin
        hrEmp.Reset();
        hrEmp.SetRange(Status, hrEmp.Status::Active);
        //hrEmp.SetRange(gender, hrEmp.Gender::Female);
        if hrEmp.Find('-') then begin
            repeat
                newData.Reset();
                newData.SetRange(payrollNo, hrEmp."No.");
                hrEmp."Include In Payroll" := false;
                if newData.Find('-') then begin

                    hrEmp."Include In Payroll" := true;
                    hrEmp.Modify();
                end;
            until hrEmp.Next() = 0;
        end;
    end;

    procedure updateHelb()
    begin
        HrEmployee.Reset();
        HrEmployee.SetRange(Status, HrEmployee.Status::Active);
        if HrEmployee.Find('-') then begin
            repeat
                employeeTrans.Reset();
                employeeTrans.SetRange("Employee Code", HrEmployee."No.");
                employeeTrans.SetRange("Transaction Code", 'D-022');
                employeeTrans.SetRange("Period Month", 10);
                if employeeTrans.Find('-') then begin
                    HrEmployee."Pays Helb" := true;
                    HrEmployee.Modify();
                end;
            until HrEmployee.Next() = 0;
        end;
    end;
}

