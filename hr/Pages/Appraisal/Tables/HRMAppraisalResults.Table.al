// table 75009 "HRM-Appraisal Results"
// {

//     fields
//     {
//         field(1; "Appraisal Job Code"; Code[20])
//         {
//             NotBlank = true;
//             TableRelation = "HRM-Appraisal Jobs".Code;
//         }
//         field(3; "Appraisal Target"; Code[50])
//         {
//             NotBlank = true;
//             TableRelation = "HRM-Appraisal Targets".Code;
//         }
//         field(4; "Appraisal Period Code"; Code[50])
//         {
//             NotBlank = true;
//             TableRelation = "HRM-Appraisal Periods";
//         }
//         field(5; Score; Decimal)
//         {
//             Editable = true;
//             NotBlank = true;

//             trigger OnValidate()
//             begin
//                 // update trans_Reg
//                 Course_Reg.RESET;
//                 Course_Reg.SETRANGE(Course_Reg."PF No.", Rec."PF No.");
//                 Course_Reg.SETRANGE(Course_Reg."Appraisal Job Code", Rec."Appraisal Job Code");
//                 Course_Reg.SETRANGE(Course_Reg."Appraisal Period Code", Rec."Appraisal Period Code");
//                 Course_Reg.SETRANGE(Course_Reg."Appraisal Year Code", Rec."Appraisal Year Code");
//                 IF Course_Reg.FIND('-') THEN BEGIN
//                     //SETCURRENTKEY("PF No.",Programme,Stage,Unit,Semester,ExamType,"Reg. Transaction ID","Entry No");
//                     //  RENAME("PF No.",Programme,Stage,Unit,Semester,ExamType,Course_Reg."Reg. Transacton ID","Entry No");

//                     //EmployeeApprTargers.reset;
//                     //EmployeeApprTargers.setrange();

//                 END;
//                 prog.RESET;
//                 prog.SETRANGE(Code, "Appraisal Job Code");
//                 IF NOT prog.FIND('-') THEN ERROR('Invalid Job Position!');
//                 IF prog."Appraisal Category" = '' THEN ERROR('Appraisal category is missing on the program!');
//                 SExams.RESET;
//                 SExams.SETRANGE(SExams.Code, ExamType);
//                 SExams.SETRANGE(Category, prog."Appraisal Category");
//                 IF SExams.FIND('-') THEN BEGIN
//                     IF Score > SExams."Max. Score" THEN
//                         ERROR('Score can not be greater than the maximum score.');
//                     IF Score > 0 THEN BEGIN
//                         Percentage := (Score / SExams."Max. Score") * 100;
//                         Contribution := Percentage * (SExams."% Contrib. Final Score" / 100);
//                         Gradings.RESET;
//                         prog.RESET;
//                         IF prog.GET("Appraisal Job Code") THEN
//                             IF prog."Appraisal Category" = '' THEN
//                                 Gradings.SETRANGE(Gradings.Category, 'DEFAULT')
//                             ELSE
//                                 Gradings.SETRANGE(Gradings.Category, prog."Appraisal Category");
//                         Gradings.SETFILTER("Lower Limit", '=%1|<%2', Score, Score);
//                         Gradings.SETFILTER("Upper Limit", '=%1|>%2', Score, Score);
//                         LastGrade := '';
//                         LastScore := 0;
//                         IF Gradings.FIND('-') THEN BEGIN
//                             Grade := Gradings.Grade;
//                         END;

//                     END ELSE BEGIN
//                         Percentage := 0;
//                         Contribution := 0;
//                         Grade := '';
//                     END;

//                 END;


//                 Course_Reg.RESET;
//                 Course_Reg.SETRANGE(Course_Reg."PF No.", "PF No.");
//                 Course_Reg.SETRANGE(Course_Reg."Appraisal Job Code", "Appraisal Job Code");
//                 Course_Reg.SETRANGE(Course_Reg."Appraisal Period Code", "Appraisal Period Code");
//                 Course_Reg.SETRANGE(Course_Reg."Appraisal Year Code", "Appraisal Year Code");
//                 IF Course_Reg.FIND('-') THEN BEGIN

