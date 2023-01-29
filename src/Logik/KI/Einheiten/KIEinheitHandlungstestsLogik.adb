with AufgabenDatentypen;
with KartenRecords;
with KartenRecordKonstanten;
with EinheitenDatentypen;

with LeseEinheitenGebaut;

with KIDatentypen;

with KIEinheitUmsetzenModernisierenLogik;

package body KIEinheitHandlungstestsLogik is
   
   -- Das hier später anpassen, dass die Verschanzung für eine Runde beendet wird. äöü
   function BewachtStadt
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type AufgabenDatentypen.Einheiten_Aufgaben_Enum;
      use type KIDatentypen.Einheit_Aufgabe_Enum;
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      if
        LeseEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = KIDatentypen.Stadt_Bewachen_Enum
        and
          LeseEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = KartenRecordKonstanten.LeerKoordinate
        and
          LeseEinheitenGebaut.Beschäftigung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = AufgabenDatentypen.Verschanzen_Enum
      then
         Nullwert := KIEinheitUmsetzenModernisierenLogik.EinheitVerbessern (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
         return True;
         
      else
         return False;
      end if;
      
   end BewachtStadt;
   
   

   function HandlungBeendet
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type AufgabenDatentypen.Einheiten_Aufgaben_Enum;
   begin
            
      if
        BewachtStadt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = True
      then
         return True;
         
      elsif
        LeseEinheitenGebaut.Beschäftigung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) /= EinheitenKonstanten.LeerBeschäftigung
      then
         return True;
            
      else
         return Unbewegbar (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      end if;
      
   end HandlungBeendet;
   
   
   
   function Unbewegbar
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type EinheitenDatentypen.Bewegungspunkte;
      use type EinheitenDatentypen.EinheitenIDMitNullWert;
   begin
      
      if
        LeseEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = EinheitenKonstanten.LeerBewegungspunkte
        or
          LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = EinheitenKonstanten.LeerID
      then
         return True;
            
      else
         return False;
      end if;
      
   end Unbewegbar;
   
end KIEinheitHandlungstestsLogik;
