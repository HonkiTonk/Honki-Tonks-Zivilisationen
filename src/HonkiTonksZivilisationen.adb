with Ada.Task_Identification; use Ada.Task_Identification;
with Ada.Exceptions; use Ada.Exceptions;
with Ada.Text_IO; use Ada.Text_IO;

with ZeitKonstanten;

with StartLogik;
with Grafik;
with Musik;
with Sound;

with NachGrafiktask;
with FehlermeldungSchreiben;
with StartEndeSound;
-- with StartEndeMusik;
with DebugobjekteLogik;

procedure HonkiTonksZivilisationen
is

   UnerwarteterFehler : Boolean := False;

   type Tasks_Enum is (
                       Task_Logik_Enum, Task_Grafik_Enum, Task_Musik_Enum, Task_Sound_Enum
                      );

   type TasksLaufenArray is array (Tasks_Enum'Range) of Boolean;
   TasksLaufen : TasksLaufenArray := (
                                      others => False
                                     );

   type TaskIDArray is array (Tasks_Enum'Range) of Task_Id;
   TaskID : TaskIDArray;

   task LogikTask;
   task GrafikTask;
   task MusikTask;
   task SoundTask;

   task body LogikTask
   is begin

      TaskID (Task_Logik_Enum) := Current_Task;

      TasksLaufen (Task_Logik_Enum) := True;
      StartLogik.StartLogik;
      TasksLaufen (Task_Logik_Enum) := False;

   exception
      when StandardAdaFehler : others =>
         case
           DebugobjekteLogik.Debug.FehlerWarnung
         is
            when True =>
               Put_Line (Item => "Logiktask wurde abgebrochen.");
               Put_Line (Item => Exception_Information (StandardAdaFehler));

            when False =>
               null;
         end case;

         FehlermeldungSchreiben.MeldungSchreiben (MeldungExtern => "Logiktask wurde abgebrochen.");
         FehlermeldungSchreiben.MeldungSchreibenASCII (MeldungExtern => Exception_Information (StandardAdaFehler));
         UnerwarteterFehler := True;

   end LogikTask;



   task body GrafikTask
   is begin

      TaskID (Task_Grafik_Enum) := Current_Task;

      TasksLaufen (Task_Grafik_Enum) := True;
      Grafik.Grafik;
      TasksLaufen (Task_Grafik_Enum) := False;

   exception
      when StandardAdaFehler : others =>
         case
           DebugobjekteLogik.Debug.FehlerWarnung
         is
            when True =>
               Put_Line (Item => "Grafiktask wurde abgebrochen.");
               Put_Line (Item => Exception_Information (StandardAdaFehler));

            when False =>
               null;
         end case;

         FehlermeldungSchreiben.MeldungSchreiben (MeldungExtern => "Grafiktask wurde abgebrochen.");
         FehlermeldungSchreiben.MeldungSchreibenASCII (MeldungExtern => Exception_Information (StandardAdaFehler));
         UnerwarteterFehler := True;

   end GrafikTask;



   task body MusikTask
   is begin

      TaskID (Task_Musik_Enum) := Current_Task;

      TasksLaufen (Task_Musik_Enum) := True;
      Musik.Musik;
      TasksLaufen (Task_Musik_Enum) := False;

   exception
      when StandardAdaFehler : others =>
         case
           DebugobjekteLogik.Debug.FehlerWarnung
         is
            when True =>
               Put_Line (Item => "Musiktask wurde abgebrochen.");
               Put_Line (Item => Exception_Information (StandardAdaFehler));

            when False =>
               null;
         end case;

         FehlermeldungSchreiben.MeldungSchreiben (MeldungExtern => "Musiktask wurde abgebrochen.");
         FehlermeldungSchreiben.MeldungSchreibenASCII (MeldungExtern => Exception_Information (StandardAdaFehler));
         UnerwarteterFehler := True;

   end MusikTask;



   task body SoundTask
   is begin

      TaskID (Task_Sound_Enum) := Current_Task;

      TasksLaufen (Task_Sound_Enum) := True;
      Sound.Sound;
      TasksLaufen (Task_Sound_Enum) := False;

   exception
      when StandardAdaFehler : others =>
         case
           DebugobjekteLogik.Debug.FehlerWarnung
         is
            when True =>
               Put_Line (Item => "Soundtask wurde abgebrochen.");
               Put_Line (Item => Exception_Information (StandardAdaFehler));

            when False =>
               null;
         end case;

         FehlermeldungSchreiben.MeldungSchreiben (MeldungExtern => "Soundtask wurde abgebrochen.");
         FehlermeldungSchreiben.MeldungSchreibenASCII (MeldungExtern => Exception_Information (StandardAdaFehler));
         UnerwarteterFehler := True;

   end SoundTask;

begin

   TaskIDsBelegenLassenSchleife:
   loop

      if
        TasksLaufen (Task_Logik_Enum) = True
        and
          TasksLaufen (Task_Grafik_Enum) = True
        and
          TasksLaufen (Task_Musik_Enum) = True
        and
          TasksLaufen (Task_Sound_Enum) = True
      then
         exit TaskIDsBelegenLassenSchleife;

      elsif
        UnerwarteterFehler
      then
         exit TaskIDsBelegenLassenSchleife;

      else
         delay ZeitKonstanten.WartezeitStart;
      end if;

   end loop TaskIDsBelegenLassenSchleife;

   SpielLäuftSchleife:
   loop

      case
        UnerwarteterFehler
      is
         when True =>
            Abort_Task (T => TaskID (Task_Logik_Enum));
            Abort_Task (T => TaskID (Task_Grafik_Enum));
            Abort_Task (T => TaskID (Task_Musik_Enum));

            -- Wird benötigt damit nicht zusätzlich die Fehlermeldung "AL lib: (EE) alc_cleanup: 1 device not closed" noch mit angezeigt wird.
            StartEndeSound.Entfernen;
            Abort_Task (T => TaskID (Task_Sound_Enum));

            FehlermeldungSchreiben.MeldungSchreiben (MeldungExtern => "Unerwartet beendet.");
            exit SpielLäuftSchleife;

         when False =>
            delay ZeitKonstanten.WartezeitStart;
      end case;

      case
        NachGrafiktask.FensterGeschlossen
      is
         when True =>
            StartEndeSound.TaskStoppen;

            Abort_Task (T => TaskID (Task_Logik_Enum));
            Abort_Task (T => TaskID (Task_Musik_Enum));
            -- Den Soundtask abzubrechen sollte nicht mehr nötig sein, da durch den Aufruf von StartEndeSound.AllesStoppen der Soundtask bereits beendet wird.
            -- Könnte es da Problemfälle geben? äöü
            -- Abort_Task (T => TaskID (Task_Sound_Enum));

            -- StartEndeMusik.Stoppen;
            -- Sollte das nicht auch nötig sein? äöü
            -- StartEndeMusik.Entfernen;
            TasksLaufen := (others => False);

         when False =>
            null;
      end case;

      if
        TasksLaufen (Task_Logik_Enum) = False
        and
          TasksLaufen (Task_Grafik_Enum) = False
        and
          TasksLaufen (Task_Musik_Enum) = False
        and
          TasksLaufen (Task_Sound_Enum) = False
      then
         exit SpielLäuftSchleife;

      else
         null;
      end if;

      UnerwarteterFehlerSchleife:
      for UnerwarteterFehlerSchleifenwert in Tasks_Enum'Range loop

         if
           Is_Terminated (T => TaskID (UnerwarteterFehlerSchleifenwert)) = True
           and
             TasksLaufen (UnerwarteterFehlerSchleifenwert) = True
         then
            UnerwarteterFehler := True;
            exit UnerwarteterFehlerSchleife;

         else
            null;
         end if;

      end loop UnerwarteterFehlerSchleife;

   end loop SpielLäuftSchleife;

end HonkiTonksZivilisationen;
