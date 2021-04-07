pragma SPARK_Mode (On);

with Anzeige;

package body VerbesserungenDatenbank is

   procedure Beschreibung
     (IDExtern : in GlobaleDatentypen.KartenVerbesserung)
   is begin
      
      case
        IDExtern
      is
         when 0 =>
            null;
            
         when others =>
            Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Beschreibungen_Verbesserungen_Kurz,
                                                  TextZeileExtern => Positive (IDExtern));
      end case;
      
   end Beschreibung;

end VerbesserungenDatenbank;
