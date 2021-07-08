pragma SPARK_Mode (On);

with GlobaleTexte;

with Anzeige;

package body KartenAllgemein is

   procedure Beschreibung
     (IDExtern : in GlobaleDatentypen.KartenGrund)
   is begin

      case
        IDExtern
      is
         when 0 =>
            null;
            
         when others =>
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                           TextDateiExtern        => GlobaleTexte.Beschreibungen_Kartenfelder_Kurz,
                                           ÜberschriftZeileExtern => 0,
                                           ErsteZeileExtern       => Positive (IDExtern),
                                           LetzteZeileExtern      => Positive (IDExtern),
                                           AbstandAnfangExtern    => GlobaleTexte.Keiner,
                                           AbstandMitteExtern     => GlobaleTexte.Keiner,
                                           AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      end case;
      
   end Beschreibung;

end KartenAllgemein;
