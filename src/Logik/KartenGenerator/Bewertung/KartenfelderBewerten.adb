pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenRecordKonstanten;

with Karten;
with FelderwerteFestlegen;

package body KartenfelderBewerten is

   procedure KartenfelderBewerten
     -- Leerwert heineingeben um für alle Rassen die Werte zu berechnen, anderer Wert um für eine bestimmte Rasse die Werte zu berechnen.
     (RasseExtern : in SystemDatentypen.Rassen_Enum)
   is

      task UnterwasserUnterirdischBewerten;
      task PlanetenInneresBewerten;
      
      task body UnterwasserUnterirdischBewerten
      is begin
         
         YAchseUnterwasserSchleife:
         for YAchseUnterwasserSchleifenwert in Karten.WeltkarteArray'First (2) + KartenRecordKonstanten.Eisrand (Karten.Kartengröße)
           .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - KartenRecordKonstanten.Eisrand (Karten.Kartengröße) loop
            XAchseUnterwasserSchleife:
            for XAchseUnterwasserSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
               FelderwerteFestlegen.KartenfelderBewertenKleineSchleife (RasseExtern       => RasseExtern,
                                                                        KoordinatenExtern => (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert));
               
            end loop XAchseUnterwasserSchleife;
         end loop YAchseUnterwasserSchleife;
         
      end UnterwasserUnterirdischBewerten;
      
      
      
      task body PlanetenInneresBewerten
      is begin
         
         YAchseInneresSchleife:
         for YAchseInneresSchleifenwert in Karten.WeltkarteArray'First (2) + KartenRecordKonstanten.Eisrand (Karten.Kartengröße)
           .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - KartenRecordKonstanten.Eisrand (Karten.Kartengröße) loop
            XAchseInneresSchleife:
            for XAchseInneresSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
               FelderwerteFestlegen.KartenfelderBewertenKleineSchleife (RasseExtern       => RasseExtern,
                                                                        KoordinatenExtern => (-2, YAchseInneresSchleifenwert, XAchseInneresSchleifenwert));
               
            end loop XAchseInneresSchleife;
         end loop YAchseInneresSchleife;
         
      end PlanetenInneresBewerten;
      
   begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) + KartenRecordKonstanten.Eisrand (Karten.Kartengröße)
        .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - KartenRecordKonstanten.Eisrand (Karten.Kartengröße) loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            FelderwerteFestlegen.KartenfelderBewertenKleineSchleife (RasseExtern       => RasseExtern,
                                                                     KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert));
               
         end loop XAchseSchleife;
      end loop YAchseSchleife;
   
   end KartenfelderBewerten;

end KartenfelderBewerten;
