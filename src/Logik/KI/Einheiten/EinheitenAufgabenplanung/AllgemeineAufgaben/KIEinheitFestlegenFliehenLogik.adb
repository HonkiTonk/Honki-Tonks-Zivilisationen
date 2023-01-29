with KartenRecordKonstanten;

with SchreibeEinheitenGebaut;

with KIDatentypen;

package body KIEinheitFestlegenFliehenLogik is

   function Fliehen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      ZielKoordinate := Ziel (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      case
        ZielKoordinate = KartenRecordKonstanten.LeerKoordinate
      is
         when False =>
            -- Hier muss noch ein Ziel hinzugefügt werden. äöü
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    AufgabeExtern              => KIDatentypen.Flucht_Enum);
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                       KoordinatenExtern          => ZielKoordinate);
            return True;
            
         when True =>
            return False;
      end case;
      
   end Fliehen;
   
   
   
   -- Hier muss noch ein Ziel hinzugefügt werden. äöü
   function Ziel
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      -- Platzhalter
      case
        EinheitSpeziesNummerExtern.Spezies
      is
         when SpeziesDatentypen.Ekropa_Enum =>
            null;
            
         when others =>
            null;
      end case;
      
      return KartenRecordKonstanten.LeerKoordinate;
      
   end Ziel;

end KIEinheitFestlegenFliehenLogik;
