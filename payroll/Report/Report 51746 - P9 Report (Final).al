report 51746 "P9 Report (Final)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './payroll/Report/SSR/P9 Report (Final).rdl';
    PreviewMode = PrintLayout;
    Description = 'P9 Report';

    dataset
    {
        dataitem(DataItem8631; "HRM-Employee (D)")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            PrintOnlyIfDetail = true;
            column(EmployerPIN; controlinfo."Company P.I.N")
            {
            }
            column(Fname; "First Name")
            {
            }
            column(MName; "Middle Name" + ' ' + "Last Name")
            {
            }
            column(Emp_No; "No.")
            {
            }
            column(Pin_No; "PIN Number")
            {
            }
            column(Tac_Charged; "Total Tax Charged")
            {
            }
            column(TotalL; TotalL)
            {
            }
            column(TotaA; TotaA)
            {
            }
            column(TotalB; TotalB)
            {
            }
            column(totalD; totalD)
            {
            }
            column(totalC; totalC)
            {
            }
            column(TotalF; TotalF)
            {
            }
            column(TotalE3; TotalE3)
            {
            }
            column(TotalE2; TotalE2)
            {
            }
            column(TotalE1; TotalE1)
            {
            }
            column(TotalK; TotalK)
            {
            }
            column(TotalJ; TotalJ)
            {
            }
            column(TotalH; TotalH)
            {
            }
            column(TotalG; TotalG)
            {
            }
            column(Comp_Name; controlinfo.Name)
            {
            }
            dataitem(DataItem7242; 61093)
            {
                DataItemLink = "Employee Code" = FIELD("No.");
                DataItemTableView = SORTING("Employee Code", "Payroll Period")
                                    ORDER(Ascending);
                RequestFilterFields = "Period Year", "Employee Code";
                column(Month; GETFILTER("Period Year"))
                {
                }
                column(SelectedPeriod; GETFILTER("Period Year"))
                {
                }
                column(PeriodMonth; FORMAT("Payroll Period", 0, '<Month Text>'))
                {
                }
                column(B_Pay; "Basic Pay")
                {
                }
                column(Benefits; "Gross Pay" - "Basic Pay")
                {
                }
                column(Value_Of_Quoters; "Value Of Quarters")
                {
                }
                column(Gross; "Gross Pay")
                {
                }
                column(Owner_Occupier; "Owner Occupier Interest")
                {
                }
                column(thirty_Perc_Of_BPay; "Basic Pay" * 0.3)
                {
                }
                column(Actual; NSSF + Pension)
                {
                }
                column(fixedDefContri; fixedDefContri)
                {
                }
                column(Gross_Pay__ColG; "Gross Pay" - (NSSF + Pension + "Owner Occupier Interest"))
                {
                }
                column(TaxCharged; "Tax Charged")
                {
                }
                column(Tax_Relief; "Tax Relief")
                {
                }
                column(Ins_Relief; "Insurance Relief" + "OtherInsurance Relief")
                {
                }
                column(PAYE1; PAYE)
                {
                }
                column(ColG; ColG)
                {
                }
                column(Emp_Code; "Employee Code")
                {
                }
                column(PayPeriod; "Payroll Period")
                {
                }

                trigger OnAfterGetRecord()
                var
                    prPayrollProcess: Codeunit 50119;
                begin

                    IF ("Defined Contribution" + NSSF) > 20000 THEN BEGIN
                        ColG := 20000 + "Owner Occupier Interest";
                        TotalG := TotalG + ColG;
                    END;

                    fixedDefContri := 20000;
                end;

                trigger OnPreDataItem()
                var
                    "HRM-Employee (D)": Record "HRM-Employee (D)";
                begin
                    //SETFILTER("Period Year",FORMAT(SelectedPeriod));
                    IF GETFILTER("Period Year") = '' THEN ERROR('ERROR:\Specify the year in the Period Year Filter!');
                    CLEAR(yearFilters);
                    IF EVALUATE(yearFilters, GETFILTER("Period Year")) THEN;
                    // PerionTrans.RESET;
                    // PerionTrans.SETRANGE(PerionTrans."Employee Code", "HRM-Employee (D)"."No.");
                    // PerionTrans.SETRANGE(PerionTrans."Period Year", yearFilters);
                    // PerionTrans.SETRANGE(PerionTrans."Transaction Code", 'PNSR');
                    // IF PerionTrans.FIND('-') THEN BEGIN
                    //     REPEAT
                    //         P9.RESET;
                    //         P9.SETRANGE(P9."Employee Code", "HRM-Employee (D)"."No.");
                    //         P9.SETRANGE(P9."Payroll Period", PerionTrans."Payroll Period");
                    //         IF P9.FIND('-') THEN BEGIN
                    //             P9.Pension := PerionTrans.Amount;
                    //             P9.MODIFY;
                    //         END;
                    //     UNTIL PerionTrans.NEXT = 0;
                    // END;


                    P9.RESET;
                    P9.SETRANGE(P9."Employee Code", "HRM-Employee (D)"."No.");
                    P9.SETRANGE(P9."Period Year", yearFilters);
                    IF P9.FIND('-') THEN BEGIN
                        REPEAT
                            TotaA := TotaA + P9."Gross Pay";
                            TotalB := TotalB + P9.Benefits;
                            totalC := totalC + P9."Value Of Quarters";
                            totalD := totalD + P9."Gross Pay";
                            TotalE1 := TotalE1 + (P9."Gross Pay" * 0.3);
                            TotalE2 := TotalE2 + (P9.NSSF + P9.Pension);
                            TotalE3 := TotalE3 + 20000;
                            TotalF := TotalF + P9."Owner Occupier Interest";
                            TotalG := TotalG + (P9.NSSF + P9.Pension + P9."Owner Occupier Interest");
                            IF P9.NSSF < 20000 THEN BEGIN
                                //TotalG:=TotalG+P9.NSSF;
                                TotalH := TotalH + (P9."Gross Pay" - (P9.NSSF + P9.Pension + P9."Owner Occupier Interest"));
                            END ELSE BEGIN
                                //TotalG:=TotalG+20000;
                                TotalH := TotalH + (P9."Gross Pay" - (P9.NSSF + P9.Pension + P9."Owner Occupier Interest"));
                            END;
                            //TotalJ:=TotalJ+(P9."Tax Charged"+(P9."Tax Relief"+P9."Insurance Relief"));
                            TotalJ := TotalJ + (P9."Tax Charged");
                            TotalK := TotalK + (P9."Tax Relief" + P9."Insurance Relief");
                            TotalL := TotalL + P9.PAYE;
                        UNTIL P9.NEXT = 0;
                    END;

                    "Total Tax Charged" := TotalH;
                end;
            }

            trigger OnAfterGetRecord()
            begin




                TotaA := 0;
                TotalB := 0;
                totalC := 0;
                totalD := 0;
                TotalE1 := 0;
                TotalE2 := 0;
                TotalE3 := 0;
                TotalF := 0;
                TotalG := 0;
                TotalH := 0;
                TotalJ := 0;
                TotalK := 0;
                TotalL := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
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
        CLEAR(fixedDefContri);
    end;

    trigger OnPreReport()
    begin

        //IF SelectedPeriod=0 THEN BEGIN
        // ERROR('Specify The Year');
        //END;
        controlinfo.GET();

        // fixedDefContri:=20000;
    end;

    var
        objEmp: Record 61619;
        strEmpName: Text[250];
        strPin: Text[30];
        EmployerPIN: Text[30];
        controlinfo: Record 79;
        fixedDefContri: Decimal;
        "Total Tax Charged": Decimal;
        "Total PAYE": Decimal;
        TotaA: Decimal;
        TotalB: Decimal;
        totalC: Decimal;
        totalD: Decimal;
        TotalE1: Decimal;
        TotalE2: Decimal;
        TotalE3: Decimal;
        TotalF: Decimal;
        TotalG: Decimal;
        TotalH: Decimal;
        TotalI: Decimal;
        TotalJ: Decimal;
        TotalK: Decimal;
        TotalL: Decimal;
        P9: Record 61093;
        ColG: Decimal;
        PerionTrans: Record 61092;
        yearFilters: Integer;

}

