report 70264 "Casual-Deductions Summary 2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './payroll/Report/Casual/CasualDeductionsSummary2.rdl';

    dataset
    {
        dataitem(DataItem1; "PRL-Casual Period Transactions")
        {
            DataItemTableView = WHERE("Employee Category" = FILTER('CASUAL' | 'CASUALS'));
            column(COMPANYNAME; CompanyInfo.Name)
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
            column(abreviation; 'MUST')
            {
            }
            column(DetDate; DetDate)
            {
            }
            column(EmpNo; "Employee Code")
            {
            }
            column(empName; empName)
            {
            }
            column(EmpAmount; Amount)
            {
            }
            column("code"; "Transaction Code")
            {
            }
            column(name; "Transaction Name")
            {
            }
            column(Transaction; "Transaction Code" + ': ' + "Transaction Name")
            {
            }
            column(TotLabel; "Transaction Code" + ': ' + "Transaction Name")
            {
            }

            trigger OnAfterGetRecord()
            begin
                //  IF NOT (((("prPeriod Transactions"."Group Order"=1) AND
                //   ("prPeriod Transactions"."Sub Group Order"<>1)) OR
                //  ("prPeriod Transactions"."Group Order"=3) OR
                //   (("prPeriod Transactions"."Group Order"=4) AND
                //    ("prPeriod Transactions"."Sub Group Order"<>0)))) THEN
                "prPayroll Periods".RESET;
                "prPayroll Periods".SETRANGE("prPayroll Periods"."Date Openned", SelectedPeriod);
                "prPayroll Periods".SETRANGE("prPayroll Periods"."Current Instalment", NoOfInstalment);
                IF "prPayroll Periods".FIND('-') THEN BEGIN
                    CLEAR(DetDate);
                    DetDate := FORMAT("prPayroll Periods"."Period Name");
                END;

                CLEAR(empName);
                IF emps.GET("Employee Code") THEN
                    empName := emps."First Name" + ' ' + emps."Middle Name" + ' ' + emps."Last Name";
                IF NOT (((("Group Order" = 7) AND
                     (("Sub Group Order" <> 6)
                    AND ("Sub Group Order" <> 5))) OR
                    (("Group Order" = 8) AND
                     ("Sub Group Order" <> 9)))) THEN BEGIN
                    CurrReport.SKIP;
                END;

                /*
              CLEAR(rows);
              CLEAR(rows2);
              "prPeriod Transactions".RESET;
              "prPeriod Transactions".SETRANGE("Payroll Period",SelectedPeriod);
              "prPeriod Transactions".SETFILTER("Group Order",'=1|3|4|7|8|9');
              //"prPeriod Transactions".SETFILTER("prPeriod Transactions"."Sub Group Order",'=2');
              "prPeriod Transactions".SETCURRENTKEY("Payroll Period","Group Order","Sub Group Order");
              IF "prPeriod Transactions".FIND('-') THEN BEGIN
              CLEAR(DetDate);
              DetDate:=FORMAT("prPayroll Periods"."Period Name");
              REPEAT
              BEGIN
              IF "prPeriod Transactions".Amount>0 THEN BEGIN
              IF (("prPeriod Transactions"."Group Order"=4) AND ("prPeriod Transactions"."Sub Group Order"=0)) THEN
                GPY:=GPY+"prPeriod Transactions".Amount;

              IF (("prPeriod Transactions"."Group Order"=7) AND
              (("prPeriod Transactions"."Sub Group Order"=3) OR ("prPeriod Transactions"."Sub Group Order"=1) OR
               ("prPeriod Transactions"."Sub Group Order"=2)))  THEN
                STAT:=STAT+"prPeriod Transactions".Amount;

              IF (("prPeriod Transactions"."Group Order"=8) AND
              (("prPeriod Transactions"."Sub Group Order"=1) OR ("prPeriod Transactions"."Sub Group Order"=0))) THEN
                 DED:=DED+"prPeriod Transactions".Amount;

              IF (("prPeriod Transactions"."Group Order"=9) AND ("prPeriod Transactions"."Sub Group Order"=0)) THEN
                NETS:=NETS+"prPeriod Transactions".Amount;





              //TotalsAllowances:=TotalsAllowances+"prPeriod Transactions".Amount;
                  IF ((("prPeriod Transactions"."Group Order"=1) AND
                   ("prPeriod Transactions"."Sub Group Order"<>1)) OR
                  ("prPeriod Transactions"."Group Order"=3) OR
                   (("prPeriod Transactions"."Group Order"=4) AND
                    ("prPeriod Transactions"."Sub Group Order"<>0))) THEN BEGIN // A Payment
                    CLEAR(countz);
                   // countz:=1;
                    CLEAR(found);
                    REPEAT
                   BEGIN
                     countz:=countz+1;
                     IF (PayTrans[countz])="prPeriod Transactions"."Transaction Name" THEN found:=TRUE;
                     END;
                    UNTIL ((countz=(ARRAYLEN(PayTransAmt))) OR ((PayTrans[countz])="prPeriod Transactions"."Transaction Name")
                    OR ((PayTrans[countz])=''));
                   rows:= countz;
                  PayTrans[rows]:="prPeriod Transactions"."Transaction Name";
                  PayTransAmt[rows]:=PayTransAmt[rows]+"prPeriod Transactions".Amount;
                  END ELSE IF ((("prPeriod Transactions"."Group Order"=7) AND
                   (("prPeriod Transactions"."Sub Group Order"<>6)
                  AND ("prPeriod Transactions"."Sub Group Order"<>5))) OR
                  (("prPeriod Transactions"."Group Order"=8) AND
                   ("prPeriod Transactions"."Sub Group Order"<>9))) THEN BEGIN
                    CLEAR(countz);
                   // countz:=1;
                    CLEAR(found);
                    REPEAT
                   BEGIN
                     countz:=countz+1;
                     IF (DedTrans[countz])="prPeriod Transactions"."Transaction Name" THEN found:=TRUE;
                     END;
                    UNTIL ((countz=(ARRAYLEN(DedTransAmt))) OR ((DedTrans[countz])="prPeriod Transactions"."Transaction Name")
                    OR ((DedTrans[countz])=''));
                   rows:= countz;
                  DedTrans[rows]:="prPeriod Transactions"."Transaction Name";
                  DedTransAmt[rows]:=DedTransAmt[rows]+"prPeriod Transactions".Amount;
                  END;
                  END; // If Amount >0;
              END;
              UNTIL "prPeriod Transactions".NEXT=0;
              END;// End prPeriod Transactions Repeat
              // MESSAGE('Heh'+FORMAT(rows)+', '+FORMAT(rows2));
                                    */

            end;

            trigger OnPreDataItem()
            begin

                //LastFieldNo := FIELDNO("Period Year");
                SETFILTER("Payroll Period", '=%1', SelectedPeriod);
                SETFILTER("Current Instalment", '=%1', NoOfInstalment);
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
                    TableRelation = "PRL-Payroll Periods"."Date Opened" WHERE("Payroll Code" = FILTER('CASUAL' | 'CASUALS'));
                    ApplicationArea = All;
                }
                field(NoOfInstalment; NoOfInstalment)
                {
                    Caption = 'Instalment';
                    ApplicationArea = All;
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
        //objPeriod.SETFILTER("Payroll Code",'%1|%2','CASUAL','CASUALS');
        IF objPeriod.FIND('-') THEN BEGIN
            PeriodFilter := objPeriod."Date Openned";
            NoOfInstalment := objPeriod."Current Instalment";
            PeriodName := objPeriod."Period Name";
        END;
    end;

    trigger OnPreReport()
    begin

        SelectedPeriod := PeriodFilter;


        IF CompanyInfo.GET() THEN
            CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
        CLEAR(rows);
        CLEAR(GPY);
        CLEAR(STAT);
        CLEAR(DED);
        CLEAR(NETS);
    end;

    var
        NoOfInstalment: Integer;
        empName: Text[250];
        DetDate: Text[100];
        found: Boolean;
        countz: Integer;
        PeriodFilter: Date;
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        PeriodTrans: Record 70252;
        objPeriod: Record 70250;
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
        PayTrans: array[70] of Text[250];
        PayTransAmt: array[70] of Decimal;
        DedTrans: array[70] of Text[250];
        DedTransAmt: array[70] of Decimal;
        rows: Integer;
        rows2: Integer;
        GPY: Decimal;
        NETS: Decimal;
        STAT: Decimal;
        DED: Decimal;
        TotalFor: Label 'Total for ';
        GroupOrder: Label '3';
        TransBal: array[2, 60] of Text[250];
        Addr: array[2, 10] of Text[250];
        RecordNo: Integer;
        NoOfColumns: Integer;
        ColumnNo: Integer;
        emps: Record "HRM-Employee (D)";
        "prPayroll Periods": Record 70250;
}

