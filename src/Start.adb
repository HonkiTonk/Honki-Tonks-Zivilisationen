with Ada.Wide_Wide_Text_IO, Auswahl, Einlesen, Optionen, SpielEinstellungen, AllesAufAnfangSetzen, Informationen, Laden, Fehlermeldungen, ImSpiel;
use Ada.Wide_Wide_Text_IO;

procedure Start is
   ErfolgreichGeladen : Boolean;

   Startauswahl : Integer;
   RückgabeKampagne : Integer := 0;

begin

   Einlesen.EinlesenText;

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

         when 2 => -- Laden
            ErfolgreichGeladen := Laden.Laden;
            case ErfolgreichGeladen is
               when True =>
                  RückgabeKampagne := ImSpiel.ImSpiel;
                  case RückgabeKampagne is
                     when 0 =>
                        AllesAufAnfangSetzen.AllesAufAnfangSetzen;

                     when -1 =>
                        exit StartSchleife;

                     when others =>
                        Put_Line (Item => "Sollte niemals aufgerufen werden, Start.Laden");
                  end case;

               when False =>
                  Fehlermeldungen.Fehlermeldungen (WelcheFehlermeldung => 9);
            end case;

         when 3 => -- Optionen
            Optionen.Optionen;

         when 4 => -- Informationen
            Informationen.Informationen;

         when -1 => -- Beenden
            exit StartSchleife;

         when others =>
            Put_Line (Item => "Sollte niemals aufgerufen werden, Start.Start2");
      end case;

   end loop StartSchleife;

   Put_Line (Item => "Auf Wiedersehen!");

end Start;
