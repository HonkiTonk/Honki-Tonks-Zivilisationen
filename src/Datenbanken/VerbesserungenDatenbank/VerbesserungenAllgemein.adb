pragma SPARK_Mode (On);

with GlobaleTexte;

with Anzeige;

package body VerbesserungenAllgemein is

   procedure Beschreibung
     (KartenVerbesserungExtern : in GlobaleDatentypen.Karten_Verbesserung_Enum)
   is begin
      
      case
        KartenVerbesserungExtern
      is
         when GlobaleDatentypen.Leer =>
            null;
            
         when others =>
            Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Beschreibungen_Verbesserungen_Kurz,
                                                  TextZeileExtern => GlobaleDatentypen.Karten_Verbesserung_Enum'Pos (KartenVerbesserungExtern));
      end case;
      
   end Beschreibung;

end VerbesserungenAllgemein;
