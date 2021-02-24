pragma SPARK_Mode (On);

with Anzeige;

package body KartenDatenbank is

   procedure Beschreibung (ID : in GlobaleDatentypen.KartenGrund) is
   begin

      case ID is
         when 0 =>
            null;
            
         when others =>
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDatei => GlobaleDatentypen.Leer,
                                           TextDatei        => GlobaleDatentypen.Beschreibungen_Kartenfelder_Kurz,
                                           ÜberschriftZeile => 0,
                                           ErsteZeile       => Positive (ID),
                                           LetzteZeile      => Positive (ID),
                                           AbstandAnfang    => GlobaleDatentypen.Keiner,
                                           AbstandMitte     => GlobaleDatentypen.Keiner,
                                           AbstandEnde      => GlobaleDatentypen.Kleiner_Abstand);
      end case;
      
   end Beschreibung;

end KartenDatenbank;
