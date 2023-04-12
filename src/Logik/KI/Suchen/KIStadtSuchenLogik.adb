with KartenverbesserungDatentypen;
with EinheitenKonstanten;
with KartenRecordKonstanten;
with StadtKonstanten;

with LeseStadtGebaut;

with EinheitSuchenLogik;

-- Wird hier irgendwo mal geprüft ob die Stadt sichtbar ist? äöü
package body KIStadtSuchenLogik is
   
   function NähesteFeindlicheStadtSuchen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      AnfangKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
   
      GefundeneStadt := StadtSuchen (SpeziesExtern           => SpeziesExtern,
                                     AnfangKoordinatenExtern => AnfangKoordinatenExtern);
         
      case
        GefundeneStadt
      is
         when 0 =>
            return KartenRecordKonstanten.LeerKoordinate;
            
         when others =>
            return LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => (SpeziesExtern, GefundeneStadt));
      end case;
      
   end NähesteFeindlicheStadtSuchen;
   
   
   
   function StadtSuchen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      AnfangKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return StadtDatentypen.MaximaleStädteMitNullWert
   is
      use type KartenverbesserungDatentypen.Verbesserung_Enum;
      use type KartenDatentypen.Ebene;
   begin
      
      AktuelleStadt := StadtDatentypen.MaximaleStädteMitNullWert'First;
      
      StadtSchleife:
      for StadtSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern) loop
         
         if
           LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert)) = KartenverbesserungDatentypen.Leer_Verbesserung_Enum
         then
            null;
            
         elsif
           AktuelleStadt = StadtDatentypen.MaximaleStädteMitNullWert'First
         then
            AktuelleStadt := StadtSchleifenwert;
            Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => (SpeziesExtern, AktuelleStadt));
            
            Entfernung := Natural (abs (AnfangKoordinatenExtern.EAchse - Stadtkoordinaten.EAchse)) + Natural (abs (AnfangKoordinatenExtern.YAchse - Stadtkoordinaten.YAchse))
              + Natural (abs (AnfangKoordinatenExtern.XAchse - Stadtkoordinaten.XAchse));
            
         else
            Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert));
            
            EntfernungNeu := Natural (abs (AnfangKoordinatenExtern.EAchse - Stadtkoordinaten.EAchse)) + Natural (abs (AnfangKoordinatenExtern.YAchse - Stadtkoordinaten.YAchse))
              + Natural (abs (AnfangKoordinatenExtern.XAchse - Stadtkoordinaten.XAchse));
            
            if
              Entfernung > EntfernungNeu
            then
               AktuelleStadt := StadtSchleifenwert;
               
            else
               null;
            end if;
         end if;
            
      end loop StadtSchleife;
      
      return AktuelleStadt;
      
   end StadtSuchen;
   
   
   
   function UnbewachteStadtSuchen
     (FeindlicheSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is
      use type KartenverbesserungDatentypen.Verbesserung_Enum;
   begin
      
      StadtSchleife:
      for StadtNummerSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => FeindlicheSpeziesExtern) loop
         
         if
           LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (FeindlicheSpeziesExtern, StadtNummerSchleifenwert)) = KartenverbesserungDatentypen.Leer_Verbesserung_Enum
         then
            null;
               
         else
            Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => (FeindlicheSpeziesExtern, StadtNummerSchleifenwert));
                                                             
            case
              EinheitSuchenLogik.KoordinatenEinheitMitSpeziesSuchen (SpeziesExtern     => FeindlicheSpeziesExtern,
                                                                     KoordinatenExtern => Stadtkoordinaten,
                                                                     LogikGrafikExtern => True)
            is
               when EinheitenKonstanten.LeerNummer =>
                  return Stadtkoordinaten;
                  
               when others =>
                  null;
            end case;
         end if;
         
      end loop StadtSchleife;
      
      return KartenRecordKonstanten.LeerKoordinate;
      
   end UnbewachteStadtSuchen;

end KIStadtSuchenLogik;
