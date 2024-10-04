page 85536 "HRM-WorkStudy Pay List"
{
    CardPageID = "PRL-WorkStudy Pay Card";
    Editable = true;
    PageType = List;
    SourceTable = "HRM-Employee (D)";
    SourceTableView = WHERE("Employee Category" = FILTER('WORKSTUDY'));

    // SORTING("No.")
    // ORDER(Ascending)

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
                field("Employee Category"; Rec."Employee Category")
                {
                    ApplicationArea = all;
                }
                field("Daily Rate"; Rec."Daily Rate")
                {
                    ApplicationArea = all;
                    Caption = 'Hourly Rate';
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = all;
                }
                field("Main Bank"; Rec."Main Bank")
                {
                    ApplicationArea = all;
                }
                field("Branch Bank"; Rec."Branch Bank")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Bank Account Number"; Rec."Bank Account Number")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Home Phone Number"; Rec."Home Phone Number")
                {
                    ApplicationArea = all;
                }
                field("Cellular Phone Number"; Rec."Cellular Phone Number")
                {
                    ApplicationArea = all;
                }
                field("Work Phone Number"; Rec."Work Phone Number")
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
                field("Department Code1"; Rec."Department Code")
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
                    ApplicationArea = all;
                    Caption = 'Assign Transaction';
                    Image = ApplyEntries;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "PRL-Casual Emp. Transactions";
                    RunPageLink = "Employee Code" = FIELD("No.");
                }
            }
        }
        area(reporting)
        {
            action(View2PagePayslip)
            {
                ApplicationArea = all;
                Caption = 'View 2 Pages Payslip';
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    objPeriod.Reset;
                    objPeriod.SetRange(objPeriod.Closed, false);
                    //objPeriod.SETFILTER(objPeriod."Payroll Code",'%1|%2','CASUAL','CASUALS');
                    if objPeriod.Find('-') then;
                    SelectedPeriod := objPeriod."Date Openned";

                    SalCard.Reset;
                    SalCard.SetRange(SalCard."Employee Code", Rec."No.");
                    SalCard.SetRange(SalCard."Payroll Period", SelectedPeriod);
                    SalCard.SetRange("Current Instalment", objPeriod."Current Instalment");
                    if SalCard.Find('-') then
                        REPORT.Run(70252, true, false, SalCard);
                end;
            }
            action(ViewhorPayslip)
            {
                ApplicationArea = all;
                Caption = 'Payslip (Horizontal)';
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    objPeriod.Reset;
                    objPeriod.SetRange(objPeriod.Closed, false);
                    //objPeriod.SETFILTER(objPeriod."Payroll Code",'%1|%2','CASUAL','CASUALS');
                    if objPeriod.Find('-') then;
                    SelectedPeriod := objPeriod."Date Openned";

                    SalCard.Reset;
                    SalCard.SetRange(SalCard."Employee Code", Rec."No.");
                    SalCard.SetRange(SalCard."Payroll Period", SelectedPeriod);
                    SalCard.SetRange("Current Instalment", objPeriod."Current Instalment");
                    if SalCard.Find('-') then
                        REPORT.Run(70258, true, false, SalCard);
                end;
            }
            action("Bank Schedule")
            {
                ApplicationArea = all;
                Caption = 'Bank Schedule';
                Image = "Report";
                Promoted = true;
                //todo  RunObject = Report "Post Casual Salaries";
            }
            action("NHIF - Casual")
            {
                ApplicationArea = all;
                Caption = 'NHIF - Casual';
                Image = "Report";
                Promoted = true;
                //todo  RunObject = Report "Casual-NHIF";
            }
            action("NSSF - Casual")
            {
                ApplicationArea = all;
                Caption = 'NSSF - Casual';
                //  Image = payslip;
                // RunObject = Report "Casual-NSSF";
            }
            action("Casual - Payroll Summary")
            {
                ApplicationArea = all;
                Caption = 'Casual - Payroll Summary';
                Image = Giro;
                //  RunObject = Report "Casual Payroll Summary";
            }
            action("Casual-Deductions Summar 2")
            {
                ApplicationArea = all;
                Caption = 'Casual-Deductions Summar 2';
                //Image = "report";
                Promoted = true;
                // RunObject = Report "Casual-Deductions Summary 2";
            }
            action("Casual - Payments Summary")
            {
                ApplicationArea = all;
                Caption = 'Casual - Payments Summary';
                Image = Report2;
                Promoted = true;
                PromotedIsBig = true;
                //   RunObject = Report "Casual - Payments Summary";
            }
            action("Casual - NHIF Report 2")
            {
                ApplicationArea = all;
                Caption = 'Casual - NHIF Report 2';
                //   Image = "report";
                Promoted = true;
                // RunObject = Report "Casual - NHIF Report";
            }
            action("Casual - NSSF Report (A)")
            {
                ApplicationArea = all;
                Caption = 'Casual - NSSF Report (A)';
                //  Image = "report";
                Promoted = true;
                //  RunObject = Report "Casual - NSSF Report (A)";
            }
            action("Casual-NSSF Report (B)")
            {
                ApplicationArea = all;
                Caption = 'Casual-NSSF Report (B)';
                // Image = "report";
                Promoted = true;
                //RunObject = Report "Casual-NSSF Report (B)";
            }
            action("Casual PAYE Schedule")
            {
                ApplicationArea = all;
                Caption = 'Casual PAYE Schedule';
                // Image = "page";
                Promoted = true;
                PromotedIsBig = true;
                //  RunObject = Report "Casual - PAYE Schedule";
            }
            action("Casual Summary 1")
            {
                ApplicationArea = all;
                Caption = 'Casual Summary 1';
                //  Image = "report";
                Promoted = true;
                //RunObject = Report "Casuals Summary Report";
            }
            action("Casual Pay Summary")
            {
                ApplicationArea = all;
                Caption = 'Casual Pay Summary';
                // Image = "report";
                Promoted = true;
                //  RunObject = Report "Casual-Company Payslip";
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
                    prempTrns: Record "PRL-Casual Emp. Transactions";
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
                    computedBasic: Decimal;
                    PRLEmployeeDaysWorked: Record "PRL Employee Days Worked";
                    StdDailyRate: Decimal;
                    prempTrns2: Record "PRL-Casual Emp. Transactions";
                begin
                    ContrInfo.Get;

                    if Confirm('This will process salaries for Casual Employees, Continue?', false) = false then exit;

                    objPeriod.Reset;
                    objPeriod.SetRange(objPeriod.Closed, false);
                    //objPeriod.SETFILTER("Payroll Code",'%1|%2','CASUALS','CASUAL');
                    if objPeriod.Find('-') then
                        SelectedPeriod := objPeriod."Date Openned"
                    else
                        Error('No open period for the Casuals!');

                    Clear(StdDailyRate);
                    StdDailyRate := objPeriod."Casuals Daily Rate";
                    //SalCard.GET("No.");

                    PeriodTrans.Reset;
                    PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                    PeriodTrans.SetRange("Current Instalment", objPeriod."Current Instalment");
                    // PeriodTrans.SETFILTER("Employee Category",'%1|%2','CASUALS','CASUAL');
                    if PeriodTrans.Find('-') then
                        PeriodTrans.DeleteAll;


                    //Use CODEUNIT
                    HrEmployee.Reset;
                    HrEmployee.SetRange(HrEmployee.Status, HrEmployee.Status::Active);
                    HrEmployee.SetFilter(HrEmployee."Employee Category", '%1|%2', 'CASUALS', 'CASUAL');
                    //HrEmployee.SETRANGE(HrEmployee.Status,HrEmployee.Status::Normal);
                    if HrEmployee.Find('-') then begin
                        PeriodTrans.Reset;
                        PeriodTrans.SetRange(PeriodTrans."Employee Code", HrEmployee."No.");
                        PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                        PeriodTrans.SetRange("Current Instalment", objPeriod."Current Instalment");
                        if PeriodTrans.Find('-') then
                            PeriodTrans.DeleteAll;
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

                            Clear(ArreasVal_A);
                            Clear(ArreasVal_D);
                            ///////////////////?????????????????????????????????????????????????????????????????????????????????
                            if objPeriod."Current Instalment" = 2 then begin
                                // Compute Advance for 1st Instalments
                                PeriodTrans.Reset;
                                PeriodTrans.SetRange(PeriodTrans."Employee Code", HrEmployee."No.");
                                PeriodTrans.SetRange(PeriodTrans."Payroll Period", objPeriod."Date Openned");
                                PeriodTrans.SetRange("Current Instalment", 1);
                                PeriodTrans.SetRange("Transaction Code", 'GPAY');
                                if PeriodTrans.Find('-') then begin
                                    ArreasVal_A := PeriodTrans.Amount;
                                    ArreasVal_D := PeriodTrans.Amount;
                                end;
                                //Insert Income
                                prempTrns2.Reset;
                                prempTrns2.SetRange(prempTrns2."Employee Code", HrEmployee."No.");
                                prempTrns2.SetRange(prempTrns2."Payroll Period", objPeriod."Date Openned");
                                prempTrns2.SetRange(prempTrns2."Transaction Code", 'ADVANCE_A');
                                prempTrns2.SetRange(prempTrns2."Current Instalment", 2);
                                if prempTrns2.Find('-') then begin
                                    // update
                                    prempTrns2."Recurance Index" := 1;
                                    prempTrns2.Balance := 0;
                                    prempTrns2."Transaction Name" := 'First Instalment Payment';
                                    prempTrns2.Amount := ArreasVal_A;
                                    prempTrns2.Modify;
                                end else begin
                                    //Update
                                    prempTrns2.Init;
                                    prempTrns2."Employee Code" := HrEmployee."No.";
                                    prempTrns2.Validate("Payroll Period", objPeriod."Date Openned");
                                    prempTrns2."Period Year" := Date2DMY(objPeriod."Date Openned", 3);
                                    prempTrns2."Period Month" := Date2DMY(objPeriod."Date Openned", 2);
                                    prempTrns2."Transaction Code" := 'ADVANCE_A';
                                    prempTrns2."Transaction Name" := 'First Instalment Payment';
                                    prempTrns2."Current Instalment" := 2;
                                    // prempTrns2.VALIDATE("Transaction Code");
                                    prempTrns2."Recurance Index" := 1;
                                    prempTrns2.Balance := 0;
                                    prempTrns2.Amount := ArreasVal_A;
                                    prempTrns2.Insert;
                                    //  prempTrns.VALIDATE("Transaction Code");
                                end;
                                // Deduct The Advance Payment again throug deductions
                                prempTrns2.Reset;
                                prempTrns2.SetRange(prempTrns2."Employee Code", HrEmployee."No.");
                                prempTrns2.SetRange(prempTrns2."Payroll Period", objPeriod."Date Openned");
                                prempTrns2.SetRange(prempTrns2."Transaction Code", 'ADVANCE_D');
                                prempTrns2.SetRange(prempTrns2."Current Instalment", 2);
                                if (prempTrns2.Find('-')) then begin
                                    //Update
                                    prempTrns2."Recurance Index" := 1;
                                    prempTrns2.Balance := 0;
                                    prempTrns2."Transaction Name" := 'First Instalment Payment';
                                    prempTrns2.Amount := ArreasVal_D;
                                    prempTrns2.Modify;
                                end else begin
                                    // Insert
                                    prempTrns2.Init;
                                    prempTrns2."Employee Code" := HrEmployee."No.";
                                    prempTrns2.Validate("Payroll Period", objPeriod."Date Openned");
                                    prempTrns2."Period Year" := Date2DMY(objPeriod."Date Openned", 3);
                                    prempTrns2."Period Month" := Date2DMY(objPeriod."Date Openned", 2);
                                    prempTrns2."Transaction Code" := 'ADVANCE_D';
                                    prempTrns2."Transaction Name" := 'First Instalment Deduction';
                                    prempTrns2."Current Instalment" := 2;
                                    // prempTrns2.VALIDATE("Transaction Code");
                                    prempTrns2."Recurance Index" := 1;
                                    prempTrns2.Balance := 0;
                                    prempTrns2.Amount := ArreasVal_D;
                                    prempTrns2.Insert;
                                    //  prempTrns2.VALIDATE("Transaction Code");
                                end;
                            end;
                            ///////////////////?????????????????????????????????????????????????????????????????????????????????

                            // Get Basic Salary
                            PeriodTrans.Reset;
                            PeriodTrans.SetRange(PeriodTrans."Employee Code", HrEmployee."No.");
                            PeriodTrans.SetRange(PeriodTrans."Payroll Period", objPeriod."Date Openned");
                            PeriodTrans.SetRange("Current Instalment", objPeriod."Current Instalment");
                            if PeriodTrans.Find('-') then
                                PeriodTrans.DeleteAll;
                            Clear(computedBasic);
                            /*PRLEmployeeDaysWorked.RESET;
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
                              END;*/

                            computedBasic := 0;
                            if computedBasic = 0 then begin
                                //update or insert SalaryCard

                                /*salaryCard.RESET;
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
                                 END;*/
                                salaryCard.Reset;
                                salaryCard.SetRange(salaryCard."Employee Code", HrEmployee."No.");
                                salaryCard.SetRange("Payroll Period", objPeriod."Date Openned");
                                salaryCard.SetRange("Current Instalment", objPeriod."Current Instalment");
                                if salaryCard.Find('-') then begin
                                end;

                                dateofJoining := 0D;
                                dateofLeaving := CalcDate('-1M', Today);
                                if HrEmployee."Date Of Join" = 0D then dateofJoining := CalcDate('-1M', Today);
                                //Progress Window


                                //  ProgressWindow.UPDATE(1,HrEmployee."No."+':'+HrEmployee."First Name"+' '+HrEmployee."Middle Name"+' '+HrEmployee."Last Name");
                                //IF SalCard.GET(HrEmployee."No.") THEN BEGIN

                                if not salaryCard.Find('-') then begin
                                    // If employee has no Basic Salary

                                    // Populate Credits Here********************************************************************
                                    // Populate Credit Sales for the Month
                                    /* IF FRMVitalSetup.GET() THEN BEGIN
                                       FRMVitalSetup.TESTFIELD(FRMVitalSetup."Credit Trans. Code");
                                       SalesShipmentHeader.RESET;
                                       SalesShipmentHeader.SETRANGE(SalesShipmentHeader."Bill-to Customer No.",HrEmployee."Credit Account");
                                       SalesShipmentHeader.SETRANGE(SalesShipmentHeader."Credit Sale",TRUE);
                                       SalesShipmentHeader.SETRANGE(SalesShipmentHeader."Payment Period",SelectedPeriod);
                                       CLEAR(cummCredits);
                                       IF SalesShipmentHeader.FIND('-') THEN BEGIN
                                           REPEAT
                                             BEGIN
                                             SalesShipmentHeader.CALCFIELDS("Document Amount");
                                             IF SalesShipmentHeader."Document Amount"<>0 THEN cummCredits:=cummCredits+SalesShipmentHeader."Document Amount";
                                             END;
                                             UNTIL SalesShipmentHeader.NEXT=0;
                                             IF cummCredits<>0 THEN BEGIN
                                               transName:='';
                                               IF FrmTransCodes.GET(FRMVitalSetup."Credit Trans. Code") THEN transName:=FrmTransCodes."Transaction Name";
                                                 prempTrns.RESET;
                                               prempTrns.SETRANGE(prempTrns."Employee Code",HrEmployee."No.");
                                               prempTrns.SETRANGE(prempTrns."Payroll Period",SelectedPeriod);
                                               prempTrns.SETRANGE(prempTrns."Transaction Code",FRMVitalSetup."Credit Trans. Code");
                                               IF NOT (prempTrns.FIND('-')) THEN BEGIN
                                                 // Insert
                                                 prempTrns.INIT;
                                                 prempTrns."Employee Code":=HrEmployee."No.";
                                                 prempTrns."Payroll Period":=SelectedPeriod;
                                                 prempTrns."Period Year":=DATE2DMY(SelectedPeriod,3);
                                                 prempTrns."Period Month":=DATE2DMY(SelectedPeriod,2);
                                                 prempTrns."Transaction Code":=FRMVitalSetup."Credit Trans. Code";
                                                 prempTrns."Transaction Name":=transName;
                                                 prempTrns.VALIDATE("Transaction Code");
                                                 prempTrns."Recurance Index":=99;
                                                 prempTrns.Balance:=cummCredits;
                                                 prempTrns.Amount:=cummCredits;
                                                 prempTrns.INSERT;
                                                 prempTrns.VALIDATE("Transaction Code");
                                                 END ELSE BEGIN
                                                   //Update
                                                 prempTrns."Recurance Index":=99;
                                                 prempTrns.Balance:=cummCredits;
                                                 prempTrns."Transaction Name":=transName;
                                                 prempTrns.Amount:=cummCredits;
                                                 prempTrns.MODIFY;
                                                 prempTrns.VALIDATE("Transaction Code");
                                                   END;

                                               END;
                                         END;
                                       END;*/

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
                                    /*
                                ProcessPayroll.fnProcesspayroll(HrEmployee."No.",DOJ,0,FALSE
                                    ,FALSE,FALSE,SelectedPeriod,SelectedPeriod,'','',
                                    dateofLeaving,FALSE,HrEmployee."Department Code",HrEmployee."Payroll Code",TRUE,objPeriod."Current Instalment");
                                    */

                                    //END;// Hast Transaction
                                end else
                                    if salaryCard.Find('-') then begin
                                        GetsPAYERelief := true;
                                        DOJ := 0D;
                                        if HrEmployee."Date Of Join" = 0D then DOJ := CalcDate('-2M', Today) else DOJ := HrEmployee."Date Of Join";
                                        /* IF salaryCard."Suspend Pay"<>TRUE THEN BEGIN
                                          //IF salaryCard."Gets Personal Relief"=salaryCard."Gets Personal Relief"::"1" THEN GetsPAYERelief:=TRUE ELSE GetsPAYERelief:=FALSE;
                                          GetsPAYERelief:=TRUE;
                                          DOJ:=0D;
                                          IF HrEmployee."Date Of Join"=0D THEN DOJ:=CALCDATE('-2M',TODAY) ELSE DOJ:=HrEmployee."Date Of Join";
                                         salaryCard.RESET;
                                         salaryCard.SETRANGE(salaryCard."Employee Code",HrEmployee."No.");
                                         salaryCard.SETFILTER(salaryCard.Closed,'=%1',FALSE);
                                         IF salaryCard.FIND('-') THEN BEGIN
                                         IF salaryCard."Suspend Pay"=TRUE THEN BEGIN
                                              PeriodTrans.RESET;
                                              PeriodTrans.SETRANGE(PeriodTrans."Employee Code",HrEmployee."No.");
                                              PeriodTrans.SETRANGE(PeriodTrans."Payroll Period",SelectedPeriod);
                                              PeriodTrans.DELETEALL;
                                         END// delete stuff from transactions table
                                         ELSE BEGIN*/
                                        /* ProcessPayroll.fnProcesspayroll(HrEmployee."No.", DOJ, (salaryCard."Days Worked" * salaryCard."Daily Rate"), false
                                            , true, true, SelectedPeriod, SelectedPeriod, '', '',
                                            dateofLeaving, GetsPAYERelief, HrEmployee."Department Code", HrEmployee."Payroll Code", true, objPeriod."Current Instalment"); */

                                        Clear(Var1);
                                        counts := counts + 1;
                                        if ((counted = 21) or (counted = 11)) then begin
                                            if counted = 21 then counted := 0;
                                            Sleep(150);
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
                                        //  SLEEP(50);
                                        // END;
                                        // END;
                                        //   END;
                                    end;
                            end;
                        until HrEmployee.Next = 0;
                        ////Progress Window
                        progre.Close;
                    end;

                end;
            }
            group(periodic)
            {
                Caption = 'periodic';
                Description = 'PeriodicActions';
                Image = Administration;
                action("Payroll Period")
                {
                    ApplicationArea = all;
                    Caption = 'Payroll Period';
                    Image = Period;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "PRL-Casual Payroll Periods";
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
        ArreasVal_A: Decimal;
        ArreasVal_D: Decimal;
        Mail: Codeunit Mail;
        PictureExists: Boolean;
        DepCode: Code[10];
        OfficeCode: Code[10];
        objEmp: Record "HRM-Employee (D)";
        SalCard: Record "PRL Employee Days Worked";
        objPeriod: Record "PRL-Casual Payroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodMonth: Integer;
        PeriodYear: Integer;
        //ProcessPayroll: Codeunit "prPayrollProcessing Casual";
        HrEmployee: Record "HRM-Employee (D)";
        ProgressWindow: Dialog;
        prPeriodTransactions: Record "PRL-Casual Period Transactions";
        prEmployerDeductions: Record "PRL-Casual Employer Deductions";
        PayrollType: Record "PRL-Payroll Type";
        Selection: Integer;
        PayrollDefined: Text[30];
        PayrollCode: Code[10];
        NoofRecords: Integer;
        i: Integer;
        ContrInfo: Record "HRM-Control-Information";
        HREmp: Record "HRM-Employee (D)";
        j: Integer;
        PeriodTrans: Record "PRL-Casual Period Transactions";
        salaryCard: Record "PRL Employee Days Worked";
        dateofJoining: Date;
        dateofLeaving: Date;
        GetsPAYERelief: Boolean;
        DOJ: Date;
        SalCard2: Record "PRL Employee Days Worked";

    procedure SetNewFilter(var DepartmentCode: Code[10]; var "Office Code": Code[10])
    begin
        DepCode := DepartmentCode;
        OfficeCode := "Office Code";
    end;
}

