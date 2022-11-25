with AufgabenDatentypen;
with KartenRecords;
with KartenRecordKonstanten;

with LeseEinheitenGebaut;

with EinheitenbewegungLogik;

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
   is begin
      
      -- Muss hier not sein wegen den Rückgabewerten in der Funktion selbst, die nicht geändert werden können wegen der Einbindung im Bewegungssystem.
      return not EinheitenbewegungLogik.NochBewegungspunkte (EinheitRasseNummerExtern  => EinheitRasseNummerExtern,
                                                             BewegungDurchführenExtern => False,
                                                             KoordinatenExtern         => KartenRecordKonstanten.LeerKoordinate);
      
   end Unbewegbar;
   
end KIEinheitHandlungstestsLogik;
