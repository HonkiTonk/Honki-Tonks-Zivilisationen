pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with KartenRecords; use KartenRecords;
with StadtKonstanten;

with LeseStadtGebaut;
  
with Eingabe;

package body StadtSuchen is

   function KoordinatenStadtMitRasseSuchen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return EinheitStadtDatentypen.MaximaleStädteMitNullWert
   is begin
      
      StadtSchleife:
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Städtegrenze loop
         
         if
           LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => (RasseExtern, StadtNummerSchleifenwert)) /= KoordinatenExtern
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
      for RasseSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when SystemKonstanten.LeerSpielerKonstante =>
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
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return EinheitStadtRecords.RassePlatznummerRecord
   is begin

      RasseSchleife:
      for RasseSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           RasseExtern = RasseSchleifenwert
           or
             GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) = SystemKonstanten.LeerSpielerKonstante
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
      
      case
        StadtName.ErfolgreichAbbruch
      is
         when False =>
            return StadtKonstanten.LeerRasseNummer;
            
         when True =>
            null;
      end case;
      
      RasseSchleife:
      for RasseSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when SystemKonstanten.LeerSpielerKonstante =>
               null;
               
            when others =>
               StadtSchleife:
               for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseSchleifenwert).Städtegrenze loop
                  
                  if
                    LeseStadtGebaut.Name (StadtRasseNummerExtern => (RasseSchleifenwert, StadtNummerSchleifenwert)) = StadtName.EingegebenerText
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
