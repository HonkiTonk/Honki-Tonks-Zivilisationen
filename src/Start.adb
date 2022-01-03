pragma SPARK_Mode (On);

with Ada.Task_Identification; use Ada.Task_Identification;

with StartLogik;
with StartGrafik;
with StartSound;

with Fehler;

procedure Start
is

   LogikID : Task_Id;
   GrafikID : Task_Id;
   SoundID : Task_Id;

   type TasksLaufenArray is array (1 .. 3) of Boolean;
   TasksLaufen : TasksLaufenArray := (others => True);

   task Logik;
   task Grafik;
   task Sound;

   task body Logik
   is begin

      LogikID := Current_Task;
      StartLogik.StartLogik;
      TasksLaufen (1) := False;

   end Logik;



   task body Grafik
   is begin

      GrafikID := Current_Task;
      StartGrafik.StartGrafik;
      TasksLaufen (2) := False;

   end Grafik;



   task body Sound
   is begin

      SoundID := Current_Task;
      StartSound.StartSound;
      TasksLaufen (3) := False;

   end Sound;

begin

   SpielLäuftSchleife:
   loop

      if
        TasksLaufen = (False, False, False)
      then
         exit SpielLäuftSchleife;

      elsif
        Fehler.KritischesProblemLogik
        or
          Fehler.KritischesProblemGrafik
          or
            Fehler.KritischesProblemSound
      then
         -- So besser? Immerhin gibt es keine Konsolenmeldung mehr über den Abbruch des Environment Tasks.
         Abort_Task (T => LogikID);
         Abort_Task (T => GrafikID);
         Abort_Task (T => SoundID);
         exit SpielLäuftSchleife;

      else
         delay 0.20;
      end if;

   end loop SpielLäuftSchleife;

end Start;
