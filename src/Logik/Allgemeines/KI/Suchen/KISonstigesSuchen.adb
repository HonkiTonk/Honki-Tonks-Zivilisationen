pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenKonstanten;
with KartenRecordKonstanten;

with LeseKarten;

with Kartenkoordinatenberechnungssystem;
with BewegungPassierbarkeitPruefen;

package body KISonstigesSuchen is

   function EigenesFeldSuchen
     (AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      Bereich := 1;
      BereichGeprüft := Bereich - 1;
      
      FeldSuchenSchleife:
      loop
         
         Ziel := ZielSuchen (AktuelleKoordinatenExtern => AktuelleKoordinatenExtern,
                             EinheitRasseNummerExtern  => EinheitRasseNummerExtern);
         
         exit FeldSuchenSchleife when Ziel.XAchse /= KartenKonstanten.LeerXAchse;
         exit FeldSuchenSchleife when Bereich = KartenDatentypen.Sichtweite'Last;
         
         Bereich := Bereich + 1;
         BereichGeprüft := Bereich - 1;
      
      end loop FeldSuchenSchleife;
              
      return Ziel;
   
   end EigenesFeldSuchen;
   
   
   
   function ZielSuchen
     (AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in -Bereich .. Bereich loop
         XAchseSchleife:
         for XAchseSchleifenwert in -Bereich .. Bereich loop
            
            KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => AktuelleKoordinatenExtern,
                                                                                                 ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                 LogikGrafikExtern => True);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              LeseKarten.BelegterGrund (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                        KoordinatenExtern => KartenWert)
              = True
              and
                BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                           NeueKoordinatenExtern    => KartenWert)
              = True
            then
               return KartenWert;
                     
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return KartenRecordKonstanten.LeerKoordinate;
      
   end ZielSuchen;

end KISonstigesSuchen;
