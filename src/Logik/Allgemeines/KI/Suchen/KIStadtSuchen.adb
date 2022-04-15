pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with KartenVerbesserungDatentypen; use KartenVerbesserungDatentypen;
with EinheitenKonstanten;
with KartenRecordKonstanten;

with LeseStadtGebaut;

with EinheitSuchen;

package body KIStadtSuchen is
   
   function NähesteFeindlicheStadtSuchen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      AnfangKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
   
      GefundeneStadt := StadtSuchen (RasseExtern             => RasseExtern,
                                     AnfangKoordinatenExtern => AnfangKoordinatenExtern);
         
      case
        GefundeneStadt
      is
         when 0 =>
            return KartenRecordKonstanten.LeerKartenKoordinaten;
            
         when others =>
            return LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => (RasseExtern, GefundeneStadt));
      end case;
      
   end NähesteFeindlicheStadtSuchen;
   
   
   
   function StadtSuchen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      AnfangKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return EinheitStadtDatentypen.MaximaleStädteMitNullWert
   is begin
      
      AktuelleStadt := EinheitStadtDatentypen.MaximaleStädteMitNullWert'First;
      
      StadtSchleife:
      for StadtSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Städtegrenze loop
         
         if
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert)) = KartenVerbesserungDatentypen.Leer_Verbesserung_Enum
         then
            null;
            
         elsif
           AktuelleStadt = EinheitStadtDatentypen.MaximaleStädteMitNullWert'First
         then
            AktuelleStadt := StadtSchleifenwert; -- ----------------
            Entfernung := Positive (abs (AnfangKoordinatenExtern.EAchse - GlobaleVariablen.StadtGebaut (RasseExtern, AktuelleStadt).KoordinatenAktuell.EAchse)
                                    + abs (AnfangKoordinatenExtern.YAchse - GlobaleVariablen.StadtGebaut (RasseExtern, AktuelleStadt).KoordinatenAktuell.YAchse)
                                    + abs (AnfangKoordinatenExtern.XAchse - GlobaleVariablen.StadtGebaut (RasseExtern, AktuelleStadt).KoordinatenAktuell.XAchse));
            
         else
            EntfernungNeu := Positive (abs (AnfangKoordinatenExtern.EAchse - GlobaleVariablen.StadtGebaut (RasseExtern, StadtSchleifenwert).KoordinatenAktuell.EAchse)
                                       + abs (AnfangKoordinatenExtern.YAchse - GlobaleVariablen.StadtGebaut (RasseExtern, StadtSchleifenwert).KoordinatenAktuell.YAchse)
                                       + abs (AnfangKoordinatenExtern.XAchse - GlobaleVariablen.StadtGebaut (RasseExtern, StadtSchleifenwert).KoordinatenAktuell.XAchse));
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
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      StadtSchleife:
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (FeindlicheRasseExtern).Städtegrenze loop
         
         if
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (FeindlicheRasseExtern, StadtNummerSchleifenwert)) = KartenVerbesserungDatentypen.Leer_Verbesserung_Enum
         then
            null;
               
         elsif
           EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => FeindlicheRasseExtern,
                                                           KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => (FeindlicheRasseExtern, StadtNummerSchleifenwert)))
           = EinheitenKonstanten.LeerNummer
         then
            return LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => (FeindlicheRasseExtern, StadtNummerSchleifenwert));
                  
         else
            null;
         end if;
         
      end loop StadtSchleife;
      
      return KartenRecordKonstanten.LeerKartenKoordinaten;
      
   end UnbewachteStadtSuchen;

end KIStadtSuchen;
