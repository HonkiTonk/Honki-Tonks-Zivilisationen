pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;

with FelderwerteFestlegen;
with Karten;

package body KartenfelderBewerten is

   -- Leerwert heineingeben um für alle Rassen die Werte zu berechnen, anderer Wert um für eine bestimmte Rasse die Werte zu berechnen.
   procedure KartenfelderBewerten
     (RasseExtern : in RassenDatentypen.Rassen_Enum)
   is

      task UnterwasserUnterirdischBewerten;
      task PlanetenInneresBewerten;
      
      task body UnterwasserUnterirdischBewerten
      is begin
         
         YAchseUnterwasserSchleife:
         for YAchseUnterwasserSchleifenwert in KartenDatentypen.KartenfeldPositiv'First .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse loop
            XAchseUnterwasserSchleife:
            for XAchseUnterwasserSchleifenwert in KartenDatentypen.KartenfeldPositiv'First .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse loop
               
               FelderwerteFestlegen.KartenfelderBewertenKleineSchleife (RasseExtern       => RasseExtern,
                                                                        KoordinatenExtern => (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert));
               
            end loop XAchseUnterwasserSchleife;
         end loop YAchseUnterwasserSchleife;
         
      end UnterwasserUnterirdischBewerten;
      
      
      
      task body PlanetenInneresBewerten
      is begin
         
         YAchseInneresSchleife:
         for YAchseInneresSchleifenwert in KartenDatentypen.KartenfeldPositiv'First .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse loop
            XAchseInneresSchleife:
            for XAchseInneresSchleifenwert in KartenDatentypen.KartenfeldPositiv'First .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse loop
               
               FelderwerteFestlegen.KartenfelderBewertenKleineSchleife (RasseExtern       => RasseExtern,
                                                                        KoordinatenExtern => (-2, YAchseInneresSchleifenwert, XAchseInneresSchleifenwert));
               
            end loop XAchseInneresSchleife;
         end loop YAchseInneresSchleife;
         
      end PlanetenInneresBewerten;
      
   begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.KartenfeldPositiv'First .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.KartenfeldPositiv'First .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse loop
            
            FelderwerteFestlegen.KartenfelderBewertenKleineSchleife (RasseExtern       => RasseExtern,
                                                                     KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert));
               
         end loop XAchseSchleife;
      end loop YAchseSchleife;
   
   end KartenfelderBewerten;

end KartenfelderBewerten;
