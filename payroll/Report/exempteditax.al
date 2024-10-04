Report 50950 "Exempted Csv"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ssrs/PRiTaxReport.rdl';
    //ApplicationArea = All;

    dataset
    {
        dataitem("Employees"; "HRM-Employee (D)")
        {
            RequestFilterFields = "Physical Disability";

            column(ReportForNavId_1; 1)
            {
            }
            column(EmployeeType_HREmployees; "Employees"."No.")
            {
            }
            column(FullName_HREmployees; "Employees"."Full Name")
            {
            }
            column(PINNo_HREmployees; "Employees"."PIN Number")
            {
            }
            column(Disability_Cert; "Employees"."Disability Cert")
            {

            }
            column(BPAY; BPAY)
            {
            }
            column(HouseAllowance; HouseAllowance)
            {
            }
            column(TransportAllowance; TransportAllowance)
            {
            }
            column(LeaveAllowance; LeaveAllowance)
            {
            }
            column(DirectorsFee; DirectorsFee)
            {
            }
            column(OvertimeAllowance; OvertimeAllowance)
            {
            }
            column(Lumpsum; Lumpsum)
            {
            }
            column(OtherAllowances; OtherAllowances)
            {
            }
            column(TotalCashPay; TotalCashPay)
            {
            }
            column(ValueOfCar; ValueOfCar)
            {
            }
            column(OtherNonCash; OtherNonCash)
            {
            }
            column(TotalNonCash; TotalNonCash)
            {
            }
            column(GlobalIncome; GlobalIncome)
            {
            }
            column(TypeOfHousing; TypeOfHousing)
            {
            }
            column(RentOfHouse; RentOfHouse)
            {
            }
            column(ComputedRent; ComputedRent)
            {
            }
            column(RentRecovered; RentRecovered)
            {
            }
            column(NetValue; NetValue)
            {
            }
            column(TotalGross; TotalGross)
            {
            }
            column(ThirtyPCash; ThirtyPCash)
            {
            }
            column(ActualContr; ActualContr)
            {
            }
            column(PermissibleLimit; PermissibleLimit)
            {
            }
            column(MortgageIntrest; MortgageIntrest)
            {
            }
            column(HOSP; HOSP)
            {
            }
            column(AmountOfBenefit; AmountOfBenefit)
            {
            }
            column(TaxablePay; TaxablePay)
            {
            }
            column(TaxPayable; TaxPayable)
            {
            }
            column(MonthlyRelief; MonthlyRelief)
            {
            }
            column(InsuranceRelief; InsuranceRelief)
            {
            }
            column(PAYE; PAYE)
            {
            }

            column(PAYETAX; PAYETAX)
            {

            }
            trigger OnPreDataItem()
            begin
                if ExportCSV then begin
                    CSVBuffer.InsertEntry(LineNo, 1, 'PIN of Employee');
                    CSVBuffer.InsertEntry(LineNo, 2, 'Name of Employee');
                    CSVBuffer.InsertEntry(LineNo, 3, 'Residential Status');
                    CSVBuffer.InsertEntry(LineNo, 4, 'Type of Employee');
                    CSVBuffer.InsertEntry(LineNo, 5, 'Disability Certficate');
                    CSVBuffer.InsertEntry(LineNo, 6, 'Basic Salary');
                    CSVBuffer.InsertEntry(LineNo, 7, 'Housing Allowance');
                    CSVBuffer.InsertEntry(LineNo, 8, 'Transport Allowance');
                    CSVBuffer.InsertEntry(LineNo, 9, 'Leave Pay');
                    CSVBuffer.InsertEntry(LineNo, 10, 'Overtime Allowance');
                    CSVBuffer.InsertEntry(LineNo, 11, 'Directors Fee');
                    CSVBuffer.InsertEntry(LineNo, 12, 'Lumpsum Payment if Any');
                    CSVBuffer.InsertEntry(LineNo, 13, 'Other Allowances');
                    CSVBuffer.InsertEntry(LineNo, 14, 'Total Cash Pay (A)');
                    CSVBuffer.InsertEntry(LineNo, 15, 'Value of Car Benefit (Value of Car Benefit from D Computation of Car Benefit)(B)');
                    CSVBuffer.InsertEntry(LineNo, 16, 'Other Non Cash Benefits (C)');
                    CSVBuffer.InsertEntry(LineNo, 17, 'Total Non Cash Pay (D)=(B + C) (C if greater than 3000)');
                    CSVBuffer.InsertEntry(LineNo, 18, 'Global Income (In case of non full time service Director) (Ksh) (E)');
                    CSVBuffer.InsertEntry(LineNo, 19, 'Type of Housing');
                    CSVBuffer.InsertEntry(LineNo, 20, 'Rent of House/Market Value');
                    CSVBuffer.InsertEntry(LineNo, 21, 'Computed Rent of House (F)');
                    CSVBuffer.InsertEntry(LineNo, 22, 'Rent Recovered from Employee (G)');
                    CSVBuffer.InsertEntry(LineNo, 23, 'Net Value of Housing (Ksh) (H) = (F - G)');
                    CSVBuffer.InsertEntry(LineNo, 24, 'Total Gross Pay (Ksh) (I) = (A + D + E +H))');
                    CSVBuffer.InsertEntry(LineNo, 25, '30% of Cash Pay (J) = (A) * 30%');
                    CSVBuffer.InsertEntry(LineNo, 26, 'Actual Contribution (K)');
                    CSVBuffer.InsertEntry(LineNo, 27, 'Permissible Limit (L)');
                    CSVBuffer.InsertEntry(LineNo, 28, 'Mortgage Interest (Max 25000 Ksh a month) (M)');
                    CSVBuffer.InsertEntry(LineNo, 29, 'Deposit on Home Ownership Saving Plan (Max 96000 Ksh or 8000 Ksh a month) (N)');
                    CSVBuffer.InsertEntry(LineNo, 30, 'Amount of Benefit (O) = (Lower of J K L + M or N which ever is higher)');
                    CSVBuffer.InsertEntry(LineNo, 31, 'Exemptions for Persons of Disability (Ksh) (P)');
                    CSVBuffer.InsertEntry(LineNo, 32, 'Taxable Pay (Ksh) (P) = (I - O)');
                    CSVBuffer.InsertEntry(LineNo, 33, 'Tax Payable (Ksh) (Q) = (P)*Slab Rate');
                    CSVBuffer.InsertEntry(LineNo, 34, 'Monthly Personal Relief (Ksh) (R)');
                    CSVBuffer.InsertEntry(LineNo, 35, 'Amount of Insurance Relief (Total of Amount of Insurance Relief from E_Computation_of_Insu_Relief) (Ksh) (S)');
                    CSVBuffer.InsertEntry(LineNo, 36, 'PAYE Tax (Ksh) (T) = (Q - R - S)');
                    CSVBuffer.InsertEntry(LineNo, 37, 'Self Assessed PAYE Tax (Ksh)');
                end;
            end;

            trigger OnAfterGetRecord()
            begin
                //Init
                BPAY := 0;
                HouseAllowance := 0;
                TransportAllowance := 0;
                OvertimeAllowance := 0;
                DirectorsFee := 0;
                LeaveAllowance := 0;
                OvertimeAllowance := 0;
                Lumpsum := 0;
                OtherAllowances := 0;
                TotalCashPay := 0;
                ValueOfCar := 0;
                OtherNonCash := 0;
                TotalNonCash := 0;
                GlobalIncome := 0;
                TypeOfHousing := 0;
                ComputedRent := 0;
                RentRecovered := 0;
                NetValue := 0;
                TotalGross := 0;
                ThirtyPCash := 0;
                ActualContr := 0;
                PermissibleLimit := 0;
                MortgageIntrest := 0;
                AmountOfBenefit := 0;
                TaxablePay := 0;
                TaxPayable := 0;
                MonthlyRelief := 0;
                InsuranceRelief := 0;
                PAYE := 0;
                PAYETAX := 0;
                //Basic Pay
                // Employees.Reset();
                // Employees.SetRange("Physical Disability", true);
                // if Employees.Find('-') then begin

                // end
                fn_PeriodTrans;
                PRPeriodTrans.SetFilter(PRPeriodTrans."Transaction Code", '%1', 'BPAY');
                if PRPeriodTrans.FindFirst() then begin
                    PRPeriodTrans.CalcSums(PRPeriodTrans.Amount);
                    BPAY := PRPeriodTrans.Amount;
                end;
                //House Allowance & Arrears
                fn_PeriodTrans;
                PRPeriodTrans.SetFilter(PRPeriodTrans."Transaction Code", '%1', 'E1007');
                if PRPeriodTrans.FindFirst() then begin
                    PRPeriodTrans.CalcSums(PRPeriodTrans.Amount);
                    HouseAllowance := PRPeriodTrans.Amount;
                end;
                //Transport Allowance & Arrears
                fn_PeriodTrans;
                PRPeriodTrans.SetFilter(PRPeriodTrans."Transaction Code", '%1', 'E1014');
                if PRPeriodTrans.FindFirst() then begin
                    PRPeriodTrans.CalcSums(PRPeriodTrans.Amount);
                    TransportAllowance := PRPeriodTrans.Amount;
                end;
                //Leave Allowance & Arrears
                fn_PeriodTrans;
                PRPeriodTrans.SetFilter(PRPeriodTrans."Transaction Code", '%1', 'E1008');
                if PRPeriodTrans.FindFirst() then begin
                    PRPeriodTrans.CalcSums(PRPeriodTrans.Amount);
                    LeaveAllowance := PRPeriodTrans.Amount;
                end;
                //Overtime Allowance
                fn_PeriodTrans;
                PRPeriodTrans.SetFilter(PRPeriodTrans."Transaction Code", '%1', 'E1009');
                if PRPeriodTrans.FindFirst() then begin
                    PRPeriodTrans.CalcSums(PRPeriodTrans.Amount);
                    OvertimeAllowance := PRPeriodTrans.Amount;
                end;
                //Directors Fee
                //Other Allowances 4- Board
                // fn_PeriodTrans;
                // //PRPeriodTrans.SetFilter(PRPeriodTrans."Posting Group", '%1', 'BOARD');
                // PRPeriodTrans.SetFilter(PRPeriodTrans."Transaction Code", '%1|%2|%3|%4', 'EA005', 'EA035', 'EA052', 'EA057');
                // if PRPeriodTrans.FindFirst() then begin
                //     PRPeriodTrans.CalcSums(PRPeriodTrans.Amount);
                //     OtherAllowances += PRPeriodTrans.Amount;
                // end;
                // //Lumpsum
                // fn_PeriodTrans;
                // PRPeriodTrans.SetFilter(PRPeriodTrans."Transaction Code", '%1', 'E14');
                // if PRPeriodTrans.FindFirst() then begin
                //     PRPeriodTrans.CalcSums(PRPeriodTrans.Amount);
                //     Lumpsum := PRPeriodTrans.Amount;
                // end;
                // //Other Allowances 1
                // fn_PeriodTrans;
                // PRPeriodTrans.SetFilter(PRPeriodTrans."Transaction Code", '%1|%2|%3|%4|%5|%6|%7|%8', 'EA007', 'EA004', 'EA006', 'EA044', 'EA008', 'EA009', 'EA010', 'EA011');
                // if PRPeriodTrans.FindFirst() then begin
                //     PRPeriodTrans.CalcSums(PRPeriodTrans.Amount);
                //     OtherAllowances += PRPeriodTrans.Amount;
                // end;
                // //Other Allowances 2
                // fn_PeriodTrans;
                // PRPeriodTrans.SetFilter(PRPeriodTrans."Transaction Code", '%1|%2|%3|%4|%5|%6|%7|%8', 'EA012', 'EA015', 'EA051', 'EA016', 'EA020', 'EA021', 'EA024', 'EA048');
                // if PRPeriodTrans.FindFirst() then begin
                //     PRPeriodTrans.CalcSums(PRPeriodTrans.Amount);
                //     OtherAllowances += PRPeriodTrans.Amount;
                // end;
                //Other Allowances 3
                fn_PeriodTrans;
                PRPeriodTrans.SetFilter(PRPeriodTrans."Transaction Code", '%1|%2|%3|%4|%5|%6|%7|%8|%9|%10|%11|%12|%13|%14|%15|%16', 'E1001', 'E1002', 'E1003', 'E1004', 'E1005', 'E1006', 'E1010', 'E1011', 'E1012', 'E1013', 'E1015', 'E1016', 'E1017', 'E1018', 'E1019', 'E1020');
                if PRPeriodTrans.FindFirst() then begin
                    PRPeriodTrans.CalcSums(PRPeriodTrans.Amount);
                    OtherAllowances += PRPeriodTrans.Amount;
                end;
                // //Other Allowances 4
                // fn_PeriodTrans;
                // //PRPeriodTrans.SetFilter(PRPeriodTrans."Posting Group", '<>%1', 'BOARD');
                // PRPeriodTrans.SetFilter(PRPeriodTrans."Transaction Code", '%1', 'ED113');
                // if PRPeriodTrans.FindFirst() then begin
                //     PRPeriodTrans.CalcSums(PRPeriodTrans.Amount);
                //     OtherAllowances += PRPeriodTrans.Amount;
                // end;

                //Other Non Cash
                PRTransCodes.Reset;
                PRTransCodes.SetRange(PRTransCodes."Transaction Type", PRTransCodes."transaction type"::Income);
                if PRTransCodes.FindFirst() then begin
                    repeat
                        fn_PeriodTrans;
                        PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", PRTransCodes."Transaction Code");
                        if PRPeriodTrans.FindFirst() then begin
                            OtherNonCash += PRPeriodTrans.Amount;
                        end;
                    until PRTransCodes.Next = 0;
                end;
                //Total Cash Pay
                TotalCashPay := BPAY + HouseAllowance + TransportAllowance + OvertimeAllowance + DirectorsFee + LeaveAllowance + Lumpsum + OtherAllowances + OtherNonCash;
                //Value of Car

                //Total Non Cash
                TotalNonCash := OtherNonCash + ValueOfCar;
                //Globa Income
                GlobalIncome := TotalNonCash + TotalCashPay;
                //Type of Housing
                //Rent of House
                //Computed Rent
                //Rent Recovered
                //Net Value
                //Total Gross
                TotalGross := GlobalIncome;
                //30% of Cash
                ThirtyPCash := 0.3 * GlobalIncome;
                //Actual Contribution - Include Voluntary Pension & Voluntary NSSF & NSSF

                // PRTransCodes.Reset;
                // PRTransCodes.SetFilter(PRTransCodes."Special Trans Deductions", '%1|%2', (PRTransCodes."Special Trans Deductions"::"Defined Contribution"), (PRTransCodes."Special Trans Deductions"::"Voluntary Pension"));
                // if PRTransCodes.FindFirst() then begin
                //     repeat
                //         fn_PeriodTrans;
                //         PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", PRTransCodes.Code);
                //         if PRPeriodTrans.FindFirst() then begin
                //             ActualContr += PRPeriodTrans.Amount;
                //         end;
                //     until PRTransCodes.Next = 0;
                // end;

                fn_PeriodTrans;
                PRPeriodTrans.SetFilter(PRPeriodTrans."Transaction Code", '%1|%2', 'DEFCON1', 'PNSR');
                if PRPeriodTrans.FindFirst() then begin
                    PRPeriodTrans.CalcSums(PRPeriodTrans.Amount);
                    ActualContr += PRPeriodTrans.Amount;
                end;
                //Add NSSF too
                /*
                fn_PeriodTrans;
                PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'NSSF');
                if PRPeriodTrans.FindFirst() then begin
                    ActualContr += PRPeriodTrans.Amount;
                end;
                */
                //Permissible Limit
                PermissibleLimit := 20000;
                //Mortgage Intrest
                // fn_PeriodTrans;
                // PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'MORG-RL');
                // if PRPeriodTrans.FindFirst() then begin
                //     PRPeriodTrans.CalcSums(PRPeriodTrans.Amount);
                //     MortgageIntrest := PRPeriodTrans.Amount;
                // end;
                //Deposit on Home Ownership

                //Amount of Benefit
                E1 := 0.3 * TotalCashPay;
                E2 := ActualContr;
                E3 := 20000;
                //Column G - Get least between e1,E2,e3
                if E1 > E2 then begin
                    AmountOfBenefit := E2;
                end
                else begin
                    AmountOfBenefit := E1;
                end;
                if E3 < AmountOfBenefit then begin
                    AmountOfBenefit := E3;
                end;
                AmountOfBenefit += MortgageIntrest;
                //Taxable Pay
                fn_PeriodTrans;
                PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'TXBP');
                if PRPeriodTrans.FindFirst() then begin
                    TaxablePay := PRPeriodTrans.Amount;
                end;
                //Tax Payable
                fn_PeriodTrans;
                PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'TXCHRG');
                if PRPeriodTrans.FindFirst() then begin
                    TaxPayable := PRPeriodTrans.Amount;
                end;
                //Monthly Relief
                fn_PeriodTrans;
                PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'PSNR');
                if PRPeriodTrans.FindFirst() then begin
                    MonthlyRelief := PRPeriodTrans.Amount;
                end;
                //Insurance Relief
                fn_PeriodTrans;
                PRPeriodTrans.Setfilter(PRPeriodTrans."Transaction Code", '%1|%2', 'INSR', 'NHIFINSR');
                if PRPeriodTrans.FindFirst() then begin
                    PRPeriodTrans.CalcSums(PRPeriodTrans.Amount);
                    if PRPeriodTrans.Amount > 5000 then
                        InsuranceRelief := 5000
                    else
                        InsuranceRelief := PRPeriodTrans.Amount;
                end;
                //PAYE
                fn_PeriodTrans;
                PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'PAYE');
                if PRPeriodTrans.FindFirst() then begin
                    PAYE := PRPeriodTrans.Amount;
                end;
                if TotalCashPay = 0 then CurrReport.Skip;
                //PAYETAX
                // fn_PeriodTrans;
                // PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'PAYETAX');
                // if PRPeriodTrans.FindFirst() then begin
                //     PAYETAX := TaxPayable - MonthlyRelief - InsuranceRelief;
                // end;
                if TotalCashPay = 0 then CurrReport.Skip;

                if ExportCSV then begin
                    LineNo := LineNo + 1;
                    CSVBuffer.InsertEntry(LineNo, 1, Employees."PIN Number");
                    CSVBuffer.InsertEntry(LineNo, 2, Employees."Full Name");
                    CSVBuffer.InsertEntry(LineNo, 3, 'Resident');
                    CSVBuffer.InsertEntry(LineNo, 4, 'Primary Employee');
                    CSVBuffer.InsertEntry(LineNo, 5, Employees."Disability Cert");
                    CSVBuffer.InsertEntry(LineNo, 6, format(BPAY, 0, 2));
                    CSVBuffer.InsertEntry(LineNo, 7, format(HouseAllowance, 0, 2));
                    CSVBuffer.InsertEntry(LineNo, 8, format(TransportAllowance, 0, 2));
                    CSVBuffer.InsertEntry(LineNo, 9, format(LeaveAllowance, 0, 2));
                    CSVBuffer.InsertEntry(LineNo, 10, format(OvertimeAllowance, 0, 2));
                    CSVBuffer.InsertEntry(LineNo, 11, format(DirectorsFee, 0, 2));
                    CSVBuffer.InsertEntry(LineNo, 12, Format(Lumpsum, 0, 2));
                    CSVBuffer.InsertEntry(LineNo, 13, Format(OtherAllowances, 0, 2));
                    //CSVBuffer.InsertEntry(LineNo, 13, format(TotalCashPay, 0, 2));
                    CSVBuffer.InsertEntry(LineNo, 14, '');
                    CSVBuffer.InsertEntry(LineNo, 15, Format(0.00, 0, 2));
                    CSVBuffer.InsertEntry(LineNo, 16, Format(0.00, 0, 2));
                    //CSVBuffer.InsertEntry(LineNo, 16, Format(TotalNonCash, 0, 2));
                    CSVBuffer.InsertEntry(LineNo, 17, '');
                    //CSVBuffer.InsertEntry(LineNo, 17, Format(OtherNonCash, 0, 2));
                    CSVBuffer.InsertEntry(LineNo, 18, Format(0.00, 0, 2));
                    CSVBuffer.InsertEntry(LineNo, 19, 'Benefit not given');
                    CSVBuffer.InsertEntry(LineNo, 20, '');
                    CSVBuffer.InsertEntry(LineNo, 21, '');
                    CSVBuffer.InsertEntry(LineNo, 22, '');
                    CSVBuffer.InsertEntry(LineNo, 23, '');
                    CSVBuffer.InsertEntry(LineNo, 24, '');
                    CSVBuffer.InsertEntry(LineNo, 25, '');
                    CSVBuffer.InsertEntry(LineNo, 26, Format(ActualContr, 0, 2));
                    CSVBuffer.InsertEntry(LineNo, 27, '');
                    CSVBuffer.InsertEntry(LineNo, 28, Format(0.00, 0, 2));
                    CSVBuffer.InsertEntry(LineNo, 29, Format(0.00, 0, 2));
                    CSVBuffer.InsertEntry(LineNo, 30, '');
                    CSVBuffer.InsertEntry(LineNo, 31, '');
                    CSVBuffer.InsertEntry(LineNo, 32, '');
                    CSVBuffer.InsertEntry(LineNo, 33, '');
                    if Employees.Category = 'FULL TIME' then
                        CSVBuffer.InsertEntry(LineNo, 34, '')
                    else
                        CSVBuffer.InsertEntry(LineNo, 34, Format(0.00, 0, 2));
                    CSVBuffer.InsertEntry(LineNo, 35, Format(InsuranceRelief, 0, 2));
                    CSVBuffer.InsertEntry(LineNo, 36, '');
                    CSVBuffer.InsertEntry(LineNo, 37, Format(PAYE, 0, 2));
                end;
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(PeriodFilter; PeriodFilter)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Period Filter';
                        TableRelation = "PRL-Payroll Periods";
                    }

                    field(PostingGroup; PostingGrp_TxtFilter)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Employee Posting Group';
                    }
                    field(ExportCSV; ExportCSV)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Export to CSV?';
                    }
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
    trigger OnPreReport()
    begin
        if PeriodFilter = 0D then Error('Please select payroll period');
        fnCompanyInfo;

        if ExportCSV then
            LineNo := 1;
    end;

    trigger OnPostReport()
    begin
        if ExportCSV then begin
            FileName := 'B_Employees_Dtls.csv';
            CSVBuffer.SaveDataToBlob(TempBlob, ',');
            TempBlob.CreateInStream(InStr);
            DownloadFromStream(InStr, '', '', '', FileName);
        end;
    end;

    var
        CompInfo: Record "Company Information";
        PRPeriodTrans: Record "PRL-Period Transactions";
        PeriodFilter: Date;
        PRTransCodes: Record "PRL-Transaction Codes";
        BPAY: Decimal;
        HouseAllowance: Decimal;
        TransportAllowance: Decimal;
        LeaveAllowance: Decimal;
        OvertimeAllowance: Decimal;
        DirectorsFee: Decimal;
        Lumpsum: Decimal;
        OtherAllowances: Decimal;
        TotalCashPay: Decimal;
        ValueOfCar: Decimal;
        OtherNonCash: Decimal;
        TotalNonCash: Decimal;
        GlobalIncome: Decimal;
        TypeOfHousing: Decimal;
        RentOfHouse: Decimal;
        ComputedRent: Decimal;
        RentRecovered: Decimal;
        NetValue: Decimal;
        TotalGross: Decimal;
        ThirtyPCash: Decimal;
        ActualContr: Decimal;
        PermissibleLimit: Decimal;
        MortgageIntrest: Decimal;
        HOSP: Decimal;
        AmountOfBenefit: Decimal;
        E1: Decimal;
        E2: Decimal;
        E3: Decimal;
        TaxablePay: Decimal;
        TaxPayable: Decimal;
        MonthlyRelief: Decimal;
        InsuranceRelief: Decimal;
        PAYETAX: Decimal;
        PostingGrp_TxtFilter: Option "ALL","JSC","KJA","BOARD","JSC & KJA","CASUALS";
        ExportCSV: Boolean;
        CSVBuffer: Record "CSV Buffer" temporary;
        LineNo: Integer;
        TempBlob: Codeunit "Temp Blob";
        FileMgt: Codeunit "File Management";
        InStr: InStream;
        FileName: Text;
        paye: Decimal;

    procedure fnCompanyInfo()
    begin
        CompInfo.Reset;
        if CompInfo.Get then CompInfo.CalcFields(CompInfo.Picture);
    end;

    local procedure fn_PeriodTrans()
    begin
        PRPeriodTrans.Reset;
        PRPeriodTrans.SetCurrentkey("Employee Code", "Transaction Code", "Payroll Period");
        PRPeriodTrans.SetRange(PRPeriodTrans."Employee Code", "Employees"."No.");
        PRPeriodTrans.SetRange(PRPeriodTrans."Payroll Period", PeriodFilter);
        if PostingGrp_TxtFilter = PostingGrp_TxtFilter::ALL then begin
        end;

        // if PostingGrp_TxtFilter = PostingGrp_TxtFilter::BOARD then begin
        //     PRPeriodTrans.SetFilter(PRPeriodTrans."Posting Group", '%1', 'BOARD');
        // end;

        // if PostingGrp_TxtFilter = PostingGrp_TxtFilter::CASUALS then begin
        //     PRPeriodTrans.SetFilter(PRPeriodTrans."Posting Group", '%1', 'CASUALS');
        // end;

        // if PostingGrp_TxtFilter = PostingGrp_TxtFilter::JSC then begin
        //     PRPeriodTrans.SetFilter(PRPeriodTrans."Posting Group", '%1', 'JSC');
        // end;

        // if PostingGrp_TxtFilter = PostingGrp_TxtFilter::"JSC & KJA" then begin
        //     PRPeriodTrans.SetFilter(PRPeriodTrans."Posting Group", '%1|%2', 'JSC', 'KJA');
        // end;

        // if PostingGrp_TxtFilter = PostingGrp_TxtFilter::KJA then begin
        //     PRPeriodTrans.SetFilter(PRPeriodTrans."Posting Group", '%1', 'KJA');
        // end;
    end;
}