pragma SPARK_Mode (On);

package body SchreibeEinheitenGebaut is

   procedure ID
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      IDExtern : in GlobaleDatentypen.EinheitenID)
   is begin
      
      null;
      
   end ID;
   
   
   
   procedure Lebenspunkte
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      LebenspunkteExtern : in GlobaleDatentypen.MaximaleEinheitenMitNullWert;
      SetzenÄndernExtern : in Boolean)
   is begin
      
      case
        SetzenÄndernExtern
      is
         when True =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte := LebenspunkteExtern;
            
         when False =>
            null;
      end case;
      
   end Lebenspunkte;

end SchreibeEinheitenGebaut;
