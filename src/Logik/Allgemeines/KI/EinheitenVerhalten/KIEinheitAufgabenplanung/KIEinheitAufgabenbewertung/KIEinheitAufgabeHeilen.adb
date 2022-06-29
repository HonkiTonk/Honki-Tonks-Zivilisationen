pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with EinheitenRecords; use EinheitenRecords;
with EinheitenKonstanten;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with KIDatentypen; use KIDatentypen;

with KIKriegErmitteln;
with KIGefahrErmitteln;

package body KIEinheitAufgabeHeilen is

   function SichHeilen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      case
        KIKriegErmitteln.IstImKrieg (RasseExtern => EinheitRasseNummerExtern.Rasse)
      is
         when True =>
            return HeilenKrieg (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when False =>
            return HeilenFrieden (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
   end SichHeilen;
   
   
   
   -------------------------------- Zu Friedenszeiten immer den gleichen Wert für verletzte Einheiten zurückgeben?
   function HeilenFrieden
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      Lebenspunkte := LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      MaximaleLebenspunkte := LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      if
        Lebenspunkte = MaximaleLebenspunkte
      then
         return -1;
         
      elsif
        Lebenspunkte > (MaximaleLebenspunkte / 3) * 2
      then
         return 10;
         
      elsif
        Lebenspunkte > MaximaleLebenspunkte / 2
      then
         return 15;
         
      elsif
        Lebenspunkte = 1
      then
         return 20;
         
      else
         return 18;
      end if;
      
   end HeilenFrieden;
   
   
   
   ------------------------------- Abhängig von Gegner in der Nähe machen.
   function HeilenKrieg
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      if
        KIGefahrErmitteln.GefahrErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerRasseNummer
      then
         return HeilenFrieden (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
      else
         Lebenspunkte := LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         MaximaleLebenspunkte := LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                              IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      end if;
          
      if
        Lebenspunkte < MaximaleLebenspunkte / 3
      then
         return 15;
         
      elsif
        Lebenspunkte = 1
      then
         return 50;
         
      else
         return -1;
      end if;
      
   end HeilenKrieg;

end KIEinheitAufgabeHeilen;
