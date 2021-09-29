pragma SPARK_Mode (On);

with KartenKonstanten;

with LeseKarten;

with KartePositionPruefen;

package body KartenGeneratorBerechnungenAllgemein is

   function GleicherGrundAnzahlBestimmen
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      GrundExtern : in GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum;
      EbeneExtern : in GlobaleDatentypen.EbeneVorhanden)
      return AnzahlGleicherFelder
   is begin
      
      AnzahlGleicherGrundBestimmen := 0;
      
      YAchseSchleife:
      for YAchseSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseSchleife:
         for XAchsenSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
               
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => PositionExtern,
                                                                        ÄnderungExtern    => (EbeneExtern, YAchseSchleifenwert, XAchsenSchleifenwert));
               
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               -- Prüfung für die Änderung (0, 0) nicht benötigt, da das Feld immer mit Flachland belegt sein sollte.
               null;
                  
            elsif
              LeseKarten.Grund (PositionExtern => KartenWert) = GrundExtern
            then
               AnzahlGleicherGrundBestimmen := AnzahlGleicherGrundBestimmen + 1;
                  
            else
               null;
            end if;
               
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return AnzahlGleicherGrundBestimmen;
      
   end GleicherGrundAnzahlBestimmen;

end KartenGeneratorBerechnungenAllgemein;
