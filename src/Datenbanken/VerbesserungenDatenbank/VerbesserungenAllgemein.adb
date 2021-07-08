pragma SPARK_Mode (On);

with GlobaleTexte;

with Anzeige;

package body VerbesserungenAllgemein is

   procedure Beschreibung
     (IDExtern : in GlobaleDatentypen.KartenVerbesserung)
   is begin
      
      case
        IDExtern
      is
         when 0 =>
            null;
            
         when others =>
            Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Beschreibungen_Verbesserungen_Kurz,
                                                  TextZeileExtern => Positive (IDExtern));
      end case;
      
   end Beschreibung;

end VerbesserungenAllgemein;
