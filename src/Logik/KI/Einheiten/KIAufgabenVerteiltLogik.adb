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
      use type EinheitenDatentypen.Einheitenbereich;
      use type EinheitenDatentypen.EinheitenID;
   begin
      
      GleicheAufgabe := 0;
     
      EinheitenSchleife:
      for EinheitNummerSchleifenwert in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) loop
            
         if
           LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = EinheitenKonstanten.LeerID
         then
            exit EinheitenSchleife;
            
         elsif
           EinheitNummerSchleifenwert = EinheitSpeziesNummerExtern.Nummer
         then
            null;
               
         elsif
           LeseEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = AufgabeExtern
         then
            GleicheAufgabe := GleicheAufgabe + 1;
               
         else
            null;
         end if;
            
      end loop EinheitenSchleife;
      
      return GleicheAufgabe;
      
   end AufgabenVerteilt;
   
   
   
   -- Gibt es bereits eine Einheit die diese Aufgabe auf diesem Ziel ausführen will?
   function EinheitAufgabeZiel
     (AufgabeExtern : in KIDatentypen.Einheit_Aufgabe_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      ZielKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type KIDatentypen.Einheit_Aufgabe_Enum;
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
      use type EinheitenDatentypen.EinheitenID;
   begin
      
      EinheitenSchleife:
      for EinheitNummerSchleifenwert in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern) loop
         
         Zielkoordinaten := LeseEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitNummerSchleifenwert));
         
         if
           LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitNummerSchleifenwert)) = EinheitenKonstanten.LeerID
         then
            exit EinheitenSchleife;
            
         elsif
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
         
      end loop EinheitenSchleife;
      
      return False;
      
   end EinheitAufgabeZiel;
   
   
   
   -- Gibt es bereits eine Einheit mit diesem Ziel?
   function EinheitZiel
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      ZielKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
      use type EinheitenDatentypen.EinheitenID;
   begin
      
      EinheitenSchleife:
      for EinheitNummerSchleifenwert in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern) loop
         
         if
           LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitNummerSchleifenwert)) = EinheitenKonstanten.LeerID
         then
            exit EinheitenSchleife;
            
         elsif
           LeseEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitNummerSchleifenwert)) = ZielKoordinatenExtern
         then
            return True;
            
         else
            null;
         end if;
         
      end loop EinheitenSchleife;
      
      return False;
      
   end EinheitZiel;

end KIAufgabenVerteiltLogik;
