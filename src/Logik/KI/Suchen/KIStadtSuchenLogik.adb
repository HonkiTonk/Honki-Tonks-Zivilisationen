with KartenverbesserungDatentypen;
with EinheitenKonstanten;
with KartenRecordKonstanten;
with StadtKonstanten;

with LeseStadtGebaut;

with EinheitSuchenLogik;

package body KIStadtSuchenLogik is
   
   function NähesteFeindlicheStadtSuchen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      AnfangKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
   
      GefundeneStadt := StadtSuchen (RasseExtern             => RasseExtern,
                                     AnfangKoordinatenExtern => AnfangKoordinatenExtern);
         
      case
        GefundeneStadt
      is
         when 0 =>
            return KartenRecordKonstanten.LeerKoordinate;
            
         when others =>
            return LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => (RasseExtern, GefundeneStadt));
      end case;
      
   end NähesteFeindlicheStadtSuchen;
   
   
   
   function StadtSuchen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      AnfangKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return StadtDatentypen.MaximaleStädteMitNullWert
   is
      use type KartenverbesserungDatentypen.Karten_Verbesserung_Enum;
      use type KartenDatentypen.Ebene;
   begin
      
      AktuelleStadt := StadtDatentypen.MaximaleStädteMitNullWert'First;
      
      StadtSchleife:
      for StadtSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (RasseExtern => RasseExtern) loop
         
         if
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert)) = KartenverbesserungDatentypen.Leer_Verbesserung_Enum
         then
            null;
            
         elsif
           AktuelleStadt = StadtDatentypen.MaximaleStädteMitNullWert'First
         then
            AktuelleStadt := StadtSchleifenwert;
            Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => (RasseExtern, AktuelleStadt));
            
            Entfernung := Natural (abs (AnfangKoordinatenExtern.EAchse - Stadtkoordinaten.EAchse)) + Natural (abs (AnfangKoordinatenExtern.YAchse - Stadtkoordinaten.YAchse))
              + Natural (abs (AnfangKoordinatenExtern.XAchse - Stadtkoordinaten.XAchse));
            
         else
            Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert));
            
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
     (FeindlicheRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is
      use type KartenverbesserungDatentypen.Karten_Verbesserung_Enum;
   begin
      
      StadtSchleife:
      for StadtNummerSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (RasseExtern => FeindlicheRasseExtern) loop
         
         if
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (FeindlicheRasseExtern, StadtNummerSchleifenwert)) = KartenverbesserungDatentypen.Leer_Verbesserung_Enum
         then
            null;
               
         else
            Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => (FeindlicheRasseExtern, StadtNummerSchleifenwert));
                                                             
            case
              EinheitSuchenLogik.KoordinatenEinheitMitRasseSuchen (RasseExtern       => FeindlicheRasseExtern,
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
