pragma SPARK_Mode (On);

with Anzeige;

package body KartenDatenbank is
   
   procedure StandardKartenDatenbankWiederherstellen
   is begin
      
      KartenListe := KartenListeStandard;
      
   end StandardKartenDatenbankWiederherstellen;
   
   

   procedure Beschreibung
     (IDExtern : in GlobaleDatentypen.KartenGrund)
   is begin

      case
        IDExtern
      is
         when 0 =>
            null;
            
         when others =>
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                           TextDateiExtern        => GlobaleDatentypen.Beschreibungen_Kartenfelder_Kurz,
                                           ÜberschriftZeileExtern => 0,
                                           ErsteZeileExtern       => Positive (IDExtern),
                                           LetzteZeileExtern      => Positive (IDExtern),
                                           AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                           AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                           AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
      end case;
      
   end Beschreibung;

end KartenDatenbank;