//                     EmployeeApprTargers.RESET;
//                     EmployeeApprTargers.SETRANGE(EmployeeApprTargers."Appraisal Job Code", Course_Reg."Appraisal Job Code");
//                     EmployeeApprTargers.SETRANGE(EmployeeApprTargers."Appraisal Target Code", Rec."Appraisal Target");
//                     EmployeeApprTargers.SETRANGE(EmployeeApprTargers."Appraisal Period Code", "Appraisal Period Code");
//                     EmployeeApprTargers.SETRANGE(EmployeeApprTargers."PF. No.", "PF No.");
//                     IF EmployeeApprTargers.FIND('-') THEN BEGIN
//                         EmployeeApprTargers.CALCFIELDS(EmployeeApprTargers."Total Score", EmployeeApprTargers."Individual Target");
//                         EmployeeApprTargers."Final Score" := EmployeeApprTargers."Total Score";
//                         EmployeeApprTargers."Total Marks" := EmployeeApprTargers."Total Score";
//                         //  EmployeeApprTargers.Grade:=GetGrade(EmployeeApprTargers."Mid-Year Marks",0,EmployeeApprTargers."End-Year Marks",Course_Reg."Appraisal Job Code");
//                         /*  IF (GetGrade(EmployeeApprTargers."Mid-Year Marks",0,EmployeeApprTargers."End-Year Marks",Course_Reg."Appraisal Job Code"))='E' THEN
//                             EmployeeApprTargers."Consolidated Mark Pref.":='^';
//                          */
//                         ACAUnitsSubjects.RESET;
//                         ACAUnitsSubjects.SETRANGE("Appraisal Job Code", "Appraisal Job Code");
//                         ACAUnitsSubjects.SETRANGE(Code, "Appraisal Target");
//                         IF ACAUnitsSubjects.FIND('-') THEN BEGIN
//                         END;
//                         // EmployeeApprTargers."Old Unit":=GetGrade(EmployeeApprTargers."CAT-1",EmployeeApprTargers."CAT-2",EmployeeApprTargers."EXAMs Marks",Course_Reg.Programme);
//                         // EmployeeApprTargers."Academic Year":="Academic Year";
//                         EmployeeApprTargers.MODIFY;

//                     END ELSE BEGIN
//                         AppraisalRegi2.RESET;
//                         AppraisalRegi2.SETRANGE(AppraisalRegi2."PF No.", "PF No.");
//                         AppraisalRegi2.SETRANGE(AppraisalRegi2."Appraisal Job Code", "Appraisal Job Code");
//                         AppraisalRegi2.SETRANGE(AppraisalRegi2."Appraisal Period Code", "Appraisal Period Code");
//                         IF AppraisalRegi2.FIND('-') THEN BEGIN
//                             EmployeeApprTargers.INIT;
//                             EmployeeApprTargers."Reg. Transacton ID" := AppraisalRegi2."Reg. Transacton ID";
//                             EmployeeApprTargers."Appraisal Job Code" := "Appraisal Job Code";
//                             EmployeeApprTargers."Appraisal Target Code" := "Appraisal Target";
//                             EmployeeApprTargers."Appraisal Period Code" := "Appraisal Period Code";
//                             EmployeeApprTargers."PF. No." := "PF No.";
//                             EmployeeApprTargers."Appraisal year Code" := "Appraisal Year Code";
//                             EmployeeApprTargers.INSERT;

//                             EmployeeApprTargers.RESET;
//                             EmployeeApprTargers.SETRANGE(EmployeeApprTargers."Appraisal Job Code", Course_Reg."Appraisal Job Code");
//                             EmployeeApprTargers.SETRANGE(EmployeeApprTargers."Appraisal Target Code", "Appraisal Target");
//                             EmployeeApprTargers.SETRANGE(EmployeeApprTargers."Appraisal Period Code", "Appraisal Period Code");
//                             EmployeeApprTargers.SETRANGE(EmployeeApprTargers."PF. No.", "PF No.");
//                             IF EmployeeApprTargers.FIND('-') THEN BEGIN
//                                 ///  EmployeeApprTargers.CALCFIELDS(EmployeeApprTargers."Total Score",EmployeeApprTargers."Mid-Year Marks",EmployeeApprTargers."Mid-Year Total Marks",EmployeeApprTargers."End-Year  Marks",EmployeeApprTargers."End Year Marks Exists",
//                                 //  EmployeeApprTargers."Mid-Year Marks Exists");
//                                 /* EmployeeApprTargers."End-Year  Marks":=EmployeeApprTargers."Total Score";
//                                  EmployeeApprTargers."Total Marks":=EmployeeApprTargers."Total Score";
//                                  EmployeeApprTargers.Grade:=GetGrade(EmployeeApprTargers."Mid-Year Marks",0,EmployeeApprTargers."End-Year  Marks",Course_Reg."Appraisal Job Code");
//                                  IF EmployeeApprTargers.Grade='E' THEN
//                                    EmployeeApprTargers."Consolidated Mark Pref.":='^';

//                                    ACAUnitsSubjects.RESET;
//                                    ACAUnitsSubjects.SETRANGE("Appraisal Job Code","Appraisal Job Code");
//                                    ACAUnitsSubjects.SETRANGE(Code,"Appraisal Target");
//                                    IF ACAUnitsSubjects.FIND('-') THEN BEGIN

//                                      END;*/
//                                 EmployeeApprTargers."Appraisal year Code" := "Appraisal Year Code";
//                                 EmployeeApprTargers.MODIFY;

//                             END;
//                         END;

//                     END;

//                 END;

