pragma SPARK_Mode (On);

with StadtKonstanten, EinheitStadtDatentypen;
use EinheitStadtDatentypen;

with LeseStadtGebaut;
  
with Eingabe;

package body StadtSuchen is

   function KoordinatenStadtMitRasseSuchen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return EinheitStadtDatentypen.MaximaleStädteMitNullWert
   is begin
      
      StadtSchleife:
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Städtegrenze loop
         
         if
           LeseStadtGebaut.Position (StadtRasseNummerExtern => (RasseExtern, StadtNummerSchleifenwert)) /= KoordinatenExtern
         then
            null;
            
         else
            return StadtNummerSchleifenwert;
         end if;
         
      end loop StadtSchleife;
      
      return StadtKonstanten.LeerNummer;
      
   end KoordinatenStadtMitRasseSuchen;



   function KoordinatenStadtOhneRasseSuchen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return EinheitStadtRecords.RassePlatznummerRecord
   is begin

      RasseSchleife:
      for RasseSchleifenwert in SonstigeDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when SonstigeDatentypen.Leer =>
               null;
               
            when others =>
               StadtNummer := KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseSchleifenwert,
                                                              KoordinatenExtern => KoordinatenExtern);
               
               if
                 StadtNummer = StadtKonstanten.LeerNummer
               then
                  null;
                  
               else
                  return (RasseSchleifenwert, StadtNummer);
               end if;
         end case;
         
      end loop RasseSchleife;
      
      return StadtKonstanten.LeerRasseNummer;
      
   end KoordinatenStadtOhneRasseSuchen;
   
   
   
   function KoordinatenStadtOhneSpezielleRasseSuchen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return EinheitStadtRecords.RassePlatznummerRecord
   is begin

      RasseSchleife:
      for RasseSchleifenwert in SonstigeDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           RasseExtern = RasseSchleifenwert
           or
             GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) = SonstigeDatentypen.Leer
         then
            null;
            
         else
            StadtNummer := KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseSchleifenwert,
                                                           KoordinatenExtern => KoordinatenExtern);
               
            case
              StadtNummer
            is
               when StadtKonstanten.LeerNummer =>
                  null;
                  
               when others =>
                  return (RasseSchleifenwert, StadtNummer);
            end case;
         end if;
         
      end loop RasseSchleife;
      
      return StadtKonstanten.LeerRasseNummer;
      
   end KoordinatenStadtOhneSpezielleRasseSuchen;
   

   
   function StadtNachNamenSuchen
     return EinheitStadtRecords.RassePlatznummerRecord
   is begin
      
      StadtName := Eingabe.StadtName;
      
      RasseSchleife:
      for RasseSchleifenwert in SonstigeDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when SonstigeDatentypen.Leer =>
               null;
               
            when others =>
               StadtSchleife:
               for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseSchleifenwert).Städtegrenze loop
                  
                  if
                    LeseStadtGebaut.Name (StadtRasseNummerExtern => (RasseSchleifenwert, StadtNummerSchleifenwert)) = StadtName
                  then
                     return (RasseSchleifenwert, StadtNummerSchleifenwert);
               
                  else
                     null;
                  end if;
            
               end loop StadtSchleife;
         end case;
         
      end loop RasseSchleife;
      
      return StadtKonstanten.LeerRasseNummer;
      
   end StadtNachNamenSuchen;

end StadtSuchen;
