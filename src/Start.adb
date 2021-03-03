pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO;
use Ada.Wide_Wide_Text_IO;

with GlobaleDatentypen;

with Auswahl, Einlesen, Optionen, SpielEinstellungen, AllesAufAnfangSetzen, Informationen, ImSpiel, Laden, Anzeige;

procedure Start is

   EinlesenErgebnis : Boolean;
   LadenErfolgreich : Boolean;

   Startauswahl : Integer;
   RückgabeKampagne : Integer;

begin

   EinlesenErgebnis := Einlesen.Einlesen;

   case EinlesenErgebnis is
      when True =>
         StartSchleife:
         loop

            Startauswahl := Auswahl.Auswahl (FrageDatei  => GlobaleDatentypen.Start,
                                             TextDatei   => GlobaleDatentypen.Start,
                                             FrageZeile  => 1,
                                             ErsteZeile  => 2,
                                             LetzteZeile => 6);

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
                  LadenErfolgreich := Laden.LadenNeu;

                  case LadenErfolgreich is
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
                        null;
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

         Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDatei => GlobaleDatentypen.Leer,
                                        TextDatei        => GlobaleDatentypen.Start,
                                        ÜberschriftZeile => 0,
                                        ErsteZeile       => 7,
                                        LetzteZeile      => 7,
                                        AbstandAnfang    => GlobaleDatentypen.Neue_Zeile,
                                        AbstandMitte     => GlobaleDatentypen.Keiner,
                                        AbstandEnde      => GlobaleDatentypen.Keiner);

      when False =>
         Put_Line (Item => "Benötigte Dateien nicht gefunden.");
   end case;

end Start;
