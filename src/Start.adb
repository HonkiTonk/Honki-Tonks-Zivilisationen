pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO;
use Ada.Wide_Wide_Text_IO;

with GlobaleDatentypen, GlobaleKonstanten;
-- with Programmanalyse;

with Auswahl, Einlesen, Optionen, SpielEinstellungen, AllesAufAnfangSetzen, Informationen, ImSpiel, Laden, Anzeige, Wuerdigung;

procedure Start is

   EinlesenErgebnis : Boolean;
   LadenErfolgreich : Boolean;

   Startauswahl : Integer;
   RückgabeKampagne : Integer;
   RückgabeOptionen : Integer;

begin

   -- Programmanalyse.Auswahl;

   EinlesenErgebnis := Einlesen.Einlesen;

   case EinlesenErgebnis is
      when True =>
         StartSchleife:
         loop

            Startauswahl := Auswahl.Auswahl (FrageDateiExtern  => GlobaleDatentypen.Start,
                                             TextDateiExtern   => GlobaleDatentypen.Start,
                                             FrageZeileExtern  => 1,
                                             ErsteZeileExtern  => 2,
                                             LetzteZeileExtern => 6);

            case Startauswahl is
               when GlobaleKonstanten.StartNormalKonstante => -- Start
                  RückgabeKampagne := SpielEinstellungen.SpielEinstellungen;

                  case RückgabeKampagne is
                     when GlobaleKonstanten.HauptmenüKonstante =>
                        AllesAufAnfangSetzen.AllesAufAnfangSetzen;

                     when GlobaleKonstanten.SpielBeendenKonstante =>
                        exit StartSchleife;

                     when others =>
                        null;
                  end case;

               when GlobaleKonstanten.LadenKonstante => -- Laden
                  LadenErfolgreich := Laden.LadenNeu;

                  case LadenErfolgreich is
                     when True =>
                        RückgabeKampagne := ImSpiel.ImSpiel;
                        case RückgabeKampagne is
                           when GlobaleKonstanten.HauptmenüKonstante =>
                              AllesAufAnfangSetzen.AllesAufAnfangSetzen;

                           when GlobaleKonstanten.SpielBeendenKonstante =>
                              exit StartSchleife;

                           when others =>
                              null;
                        end case;

                     when False =>
                        null;
                  end case;

               when GlobaleKonstanten.OptionenKonstante => -- Optionen
                  RückgabeOptionen := Optionen.Optionen;
                  case RückgabeOptionen is
                     when GlobaleKonstanten.SpielBeendenKonstante =>
                        exit StartSchleife;

                     when others =>
                        null;
                  end case;

               when GlobaleKonstanten.InformationenKonstante => -- Informationen
                  Informationen.Informationen;

               when 10 => -- Wuerdigung
                  Wuerdigung.Wuerdigung;

               when GlobaleKonstanten.SpielBeendenKonstante => -- Beenden
                  exit StartSchleife;

               when others =>
                  null;
            end case;

         end loop StartSchleife;

         Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                        TextDateiExtern        => GlobaleDatentypen.Start,
                                        ÜberschriftZeileExtern => 0,
                                        ErsteZeileExtern       => 7,
                                        LetzteZeileExtern      => 7,
                                        AbstandAnfangExtern    => GlobaleDatentypen.Neue_Zeile,
                                        AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                        AbstandEndeExtern      => GlobaleDatentypen.Keiner);

      when False =>
         Put_Line (Item => "Benötigte Dateien nicht gefunden (Start.EinlesenErgebnis => False)!"); -- Nicht über Anzeige regeln, da die benötigten Dateien ja gar nicht eingelesen wurden!
   end case;

end Start;
