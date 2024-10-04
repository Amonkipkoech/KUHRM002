// page 68970 "ACA-Clearance Approval Entries"
// {
//     Caption = 'Clearance Approval Entries';
//     Editable = false;
//     PageType = List;
//     SourceTable = 61758;
//     SourceTableView = WHERE(Status = FILTER(Open));

//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field("Student ID"; Rec."Student ID")
//                 {
//                 }
//                 /* field("Student Name"; "Student Name")
//                 {
//                 } */
//                 field("Clearance Level Code"; Rec."Clearance Level Code")
//                 {
//                 }
//                 field(Department; Rec.Department)
//                 {
//                 }
//                 field("Initiated By"; Rec."Initiated By")
//                 {
//                 }
//                 field("Initiated Date"; Rec."Initiated Date")
//                 {
//                 }
//                 field("Initiated Time"; Rec."Initiated Time")
//                 {
//                 }
//                 field("Last Date Modified"; Rec."Last Date Modified")
//                 {
//                 }
//                 field("Last Time Modified"; Rec."Last Time Modified")
//                 {
//                 }
//                 /*  field("Student Intake"; "Student Intake")
//                  {
//                  } */
//                 field("Clear By ID"; Rec."Clear By ID")
//                 {
//                 }
//                 field(Cleared; Rec.Cleared)
//                 {
//                 }
//                 field("Priority Level"; Rec."Priority Level")
//                 {
//                 }
//                 /* field("Academic Year"; "Academic Year")
//                 {
//                 }
//                 field(Semester; Semester)
//                 {
//                 } */
//                 field(Status; Rec.Status)
//                 {
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(creation)
//         {
//             action(clear_stud)
//             {
//                 Caption = 'Clear Student';
//                 Image = Approve;
//                 Promoted = true;
//                 PromotedIsBig = true;
//                 ShortCutKey = 'F12';

//                 trigger OnAction()
//                 begin
//                     IF Rec."Clearance Level Code" = '' THEN ERROR('Nothing to clear!');
//                     CLEAR(counted);
//                     CLEAR(stringval);
//                     IF CONFIRM('Clear ' + Rec."Student ID", TRUE) = FALSE THEN ERROR('Cancelled!');
//                     conditions.RESET;
//                     conditions.SETRANGE(conditions."Clearance Level Code", Rec."Clearance Level Code");
//                     conditions.SETFILTER(conditions."Condition to Check", '<>%1', '');
//                     IF conditions.FIND('-') THEN BEGIN
//                         stringval := '\-----------------------***** ATTENTION *****------------------------';
//                         stringval := stringval + '\Ensure that the following conditions are met';
//                         REPEAT
//                         BEGIN
//                             stringval := stringval + '\' + FORMAT(conditions.Sequence) + '). ' + conditions."Condition to Check";
//                         END;
//                         UNTIL conditions.NEXT = 0;
//                         stringval := stringval + '\                            CONTINUE?                               ';
//                         stringval := stringval + '\-----------------------*********************------------------------';
//                     END ELSE
//                         stringval := 'Ensure that all the conditions required for clearance are met. Continue?';

//                     IF CONFIRM(stringval, TRUE) = FALSE THEN ERROR('Cancelled!');

//                     enties.RESET;
//                     enties.SETRANGE(enties."Clearance Level Code", Rec."Clearance Level Code");
//                     enties.SETRANGE(enties.Department, Rec.Department);
//                     enties.SETRANGE(enties."Student ID", Rec."Student ID");
//                     enties.SETFILTER(enties."Clear By ID", Rec."Clear By ID");
//                     IF enties.FIND('-') THEN BEGIN
//                         enties.Cleared := TRUE;
//                         enties.MODIFY;
//                     END;

