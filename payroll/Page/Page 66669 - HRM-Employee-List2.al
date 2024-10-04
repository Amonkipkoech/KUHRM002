page 62228 "HRM-Employee-List2"
{
    CardPageID = "PRL-Header Salary Card";
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "HRM-Employee (D)";

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
                field("Posting Group"; Rec."Posting Group")
                {
                    ApplicationArea = all;
                }

                field(Initials; Rec.Initials)
                {
                    ApplicationArea = all;
                }

                field("Date Of Join"; Rec."Date Of Join")
                {
                    ApplicationArea = All;
                }

                field("Home Phone Number"; Rec."Home Phone Number")
                {
                    ApplicationArea = All;
                }
                field("Cellular Phone Number"; Rec."Cellular Phone Number")
                {
                    ApplicationArea = All;
                }
                field("Work Phone Number"; Rec."Work Phone Number")
                {
                    ApplicationArea = All;
                }

                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = All;
                }

                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }

                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                }

                field("Marital Status"; Rec."Marital Status")
                {
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
                action("Upload Attachments")
                {
                    ApplicationArea = all;
                    Caption = 'Upload Attachments';
                    Image = Attachments;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HRM- Emp. Attachments (B)";
                    RunPageLink = "Employee No" = FIELD("No.");
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
                    ApplicationArea = all;
                    Caption = 'Pension Details';
                    Image = History;
                    RunObject = Page "PRL-Pension Contrib. Details";
                    RunPageLink = "Employee Code" = FIELD("No.");
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
                ApplicationArea = All;
                Caption = 'vew payslip';
                Image = "Report";
                Promoted = true;
                //todo RunObject = Report "Individual Payslips mst";
                Visible = false;
            }
            action("Master Payroll Summary")
            {
                ApplicationArea = All;
                Caption = 'Master Payroll Summary';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "PRL-Company Payroll Summary 3";
            }
            action("Deductions Summary 2")
            {
                ApplicationArea = All;
                Caption = 'Deductions Summary 2';
                Image = "Report";
                Promoted = true;
                //todo RunObject = Report "PRL-Deductions Summary 2";
            }
            action("Earnings Summary 2")
            {
                ApplicationArea = all;
                Caption = 'Earnings Summary 2';
                Image = "Report";
                Promoted = true;
                //todo  RunObject = Report "PRL-Payments Summary 2";
            }
            action("Payroll summary")
            {
                ApplicationArea = All;
                Caption = 'Payroll summary';
                Image = Report;
                //todo   RunObject = Report "Payroll Summary 2";
            }
            action("Deductions Summary")
            {
                ApplicationArea = All;
                Caption = 'Deductions Summary';
                Image = Simulate;
                //todo  RunObject = Report "PRL-Deductions Summary";
            }
            action("Earnings Summary")
            {
                ApplicationArea = All;
                Caption = 'Earnings Summary';
                Image = DepositSlip;
                //todo   RunObject = Report "PRL-Earnings Summary";
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
                //todo   RunObject = Report prGrossNetPay;
            }
            action("Third Rule")
            {
                ApplicationArea = All;
                Caption = 'Third Rule';
                Image = AddWatch;
                //todo   RunObject = Report "A third Rule Report";
            }
            action("Co_op Remittance")
            {
                ApplicationArea = All;
                Caption = 'Co_op Remittance';
                Image = CreateForm;
                //todo RunObject = Report "prCoop remmitance";
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
                //todo  RunObject = Report "pr Transactions";
            }
            action("bank Schedule")
            {
                ApplicationArea = All;
                Caption = 'bank Schedule';
                Image = "Report";
                Promoted = true;
                //todo   RunObject = Report "pr Bank Schedule";
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
                //todo   RunObject = Report "Employer Certificate P.10 mst";
            }
            action("P.10")
            {
                ApplicationArea = all;
                Caption = 'P.10';
                Image = "Report";
                Promoted = true;
                //todo  RunObject = Report "P.10 A mst";
            }
            action("P9 Report")
            {
                ApplicationArea = All;
                Caption = 'P9 Report';
                Image = Report2;
                Promoted = true;
                PromotedIsBig = true;
                //  RunObject = Report "P9 Report (Final)";
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
                ApplicationArea = all;
                Caption = 'NHIF Schedult';
                Image = "Report";
                Promoted = true;
                //todo  RunObject = Report "prNHIF mst";
            }
            action("NSSF Schedule")
            {
                ApplicationArea = all;
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
                    //  RunObject = Report prPayrollJournalTransfer;
                }
                action("mass update Transactions")
                {
                    ApplicationArea = all;
                    Caption = 'mass update Transactions';
                    Image = PostBatch;
                    Promoted = true;
                    //  RunObject = Report "Mass Update Transactions";
                }
                action("Payroll Period")
                {
                    ApplicationArea = all;
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
                ApplicationArea = all;
                Caption = 'Process Payslip';
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
                    SalesShipmentHeader: Record "Sales Shipment Header";
                    FrmTransCodes: Record "PRL-Transaction Codes";
                    transName: Text[150];
                    cummCredits: Decimal;
                begin
                    ContrInfo.Get;

                    if Confirm('This will process salaries for Permanent Employees, Continue?', false) = false then exit;

                    objPeriod.Reset;
                    objPeriod.SetRange(objPeriod.Closed, false);
                    objPeriod.SetFilter("Payroll Code", '%1', 'PAYROLL');
                    if objPeriod.Find('-') then begin
                        PeriodName := objPeriod."Period Name";
                        SelectedPeriod := objPeriod."Date Opened";
                    end
                    else
                        Error('No open period for the Casuals!');

                    ///CLEAR(StdDailyRate);
                    //StdDailyRate:=objPeriod."Casual Daily Rate";
                    //SalCard.GET("No.");

                    PeriodTrans.Reset;
                    PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                    PeriodTrans.SetFilter("Employee Category", '<>%1', 'CASUALS');
                    if PeriodTrans.Find('-') then
                        PeriodTrans.DeleteAll;


                    //Use CODEUNIT
                    HrEmployee.Reset;
                    HrEmployee.SetRange(HrEmployee.Status, HrEmployee.Status::Active);
                    HrEmployee.SetFilter(HrEmployee."Employee Category", '<>%1', 'CASUALS');
                    if Confirm('Process for the current employee only?', false) = true then
                        HrEmployee.SetRange("No.", Rec."No.");
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

                            //  ProgressWindow.UPDATE(1,HrEmployee."No."+':'+HrEmployee."First Name"+' '+HrEmployee."Middle Name"+' '+HrEmployee."Last Name");
                            salaryCard.Reset;
                            salaryCard.SetRange(salaryCard."Employee Code", HrEmployee."No.");
                            salaryCard.SetRange("Payroll Period", SelectedPeriod);
                            if not salaryCard.Find('-') then begin
                                // If employee has no Basic Salary

                                // Populate Credits Here********************************************************************
                                // Populate Credit Sales for the Month
                                if FRMVitalSetup.Get() then begin
                                    FRMVitalSetup.TestField(FRMVitalSetup."Credit Trans. Code");
                                    SalesShipmentHeader.Reset;
                                    SalesShipmentHeader.SetRange(SalesShipmentHeader."Bill-to Customer No.", HrEmployee."Credit Account");
                                    /* SalesShipmentHeader.SetRange(SalesShipmentHeader."Credit Sale", true);
                                    SalesShipmentHeader.SetRange(SalesShipmentHeader."Payment Period", SelectedPeriod); */
                                    Clear(cummCredits);
                                    if SalesShipmentHeader.Find('-') then begin
                                        repeat
                                        begin
                                            /* SalesShipmentHeader.CalcFields("Document Amount");
                                            if SalesShipmentHeader."Document Amount" <> 0 then cummCredits := cummCredits + SalesShipmentHeader."Document Amount"; */
                                        end;
                                        until SalesShipmentHeader.Next = 0;
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
                                                prempTrns.Insert;
                                                prempTrns.Validate("Transaction Code");
                                            end else begin
                                                //Update
                                                prempTrns."Recurance Index" := 99;
                                                prempTrns.Balance := cummCredits;
                                                prempTrns."Transaction Name" := transName;
                                                prempTrns.Amount := cummCredits;
                                                prempTrns.Modify;
                                                prempTrns.Validate("Transaction Code");
                                            end;

                                        end;
                                    end;
                                end;

                                //Populate Credits ********************************************************************END**
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
                                /* ProcessPayroll.fnProcesspayroll(HrEmployee."No.", DOJ, 0, false
                                , false, false, SelectedPeriod, SelectedPeriod, '', '',
                                dateofLeaving, false, HrEmployee."Department Code"); */
                                ProcessPayroll.fnProcesspayroll(HrEmployee."No.", DOJ, salaryCard."Basic Pay", salaryCard."Pays PAYE"
                    , salaryCard."Pays NSSF", salaryCard."Pays NHIF", SelectedPeriod, SelectedPeriod, '', '',
                    dateofLeaving, GetsPAYERelief, HrEmployee."Department Code", PayrollCode, true);


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

                                                /*  ProcessPayroll.fnProcesspayroll(HrEmployee."No.", DOJ, salaryCard."Basic Pay", salaryCard."Pays PAYE"
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
                    ApplicationArea = all;

                    Caption = 'payroll Journal Transfer';
                    Image = Journals;
                    Promoted = true;
                    // RunObject = Report prPayrollJournalTransfer;
                }
                action(Action67)
                {
                    ApplicationArea = all;

                    Caption = 'mass update Transactions';
                    Image = PostBatch;
                    Promoted = true;
                    // RunObject = Report "Mass Update Transactions";
                }
                action(Action65)
                {
                    ApplicationArea = all;
                    Caption = 'Payroll Period';
                    Image = Period;
                    RunObject = Page "PRL-Payroll Periods";
                }
                action("Salary Increament Process")
                {
                    ApplicationArea = all;
                    Caption = 'Salary Increament Process';
                    Image = AddAction;
                    Promoted = true;
                    RunObject = Page "HRM-Emp. Categories";
                }
                action("Salary Increament Register")
                {
                    ApplicationArea = all;
                    Caption = 'Salary Increament Register';
                    Image = Register;
                    Promoted = true;
                    RunObject = Page "HRM-Salary Increament Register";
                }
                action("Un-Afected Salary Increaments")
                {
                    ApplicationArea = all;
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
        if (DepCode <> '') then
            Rec.SetFilter("Department Code", ' = %1', DepCode);
        if (OfficeCode <> '') then
            Rec.SetFilter(Office, ' = %1', OfficeCode);
    end;

    var
        //  Mail: Codeunit Mail;
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

    procedure SetNewFilter(var DepartmentCode: Code[10]; var "Office Code": Code[10])
    begin
        DepCode := DepartmentCode;
        OfficeCode := "Office Code";
    end;
}

