with Ada.Task_Identification; use Ada.Task_Identification;
with Ada.Exceptions; use Ada.Exceptions;
with Ada.Text_IO; use Ada.Text_IO;

with MeldungSchreibenHTSEB;

with ZeitKonstanten;
with Projekteinstellungen;

with LeseGrafiktask;

with Logik;
with Grafik;
with Musik;
with Sound;

with StartEndeSound;
-- with StartEndeMusik;
with SchreibenEinstellungenLogik;
with SpeichernLogik;

procedure HonkiTonksZivilisationen
is

   UnerwarteterFehler : Boolean := False;
   NotfallSpielstand : Boolean;

   type Tasks_Enum is (
                       Task_Logik_Enum, Task_Grafik_Enum, Task_Musik_Enum, Task_Sound_Enum
                      );

   type TasksLaufenArray is array (Tasks_Enum'Range) of Boolean;
   TasksLaufen : TasksLaufenArray := (
                                      others => False
                                     );

   type TaskIDArray is array (Tasks_Enum'Range) of Task_Id;
   TaskID : TaskIDArray;

   task Logiktask;
   task Grafiktask;
   task Musiktask;
   task Soundtask;

   task body Logiktask
   is begin

      TaskID (Task_Logik_Enum) := Current_Task;

      TasksLaufen (Task_Logik_Enum) := True;
      Logik.Logik;
      TasksLaufen (Task_Logik_Enum) := False;

   exception
      when StandardAdaFehler : others =>
         case
           Projekteinstellungen.Einstellungen.FehlerWarnung
         is
            when True =>
               Put_Line (Item => "Logiktask wurde abgebrochen: " & Exception_Information (X => StandardAdaFehler));

            when False =>
               null;
         end case;

         MeldungSchreibenHTSEB.MeldungASCII (MeldungExtern => "Logiktask wurde abgebrochen: " & Exception_Information (X => StandardAdaFehler));
         UnerwarteterFehler := True;

   end Logiktask;



   task body Grafiktask
   is begin

      TaskID (Task_Grafik_Enum) := Current_Task;

      TasksLaufen (Task_Grafik_Enum) := True;
      Grafik.Grafik;
      TasksLaufen (Task_Grafik_Enum) := False;

   exception
      when StandardAdaFehler : others =>
         case
           Projekteinstellungen.Einstellungen.FehlerWarnung
         is
            when True =>
               Put_Line (Item => "Grafiktask wurde abgebrochen: " & Exception_Information (X => StandardAdaFehler));

            when False =>
               null;
         end case;

         MeldungSchreibenHTSEB.MeldungASCII (MeldungExtern => "Grafiktask wurde abgebrochen: " & Exception_Information (X => StandardAdaFehler));
         UnerwarteterFehler := True;

   end Grafiktask;



   task body Musiktask
   is begin

      TaskID (Task_Musik_Enum) := Current_Task;

      TasksLaufen (Task_Musik_Enum) := True;
      Musik.Musik;
      TasksLaufen (Task_Musik_Enum) := False;

   exception
      when StandardAdaFehler : others =>
         case
           Projekteinstellungen.Einstellungen.FehlerWarnung
         is
            when True =>
               Put_Line (Item => "Musiktask wurde abgebrochen: " & Exception_Information (X => StandardAdaFehler));

            when False =>
               null;
         end case;

         MeldungSchreibenHTSEB.MeldungASCII (MeldungExtern => "Musiktask wurde abgebrochen: " & Exception_Information (X => StandardAdaFehler));
         UnerwarteterFehler := True;

   end Musiktask;



   task body Soundtask
   is begin

      TaskID (Task_Sound_Enum) := Current_Task;

      TasksLaufen (Task_Sound_Enum) := True;
      Sound.Sound;
      TasksLaufen (Task_Sound_Enum) := False;

   exception
      when StandardAdaFehler : others =>
         case
           Projekteinstellungen.Einstellungen.FehlerWarnung
         is
            when True =>
               Put_Line (Item => "Soundtask wurde abgebrochen: " & Exception_Information (X => StandardAdaFehler));

            when False =>
               null;
         end case;

         MeldungSchreibenHTSEB.MeldungASCII (MeldungExtern => "Soundtask wurde abgebrochen: " & Exception_Information (X => StandardAdaFehler));
         UnerwarteterFehler := True;

   end Soundtask;

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
         NotfallSpielstand := True;
         exit TaskIDsBelegenLassenSchleife;

      elsif
        UnerwarteterFehler
      then
         NotfallSpielstand := False;
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

            -- Wird benötigt damit nicht der Fehler "AL lib: (EE) alc_cleanup: 1 device not closed" erzeugt wird.
            StartEndeSound.Entfernen;
            Abort_Task (T => TaskID (Task_Sound_Enum));

            if
              NotfallSpielstand
            then
               SpeichernLogik.Speichern (AutospeichernExtern    => True,
                                         NotfallspeichernExtern => True);

            else
               null;
            end if;

            exit SpielLäuftSchleife;

         when False =>
            delay ZeitKonstanten.WartezeitStart;
      end case;

      case
        LeseGrafiktask.FensterEntfernen
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
         SchreibenEinstellungenLogik.SpielendeEinstellungen;
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

exception
   when StandardAdaFehler : others =>
      Put_Line (Item => "Starttask wurde abgebrochen: " & Exception_Information (X => StandardAdaFehler));

      MeldungSchreibenHTSEB.MeldungASCII (MeldungExtern => "Starttask wurde abgebrochen: " & Exception_Information (X => StandardAdaFehler));

end HonkiTonksZivilisationen;
