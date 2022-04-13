pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenGrundDatentypen; use KartenGrundDatentypen;
with KartenKonstanten;

with LeseKarten;

with KarteKoordinatenPruefen;

package body KartenGeneratorBerechnungenAllgemein is

   function GleicherGrundAnzahlBestimmen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      GrundExtern : in KartenGrundDatentypen.Karten_Grund_Alle_Felder_Enum;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden)
      return AnzahlGleicherFelder
   is begin
      
      AnzahlGleicherGrundBestimmen := 0;
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XAchsenSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
               
            KartenWert := KarteKoordinatenPruefen.KarteKoordinatenPrüfen (KoordinatenExtern => KoordinatenExtern,
                                                                           ÄnderungExtern    => (EbeneExtern, YAchseSchleifenwert, XAchsenSchleifenwert),
                                                                           LogikGrafikExtern => True);
               
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               -- Prüfung für die Änderung (0, 0) nicht benötigt, da das Feld immer mit Flachland belegt sein sollte.
               null;
                  
            elsif
              LeseKarten.Grund (KoordinatenExtern => KartenWert) = GrundExtern
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
