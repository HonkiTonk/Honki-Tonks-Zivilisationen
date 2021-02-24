pragma SPARK_Mode (On);

with Anzeige;

package body VerbesserungenDatenbank is

   procedure Beschreibung (ID : in GlobaleDatentypen.KartenVerbesserung) is
   begin
      
      case ID is
         when 0 =>
            null;
            
         when others =>
            Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDatei => GlobaleDatentypen.Beschreibungen_Verbesserungen_Kurz,
                                                  TextZeile => Positive (ID));
      end case;
      
   end Beschreibung;

end VerbesserungenDatenbank;
