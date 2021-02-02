with Ada.Wide_Wide_Text_IO;
use Ada.Wide_Wide_Text_IO;

with Auswahl, Einlesen, Optionen, SpielEinstellungen, AllesAufAnfangSetzen, Informationen, ImSpiel, Laden;

procedure Start is

   Startauswahl : Integer;
   RückgabeKampagne : Integer;
   EinlesenErgebnis : Boolean;

begin

   EinlesenErgebnis := Einlesen.Einlesen;

   case EinlesenErgebnis is
      when True =>
         StartSchleife:
         loop

            Startauswahl := Auswahl.AuswahlNeu (AuswahlOderAnzeige => True,
                                                FrageDatei         => 0,
                                                FrageZeile         => 0,
                                                TextDatei          => 1,
                                                ErsteZeile         => 1,
                                                LetzteZeile        => 5);

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
                  Laden.LadenNeu;
                  RückgabeKampagne := ImSpiel.ImSpiel;
                  case RückgabeKampagne is
                     when 0 =>
                        AllesAufAnfangSetzen.AllesAufAnfangSetzen;

                     when -1 =>
                        exit StartSchleife;

                     when others =>
                        Put_Line (Item => "Sollte niemals aufgerufen werden, Start.Laden");
                  end case;

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
