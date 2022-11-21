with EinheitenDatentypen;
with EinheitenKonstanten;
with KartenRecordKonstanten;

with LeseEinheitenGebaut;

package body KIAufgabenVerteiltLogik is

   function AufgabenVerteilt
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AufgabeExtern : in KIDatentypen.Einheit_Aufgabe_Enum)
      return Natural
   is
      use type KIDatentypen.Einheit_Aufgabe_Enum;
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      use type EinheitenDatentypen.EinheitenIDMitNullWert;
   begin
      
      GleicheAufgabe := 0;
     
      EinheitSchleife:
      for EinheitNummerSchleifenwert in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse) loop
            
         if
           EinheitNummerSchleifenwert = EinheitRasseNummerExtern.Nummer
           or
             LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerID
         then
            null;
               
         elsif
           LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = AufgabeExtern
         then
            GleicheAufgabe := GleicheAufgabe + 1;
               
         else
            null;
         end if;
            
      end loop EinheitSchleife;
      
      return GleicheAufgabe;
      
   end AufgabenVerteilt;
   
   
   
   -- Gibt es bereits eine Einheit die diese Aufgabe auf diesem Ziel ausführen will?
   function EinheitAufgabeZiel
     (AufgabeExtern : in KIDatentypen.Einheit_Aufgabe_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ZielKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type KIDatentypen.Einheit_Aufgabe_Enum;
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      EinheitSchleife:
      for EinheitNummerSchleifenwert in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => RasseExtern) loop
         
         Zielkoordinaten := LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerSchleifenwert));
         
         if
           LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerSchleifenwert)) /= AufgabeExtern
         then
            null;
            
         elsif
           Zielkoordinaten = ZielKoordinatenExtern
           or
             (LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerSchleifenwert)) = ZielKoordinatenExtern
              and
                Zielkoordinaten = KartenRecordKonstanten.LeerKoordinate)
         then
            return True;
            
         else
            null;
         end if;
         
      end loop EinheitSchleife;
      
      return False;
      
   end EinheitAufgabeZiel;
   
   
   
   -- Gibt es bereits eine Einheit mit diesem Ziel?
   function EinheitZiel
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ZielKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      EinheitSchleife:
      for EinheitNummerSchleifenwert in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => RasseExtern) loop
         
         if
           LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerSchleifenwert)) = ZielKoordinatenExtern
         then
            return True;
            
         else
            null;
         end if;
         
      end loop EinheitSchleife;
      
      return False;
      
   end EinheitZiel;

end KIAufgabenVerteiltLogik;
