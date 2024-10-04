page 68723 "PRL-Emp. Cue (Payroll)"
{
    PageType = CardPart;
    SourceTable = "HRM-Cue";

    layout
    {
        area(content)
        {
            cuegroup("All Employees")
            {
                Caption = 'All Employees';
                field("Employee-Active"; Rec."Employee-Active")
                {
                    Caption = 'Active Employees';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Employee-InActive"; Rec."Employee-InActive")
                {
                    Caption = 'Inactive Employees';
                    ApplicationArea = all;
                    Editable = false;

                }
                field("Employee-Male"; Rec."Employee-Male")
                {
                    Caption = 'Male Employees';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Employee-Female"; Rec."Employee-Female")
                {
                    Caption = 'Female Employees';
                    ApplicationArea = all;
                    Editable = false;
                }
                // field("Payroll Emp Count"; Rec."Payroll Emp Count")
                // {
                //     Caption = 'Employees In Payroll';
                //     DrillDownPageID = "HRM-Employee-List";
                //     ApplicationArea = All;

                // }
                // field("Employee-Male (PR)"; Rec."Employee-Male (PR)")
                // {
                //     Caption = 'Employees - Male';
                //     DrillDownPageID = "HRM-Employee-List";
                //     ApplicationArea = All;
                // }
                // field("Employee-Female (PR)"; Rec."Employee-Female (PR)")
                // {
                //     Caption = 'Employees - Female';
                //     DrillDownPageID = "HRM-Employee-List";
                //     ApplicationArea = All;
                // }
                // field(InactiveEmp; Rec."Employee-InActive (PR)")
                // {
                //     Caption = 'In-Active Employees';
                //     DrillDownPageID = "HRM-Employee-List (Inactive)";
                //     ApplicationArea = All;
                // }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("vew payslip")
            {
                Applicationarea = All;
                Caption = 'vew payslip';
                Image = "Report";

                //todo   RunObject = Report "Individual Payslips mst";
            }
            action("Master Payroll Summary")
            {
                Applicationarea = All;
                Caption = 'Master Payroll Summary';
                Image = "Report";

                //todo  RunObject = Report "Company Payroll Summary";
            }
            action("Deductions Summary 2")
            {
                Applicationarea = All;
                Caption = 'Deductions Summary 2';
                Image = "Report";

                //todo  RunObject = Report "PRL-Deductions Summary 2";
            }
            action("Earnings Summary 2")
            {
                Applicationarea = All;
                Caption = 'Earnings Summary 2';
                Image = "Report";

                //todo RunObject = Report "PRL-Payments Summary 2";
            }
            action("Payroll summary")
            {
                Applicationarea = All;
                Caption = 'Payroll summary';
                Image = Report;
                //todo  RunObject = Report "Payroll Summary 2";
            }
            action("Deductions Summary")
            {
                Applicationarea = All;
                Caption = 'Deductions Summary';
                Image = Report;
                //todo  RunObject = Report "PRL-Deductions Summary";
            }
            action("Earnings Summary")
            {
                Applicationarea = All;
                Caption = 'Earnings Summary';
                Image = DepositSlip;
                //todo  RunObject = Report "PRL-Earnings Summary";
            }
            action("Staff pension")
            {
                Applicationarea = All;
                Caption = 'Staff pension';
                Image = Aging;
                //todo  RunObject = Report "prStaff Pension Contrib";
            }
            action("Gross Netpay")
            {
                Applicationarea = All;
                Caption = 'Gross Netpay';
                Image = Giro;
                //todo    RunObject = Report prGrossNetPay;
            }
            action("Third Rule")
            {
                Applicationarea = All;
                Caption = 'Third Rule';
                Image = AddWatch;
                //todo RunObject = Report "A third Rule Report";
            }
            action("Co_op Remittance")
            {
                Applicationarea = All;
                Caption = 'Co_op Remittance';
                Image = CreateForm;
                //todoRunObject = Report "prCoop remmitance";
            }
            separator("setup finance")
            {
                Caption = 'setup finance';
            }
            action("receipt type")
            {
                Applicationarea = All;
                Caption = 'receipt type';
                Image = ServiceSetup;

                //todo  RunObject = Page "FIN-Receipt Types";
            }
            action(Transactions)
            {
                Applicationarea = All;
                Caption = 'Transactions';
                Image = "Report";

                //       RunObject = Report "pr Transactions";
            }
            action("bank Schedule")
            {
                Applicationarea = All;
                Caption = 'bank Schedule';
                Image = "Report";

                //todo RunObject = Report "pr Bank Schedule";
            }
            separator(Separator26)
            {
            }
            action("Employer Certificate")
            {
                Applicationarea = All;
                Caption = 'Employer Certificate';
                Image = "Report";


                //todo  RunObject = Report "Employer Certificate P.10 mst";
            }
            action("P.10")
            {
                Applicationarea = All;
                Caption = 'P.10';
                Image = "Report";

                //todo RunObject = Report "P.10 A mst";
            }
            action("Paye Scheule")
            {
                Applicationarea = All;
                Caption = 'Paye Scheule';
                Image = "Report";

                //todo RunObject = Report "prPaye Schedule mst";
            }
            action("NHIF Schedult")
            {
                Applicationarea = All;
                Caption = 'NHIF Schedult';
                Image = "Report";

                //    RunObject = Report "prNHIF mst";
            }
            action("NSSF Schedule")
            {
                Applicationarea = All;
                Caption = 'NSSF Schedule';
                Image = "Report";

                // RunObject = Report "prNSSF mst";
            }

            action(ProcessPayroll)
            {
                Applicationarea = All;
                Caption = 'Process Payslip';
                Image = ExecuteBatch;


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
                begin
                    ContrInfo.Get;

                    if Confirm('This will process salaries for all employees, Continue?', false) = false then exit;

                    objPeriod.Reset;
                    objPeriod.SetRange(objPeriod.Closed, false);
                    if objPeriod.Find('-') then;
                    SelectedPeriod := objPeriod."Date Opened";

                    //SalCard.GET("No.");

                    PeriodTrans.Reset;
                    PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                    if PeriodTrans.Find('-') then
                        PeriodTrans.DeleteAll;


                    //Use CODEUNIT
                    HrEmployee.Reset;
                    HrEmployee.SetRange(HrEmployee.Status, HrEmployee.Status::Active);
                    // HrEmployee.SETRANGE(HrEmployee."Employee Type",HrEmployee."Employee Type"::Permanent);
                    //HrEmployee.SETRANGE(HrEmployee.Status,HrEmployee.Status::Normal);
                    if HrEmployee.Find('-') then begin
                        PeriodTrans.Reset;
                        PeriodTrans.SetRange(PeriodTrans."Employee Code", HrEmployee."No.");
                        PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                        if PeriodTrans.Find('-') then
                            PeriodTrans.DeleteAll;

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
                        progre.Open('Processing Please wait..............\#1###############################################################' +
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
                        '\#13###############################################################',
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
                            salaryCard.Reset;
                            salaryCard.SetRange(salaryCard."Employee Code", HrEmployee."No.");
                            //IF salaryCard.FIND('-') THEN BEGIN
                            //END;

                            dateofJoining := 0D;
                            dateofLeaving := CalcDate('100Y', Today);
                            if HrEmployee."Date Of Join" = 0D then dateofJoining := CalcDate('-1M', Today);
                            //Progress Window


                            //  ProgressWindow.UPDATE(1,HrEmployee."No."+':'+HrEmployee."First Name"+' '+HrEmployee."Middle Name"+' '+HrEmployee."Last Name");
                            //IF SalCard.GET(HrEmployee."No.") THEN BEGIN

                            if not salaryCard.Find('-') then begin
                                // If employee has no Basic Salary
                                prempTrns.Reset;
                                prempTrns.SetRange(prempTrns."Employee Code", HrEmployee."No.");
                                prempTrns.SetRange(prempTrns."Payroll Period", SelectedPeriod);
                                if prempTrns.Find('-') then begin
                                    PeriodTrans.Reset;
                                    PeriodTrans.SetRange(PeriodTrans."Employee Code", HrEmployee."No.");
                                    PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                                    PeriodTrans.DeleteAll; // Delete Processed Transactions

                                    /* ProcessPayroll.fnProcesspayroll(HrEmployee."No.", DOJ, 0, false
                                        , false, false, SelectedPeriod, SelectedPeriod, '', '',
                                        dateofLeaving, false, HrEmployee."Department Code", '', false); */

                                    /* ProcessPayroll.fnProcesspayroll(HrEmployee."No.", DOJ, salaryCard."Basic Pay", salaryCard."Pays PAYE"
                                                    , salaryCard."Pays NSSF", salaryCard."Pays NHIF", SelectedPeriod, SelectedPeriod, '', '',
                                                    dateofLeaving, GetsPAYERelief, HrEmployee."Department Code"); */

                                    ProcessPayroll.fnProcesspayroll(HrEmployee."No.", DOJ, salaryCard."Basic Pay", salaryCard."Pays PAYE"
                    , salaryCard."Pays NSSF", salaryCard."Pays NHIF", SelectedPeriod, SelectedPeriod, '', '',
                    dateofLeaving, GetsPAYERelief, HrEmployee."Department Code", PayrollCode, true);


                                end;// Hast Transaction
                            end else
                                if salaryCard.Find('-') then begin
                                    if salaryCard."Suspend Pay" <> true then begin
                                        //IF salaryCard."Gets Personal Relief"=salaryCard."Gets Personal Relief"::"1" THEN GetsPAYERelief:=TRUE ELSE GetsPAYERelief:=FALSE;
                                        GetsPAYERelief := true;
                                        DOJ := 0D;
                                        if HrEmployee."Date Of Join" = 0D then DOJ := CalcDate('-2M', Today) else DOJ := HrEmployee."Date Of Join";
                                        salaryCard.Reset;
                                        salaryCard.SetRange(salaryCard."Employee Code", HrEmployee."No.");
                                        if salaryCard.Find('-') then begin
                                            if salaryCard."Suspend Pay" = true then begin
                                                PeriodTrans.Reset;
                                                PeriodTrans.SetRange(PeriodTrans."Employee Code", HrEmployee."No.");
                                                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                                                PeriodTrans.DeleteAll;
                                            end// delete stuff from transactions table
                                            else begin
                                                /*   ProcessPayroll.fnProcesspayroll(HrEmployee."No.", DOJ, salaryCard."Basic Pay", salaryCard."Pays PAYE"
                                                      , salaryCard."Pays NSSF", salaryCard."Pays NHIF", SelectedPeriod, SelectedPeriod, '', '',
                                                      dateofLeaving, GetsPAYERelief, HrEmployee."Department Code"); */
                                                ProcessPayroll.fnProcesspayroll(HrEmployee."No.", DOJ, salaryCard."Basic Pay", salaryCard."Pays PAYE"
                , salaryCard."Pays NSSF", salaryCard."Pays NHIF", SelectedPeriod, SelectedPeriod, '', '',
                dateofLeaving, GetsPAYERelief, HrEmployee."Department Code", PayrollCode, true);

                                                Clear(Var1);
                                                counts := counts + 1;
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

                                            end;
                                        end;
                                        //   END;
                                    end;
                                end;
                        until HrEmployee.Next = 0;
                        ////Progress Window
                        progre.Close;
                    end;
                    //CODEUNIT



                    //REPORT.RUN(39005514,TRUE,FALSE,SalCard);
                end;

            }
        }



    }


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
        j: Integer;
        PeriodTrans: Record "PRL-Period Transactions";
        salaryCard: Record "PRL-Salary Card";
        dateofJoining: Date;
        dateofLeaving: Date;
        GetsPAYERelief: Boolean;
        DOJ: Date;
        SalCard2: Record "PRL-Salary Card";
}