//             end;
//         }
//         field(6; Exam; Code[50])
//         {
//         }
//         field(7; "Reg. Transaction ID"; Code[50])
//         {
//         }
//         field(8; "PF No."; Code[30])
//         {
//             Editable = true;
//             TableRelation = Customer."No.";
//         }
//         field(9;Grade;Code[50])
//         {
//             TableRelation = "HRM-Appraisal Grading".Grade;
//         }
//         field(10;Percentage;Decimal)
//         {
//         }
//         field(11;Contribution;Decimal)
//         {
//             Editable = false;
//         }
//         field(18;"Appraisal Category";Code[50])
//         {
//         }
//         field(19;ExamType;Code[50])
//         {
//         }
//         field(20;"Admission No";Code[50])
//         {
//         }
//         field(21;SN;Boolean)
//         {
//         }
//         field(22;Reported;Boolean)
//         {
//         }
//         field(23;"Lecturer Names";Text[250])
//         {
//         }
//         field(24;UserID;Code[50])
//         {
//         }
//         field(50001;"Original Score";Decimal)
//         {
//         }
//         field(50002;"Last Edited By";Code[50])
//         {
//         }
//         field(50003;"Last Edited On";Date)
//         {
//         }
//         field(50004;Submitted;Boolean)
//         {
//         }
//         field(50005;"Submitted On";Date)
//         {
//         }
//         field(50006;"Submitted By";Code[50])
//         {
//         }
//         field(50007;Category;Code[50])
//         {
//         }
//         field(50008;Department;Code[50])
//         {
//         }
//         field(50009;"Original Contribution";Decimal)
//         {
//         }
//         field(50018;"Appraisal Year Code";Code[50])
//         {
//             TableRelation = "HRM-Appraisal Years".Code;
//         }
//         field(50022;"User Name";Code[20])
//         {
//         }
//     }

//     keys
//     {
//         key(Key1;"Reg. Transaction ID")
//         {
//             Clustered = true;
//             SumIndexFields = Score,Contribution;
//         }
//     }

//     fieldgroups
//     {
//     }

//     trigger OnDelete()
//     begin
//          //  ERROR('Please note that modification of results is not allowed');
//     end;

//     trigger OnModify()
//     begin
//          // ERROR('Please note that modification of results is not allowed');
//     end;

//     var
//         SExams: Record "HRM-Appraisal Res. Setup";
//         //Gradings: Record "61599";
//         LastGrade: Code[20];
//         LastScore: Decimal;
//         ExitDo: Boolean;
//         //Gradings2: Record "61599";
//         EResults: Record "75009";
//         Exams: Record "HRM-Appraisal Res. Setup";
//         Course_Reg: Record "75007";
//         EmployeeApprTargers: Record "75010";
//         prog: Record "75003";
//         EResults2: Record "75009";
//         AppraisalRegi2: Record "75007";
//         ACAUnitsSubjects: Record "75004";

//     [Scope('Internal')]
//     procedure GetGrade(CAT1: Decimal;CAT2: Decimal;FinalM: Decimal;prog: Code[100]) xGrade: Text[100]
//     var
//         UnitsRR: Record "75004";
//         ProgrammeRec: Record "75003";
//         LastGrade: Code[20];
//         LastRemark: Code[20];
//         ExitDo: Boolean;
//         LastScore: Decimal;
//         //Gradings: Record "61599";
//         //Gradings2: Record "61599";
//         GLabel: array [6] of Code[20];
//         i: Integer;
//         GLabel2: array [6] of Code[100];
//         FStatus: Boolean;
//         Grd: Code[80];
//         Grade: Code[20];
//         GradeCategory: Code[50];
//         Marks: Decimal;
//     begin
//         GradeCategory:='';
//         CLEAR(Marks);
//         ProgrammeRec.RESET;
//         IF ProgrammeRec.GET(prog) THEN
//         GradeCategory:=ProgrammeRec."Appraisal Category";
//         IF GradeCategory='' THEN ERROR('Please note that you must specify Appraisal Category in Appraisal Job Setup');
//         xGrade:='';
//         IF CAT1+CAT2+FinalM > 0 THEN BEGIN
//         Marks:=CAT1+CAT2+FinalM;
//         Gradings.RESET;
//         Gradings.SETRANGE(Gradings.Category,GradeCategory);
//         LastGrade:='';
//         LastRemark:='';
//         LastScore:=0;
//         IF Gradings.FIND('-') THEN BEGIN
//         ExitDo:=FALSE;
//         REPEAT
//         LastScore:=Gradings."Up to";
//         IF Marks < LastScore THEN BEGIN
//         IF ExitDo = FALSE THEN BEGIN
//         xGrade:=Gradings.Grade;
//         IF Gradings.Failed=FALSE THEN
//         LastRemark:='PASS'
//         ELSE
//         LastRemark:='FAIL';
//         ExitDo:=TRUE;
//         END;
//         END;

//         UNTIL Gradings.NEXT = 0;


//         END;

//         END ELSE BEGIN
//         Grade:='';
//         END;
//     end;
// }

