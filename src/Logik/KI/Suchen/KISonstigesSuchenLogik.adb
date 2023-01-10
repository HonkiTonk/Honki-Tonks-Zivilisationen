with KartenKonstanten;
with KartenRecordKonstanten;

with LeseWeltkarte;

with KartenkoordinatenberechnungssystemLogik;
with PassierbarkeitspruefungLogik;

package body KISonstigesSuchenLogik is

   function EigenesFeldSuchen
     (AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      case
        LeseWeltkarte.BelegterGrund (SpeziesExtern       => EinheitSpeziesNummerExtern.Spezies,
                                     KoordinatenExtern => AktuelleKoordinatenExtern)
      is
         when True =>
            return AktuelleKoordinatenExtern;
            
         when False =>
            Bereich := 1;
            -- Der geprüfte Bereich wird noch nicht ausgeschlossen und die Suche fängt noch nicht bei 0 an, ändern. äöü
            BereichGeprüft := Bereich - 1;
      end case;
      
      FeldSuchenSchleife:
      loop
         
         Ziel := ZielSuchen (AktuelleKoordinatenExtern => AktuelleKoordinatenExtern,
                             EinheitSpeziesNummerExtern  => EinheitSpeziesNummerExtern,
                             BereichExtern             => Bereich);
         
         if
           Ziel.XAchse /= KartenKonstanten.LeerXAchse
           or
             Bereich = KartenDatentypen.Sichtweite'Last
         then
            exit FeldSuchenSchleife;
            
         else
            Bereich := Bereich + 1;
            BereichGeprüft := Bereich - 1;
         end if;
               
      end loop FeldSuchenSchleife;
              
      return Ziel;
   
   end EigenesFeldSuchen;
   
   
   
   function ZielSuchen
     (AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      BereichExtern : in KartenDatentypen.Sichtweite)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in -BereichExtern .. BereichExtern loop
         XAchseSchleife:
         for XAchseSchleifenwert in -BereichExtern .. BereichExtern loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => AktuelleKoordinatenExtern,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => True);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              True = LeseWeltkarte.BelegterGrund (SpeziesExtern       => EinheitSpeziesNummerExtern.Spezies,
                                                  KoordinatenExtern => KartenWert)
              and
                True = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                                 NeueKoordinatenExtern    => KartenWert)
            then
               return KartenWert;
                     
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return KartenRecordKonstanten.LeerKoordinate;
      
   end ZielSuchen;

end KISonstigesSuchenLogik;