//                     enties.RESET;
//                     enties.SETRANGE(enties."Clearance Level Code", Rec."Clearance Level Code");
//                     enties.SETRANGE(enties.Department, Rec.Department);
//                     enties.SETRANGE(enties."Student ID", Rec."Student ID");
//                     enties.SETFILTER(enties.Status, '=%1', enties.Status::Open);
//                     IF enties.FIND('-') THEN BEGIN
//                         REPEAT
//                         BEGIN
//                             enties."Last Date Modified" := TODAY;
//                             enties."Last Time Modified" := TIME;
//                             enties.Status := enties.Status::Cleared;
//                             enties.MODIFY;
//                         END;
//                         UNTIL enties.NEXT = 0;
//                     END;

//                     // Approval for the 1st Approval
//                     IF Rec."Priority Level" = Rec."Priority Level"::"1st Level" THEN BEGIN
//                         //
//                         enties.RESET;
//                         // enties.SETRANGE(enties."Clearance Level Code","Clearance Level Code");
//                         enties.SETRANGE(enties.Department, Rec.Department);
//                         enties.SETRANGE(enties."Student ID", Rec."Student ID");
//                         enties.SETFILTER(enties.Status, '=%1', enties.Status::Created);
//                         //enties.SETFILTER(enties."Priority Level",'=%1',enties."Priority Level"::Normal);
//                         IF enties.FIND('-') THEN BEGIN
//                             REPEAT
//                             BEGIN
//                                 enties."Last Date Modified" := TODAY;
//                                 enties."Last Time Modified" := TIME;
//                                 enties.Status := enties.Status::Open;
//                                 enties.MODIFY;
//                             END;
//                             UNTIL enties.NEXT = 0;
//                         END;
//                     END ELSE
//                         IF Rec."Priority Level" = Rec."Priority Level"::Normal THEN BEGIN
//                             //Search where Final Level and set to open
//                             enties.RESET;
//                             //enties.SETRANGE(enties."Clearance Level Code","Clearance Level Code");
//                             enties.SETRANGE(enties.Department, Rec.Department);
//                             enties.SETRANGE(enties."Student ID", Rec."Student ID");
//                             enties.SETFILTER(enties.Status, '=%1', enties.Status::Open);
//                             enties.SETFILTER(enties."Priority Level", '=%1', enties."Priority Level"::Normal);
//                             IF NOT enties.FIND('-') THEN BEGIN
//                                 // If All other Clearances are done, Open the final Clearance
//                                 /////////////////////////////////////////////////////////////
//                                 //enties.SETRANGE(enties."Clearance Level Code","Clearance Level Code");
//                                 enties.RESET;
//                                 enties.SETRANGE(enties.Department, Rec.Department);
//                                 enties.SETRANGE(enties."Student ID", Rec."Student ID");
//                                 enties.SETFILTER(enties.Status, '=%1', enties.Status::Created);
//                                 enties.SETFILTER(enties."Priority Level", '=%1', enties."Priority Level"::"Final level");
//                                 IF enties.FIND('-') THEN BEGIN
//                                     REPEAT
//                                     BEGIN
//                                         enties."Last Date Modified" := TODAY;
//                                         enties."Last Time Modified" := TIME;
//                                         enties.Status := enties.Status::Open;
//                                         enties.MODIFY;
//                                     END;
//                                     UNTIL enties.NEXT = 0;
//                                 END;

//                                 /////////////////////////////////////////////////////////////
//                             END;
//                         END ELSE
//                             IF Rec."Priority Level" = Rec."Priority Level"::"Final level" THEN BEGIN
//                                 // Change status of the clearance of the student card
//                                 IF cust.GET(Rec."Student ID") THEN BEGIN
//                                     cust."Clearance Status" := cust."Clearance Status"::Cleared;
//                                     cust.MODIFY;
//                                 END;
//                             END;
//                 end;
//             }
//         }
//     }

//     trigger OnInit()
//     begin
//         Rec.SETFILTER("Clear By ID", USERID);
//     end;

//     trigger OnOpenPage()
//     begin
//         Rec.SETFILTER("Clear By ID", USERID);
//     end;

//     var
//         enties: Record 61758;
//         counted: Integer;
//         stringval: Code[1024];
//         conditions: Record 61759;
//         cust: Record 18;
// }

