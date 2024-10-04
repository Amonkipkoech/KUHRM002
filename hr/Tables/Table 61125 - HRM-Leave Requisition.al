table 61125 "HRM-Leave Requisition"
{
    DrillDownPageID = "HRM-Leave Application List";
    LookupPageID = "HRM-Leave Application List";

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; Date; Date)
        {
        }
        field(3; "Employee No"; Code[20])
        {
            TableRelation = "HRM-Employee (D)"."No.";

            trigger OnValidate()
            begin
                if "No." = '' then begin
                    GenLedgerSetup.Get();
                    GenLedgerSetup.TestField(GenLedgerSetup."Leave Application Nos.");
                    NoSeriesMgt.InitSeries(GenLedgerSetup."Leave Application Nos.", xRec."No. Series", 0D, "No.", "No. Series");
                end;

                if Emp.Get("Employee No") then begin
                    Emp.CalcFields(Emp."Leave Balance");
                    "Employee Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                    "Leave Balance" := Emp."Leave Balance";
                    //JobCadre := HREmp."Salary Category";
                    Gender := Emp.Gender;
                end;
            end;
        }
        field(4; "Employee Name"; Text[200])
        {
        }
        field(5; "Campus Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(6; "Department Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }

        field(7; "Applied Days"; Decimal)
        {

            DecimalPlaces = 0 : 0;

            trigger OnValidate()
            begin
                LeaveTypes.Reset();
                LeaveTypes.SetRange(IsAnnual, false);
                if not LeaveTypes.FindFirst() then begin
                    CalcFields("Availlable Days");
                    if (("Availlable Days" = 0) or ("Applied Days" > "Availlable Days")) then begin
                        Error('Applied days must not be more than leave balance.');
                    end;
                end;
                if ("Applied Days" <> 0) and ("Starting Date" <> 0D) then begin
                    // "End Date":=CalcEndDate("Starting Date","Applied Days");
                    // "Return Date" :=CalcReturnDate("End Date");
                    Validate("Starting Date")
                end;
            end;
        }
        field(8; "Starting Date"; Date)
        {

            trigger OnValidate()
            begin
                dates.Reset;
                dates.SetRange(dates."Period Start", "Starting Date");
                dates.SetFilter(dates."Period Type", '=%1', dates."Period Type"::Date);
                if dates.Find('-') then
                    if (dates."Period Name" = 'Sunday') /*OR (dates."Period Name"='Saturday'))*/then begin
                        if (dates."Period Name" = 'Sunday') then Error('You can not start your leave on a Sunday')
                        //ELSE IF (dates."Period Name"='Saturday') THEN ERROR('You can not start your leave on a Saturday')
                    end;

                // Check if the start date is a holliday
                //BaseCalendar.RESET;
                //BaseCalendar.SETRANGE(BaseCalendar.Date,"Starting Date");
                //BaseCalendar.SETFILTER(BaseCalendar."Recurring System",'=%1',BaseCalendar."Recurring System"::"Annual Recurring");
                //I/F BaseCalendar.FIND('-') THEN BEGIN
                //IF BaseCalendar.Description<>'' THEN
                // ERROR('You can not start your Leave on a Holiday - '''+BaseCalendar.Description+'''')
                // ELSE ERROR('You can not start your Leave on a Holiday');
                //END;
                // For one of Hollidays Like Isther
                BaseCalendar.Reset;
                BaseCalendar.SetFilter(BaseCalendar."Base Calendar Code", GeneralOptions."Base Calendar");
                BaseCalendar.SetRange(BaseCalendar.Date, "Starting Date");
                if BaseCalendar.Find('-') then begin
                    repeat
                        if BaseCalendar.Nonworking = true then begin
                            if BaseCalendar.Description <> '' then
                                Error('You can not start your Leave on a Holiday - ''' + BaseCalendar.Description + '''')
                            else
                                Error('You can not start your Leave on a Holiday');
                        end;
                    until BaseCalendar.Next = 0;
                end;

                // For Annual Holidays
                BaseCalendar.Reset;
                BaseCalendar.SetFilter(BaseCalendar."Base Calendar Code", GeneralOptions."Base Calendar");
                BaseCalendar.SetRange(BaseCalendar."Recurring System", BaseCalendar."Recurring System"::"Annual Recurring");
                if BaseCalendar.Find('-') then begin
                    repeat
                    /* if ((Date2DMY("Starting Date", 1) = BaseCalendar."Date Day") and (Date2DMY("Starting Date", 2) = BaseCalendar."Date Month")) then begin
                        if BaseCalendar.Nonworking = true then begin
                            if BaseCalendar.Description <> '' then
                                Error('You can not start your Leave on a Holiday - ''' + BaseCalendar.Description + '''')
                            else
                                Error('You can not start your Leave on a Holiday');
                        end;
                    end; */
                    until BaseCalendar.Next = 0;
                end;


                if ("Applied Days" <> 0) and ("Starting Date" <> 0D) then begin
                    "End Date" := CalcEndDate("Starting Date", "Applied Days");
                    "Return Date" := CalcReturnDate("End Date");
                    //"Approved End Date":="End Date";

                end;

            end;
        }
        field(9; "End Date"; Date)
        {
        }
        field(10; Purpose; Text[200])
        {
        }
        field(11; "Leave Type"; Code[20])
        {
            TableRelation = "HRM-Leave Types".Code; // where(Gender = field(Gender));



            trigger OnValidate()
            var

            begin

                ValidateLeaveDays(Rec."Leave Type", Rec."Applied Days");

                CalcFields("Availlable Days");
                if Emp.Get("Employee No") then begin
                    Emp.CalcFields(Emp."Leave Balance");
                    "Leave Balance" := Emp."Leave Balance";
                    "Applied Days" := 0;

                end;

                Purpose := Format("Leave Type");

            end;

        }
        field(12; "Leave Balance"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(13; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(14; Status; Option)
        {
            //OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment,Cancelled,Posted';
            OptionMembers = Open,Released,"Pending Approval",Approved,"Pending Prepayment",Cancelled,Rejected,Posted;

            trigger OnValidate()
            var
                UserMgt: Codeunit "User Setup Management";
                //todo ApprovalMgt: Codeunit "Approvals Management";
                ReqLine: Record "HMS-Setup Blood Group";
                InventorySetup: Record "Inventory Setup";
                GenJnline: Record "Item Journal Line";
                LineNo: Integer;
                Post: Boolean;
                //JournlPosted: Codeunit "Journal Post Successful";
                HasLines: Boolean;
                AllKeyFieldsEntered: Boolean;
                FixedAsset: Record "Fixed Asset";
                //MinorAssetsIssue: Record "HMS-Patient";
                LeaveEntry: Record "HRM-Leave Ledger";
                [InDataSet]
                "No.Editable": Boolean;
                [InDataSet]
                DateEditable: Boolean;
                [InDataSet]
                "Employee NoEditable": Boolean;
                [InDataSet]
                "Institution CodeEditable": Boolean;
                [InDataSet]
                "Department CodeEditable": Boolean;
                [InDataSet]
                "Applied DaysEditable": Boolean;
                [InDataSet]
                "Starting DateEditable": Boolean;
                [InDataSet]
                PurposeEditable: Boolean;
                ApprovalEntries: Page "Fin-Approval Entries";
                DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application";
                HREmp: Record "HRM-Employee (D)";
            begin
                /*
                  IF Status = Status::Posted THEN BEGIN
                 leaveLedgers.RESET;
                 IF leaveLedgers.FIND('+') THEN
                 lastNo:=leaveLedgers."Entry No."+10
                 ELSE lastNo:=10;
                  // post the leave application to ledger entries with a negative adjustment
                  leaveLedgers.INIT;
                   leaveLedgers."Entry No.":=lastNo;
                   leaveLedgers."Employee No":="Employee No";
                   leaveLedgers."Document No":="No.";
                   leaveLedgers."Leave Type":="Leave Type";
                   leaveLedgers."Transaction Date":=TODAY;
                   leaveLedgers."Transaction Type":=leaveLedgers."Transaction Type"::Application;
                   leaveLedgers."No. of Days":=(("Applied Days")*(-1));
                   leaveLedgers."Transaction Description":='Leave Application';
                   leaveLedgers."Leave Period":=DATE2DWY(TODAY,3);
                  leaveLedgers.INSERT;
                  "Leave Balance":="Availlable Days";
                  MODIFY
                 END;
                 */
                /* 
                  LeaveEntry.Reset;
                  if LeaveEntry.Find('+') then
                      lastNo := LeaveEntry."Entry No." + 1;
                  TestField("Employee No");
                  TestField("Applied Days");
                  TestField("Starting Date");

                  HRMLeaveTypes.Reset;
                  HRMLeaveTypes.SetRange(Code, "Leave Type");

                  if HRMLeaveTypes.Find('-') then begin
                      if HRMLeaveTypes."Deduct From Leave Days" then begin
                          LeaveEntry.Init;
                          LeaveEntry."Entry No." := lastNo;
                          LeaveEntry."Document No" := "No.";
                          LeaveEntry."Leave Period" := Date2DWY(Today, 3);
                          LeaveEntry."Transaction Date" := Date;
                          LeaveEntry."Employee No" := "Employee No";
                          LeaveEntry."Leave Type" := "Leave Type";
                          LeaveEntry."No. of Days" := -"Applied Days";
                          LeaveEntry."Transaction Description" := Purpose;
                          LeaveEntry."Entry Type" := LeaveEntry."Entry Type"::Application;
                          LeaveEntry."Created By" := UserId;
                          LeaveEntry."Transaction Type" := LeaveEntry."Transaction Type"::Application;
                          LeaveEntry.Insert(true);
                      end else begin
                          LeaveEntry.Init;
                          LeaveEntry."Document No" := "No.";
                          LeaveEntry."Entry No." := lastNo;
                          LeaveEntry."Leave Period" := Date2DWY(Today, 3);
                          LeaveEntry."Transaction Date" := Date;
                          LeaveEntry."Employee No" := "Employee No";
                          LeaveEntry."Leave Type" := "Leave Type";
                          LeaveEntry."No. of Days" := -"Applied Days";
                          LeaveEntry."Transaction Description" := Purpose;
                          LeaveEntry."Entry Type" := LeaveEntry."Entry Type"::Application;
                          LeaveEntry."Created By" := UserId;
                          LeaveEntry."Transaction Type" := LeaveEntry."Transaction Type"::Application;
                          LeaveEntry.Insert(true);

                          LeaveEntry.Init;
                          LeaveEntry."Document No" := "No.";
                          LeaveEntry."Entry No." := lastNo;
                          LeaveEntry."Leave Period" := Date2DWY(Today, 3);
                          LeaveEntry."Transaction Date" := Date;
                          LeaveEntry."Employee No" := "Employee No";
                          LeaveEntry."Leave Type" := "Leave Type";
                          LeaveEntry."No. of Days" := "Applied Days";
                          LeaveEntry."Transaction Description" := Purpose + '(' + "Leave Type" + ' Reversal)';
                          LeaveEntry."Entry Type" := LeaveEntry."Entry Type"::Application;
                          LeaveEntry."Created By" := UserId;
                          LeaveEntry."Transaction Type" := LeaveEntry."Transaction Type"::Application;
                          LeaveEntry.Insert(true);
                      end;
                      Posted := true;
                      "Posted By" := UserId;
                      "Posting Date" := Today;
                      Modify;

                      if HREmp.Get("Employee No") then begin
                          HREmp."On Leave" := true;
                          HREmp."Current Leave No" := "No.";
                          HREmp.Status := HREmp.Status::Inactive;
                          HREmp.Modify;
                      end;
                      //Message('Leave Posted Successfully');
                      Message('Leave requisition sent for approval');
                  end else
                      Error('Invalid leave type!'); */

            end;
        }
        field(15; "User ID"; Code[30])
        {
        }
        field(16; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center".Code;

            //trigger OnValidate()
            // begin

            //     TestField(Status, Status::Open);
            // if not UserMgt.CheckRespCenter(1, "Responsibility Center") then
            //     Error(
            //       Text001,
            //RespCenter.TableCaption, UserMgt.GetPurchasesFilter);
            /*
           "Location Code" := UserMgt.GetLocation(1,'',"Responsibility Center");
           IF "Location Code" = '' THEN BEGIN
             IF InvtSetup.GET THEN
               "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";
           END ELSE BEGIN
             IF Location.GET("Location Code") THEN;
             "Inbound Whse. Handling Time" := Location."Inbound Whse. Handling Time";
           END;

           UpdateShipToAddress;
              */
            /*
         CreateDim(
           DATABASE::"Responsibility Center","Responsibility Center",
           DATABASE::Vendor,"Pay-to Vendor No.",
           DATABASE::"Salesperson/Purchaser","Purchaser Code",
           DATABASE::Campaign,"Campaign No.");

         IF xRec."Responsibility Center" <> "Responsibility Center" THEN BEGIN
           RecreatePurchLines(FIELDCAPTION("Responsibility Center"));
           "Assigned User ID" := '';
         END;
           */

            // end;
        }
        field(17; Posted; Boolean)
        {
        }
        field(18; "Posted By"; Code[20])
        {
        }
        field(19; "Posting Date"; Date)
        {
        }
        field(20; "Process Leave Allowance"; Boolean)
        {
        }
        field(21; "Availlable Days"; Decimal)
        {
            CalcFormula = Sum("HRM-Leave Ledger"."No. of Days" WHERE("Employee No" = FIELD("Employee No"), "Leave Type" = field("Leave Type")));
            DecimalPlaces = 0 : 0;
            FieldClass = FlowField;
        }
        field(22; "Return Date"; Date)
        {
        }
        field(23; "Reliever No."; Code[30])
        {
            TableRelation = "HRM-Employee (D)"."No.";

            trigger OnValidate()
            begin
                if Emp3.Get("Reliever No.") then
                    "Reliever Name" := Emp3."First Name" + ' ' + Emp3."Middle Name" + ' ' + Emp3."Last Name";
            end;
        }
        field(24; "Reliever Name"; Text[250])
        {
        }
        field(25; Gender; Option)
        {
            OptionMembers = " ",Male,Female;
            CalcFormula = lookup("HRM-Employee (D)".Gender where("No." = field("Employee No")));
            FieldClass = FlowField;
        }
        field(26; JobGrade; text[250])
        {
            CalcFormula = lookup("HRM-Employee (D)"."Salary Category" where("No." = field("Employee No")));
            FieldClass = FlowField;
        }
        field(27; "Family Member"; Option)
        {
            OptionMembers = " ",Spouse,Child,Parent;
        }

    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Status <> Status::Open then Error('You can only delete a document if its status is still Open!')
    end;

    trigger OnInsert()
    begin

        // if "No." = '' then begin
        //     GenLedgerSetup.Get();
        //     GenLedgerSetup.TestField(GenLedgerSetup."Leave Application Nos.");
        //     NoSeriesMgt.InitSeries(GenLedgerSetup."Leave Application Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        // end;
        "User ID" := UserId;
        Date := Today;
        Status := Status::Open;

        if usersetup.Get(UserId) then begin
            /*  if usersetup."Staff No" = '' then
                 Error('You are not authorized to use the leave application page. Please consult the system administrator.');
             if Employee.Get(CopyStr(usersetup."Staff No", 4, ((StrLen(usersetup."Staff No")) - 3))) then begin
                 "Employee No" := Employee."No.";
                 Validate("Employee No");
                 "Campus Code" := usersetup."Global Dimension 1 Code";
                 "Department Code" := usersetup."Global Dimension 2 Code";
                 Date := Today;
             end; */
        end;
    end;

    var
        lastNo: Integer;
        GenLedgerSetup: Record "HRM-Setup";
        //RespCenter: Record "FIN-Responsibility Center BR";
        UserMgt: Codeunit "User Setup Management";
        Dimval: Record "Dimension Value";
        Text001: Label 'Your identification is set up to process from %1 %2 only.';
        Emp3: Record "HRM-Employee (D)";
        Emp: Record "HRM-Employee (D)";
        "Employee Leaves": Record "HRM-Emp. Leaves";
        BaseCalendar: Record "Base Calendar Change";
        CurDate: Date;
        LeaveTypes: Record "HRM-Leave Types";
        DayApp: Decimal;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        EndDate: Date;
        BeginDate: Date;
        NextDate: Date;
        varDaysApplied: Integer;
        fDays: Integer;
        ReturnDateLoop: Boolean;
        Employee: Record "HRM-Employee (D)";
        fEmpNo: Code[30];
        EmpLeaveApps: Record "HRM-Leave Requisition";
        GeneralOptions: Record "HRM-Setup";
        "HR Set Up": Record "HRM-Human Resources Setup.";
        Levels: Integer;
        LEmployee: Record "HRM-Employee (D)";
        CurrYear: Integer;
        CYSDate: Date;
        CYEDate: Date;
        CurrYearValue: Integer;
        Number: Integer;
        SMTP: Codeunit "Email Message";// replaced "SMTP Mail"
        Names: Text[100];
        objPeriod: Record "PRL-Payroll Periods";
        PayPeriod: Date;
        CurrYearValue2: Integer;
        prCodes: Record "PRL-Transaction Codes";
        prTrans: Record "PRL-Employee Transactions";
        //todo   Payroll: Record "PRL-Salary Card";
        Grd: Code[10];
        hrSetup: Record "HRM-Setup";
        mContent: Text[100];
        mSubject: Text[100];
        nonworking: Decimal;
        CurrDate: Date;
        NONWORKINDAYS: Integer;
        Users2: Record User;
        usersetup: Record "User Setup";
        leaveLedgers: Record "HRM-Leave Ledger";
        dates: Record Date;
        HRMLeaveTypes: Record "HRM-Leave Types";


    procedure DetermineIfIsNonWorking(var bcDate: Date; var ltype: Record "HRM-Leave Types") ItsNonWorking: Boolean
    var
        dates: Record Date;
    begin
        Clear(ItsNonWorking);
        GeneralOptions.Find('-');
        //One off Hollidays like Good Friday
        BaseCalendar.Reset;
        BaseCalendar.SetFilter(BaseCalendar."Base Calendar Code", GeneralOptions."Base Calendar");
        BaseCalendar.SetRange(BaseCalendar.Date, bcDate);
        if BaseCalendar.Find('-') then begin
            if BaseCalendar.Nonworking = true then
                ItsNonWorking := true;
        end;

        // For Annual Holidays
        BaseCalendar.Reset;
        BaseCalendar.SetFilter(BaseCalendar."Base Calendar Code", GeneralOptions."Base Calendar");
        BaseCalendar.SetRange(BaseCalendar."Recurring System", BaseCalendar."Recurring System"::"Annual Recurring");
        if BaseCalendar.Find('-') then begin
            repeat
            /* if ((Date2DMY(bcDate, 1) = BaseCalendar."Date Day") and (Date2DMY(bcDate, 2) = BaseCalendar."Date Month")) then begin
                if BaseCalendar.Nonworking = true then
                    ItsNonWorking := true;
            end; */
            until BaseCalendar.Next = 0;
        end;

        if ItsNonWorking = false then begin
            // Check if its a weekend
            dates.Reset;
            dates.SetRange(dates."Period Type", dates."Period Type"::Date);
            dates.SetRange(dates."Period Start", bcDate);
            if dates.Find('-') then begin
                //if date is a sunday
                if dates."Period Name" = 'Sunday' then begin
                    //check if Leave includes sunday
                    if ltype."Inclusive of Sunday" = false then ItsNonWorking := true;
                end else
                    if dates."Period Name" = 'Saturday' then begin
                        //check if Leave includes sato
                        if ltype."Inclusive of Saturday" = false then ItsNonWorking := true;
                    end;
            end;
        end;
    end;

    procedure DetermineIfIncludesNonWorking(var fLeaveCode: Code[10]): Boolean
    begin
        if LeaveTypes.Get(fLeaveCode) then begin
            if LeaveTypes."Inclusive of Non Working Days" = true then
                exit(true);
        end;
    end;

    procedure DetermineLeaveReturnDate(var fBeginDate: Date; var fDays: Decimal) fReturnDate: Date
    var
        ltype: Record "HRM-Leave Types";
    begin
        ltype.Reset;
        if ltype.Get("Leave Type") then begin
        end;
        varDaysApplied := fDays;
        fReturnDate := fBeginDate;
        repeat
            if DetermineIfIncludesNonWorking("Leave Type") = false then begin
                fReturnDate := CalcDate('1D', fReturnDate);
                if DetermineIfIsNonWorking(fReturnDate, ltype) then begin
                    varDaysApplied := varDaysApplied + 1;
                end else
                    varDaysApplied := varDaysApplied;
                varDaysApplied := varDaysApplied + 1
            end
            else begin
                fReturnDate := CalcDate('1D', fReturnDate);
                varDaysApplied := varDaysApplied - 1;
            end;
        until varDaysApplied = 0;
        exit(fReturnDate);
    end;

    procedure DeterminethisLeaveEndDate(var fDate: Date) fEndDate: Date
    var
        ltype: Record "HRM-Leave Types";
    begin
        if ltype.Get("Leave Type") then begin
        end;
        ReturnDateLoop := true;
        fEndDate := fDate;
        if fEndDate <> 0D then begin
            fEndDate := CalcDate('1D', fEndDate);
            while (ReturnDateLoop) do begin
                if DetermineIfIsNonWorking(fEndDate, ltype) then
                    fEndDate := CalcDate('-1D', fEndDate)
                else
                    ReturnDateLoop := false;
            end
        end;
        exit(fEndDate);
    end;

    procedure GetPayPeriod()
    begin
        objPeriod.Reset;
        objPeriod.SetRange(objPeriod.Closed, false);
        if objPeriod.Find('-') then
            PayPeriod := objPeriod."Date Opened";
    end;

    procedure CalcEndDate(SDate: Date; LDays: Integer) LEndDate: Date
    var
        EndLeave: Boolean;
        DayCount: Integer;
        ltype: Record "HRM-Leave Types";
    begin
        ltype.Reset;
        if ltype.Get("Leave Type") then begin
        end;
        SDate := SDate;//-1;
        EndLeave := false;
        while EndLeave = false do begin
            if not DetermineIfIsNonWorking(SDate, ltype) then
                DayCount := DayCount + 1;
            SDate := SDate + 1;
            if DayCount = LDays then
                EndLeave := true;
        end;
        LEndDate := SDate - 1;

        while DetermineIfIsNonWorking(LEndDate, ltype) = true do begin
            LEndDate := LEndDate + 1;
        end;
    end;

    procedure CalcReturnDate(EndDate: Date) RDate: Date
    var
        EndLeave: Boolean;
        DayCount: Integer;
        LEndDate: Date;
        ltype: Record "HRM-Leave Types";
    begin
        if ltype.Get("Leave Type") then begin
        end;
        /*  EndLeave:=FALSE;
         EndDate:=EndDate+1;
         LEndDate:=EndDate;
         CLEAR(DayCount);
         WHILE EndLeave=FALSE DO BEGIN
         IF NOT DetermineIfIsNonWorking(EndDate,ltype) THEN BEGIN
         DayCount:=DayCount+1;
         EndDate:=EndDate+1;

         END ELSE BEGIN
         EndLeave:=TRUE;
         END;
         END;
           */
        RDate := EndDate + 1;
        while DetermineIfIsNonWorking(RDate, ltype) = true do begin
            RDate := RDate + 1;
        end;

    end;

    procedure GetDate(var Applied_Dayes: Integer; var Start_Date: Date)
    var
        DaysCount: Integer;
        NewDate: Date;
        Last_is_WotkingDay: Boolean;
    begin
        /*clear(DaysCount);
        clear(NewDate);
         NewDate:=Start_Date;
        repeat
        DaysCount:=DaysCount+1;
        Last_is_WotkingDay:=false;
        
        until (() AND ()) */

    end;

    procedure ItsHolliday(var Start_Date: Date) holliday: Boolean
    var
        baseCal: Record "Base Calendar Change";
        days: Integer;
        Months: Integer;
        bool_Non_Working: Boolean;
    begin
        Clear(days);
        Clear(Months);
        Clear(bool_Non_Working);
        days := Date2DMY(Start_Date, 1);
        Months := Date2DMY(Start_Date, 2);
        baseCal.Reset;
        baseCal.SetFilter(baseCal."Recurring System", '=%1', baseCal."Recurring System"::"Annual Recurring");
        if baseCal.Find('-') then begin
            repeat
                if ((Months = Date2DMY(baseCal.Date, 1)) and (days = Date2DMY(baseCal.Date, 1))) then bool_Non_Working := true;
            until ((((Months = Date2DMY(baseCal.Date, 1)) and (days = Date2DMY(baseCal.Date, 1)))) or (baseCal.Next = 0))
        end;
    end;

    procedure ItsSunday(var Start_Date: Date; var LeaveType: Integer)
    var
        leave_types: Record "HRM-Leave Types";
        dates: Record Date;
    begin
    end;

    procedure autoPostLeave()
    var
        LeaveEntry: Record "HRM-Leave Ledger";
        HREmp: Record "HRM-Employee (D)";
    begin
        // if Rec.Status <> Rec.Status::Released then Error('The Document Approval is not Complete');

        Rec.TestField("Employee No");
        Rec.TestField("Applied Days");
        Rec.TestField("Starting Date");

        LeaveEntry.Init;
        LeaveEntry."Document No" := Rec."No.";
        LeaveEntry."Leave Period" := Date2DWY(Today, 3);
        LeaveEntry."Transaction Date" := Rec.Date;
        LeaveEntry."Employee No" := Rec."Employee No";
        LeaveEntry."Leave Type" := Rec."Leave Type";
        LeaveEntry."No. of Days" := -Rec."Applied Days";
        LeaveEntry."Transaction Description" := Rec.Purpose;
        LeaveEntry."Entry Type" := LeaveEntry."Entry Type"::Application;
        LeaveEntry."Created By" := UserId;
        LeaveEntry."Transaction Type" := LeaveEntry."Transaction Type"::Application;
        LeaveEntry.Insert(true);

        Rec.Posted := true;
        Rec."Posted By" := UserId;
        Rec."Posting Date" := Today;
        Rec.Modify;

        if HREmp.Get(Rec."Employee No") then begin
            HREmp."On Leave" := true;
            HREmp."Current Leave No" := Rec."No.";
            HREmp.Modify;
        end;
        //Message('Leave Posted Successfully');
    end;





    local procedure ValidateLeaveDays(leaveType: Code[20]; appliedDays: Decimal)
    var
        leaveT: Record "HRM-Leave Types";
    begin
        leaveT.reset();
        leaveT.SetRange(Code, leaveType);
        leaveT.SetRange(IsAnnual, false);
        if leaveT.findfirst then begin
            if appliedDays > leaveT.Days then Error('Maximum days for leave %1 is %2', leaveType, leaveT.Days);
            //Rec."Applied Days" := leaveT.Days;
        end;

    end;

}

