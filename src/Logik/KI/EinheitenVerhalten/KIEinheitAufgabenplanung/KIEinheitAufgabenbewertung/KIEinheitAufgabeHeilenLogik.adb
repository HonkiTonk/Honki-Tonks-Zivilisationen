pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with EinheitenRecords; use EinheitenRecords;
with EinheitenKonstanten;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with KIKonstanten;

with KIKriegErmittelnLogik;
with KIGefahrErmittelnLogik;

package body KIEinheitAufgabeHeilenLogik is

   function SichHeilen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      case
        KIKriegErmittelnLogik.IstImKrieg (RasseExtern => EinheitRasseNummerExtern.Rasse)
      is
         when True =>
            return HeilenKrieg (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when False =>
            return HeilenFrieden (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
   end SichHeilen;
   
   
   
   -- Zu Friedenszeiten immer den gleichen Wert für verletzte Einheiten zurückgeben? äöü
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
         return KIKonstanten.UnmöglichAufgabenbewertung;
         
      elsif
        Lebenspunkte > (MaximaleLebenspunkte / 3) * 2
      then
         return 20;
         
      elsif
        Lebenspunkte > MaximaleLebenspunkte / 2
      then
         return 25;
         
      elsif
        Lebenspunkte = 1
      then
         return 50;
         
      else
         return 35;
      end if;
      
   end HeilenFrieden;
   
   
   
   -- Abhängig von Gegner in der Nähe machen. äöü
   function HeilenKrieg
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      if
        KIGefahrErmittelnLogik.GefahrErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerRasseNummer
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
         return KIKonstanten.UnmöglichAufgabenbewertung;
      end if;
      
   end HeilenKrieg;

end KIEinheitAufgabeHeilenLogik;
