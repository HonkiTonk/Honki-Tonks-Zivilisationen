pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenRecordKonstanten;

with SchreibeEinheitenGebaut;

with KIDatentypen;

package body KIEinheitFestlegenFliehen is

   function Fliehen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      ZielKoordinate := Ziel (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      --------------------------------- Hier muss noch ein Ziel hinzugefügt werden.
      SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              AufgabeExtern            => KIDatentypen.Flucht_Enum);
      
      return True;
      
   end Fliehen;
   
   
   
   function Ziel
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      -- Platzhalter
      case
        EinheitRasseNummerExtern.Rasse
      is
         when RassenDatentypen.Ekropa_Enum =>
            null;
            
         when others =>
            null;
      end case;
      
      return KartenRecordKonstanten.LeerKoordinate;
      
   end Ziel;

end KIEinheitFestlegenFliehen;
