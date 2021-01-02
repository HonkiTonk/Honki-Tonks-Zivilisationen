with Ada.Wide_Wide_Text_IO, Ada.Directories;
use Ada.Wide_Wide_Text_IO, Ada.Directories;

with Auswahl, Einlesen, Optionen, SpielEinstellungen, AllesAufAnfangSetzen, Informationen, ImSpiel, GlobaleVariablen, Ladezeiten;

procedure Start is

   Startauswahl : Integer;
   RückgabeKampagne : Integer := 0;
   EinlesenErgebnis : Boolean;

begin

   GlobaleVariablen.WelcheSprache := 1;

   case Exists (Name => "Dateien/Spielstand") is
      when True =>
         null;

      when False =>
         Create_Directory (New_Directory => "Dateien/Spielstand");
   end case;

   EinlesenErgebnis := Einlesen.Einlesen;

   case EinlesenErgebnis is
      when True =>
         StartSchleife:
         loop

            Startauswahl := Auswahl.Auswahl (WelcheAuswahl => 0, WelcherText => 1);

            case Startauswahl is
               when 1 => -- Start
                  RückgabeKampagne := SpielEinstellungen.SpielEinstellungen;

                  case RückgabeKampagne is
                     when 0 =>
                        AllesAufAnfangSetzen.AllesAufAnfangSetzen;

                     when -1 =>
                        exit StartSchleife;

                     when others =>
                        Put_Line (Item => "Sollte niemals aufgerufen werden, Start.Start");
                  end case;

               when 3 => -- Laden
                  -- Laden.Laden;
                  -- RückgabeKampagne := ImSpiel.ImSpiel;
                  -- case RückgabeKampagne is
                     -- when 0 =>
                        -- AllesAufAnfangSetzen.AllesAufAnfangSetzen;

                     -- when -1 =>
                        -- exit StartSchleife;

                     -- when others =>
                        -- Put_Line (Item => "Sollte niemals aufgerufen werden, Start.Laden");
                  -- end case;
                  RückgabeKampagne := SpielEinstellungen.SpielEinstellungen; -- Später wieder entfernen, wenn Laden wieder funktioniert!
               when 4 => -- Optionen
                  Optionen.Optionen;

               when 5 => -- Informationen
                  Informationen.Informationen;

               when -1 => -- Beenden
                  exit StartSchleife;

               when others =>
                  Put_Line (Item => "Sollte niemals aufgerufen werden, Start.Start2");
            end case;

         end loop StartSchleife;

         Put_Line (Item => "Auf Wiedersehen!");

      when False =>
         Put_Line (Item => "Benötigte Dateien nicht gefunden.");
   end case;

end Start;
