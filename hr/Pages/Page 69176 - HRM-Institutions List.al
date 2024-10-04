page 69176 "HRM-Institutions List"
{
    Caption = 'HR Setups';
    CardPageID = "HRM-Institutions";
    PageType = List;
    SourceTable = "HRM-Institutions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Institution Code"; Rec."Institution Code")
                {
                    ApplicationArea = all;
                }
                field("Institution Name"; Rec."Institution Name")
                {
                    ApplicationArea = all;
                }
                field(Country; Rec.Country)
                {
                    ToolTip = 'Specifies the value of the Country field.';
                    ApplicationArea = All;
                }
                field("Private/Public"; Rec."Private/Public")
                {
                    ToolTip = 'Specifies the value of the Private/Public field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group("Company Setups")
            {
                Caption = '&Company Setups';
                Image = Capacities;
                action("Company Information")
                {
                    ApplicationArea = all;
                    Caption = 'Company Information';
                    Image = CompanyInformation;
                    Promoted = true;
                    RunObject = Page "Company Information";
                }
                action(Dimensions)
                {
                    ApplicationArea = all;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    RunObject = Page Dimensions;
                }
                action(Committees)
                {
                    ApplicationArea = all;
                    Caption = 'Committees';
                    Image = AllLines;
                    Promoted = true;
                    RunObject = Page "HRM-Committees (C)";
                }
                action("Boad of Directores")
                {
                    Caption = 'Boad of Directores';
                    Image = Employee;
                    Promoted = true;
                    RunObject = Page "HRM-Board of Directors";
                    ApplicationArea = All;
                }
                action("Rules && Regulations")
                {
                    ApplicationArea = all;
                    Caption = 'Rules && Regulations';
                    Image = RoutingVersions;
                    Promoted = true;
                    RunObject = Page "HRM-Rules & Regulations";
                }
                action("Base Calender Card")
                {
                    ApplicationArea = all;
                    Caption = 'Base Calender Card';
                    Image = Calendar;
                    Promoted = true;
                    RunObject = Page "Base Calendar Card";
                }
                action("Posting Groups")
                {
                    ApplicationArea = all;
                    Caption = 'Posting Groups';
                    Image = PostingEntries;
                    Promoted = true;
                    RunObject = Page "HRM-Posting Groups";
                }
                action("Company Activities")
                {
                    ApplicationArea = all;
                    Caption = 'Company Activities';
                    RunObject = Page "HRM-Company Activities";
                }
            }
            group(Staffing)
            {
                Caption = 'Staffing';
                Image = HRSetup;
                action(Qualifications)
                {
                    ApplicationArea = all;
                    Caption = 'Qualifications';
                    Image = QualificationOverview;
                    Promoted = true;
                    RunObject = Page Qualifications;
                }
                action(Grades)
                {
                    ApplicationArea = all;
                    Caption = 'Grades';
                    Image = Group;
                    Promoted = true;
                    RunObject = Page "HRM-Grades";
                }
            }
            group("Employee Manager Setups")
            {
                Caption = 'Employee Manager Setups';
                Image = HumanResources;
                action("Contract Types")
                {
                    ApplicationArea = all;
                    Caption = 'Contract Types';
                    Image = TestDatabase;
                    Promoted = true;
                    RunObject = Page "HRM-Contract Types";
                }
                action("Ethnic Communities")
                {
                    ApplicationArea = all;
                    Caption = 'Ethnic Communities';
                    Image = Components;
                    Promoted = true;
                    RunObject = Page "GEN-Ethnic Communities";
                }
                action(Designation)
                {
                    ApplicationArea = all;
                    Caption = 'Designation';
                    Image = Group;
                    Promoted = true;
                    RunObject = Page "HRM-Staff Tiltles";
                }
                action("Causes of Absence")
                {
                    ApplicationArea = all;
                    Caption = 'Causes of Absence';
                    RunObject = Page "Causes of Absence";
                }
                action("Causes of Inactivity")
                {
                    ApplicationArea = all;
                    Caption = 'Causes of Inactivity';
                    RunObject = Page "Causes of Inactivity";
                }
                action("Grounds for Termination")
                {
                    ApplicationArea = all;
                    Caption = 'Grounds for Termination';
                    RunObject = Page "Grounds for Termination";
                }
                action("Employment Contracts")
                {
                    ApplicationArea = all;
                    Caption = 'Employment Contracts';
                    RunObject = Page "Employment Contracts";
                }
                action(Action25)
                {
                    ApplicationArea = all;
                    Caption = 'Qualifications';
                    RunObject = Page Qualifications;
                }
                action("Misc. Articles")
                {
                    ApplicationArea = all;
                    Caption = 'Misc. Articles';
                    RunObject = Page "Vendor Card";
                }
                action(Confidential)
                {
                    ApplicationArea = all;
                    Caption = 'Confidential';
                    RunObject = Page Confidential;
                }
                action("Training Sources")
                {
                    ApplicationArea = all;
                    Caption = 'Training Sources';
                    RunObject = Page "HRM-Training Sources";
                }
            }
            group("Leave Management Setups")
            {
                Caption = 'Leave Management Setups';
                Image = Intrastat;
                action("Leave Types")
                {
                    ApplicationArea = all;
                    Caption = 'Leave Types';
                    Image = QualificationOverview;
                    Promoted = true;
                    RunObject = Page "HRM-Leave Types";
                }
                action(Hollidays)
                {
                    ApplicationArea = all;
                    Caption = 'Hollidays';
                    Image = Group;
                    Promoted = true;
                    RunObject = Page "HRM-Holidays";
                }
                action("Base Calendar")
                {
                    ApplicationArea = all;
                    Caption = 'Base Calendar';
                    Image = QualificationOverview;
                    Promoted = true;
                    RunObject = Page "Base Calendar Card";
                }
                action("Leave Family Groups")
                {
                    ApplicationArea = all;
                    Caption = 'Leave Family Groups';
                    Image = Group;
                    Promoted = true;
                    //todo  RunObject = Page "HRM-Leave Family Groups";
                }
            }
            group("Disciplinary Setups")
            {
                Caption = 'Disciplinary Setups';
                Image = Reconcile;
                action("Disciplinary Case Ratings")
                {
                    ApplicationArea = all;
                    Caption = 'Disciplinary Case Ratings';
                    Image = QualificationOverview;
                    Promoted = true;
                    RunObject = Page "HRM-Disciplinary Case Ratings";
                }
                action("Disciplinary Remarks")
                {
                    ApplicationArea = all;
                    Caption = 'Disciplinary Remarks';
                    Image = Group;
                    Promoted = true;
                    RunObject = Page "HRM-Disciplinary Remarks";
                }
                action("Disciplinary  Cases")
                {
                    ApplicationArea = all;
                    Caption = 'Disciplinary  Cases';
                    Image = SetPriorities;
                    Promoted = true;
                    RunObject = Page "HRM-Disciplinary Cases (B)";
                }
                action("Disciplinary Actions")
                {
                    ApplicationArea = all;
                    Caption = 'Disciplinary Actions';
                    Image = AccountingPeriods;
                    Promoted = true;
                    RunObject = Page "HRM-Disciplinary Actions";
                }
            }
            group("Appraisal Setups")
            {
                Caption = 'Appraisal Setups';
                Image = Setup;
                action("Appraisal types")
                {
                    ApplicationArea = all;
                    Caption = 'Appraisal types';
                    Image = Trendscape;
                    Promoted = true;
                    RunObject = Page "HRM-Appraisal Types";
                }
                action("Appraisal Periods")
                {
                    ApplicationArea = all;
                    Caption = 'Appraisal Periods';
                    Image = PeriodStatus;
                    Promoted = true;
                    RunObject = Page "HRM-Appraisal Periods";
                }
                action("Appraisal Ratings")
                {
                    ApplicationArea = all;
                    Caption = 'Appraisal Ratings';
                    Image = ReceiveLoaner;
                    Promoted = true;
                    RunObject = Page "HRM-Appraisal Ratings (B)";
                }
            }
            group("Trainning Management")
            {
                Caption = 'Trainning Management';
                Image = Statistics;
                action("Trainning Programmes")
                {
                    ApplicationArea = all;
                    Caption = 'Trainning Programmes';
                    Image = QualificationOverview;
                    Promoted = true;
                    //RunObject = Page "FIN-Staff Advance List";
                }
                action("External Trainers")
                {
                    ApplicationArea = all;
                    Caption = 'External Trainers';
                    Image = Group;
                    Promoted = true;
                    RunObject = Page "Vendor Card";
                }
            }
            group("General Setups")
            {
                Caption = 'General Setups';
                Image = LotInfo;
                action("HR Setups")
                {
                    ApplicationArea = all;
                    Caption = 'HR Setups';
                    RunObject = Page "HRM-Setup";
                }
                action("Interaction Groups")
                {
                    ApplicationArea = all;
                    Caption = 'Interaction Groups';
                    Image = QualificationOverview;
                    Promoted = true;
                    RunObject = Page "Interaction Groups";
                }
                action("Interaction Templates")
                {
                    ApplicationArea = all;
                    Caption = 'Interaction Templates';
                    Image = Group;
                    Promoted = true;
                    RunObject = Page "Interaction Templates";
                }
                action("Interaction Salutations")
                {
                    ApplicationArea = all;
                    Caption = 'Interaction Salutations';
                    Image = QualificationOverview;
                    Promoted = true;
                    RunObject = Page Salutations;
                }
                action("Templates Setup")
                {
                    ApplicationArea = all;
                    Caption = 'Templates Setup';
                    Image = Template;
                    Promoted = true;
                    RunObject = Page "Interaction Template Setup";
                }
                action("Recruitment Stages")
                {
                    ApplicationArea = all;
                    Caption = 'Recruitment Stages';
                    Image = Stages;
                    Promoted = true;
                    RunObject = Page "HRM-Recruitment stages";
                }
            }
        }
    }
}

