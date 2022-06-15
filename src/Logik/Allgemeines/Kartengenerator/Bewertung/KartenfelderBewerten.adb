pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with LadezeitenDatentypen;

with FelderwerteFestlegen;
with Karten;
with Ladezeiten;

package body KartenfelderBewerten is

   -- Leerwert heineingeben um für alle Rassen die Werte zu berechnen, anderer Wert um für eine bestimmte Rasse die Werte zu berechnen.
   procedure KartenfelderBewerten
     (RasseExtern : in RassenDatentypen.Rassen_Enum)
   is

      task UnterwasserUnterirdischBewerten;
      task PlanetenInneresBewerten;
      
      task body UnterwasserUnterirdischBewerten
      is begin
         
         Multiplikator (-1) := 1;
         
         YAchseUnterwasserSchleife:
         for YAchseUnterwasserSchleifenwert in KartenDatentypen.KartenfeldPositiv'First .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse loop
            XAchseUnterwasserSchleife:
            for XAchseUnterwasserSchleifenwert in KartenDatentypen.KartenfeldPositiv'First .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse loop
               
               FelderwerteFestlegen.KartenfelderBewertenKleineSchleife (RasseExtern       => RasseExtern,
                                                                        KoordinatenExtern => (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert));
               
            end loop XAchseUnterwasserSchleife;
            
            if
              ZahlenDatentypen.EigenesPositive (YAchseUnterwasserSchleifenwert) >= Multiplikator (-1) * ZahlenDatentypen.EigenesPositive (Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse) / 33
            then
               Ladezeiten.FortschrittSpielweltSchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Bewerte_Kartenfelder_Enum);
               Multiplikator (-1) := Multiplikator (-1) + 1;
               
            else
               null;
            end if;
            
         end loop YAchseUnterwasserSchleife;
         
      end UnterwasserUnterirdischBewerten;
      
      
      
      task body PlanetenInneresBewerten
      is begin
         
         Multiplikator (-2) := 1;
         
         YAchseInneresSchleife:
         for YAchseInneresSchleifenwert in KartenDatentypen.KartenfeldPositiv'First .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse loop
            XAchseInneresSchleife:
            for XAchseInneresSchleifenwert in KartenDatentypen.KartenfeldPositiv'First .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse loop
               
               FelderwerteFestlegen.KartenfelderBewertenKleineSchleife (RasseExtern       => RasseExtern,
                                                                        KoordinatenExtern => (-2, YAchseInneresSchleifenwert, XAchseInneresSchleifenwert));
               
            end loop XAchseInneresSchleife;
            
            if
              ZahlenDatentypen.EigenesPositive (YAchseInneresSchleifenwert) >= Multiplikator (-2) * ZahlenDatentypen.EigenesPositive (Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse) / 33
            then
               Ladezeiten.FortschrittSpielweltSchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Bewerte_Kartenfelder_Enum);
               Multiplikator (-2) := Multiplikator (-2) + 1;
               
            else
               null;
            end if;
            
         end loop YAchseInneresSchleife;
         
      end PlanetenInneresBewerten;
      
   begin
         
      Multiplikator (0) := 1;
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.KartenfeldPositiv'First .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.KartenfeldPositiv'First .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse loop
            
            FelderwerteFestlegen.KartenfelderBewertenKleineSchleife (RasseExtern       => RasseExtern,
                                                                     KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert));
               
         end loop XAchseSchleife;
            
         if
           ZahlenDatentypen.EigenesPositive (YAchseSchleifenwert) >= Multiplikator (0) * ZahlenDatentypen.EigenesPositive (Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse) / 33
         then
            Ladezeiten.FortschrittSpielweltSchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Bewerte_Kartenfelder_Enum);
            Multiplikator (0) := Multiplikator (0) + 1;
               
         else
            null;
         end if;
         
      end loop YAchseSchleife;
      
      Ladezeiten.FortschrittSpielweltSchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Bewerte_Kartenfelder_Enum);
   
   end KartenfelderBewerten;

end KartenfelderBewerten;
