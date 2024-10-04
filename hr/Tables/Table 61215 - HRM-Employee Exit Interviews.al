table 61215 "HRM-Employee Exit Interviews"
{
    //todo  LookupPageID = "ACA-Hostel Reservation Lines";

    fields
    {
        field(1; "Exit Clearance No"; Code[20])
        {
        }
        field(2; "Date Of Clearance"; Date)
        {

            trigger OnValidate()
            begin

                /* IF ("Date Of Interview" <> 0D) AND ("Date Of Interview" <> xRec."Date Of Interview") THEN BEGIN
                   CareerEvent.SetMessage('Exit Interview Conducted');
                   CareerEvent.RUNMODAL;
                   OK:= CareerEvent.ReturnResult;
                   IF OK THEN BEGIN
                       CareerHistory.INIT;
                       CareerHistory."Employee No.":= "Employee No.";
                       CareerHistory."Date Of Event":= "Date Of Interview";
                       CareerHistory."Career Event":= 'Exit Interview Conducted';
                       CareerHistory."Exit Interview":= TRUE;
                        OK:= Employee.GET("Employee No.");
                        IF OK THEN BEGIN
                         CareerHistory."Employee First Name":= Employee."Known As";
                         CareerHistory."Employee Last Name":= Employee."Last Name";
                        END;
                       CareerHistory.INSERT;
                    END;
                 END;
                   */

            end;
        }
        field(3; "Clearance Requester"; Code[20])
        {
            TableRelation = "HRM-Employee (D)"."No.";

            trigger OnValidate()
            begin
                HREmp.Reset;
                HREmp.SetRange(HREmp."No.", "Clearance Requester");
                if HREmp.Find('-') then begin
                    IntFullName := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                    "Clearer Name" := IntFullName;
                end;
            end;
        }
        field(4; "Re Employ In Future"; Option)
        {
            OptionCaption = ' ,Yes,No,Not Applicable';
            OptionMembers = " ",Yes,No,"Not Applicable";
        }
        field(5; "Nature Of Separation"; Option)
        {
            OptionMembers = " ",Resignation,"Non-Renewal Of Contract",Dismissal,Retirement,Deceased,Termination,"Contract Ended",Abscondment,"Appt. Revoked","Contract Termination",Retrenchment,Other;
        }
        field(6; "Reason For Leaving (Other)"; Text[150])
        {
        }
        field(7; "Date Of Leaving"; Date)
        {
            Caption = 'Date of Exit';
        }
        field(8; "Directorate Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            var
                Dimn: Record "Dimension Value";
            begin

                Dimn.SetRange(Dimn.Code, "Directorate Code");
                if Dimn.Find('-') then begin
                    "Directorate Name" := Dimn.Name;
                end;
            end;
        }
        field(9; "Department Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            var
                Dimn: Record "Dimension Value";
            begin

                Dimn.SetRange(Dimn.Code, "Department Code");
                if Dimn.Find('-') then begin
                    "Department Name" := Dimn.Name;
                end;
            end;
        }
        field(10; Comment; Boolean)
        {
            CalcFormula = Exist("HRM-Human Resource Comments" WHERE("Table Name" = CONST("Exit Interviews"),
                                                                     "No." = FIELD("Employee No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Employee No."; Code[20])
        {
            TableRelation = "HRM-Employee (D)"."No." WHERE(Status = CONST(Active));

            trigger OnValidate()
            begin
                HREmp.Reset;
                HREmp.SetRange(HREmp."No.", "Employee No.");
                if HREmp.Find('-') then begin
                    EmpFullName := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                    "Employee Name" := EmpFullName;
                    "Appointment Date" := HREmp."Appointment Date";
                end;
            end;
        }
        field(12; "No Series"; Code[10])
        {
        }
        field(13; "Form Submitted"; Boolean)
        {

            trigger OnValidate()
            begin
                HREmp.Reset;
                HREmp.SetRange("No.", "Employee No.");
                OK := HREmp.Find('-');

                if "Form Submitted" = true then begin

                    if OK then begin
                        HREmp.Status := HREmp.Status::Inactive;
                        HREmp."Date Of Leaving" := "Date Of Leaving";
                        // HREmp."Nature Of Separation":= "Nature Of Separation";
                        HREmp."Exit Interview Done by" := "Clearance Requester";
                        HREmp.Modify;
                    end
                end;

                if "Form Submitted" = false then begin
                    if OK then begin
                        HREmp.Status := HREmp.Status::Active;
                        HREmp."Date Of Leaving" := 0D;
                        HREmp."Termination Category" := HREmp."Termination Category"::" ";
                        HREmp."Exit Interview Done by" := '';
                        HREmp.Modify;
                    end;
                end;
            end;
        }
        field(15; "Employee Name"; Text[50])
        {
        }
        field(16; "Clearer Name"; Text[50])
        {
        }
        field(17; Status; Option)
        {
            OptionCaption = 'New,Pending Approval,Approved';
            OptionMembers = New,"Pending Approval",Approved;
        }
        field(18; "Responsibility Center"; Code[30])
        {
            //TableRelation = "FIN-Responsibility Center BR".Code;
        }
        field(38; "Station Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            var
                Dimn: Record "Dimension Value";
            begin

                Dimn.SetRange(Dimn.Code, "Station Code");
                if Dimn.Find('-') then begin
                    "Station Name" := Dimn.Name;
                end;
            end;
        }
        field(50000; "Station Name"; Text[100])
        {
            Editable = false;
        }
        field(50001; "Directorate Name"; Text[100])
        {
            Editable = false;
        }
        field(50002; "Department Name"; Text[100])
        {
            Editable = false;
        }
        field(50003; "Department Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(50004; "Station Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(50005; "Directorate Filter"; Code[20])
        {
        }
        field(50006; "Employee Type"; Option)
        {
            OptionCaption = 'Permanent,Casuals,Contract';
            OptionMembers = Permanent,Casuals,Contract;
        }
        field(50007; "Appointment Date"; Date)
        {
            Caption = 'Date of Appointment';
        }
        field(50008; "Employee Clearance"; Boolean)
        {
        }
        field(50010; "Final Dues Paid"; Boolean)
        {
        }
        field(50011; "Date Final Dues Paid"; Date)
        {
        }
        field(50012; "Reason For Exit"; Option)
        {
            OptionMembers = " ",Retirement,"Retirement on Medical Ground",Resignation,"Non-Renewal of Contract",Dismissal,"End of Contract",Death,Recall,Termination;
        }
        field(50013; "Date Life Ins. Paid"; Date)
        {
            Caption = 'Date group Life Insurance was Paid';

        }
        field(50014; "Group Life Ins. Paid"; Option)
        {
            Caption = 'Group life insurance cover paid';
            OptionMembers = " ",Yes,No;

        }
        field(50015; "Part time paid Date"; Date)
        {
            Caption = 'Date Part TIme arrears was Paid';

        }
        field(50016; "Leave Arrears Paid"; Option)
        {
            Caption = 'Leave Arrears Paid ';
            OptionMembers = " ",Yes,No;
        }
        field(50017; "Date Last Salary Paid"; Date)
        {
            Caption = 'Date of Last Month Salary Paid';

        }
        field(50018; "Part Time Arrears Paid"; Option)
        {
            Caption = 'Part Time Arrears Paid';
            OptionMembers = " ",Yes,No;
        }
        field(50019; "Last Month Salary Paid"; Option)
        {
            Caption = 'Last Month Salary Paid';
            OptionMembers = " ",Yes,No;
        }
        field(50020; "Approval Status"; Option)
        {
            OptionMembers = New,"Pending Approval",Approved;
        }




    }

    keys
    {
        key(Key1; "Exit Clearance No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        //GENERATE NEW NUMBER FOR THE DOCUMENT
        if "Exit Clearance No" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Exit Interview Nos");
            NoSeriesMgt.InitSeries(HRSetup."Exit Interview Nos", xRec."Exit Clearance No", 0D, "Exit Clearance No", HRSetup."Exit Interview Nos");
        end;


        "Clearance Requester" := UserId;
    end;

    var
        CareerEvent: Page "HRM-Job Resp. and Duties Head";
        OK: Boolean;
        HREmp: Record "HRM-Employee (D)";
        HRSetup: Record "HRM-Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        EmpFullName: Text;
        IntFullName: Text;
        Dimn: Record "Dimension Value";
}

