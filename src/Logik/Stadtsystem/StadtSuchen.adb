pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with StadtKonstanten;
with KartenverbesserungDatentypen;

with LeseStadtGebaut;
with LeseKarten;
  
-- with TexteingabeLogik;

package body StadtSuchen is

   function KoordinatenStadtMitRasseSuchen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return StadtDatentypen.MaximaleStädteMitNullWert
   is begin
      
      case
        LeseKarten.Verbesserung (KoordinatenExtern => KoordinatenExtern)
      is
         when KartenverbesserungDatentypen.Karten_Verbesserung_Städte_Enum'Range =>
            Stadt := LeseKarten.StadtbelegungGrund (KoordinatenExtern => KoordinatenExtern);
            
         when others =>
            return StadtKonstanten.LeerNummer;
      end case;
            
      if
        Stadt.Rasse = RasseExtern
      then
         return Stadt.Nummer;
            
      else
         return StadtKonstanten.LeerNummer;
      end if;
      
   end KoordinatenStadtMitRasseSuchen;
   


   function KoordinatenStadtOhneRasseSuchen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return StadtRecords.RasseStadtnummerRecord
   is begin
      
      case
        LeseKarten.Verbesserung (KoordinatenExtern => KoordinatenExtern)
      is
         when KartenverbesserungDatentypen.Karten_Verbesserung_Städte_Enum'Range =>
            return LeseKarten.StadtbelegungGrund (KoordinatenExtern => KoordinatenExtern);
            
         when others =>
            return StadtKonstanten.LeerRasseNummer;
      end case;
      
   end KoordinatenStadtOhneRasseSuchen;
   
   
   
   function KoordinatenStadtOhneSpezielleRasseSuchen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return StadtRecords.RasseStadtnummerRecord
   is begin
      
      case
        LeseKarten.Verbesserung (KoordinatenExtern => KoordinatenExtern)
      is
         when KartenverbesserungDatentypen.Karten_Verbesserung_Städte_Enum'Range =>
            Stadt := LeseKarten.StadtbelegungGrund (KoordinatenExtern => KoordinatenExtern);
            
         when others =>
            return StadtKonstanten.LeerRasseNummer;
      end case;
      
      if
        Stadt.Rasse = RasseExtern
      then
         return StadtKonstanten.LeerRasseNummer;
         
      else
         return Stadt;
      end if;
      
   end KoordinatenStadtOhneSpezielleRasseSuchen;
   

   
   -- Diese Funktion muss noch überarbeitet werden. äöü
   function StadtNachNamenSuchen
     return StadtRecords.RasseStadtnummerRecord
   is begin
      
      -- StadtName := TexteingabeLogik.StadtName;
      
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
           SpielVariablen.Rassenbelegung (RasseSchleifenwert).Belegung
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
