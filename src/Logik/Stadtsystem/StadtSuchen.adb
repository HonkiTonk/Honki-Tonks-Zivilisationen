pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with KartenRecords; use KartenRecords;
with StadtDatentypen; use StadtDatentypen;
with StadtKonstanten;
with SpielVariablen;

with LeseStadtGebaut;
  
with Eingabe;

package body StadtSuchen is

   function KoordinatenStadtMitRasseSuchen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return StadtDatentypen.MaximaleStädteMitNullWert
   is begin
      
      StadtSchleife:
      for StadtNummerSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Städtegrenze loop
         
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
      return StadtRecords.RasseStadtnummerRecord
   is begin

      RasseSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           SonstigeVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
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
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return StadtRecords.RasseStadtnummerRecord
   is begin

      RasseSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           RasseExtern = RasseSchleifenwert
           or
             SonstigeVariablen.RassenImSpiel (RasseSchleifenwert) = RassenDatentypen.Leer_Spieler_Enum
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
     return StadtRecords.RasseStadtnummerRecord
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
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           SonstigeVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               StadtSchleife:
               for StadtNummerSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (RasseSchleifenwert).Städtegrenze loop
                  
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
