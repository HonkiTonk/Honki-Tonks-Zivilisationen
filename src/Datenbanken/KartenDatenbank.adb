pragma SPARK_Mode (On);

with Anzeige;

package body KartenDatenbank is

   procedure Beschreibung (ID : in GlobaleDatentypen.KartenGrund) is
   begin

      case ID is
         when 0 =>
            null;
            
         when others =>
            Anzeige.AnzeigeOhneAuswahl (ÜberschriftDatei      => 0,
                                        ÜberschriftZeile      => 0,
                                        TextDatei             => 6,
                                        ErsteZeile            => Positive (ID),
                                        LetzteZeile           => Positive (ID),
                                        MitNew_LineMittendrin => 0,
                                        MitNew_LineAmEnde     => 0);
      end case;
      
   end Beschreibung;

end KartenDatenbank;
