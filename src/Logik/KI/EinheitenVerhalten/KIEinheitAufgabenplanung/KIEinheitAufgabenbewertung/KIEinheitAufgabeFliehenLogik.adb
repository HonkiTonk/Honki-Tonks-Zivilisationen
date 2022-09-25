pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenRecords; use EinheitenRecords;
with EinheitenDatentypen;
with EinheitenKonstanten;

with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;

with KIDatentypen; use KIDatentypen;

with KIGefahrErmittelnLogik;

package body KIEinheitAufgabeFliehenLogik is

   function Fliehen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      if
        KIGefahrErmittelnLogik.GefahrErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerRasseNummer
      then
         return -1;
         
      else
         null;
      end if;
      
      case
        LeseEinheitenDatenbank.EinheitArt (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when EinheitenDatentypen.Einheitenart_Kampf_Enum'Range =>
            return FliehenKämpfer (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when others =>
            return FliehenUnbewaffnet (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
          
   end Fliehen;
   
   
   
   function FliehenKämpfer
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
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
      
      return 1;
      
   end FliehenKämpfer;
   
   
   
   function FliehenUnbewaffnet
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
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
      
      return 10;
      
   end FliehenUnbewaffnet;

end KIEinheitAufgabeFliehenLogik;
