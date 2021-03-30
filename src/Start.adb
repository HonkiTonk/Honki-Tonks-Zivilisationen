pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO;
use Ada.Wide_Wide_Text_IO;

with GlobaleDatentypen;
-- with Programmanalyse;

with Einlesen, Anzeige, Hauptmenue;

procedure Start is

   EinlesenErgebnis : Boolean;

begin

   -- Programmanalyse.Auswahl;

   EinlesenErgebnis := Einlesen.Einlesen;

   case EinlesenErgebnis is
      when True =>
         Hauptmenue.Hauptmenü;

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
