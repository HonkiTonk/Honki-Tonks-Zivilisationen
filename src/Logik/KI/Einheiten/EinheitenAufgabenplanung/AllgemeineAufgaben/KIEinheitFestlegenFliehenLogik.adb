with KartenRecordKonstanten;

with SchreibeEinheitenGebaut;

with KIDatentypen;

package body KIEinheitFestlegenFliehenLogik is

   function Fliehen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      ZielKoordinate := Ziel (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        ZielKoordinate = KartenRecordKonstanten.LeerKoordinate
      is
         when False =>
            -- Hier muss noch ein Ziel hinzugefügt werden. äöü
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Flucht_Enum);
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       KoordinatenExtern        => ZielKoordinate);
            return True;
            
         when True =>
            return False;
      end case;
      
   end Fliehen;
   
   
   
   -- Hier muss noch ein Ziel hinzugefügt werden. äöü
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

end KIEinheitFestlegenFliehenLogik;
