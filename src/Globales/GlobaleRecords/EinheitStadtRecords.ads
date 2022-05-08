pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitStadtDatentypen;
with RassenDatentypen;

-------------------- Einheit und Stadt in zwei seperate Teile aufteilen. Warum habe ich das noch nicht gemacht? Wahrscheinlich wegen den abgeleiteten Datentypen und verzwirbelten Records.
package EinheitStadtRecords is

   type RasseEinheitnummerRecord is record
      
      Rasse : RassenDatentypen.Rassen_Enum;
      Nummer : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
      
   end record;
   
   
   
   type KampfwerteRecord is record
      
      Angriff : EinheitStadtDatentypen.Kampfwerte;
      Verteidigung : EinheitStadtDatentypen.Kampfwerte;
      
   end record;

end EinheitStadtRecords;
