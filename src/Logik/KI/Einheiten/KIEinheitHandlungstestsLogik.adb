with AufgabenDatentypen;
with KartenRecords;
with KartenRecordKonstanten;
with EinheitenDatentypen;

with LeseEinheitenGebaut;

with KIDatentypen;

with KIEinheitUmsetzenModernisierenLogik;

package body KIEinheitHandlungstestsLogik is
   
   function BewachtStadt
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is
      use type AufgabenDatentypen.Einheiten_Aufgaben_Enum;
      use type KIDatentypen.Einheit_Aufgabe_Enum;
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      if
        LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KIDatentypen.Stadt_Bewachen_Enum
        and
          LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KartenRecordKonstanten.LeerKoordinate
        and
          LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = AufgabenDatentypen.Verschanzen_Enum
      then
         Nullwert := KIEinheitUmsetzenModernisierenLogik.EinheitVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         return True;
         
      else
         return False;
      end if;
      
   end BewachtStadt;
   
   

   function HandlungBeendet
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is
      use type AufgabenDatentypen.Einheiten_Aufgaben_Enum;
   begin
            
      if
        BewachtStadt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
      then
         return True;
         
      elsif
        LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= EinheitenKonstanten.LeerBeschäftigung
      then
         return True;
            
      else
         return Unbewegbar (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end if;
      
   end HandlungBeendet;
   
   
   
   function Unbewegbar
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     return Boolean
   is
      use type EinheitenDatentypen.Bewegungspunkte;
      use type EinheitenDatentypen.EinheitenIDMitNullWert;
   begin
      
      if
        LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerBewegungspunkte
        or
          LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerID
      then
         return True;
            
      else
         return False;
      end if;
      
   end Unbewegbar;
   
end KIEinheitHandlungstestsLogik;
