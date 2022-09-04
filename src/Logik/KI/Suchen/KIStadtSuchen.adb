pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenverbesserungDatentypen; use KartenverbesserungDatentypen;
with StadtDatentypen; use StadtDatentypen;
with EinheitenKonstanten;
with KartenRecordKonstanten;

with LeseStadtGebaut;

with EinheitSuchen;

package body KIStadtSuchen is
   
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
   is begin
      
      AktuelleStadt := StadtDatentypen.MaximaleStädteMitNullWert'First;
      
      StadtSchleife:
      for StadtSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Städtegrenze loop
         
         if
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert)) = KartenverbesserungDatentypen.Leer_Verbesserung_Enum
         then
            null;
            
         elsif
           AktuelleStadt = StadtDatentypen.MaximaleStädteMitNullWert'First
         then
            AktuelleStadt := StadtSchleifenwert;
            
            Entfernung := Positive (abs (AnfangKoordinatenExtern.EAchse - SpielVariablen.StadtGebaut (RasseExtern, AktuelleStadt).KoordinatenAktuell.EAchse))
              + Positive (abs (AnfangKoordinatenExtern.YAchse - SpielVariablen.StadtGebaut (RasseExtern, AktuelleStadt).KoordinatenAktuell.YAchse))
              + Positive (abs (AnfangKoordinatenExtern.XAchse - SpielVariablen.StadtGebaut (RasseExtern, AktuelleStadt).KoordinatenAktuell.XAchse));
            
         else
            EntfernungNeu := Positive (abs (AnfangKoordinatenExtern.EAchse - SpielVariablen.StadtGebaut (RasseExtern, StadtSchleifenwert).KoordinatenAktuell.EAchse))
              + Positive (abs (AnfangKoordinatenExtern.YAchse - SpielVariablen.StadtGebaut (RasseExtern, StadtSchleifenwert).KoordinatenAktuell.YAchse))
              + Positive (abs (AnfangKoordinatenExtern.XAchse - SpielVariablen.StadtGebaut (RasseExtern, StadtSchleifenwert).KoordinatenAktuell.XAchse));
            
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
   is begin
      
      StadtSchleife:
      for StadtNummerSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (FeindlicheRasseExtern).Städtegrenze loop
         
         if
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (FeindlicheRasseExtern, StadtNummerSchleifenwert)) = KartenverbesserungDatentypen.Leer_Verbesserung_Enum
         then
            null;
               
         else
            Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => (FeindlicheRasseExtern, StadtNummerSchleifenwert));
                                                             
            case
              EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => FeindlicheRasseExtern,
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

end KIStadtSuchen;
