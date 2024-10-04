report 50941 "PRL-Company Payroll Summary 4"
{
    DefaultLayout = RDLC;
    RDLCLayout = './payroll/Report/SSR/PRL-Company Payroll Summary 3.rdl';

    dataset
    {
        dataitem(prPeriod_Transactions; "PRL-Period Transactions")
        {
            DataItemTableView = SORTING("Payroll Period", "Group Order", "Sub Group Order")
                                ORDER(Ascending)
                                WHERE("Group Order" = FILTER(1 | 3 | 4 | 6 | 7 | 8 | 9 | 11 | 14 | 16),
                                "Transaction Code" = FILTER(<> 'TOT-DED'));
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(COMPANYNAME_Control1102755015; COMPANYNAME)
            {
            }
            column(COMPANYNAME_Control1102756027; COMPANYNAME)
            {
            }
            column(COMPANYNAME_Control1102756028; COMPANYNAME)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Picture_Control1102756014; CompanyInfo.Picture)
            {
            }
            column(PayrollSummary; 'COMPANY PAYROLL SUMMARY')
            {
            }
            column(PeriodNamez; 'PERIOD:  ' + PeriodName)
            {
            }
            column(TransDesc; 'TRANSACTION DESC.')
            {
            }
            column(payments; 'PAYMENTS')
            {
            }
            column(deductions; 'DEDUCTIONS')
            {
            }
            column(kirinyagatitle; COMPANYNAME)
            {
            }
            column(abreviation; 'TOM MBOYA UNIVERSITY')
            {
            }
            column(DetDate; DetDate)
            {
            }
            column(GPY; GPY)
            {
            }
            column(NETS; NETS)
            {
            }
            column(STAT; STAT)
            {
            }
            column(ENSSF; ENSSF)
            {

            }
            column(EProv; EProv)
            {

            }
            column(DED; DED)
            {
            }
            column(Ehlevi; Ehlevi)
            {

            }
            column(TransTypes; TransTypes)
            {
            }
            column(TransCode; prPeriod_Transactions."Transaction Code")
            {
            }
            column(TransName; prPeriod_Transactions."Transaction Name")
            {
            }
            column(TransAmount; prPeriod_Transactions.Amount)
            {
            }
            column(DeductionAmnt; DeductionAmnt)
            {
            }
            column(PaymentAmount; PaymentAmount)
            {
            }
            column(activeStaff; HRMEmployeeD."Employee Arc. Qty")
            {

            }
            column(Go; prPeriod_Transactions."Group Order")
            {
            }
            column(SGO; prPeriod_Transactions."Sub Group Order")
            {
            }
            column(payRollEmp; payRollEmp)
            {

            }
            column(arreas; arreas)
            {

            }
            column(final; Format(final))
            {

            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(DeductionAmnt);
                CLEAR(GPY);
                CLEAR(STAT);
                CLEAR(DED);
                CLEAR(NETS);
                Clear(ENSSF);
                Clear(EProv);


                IF ((prPeriod_Transactions."Group Order" = 4) AND (prPeriod_Transactions."Sub Group Order" = 0)) THEN
                    GPY := prPeriod_Transactions.Amount;

                //IF  THEN
                // STAT:=prPeriod_Transactions.Amount;

                //IF ((prPeriod_Transactions."Group Order"=8) AND
                //((prPeriod_Transactions."Sub Group Order"=1) OR (prPeriod_Transactions."Sub Group Order"=0))) THEN
                /*IF (((prPeriod_Transactions."Group Order"=7) AND
               ((prPeriod_Transactions."Sub Group Order"=3) OR (prPeriod_Transactions."Sub Group Order"=1) OR
                (prPeriod_Transactions."Sub Group Order"=2))) OR
                (prPeriod_Transactions."Transaction Code"='TOT-DED' )) THEN */


                //IF ((prPeriod_Transactions."Group Order"=9) AND (prPeriod_Transactions."Sub Group Order"=0)) THEN
                IF (prPeriod_Transactions."Transaction Code" = 'NPAY') THEN
                    NETS := prPeriod_Transactions.Amount;

                IF (prPeriod_Transactions."Transaction Code" = 'NSSF EMPLOYER') THEN
                    ENSSF := prPeriod_Transactions.Amount;

                IF (prPeriod_Transactions."Transaction Code" = 'NEMPRPENSION') THEN
                    EProv := prPeriod_Transactions.Amount;
                IF (prPeriod_Transactions."Transaction Code" = 'HE-LEVI') THEN
                    Ehlevi := prPeriod_Transactions.Amount;


                CLEAR(TransTypes);
                IF (prPeriod_Transactions."Group Text" IN ['INCOME', 'EARNINGS', 'ALLOWANCE', 'ALLOWANCES', 'BASIC SALARY', 'GROSS PAY', 'NEMPRPENSION', 'NSSF EMPLOYER']) THEN TransTypes := 'PAYMENTS';

                IF (prPeriod_Transactions."Group Text" IN ['STATUTORIES', 'DEDUCTIONS']) THEN BEGIN
                    TransTypes := 'DEDUCTIONS';
                    DED := prPeriod_Transactions.Amount;
                END;

                IF TransTypes = '' THEN BEGIN
                    IF NOT ((prPeriod_Transactions."Transaction Code" = 'NPAY') OR (prPeriod_Transactions."Transaction Code" = 'TOT-DED')) THEN
                        CurrReport.SKIP;
                END;

                IF (prPeriod_Transactions."Group Text" IN ['INCOME', 'EARNINGS', 'ALLOWANCE', 'ALLOWANCES', 'BASIC SALARY', 'GROSS PAY', 'NEMPRPENSION', 'NSSF EMPLOYER']) THEN PaymentAmount := prPeriod_Transactions.Amount;
                IF (prPeriod_Transactions."Group Text" IN ['STATUTORIES', 'DEDUCTIONS']) THEN DeductionAmnt := prPeriod_Transactions.Amount;
                HRMEmployeeD.Reset();
                HRMEmployeeD.SetRange("Include In Payroll", true);
                if HRMEmployeeD.Find('-') then begin
                    payRollEmp := 0;
                    repeat
                        payRollEmp := payRollEmp + 1
                    until
                    HRMEmployeeD.Next() = 0;
                end;
                /*
                
                //TotalsAllowances:=TotalsAllowances+"prPeriod Transactions".Amount;
                    IF ((prPeriod_Transactions."Group Order"=1) OR
                    (prPeriod_Transactions."Group Order"=3) OR
                     ((prPeriod_Transactions."Group Order"=4) AND (prPeriod_Transactions."Sub Group Order"<>0))) THEN BEGIN // A Payment
                     { CLEAR(countz);
                     // countz:=1;
                      CLEAR(found);
                      REPEAT
                     BEGIN
                       countz:=countz+1;
                       IF (PayTrans[countz])=prPeriod_Transactions."Transaction Name" THEN found:=TRUE;
                       END;
                      UNTIL ((countz=(ARRAYLEN(PayTransAmt))) OR ((PayTrans[countz])=prPeriod_Transactions."Transaction Name")
                      OR ((PayTrans[countz])=''));
                     rows:= countz;
                    PayTrans[rows]:=prPeriod_Transactions."Transaction Name";
                    PayTransAmt[rows]:=PayTransAmt[rows]+prPeriod_Transactions.Amount;}
                    //TransTypes:='INCOME';
                    END ELSE IF (((prPeriod_Transactions."Group Order"=7) AND ((prPeriod_Transactions."Sub Group Order"<>6)
                    AND (prPeriod_Transactions."Sub Group Order"<>5))) OR
                    ((prPeriod_Transactions."Group Order"=8) AND (prPeriod_Transactions."Sub Group Order"<>9))) THEN BEGIN
                    {  CLEAR(countz);
                     // countz:=1;
                      CLEAR(found);
                     // prPeriod_Transactions.setcurrentkey("Transaction Name");
                      REPEAT
                     BEGIN
                       countz:=countz+1;
                       IF (DedTrans[countz])=prPeriod_Transactions."Transaction Name" THEN found:=TRUE;
                       END;
                      UNTIL ((countz=(ARRAYLEN(DedTransAmt))) OR ((DedTrans[countz])=prPeriod_Transactions."Transaction Name")
                      OR ((DedTrans[countz])=''));
                     rows:= countz;
                    DedTrans[rows]:=prPeriod_Transactions."Transaction Name";
                    DedTransAmt[rows]:=DedTransAmt[rows]+prPeriod_Transactions.Amount;}
                
                    END;
                    END; // If Amount >0;
                END;
                UNTIL prPeriod_Transactions.NEXT=0;
                END;// End prPeriod_Transactions Repeat
                // MESSAGE('Heh'+FORMAT(rows)+', '+FORMAT(rows2));
                */
                if HRMEmployeeD.Get("Employee Code") then
                    if ((HRMEmployeeD."Employee Category" = 'CASUALS') OR (HRMEmployeeD."Employee Category" = 'PART-TIME'))
                        then
                        CurrReport.Skip;


            end;

            trigger OnPreDataItem()
            begin

                //LastFieldNo := FIELDNO("Period Year");
                //"PRL-Payroll Periods".SETFILTER("PRL-Payroll Periods"."Date Opened",'=%1',SelectedPeriod);
                prPeriod_Transactions.SETFILTER("Payroll Period", '=%1', SelectedPeriod);


            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(periodfilter; PeriodFilter)
                {
                    Caption = 'Period Filter';
                    TableRelation = "PRL-Payroll Periods"."Date Opened";
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        objPeriod.RESET;
        objPeriod.SETRANGE(objPeriod.Closed, FALSE);
        IF objPeriod.FIND('-') THEN;
        PeriodFilter := objPeriod."Date Opened";
    end;

    trigger OnPreReport()
    begin

        SelectedPeriod := PeriodFilter;
        objPeriod.RESET;
        objPeriod.SETRANGE(objPeriod."Date Opened", SelectedPeriod);
        IF objPeriod.FIND('-') THEN BEGIN
            PeriodName := objPeriod."Period Name";
            CLEAR(DetDate);
            DetDate := FORMAT(objPeriod."Period Name");
        END;
        arreas := 0;
        prl.Reset();
        prl.SetRange("Payroll Period", SelectedPeriod);
        prl.SetRange("Transaction Code", 'D-55');
        IF prl.Find('-') then begin
            repeat
                arreas := prl.Amount + arreas
            until prl.Next() = 0;
            //prl.Reset();
            // prl.SetRange("Transaction Code", 'D-56');
            // IF prl.Find('-') then begin
            //     repeat
            //         arreas2 := prl.Amount + arreas2
            //     until prl.Next() = 0;
            // end;
            final := arreas;
        end;




        IF CompanyInfo.GET() THEN
            CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
        CLEAR(rows);
        CLEAR(GPY);
        CLEAR(STAT);
        CLEAR(DED);
        CLEAR(NETS);
        Clear(ENSSF);
        Clear(EProv);
    end;

    var
        final: Decimal;
        arreas: Decimal;
        arreas2: Decimal;
        DetDate: Text[100];
        found: Boolean;
        countz: Integer;
        PeriodFilter: Date;
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        objPeriod: Record "PRL-Payroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        CompanyInfo: Record 79;
        TotalsAllowances: Decimal;
        Dept: Boolean;
        PaymentDesc: Text[200];
        DeductionDesc: Text[200];
        GroupText1: Text[200];
        GroupText2: Text[200];
        PaymentAmount: Decimal;
        DeductAmount: Decimal;
        PayTrans: array[100] of Text[250];
        PayTransAmt: array[100] of Decimal;
        DedTrans: array[100] of Text[250];
        DedTransAmt: array[100] of Decimal;
        rows: Integer;
        rows2: Integer;
        GPY: Decimal;
        NETS: Decimal;
        ENSSF: Decimal;
        EProv: Decimal;
        STAT: Decimal;
        DED: Decimal;
        TotalFor: Label 'Total for ';
        GroupOrder: Label '3';
        TransBal: array[2, 100] of Text[250];
        Addr: array[2, 10] of Text[250];
        RecordNo: Integer;
        NoOfColumns: Integer;
        ColumnNo: Integer;
        TransTypes: Code[20];
        PayAmount: Decimal;
        DeductionAmnt: Decimal;
        HRMEmployeeD: Record "HRM-Employee (D)";
        salCard: Record "PRL-Salary Card";
        payRollEmp: Decimal;
        Ehlevi: Decimal;
        Ehlevia: Decimal;
        prl: Record "PRL-Period Transactions";
}

