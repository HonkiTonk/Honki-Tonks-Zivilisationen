with EinheitenDatentypen;
with KartenRecordKonstanten;

with LeseEinheitenGebaut;

package body KIAufgabenVerteiltLogik is

   function AufgabenVerteilt
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      AufgabeExtern : in KIDatentypen.Einheit_Aufgabe_Enum)
      return Natural
   is
      use type KIDatentypen.Einheit_Aufgabe_Enum;
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      use type EinheitenDatentypen.EinheitenIDMitNullWert;
   begin
      
      GleicheAufgabe := 0;
     
      EinheitSchleife:
      for EinheitNummerSchleifenwert in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) loop
            
         if
           EinheitNummerSchleifenwert = EinheitSpeziesNummerExtern.Nummer
           or
             LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = EinheitenKonstanten.LeerID
         then
            null;
               
         elsif
           LeseEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = AufgabeExtern
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
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      ZielKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type KIDatentypen.Einheit_Aufgabe_Enum;
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      EinheitSchleife:
      for EinheitNummerSchleifenwert in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern) loop
         
         Zielkoordinaten := LeseEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitNummerSchleifenwert));
         
         if
           LeseEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitNummerSchleifenwert)) /= AufgabeExtern
         then
            null;
            
         elsif
           Zielkoordinaten = ZielKoordinatenExtern
           or
             (LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitNummerSchleifenwert)) = ZielKoordinatenExtern
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
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      ZielKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      EinheitSchleife:
      for EinheitNummerSchleifenwert in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern) loop
         
         if
           LeseEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitNummerSchleifenwert)) = ZielKoordinatenExtern
         then
            return True;
            
         else
            null;
         end if;
         
      end loop EinheitSchleife;
      
      return False;
      
   end EinheitZiel;

end KIAufgabenVerteiltLogik;
