with KartenRecordKonstanten;
with KartenKonstanten;

with SchreibeEinheitenGebaut;

with KIDatentypen;

with KIZielSuchenLogik;

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
      
      MöglicheKoordinate := KIZielSuchenLogik.ZielSuchen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                           ZielartExtern              => KIDatentypen.Fliehen_Enum);
      
      case
        MöglicheKoordinate.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            -- Hier dann einfach die Städteliste durchgehen oder Leer zurückgeben und die Einheit lieber befestigen? äöü
            -- Bei der Städteliste könnte die KI die Einheit immer zurückziehen/wegbewegen. äöü
            -- Bei Befestigen wäre die Einheit befestige und würde nicht sinnlos um die Welt herumziehen. äöü
            return KartenRecordKonstanten.LeerKoordinate;
            
         when others =>
            return MöglicheKoordinate;
      end case;
            
   end Ziel;

end KIEinheitFestlegenFliehenLogik;
