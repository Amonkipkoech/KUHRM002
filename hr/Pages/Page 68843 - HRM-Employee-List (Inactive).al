page 68843 "HRM-Employee-List (Inactive)"
{
    Caption = 'Inactive Employees List';
    CardPageID = "HRM-Employee (B)";
    Editable = true;
    PageType = List;
    SourceTable = "HRM-Employee (D)";
    SourceTableView = SORTING("No.")
                      ORDER(Ascending)
                      WHERE(Status = FILTER(<> Active));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Enabled = false;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = all;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = all;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = all;
                }

                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = all;
                }
                field(Initials; Rec.Initials)
                {
                    ApplicationArea = all;
                }

                field("Postal Address"; Rec."Postal Address")
                {
                    ApplicationArea = all;
                }

                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = all;
                }

                field("Post Code2"; Rec."Post Code2")
                {
                    ApplicationArea = all;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = all;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = all;
                }

                field("Cellular Phone Number"; Rec."Cellular Phone Number")
                {
                    ApplicationArea = all;
                }

                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = all;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = all;
                }


                field(Gender; Rec.Gender)
                {
                    ApplicationArea = all;
                }
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = all;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
                field("Department Code1"; Rec."Department Code")
                {
                    ApplicationArea = all;
                }

                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    ApplicationArea = all;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = all;
                }

                field("Contract End Date"; Rec."Contract End Date")
                {
                    ApplicationArea = all;
                }

                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = all;
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
                    Caption = 'Assign Transaction';
                    Image = ApplyEntries;
                    Promoted = true;
                    RunObject = Page "PRL-List Transactions";
                    RunPageLink = "Employee Code" = FIELD("No.");
                    ApplicationArea = All;
                }
                separator(Separator18)
                {
                }
                action("View Trans Codes")
                {
                    Caption = 'View Trans Codes';
                    Image = ViewDetails;
                    Promoted = true;
                    RunObject = Page "PRL-List TransCode";
                    ApplicationArea = All;
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
                    Caption = 'Banking Details';
                    Image = BankAccount;
                    RunObject = Page "PRL-Employee Banks";
                    RunPageLink = "Employee Code" = FIELD("No.");
                    ApplicationArea = All;
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
                    Image = UpdateDescription;
                    ApplicationArea = All;

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
                Caption = 'View 2 Pages Payslip';
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin

                    objPeriod.Reset;
                    objPeriod.SetRange(objPeriod.Closed, false);
                    if objPeriod.Find('-') then;
                    SelectedPeriod := objPeriod."Date Opened";

                    //CLEAR(objOcx);
                    //objOcx.fnMandatoryProcesses;

                    //Display payslip report
                    SalCard.SetRange("Employee Code", Rec."No.");
                    SalCard.SetRange(SalCard."Period Filter", SelectedPeriod);
                    REPORT.Run(52017726, true, false, SalCard);
                end;
            }
            action(View3PagePayslip)
            {
                Caption = 'View3 Pages Payslip';
                Image = PaymentHistory;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin

                    objPeriod.Reset;
                    objPeriod.SetRange(objPeriod.Closed, false);
                    if objPeriod.Find('-') then;
                    SelectedPeriod := objPeriod."Date Opened";

                    //CLEAR(objOcx);
                    //objOcx.fnMandatoryProcesses;

                    //Display payslip report
                    SalCard.SetRange("Employee Code", Rec."No.");
                    SalCard.SetRange(SalCard."Period Filter", SelectedPeriod);
                    REPORT.Run(52017726, true, false, SalCard);
                end;
            }
            action("vew payslip")
            {
                Caption = 'vew payslip';
                Image = "Report";
                Promoted = true;
                ApplicationArea = All;
                //todo RunObject = Report "Individual Payslips mst";
            }
            action("Master Payroll Summary")
            {
                Caption = 'Master Payroll Summary';
                Image = "Report";
                Promoted = true;
                ApplicationArea = All;
                //todo  RunObject = Report "Company Payroll Summary";
            }
            action("Deductions Summary 2")
            {
                Caption = 'Deductions Summary 2';
                Image = "Report";
                Promoted = true;
                ApplicationArea = All;
                //todo  RunObject = Report "PRL-Deductions Summary 2";
            }
            action("Earnings Summary 2")
            {
                Caption = 'Earnings Summary 2';
                Image = "Report";
                Promoted = true;
                ApplicationArea = All;
                //todo RunObject = Report "PRL-Payments Summary 2";
            }
            action("Payroll summary")
            {
                Caption = 'Payroll summary';
                Image = Report;
                ApplicationArea = All;
                //todo RunObject = Report "Payroll Summary 2";
            }
            action("Deductions Summary")
            {
                Caption = 'Deductions Summary';
                Image = Report;
                ApplicationArea = All;
                //todo RunObject = Report "PRL-Deductions Summary";
            }
            action("Earnings Summary")
            {
                Caption = 'Earnings Summary';
                Image = DepositSlip;
                ApplicationArea = All;
                //todo RunObject = Report "PRL-Earnings Summary";
            }
            action("Staff pension")
            {
                ApplicationArea = All;
                Caption = 'Staff pension';
                Image = Aging;
                //todo  RunObject = Report "prStaff Pension Contrib";
            }
            action("Gross Netpay")
            {
                ApplicationArea = All;
                Caption = 'Gross Netpay';
                Image = Giro;
                //todo  RunObject = Report prGrossNetPay;
            }
            action("Third Rule")
            {
                ApplicationArea = All;
                Caption = 'Third Rule';
                Image = AddWatch;
                //todo  RunObject = Report "A third Rule Report";
            }
            action("Co_op Remittance")
            {
                ApplicationArea = All;
                Caption = 'Co_op Remittance';
                Image = CreateForm;
                //todo  RunObject = Report "prCoop remmitance";
            }
            separator("setup finance")
            {
                Caption = 'setup finance';
            }
            action("receipt type")
            {
                ApplicationArea = All;
                Caption = 'receipt type';
                Image = ServiceSetup;
                Promoted = true;
                //todo  RunObject = Page "FIN-Receipt Types";
            }
            action(Action39)
            {
                ApplicationArea = All;
                Caption = 'Transactions';
                Image = "Report";
                Promoted = true;
                //todo RunObject = Report "pr Transactions";
            }
            action("bank Schedule")
            {
                ApplicationArea = All;
                Caption = 'bank Schedule';
                Image = "Report";
                Promoted = true;
                //todo  RunObject = Report "pr Bank Schedule";
            }
            separator(Separator36)
            {
            }
            action("Employer Certificate")
            {
                ApplicationArea = All;
                Caption = 'Employer Certificate';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                //todo RunObject = Report "Employer Certificate P.10 mst";
            }
            action("P.10")
            {
                ApplicationArea = All;
                Caption = 'P.10';
                Image = "Report";
                Promoted = true;
                //todo RunObject = Report "P.10 A mst";
            }
            action("Paye Scheule")
            {
                ApplicationArea = All;
                Caption = 'Paye Scheule';
                Image = "Report";
                Promoted = true;
                //todo  RunObject = Report "prPaye Schedule mst";
            }
            action("NHIF Schedult")
            {
                ApplicationArea = All;
                Caption = 'NHIF Schedult';
                Image = "Report";
                Promoted = true;
                //todo RunObject = Report "prNHIF mst";
            }
            action("NSSF Schedule")
            {
                ApplicationArea = All;
                Caption = 'NSSF Schedule';
                Image = "Report";
                Promoted = true;
                //todo RunObject = Report "prNSSF mst";
            }
            separator(Separator29)
            {
            }
            group(periodic)
            {
                Caption = 'periodic';
                action("payroll Journal Transfer")
                {
                    ApplicationArea = All;
                    Caption = 'payroll Journal Transfer';
                    Image = Journals;
                    Promoted = true;
                    //todo RunObject = Report prPayrollJournalTransfer;
                }
                action("mass update Transactions")
                {
                    ApplicationArea = All;
                    Caption = 'mass update Transactions';
                    Image = PostBatch;
                    Promoted = true;
                    //todo RunObject = Report "Mass Update Transactions";
                }
                action("Payroll Period")
                {
                    ApplicationArea = All;
                    Caption = 'Payroll Period';
                    Image = Period;
                    RunObject = Page "PRL-Payroll Periods";
                }
            }
        }
        area(processing)
        {
            action(ProcessPayroll)
            {
                Caption = 'Process Payslip';
                Image = ExecuteBatch;
                Promoted = true;
                PromotedCategory = Process;
                Visible = true;
                ApplicationArea = All;

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
                                                /* ProcessPayroll.fnProcesspayroll(HrEmployee."No.", DOJ, salaryCard."Basic Pay", salaryCard."Pays PAYE"
                                                    , salaryCard."Pays NSSF", salaryCard."Pays NHIF", SelectedPeriod, SelectedPeriod, '', '',
                                                    dateofLeaving, GetsPAYERelief, HrEmployee."Department Code", '', false); */

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


                    SalCard2.Reset;
                    SalCard2.SetRange("Employee Code", Rec."No.");
                    SalCard2.SetRange(SalCard2."Period Filter", SelectedPeriod);

                    //REPORT.RUN(39005514,TRUE,FALSE,SalCard);
                end;
            }
            group(ActionGroup70)
            {
                Caption = 'periodic';
                Description = 'PeriodicActions';
                Image = Administration;
                action(Action69)
                {
                    Caption = 'payroll Journal Transfer';
                    Image = Journals;
                    Promoted = true;
                    ApplicationArea = All;
                    //todo  RunObject = Report prPayrollJournalTransfer;
                }
                action(Action67)
                {
                    Caption = 'mass update Transactions';
                    Image = PostBatch;
                    Promoted = true;
                    ApplicationArea = All;
                    //todo  RunObject = Report "Mass Update Transactions";
                }
                action(Action65)
                {
                    Caption = 'Payroll Period';
                    Image = Period;
                    RunObject = Page "PRL-Payroll Periods";
                    ApplicationArea = All;
                }
                action("Salary Increament Process")
                {
                    Caption = 'Salary Increament Process';
                    Image = AddAction;
                    Promoted = true;
                    RunObject = Page "HRM-Emp. Categories";
                    ApplicationArea = All;
                }
                action("Salary Increament Register")
                {
                    Caption = 'Salary Increament Register';
                    Image = Register;
                    Promoted = true;
                    RunObject = Page "HRM-Salary Increament Register";
                    ApplicationArea = All;
                }
                action("Un-Afected Salary Increaments")
                {
                    Caption = 'Un-Afected Salary Increaments';
                    Image = UndoCategory;
                    Promoted = true;
                    RunObject = Page "HRM-Unaffected Sal. Increament";
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if (DepCode <> '') then
            Rec.SetFilter("Department Code", ' = %1', DepCode);
        if (OfficeCode <> '') then
            Rec.SetFilter(Office, ' = %1', OfficeCode);
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
        //ProcessPayroll: Codeunit prPayrollProcessing;
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

    procedure SetNewFilter(var DepartmentCode: Code[10]; var "Office Code": Code[10])
    begin
        DepCode := DepartmentCode;
        OfficeCode := "Office Code";
    end;
}

