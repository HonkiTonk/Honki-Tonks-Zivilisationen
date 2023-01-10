private with KartenDatentypen;
private with SpeziesDatentypen;
private with RueckgabeDatentypen;
private with KartenRecords;
private with ZahlenDatentypen;

private with LeseWeltkarteneinstellungen;

package SpieleinstellungenSpeziesLogik is
   pragma Elaborate_Body;
   
   procedure StartwerteErmitteln;
   procedure SpeziesWählen;
   procedure SpeziesAutomatischBelegen;
   procedure SpeziesBelegenSchnellstart;
   
   
   
   function EineSpeziesBelegt
     return Boolean;
   
private
   use type KartenDatentypen.Kartenfeld;
      
   FreieFelder : KartenDatentypen.SichtweiteNatural;
   
   SpeziesAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   SpielerartAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   SpieleranzahlAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
   SpeziesMenschSchnellstart : SpeziesDatentypen.Spezies_Verwendet_Enum;
   SpeziesKISchnellstart : SpeziesDatentypen.Spezies_Verwendet_Enum;
   
   GezogeneKoordinate : KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   Zusatzkoordinate : KartenRecords.AchsenKartenfeldNaturalRecord;
      
   type KoordinatenArray is array (1 .. 2) of KartenRecords.AchsenKartenfeldNaturalRecord;
   StartKoordinaten : KoordinatenArray;
   
   procedure BelegungÄndern
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum);

   procedure StartpunktFestlegen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      StartkoordinateEinsExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      StartkoordinateZweiExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 StartkoordinateEinsExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 StartkoordinateEinsExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 StartkoordinateZweiExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 StartkoordinateZweiExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   

   function StartpunktPrüfen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      NotAusExtern : in ZahlenDatentypen.NotAus)
      return Boolean;
   
   function ZusatzfeldBestimmen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      NotAusExtern : in ZahlenDatentypen.NotAus)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              ),
   
       Post => (
                  ZusatzfeldBestimmen'Result.YAchse <= LeseWeltkarteneinstellungen.YAchse
                and
                  ZusatzfeldBestimmen'Result.XAchse <= LeseWeltkarteneinstellungen.XAchse
               );

end SpieleinstellungenSpeziesLogik;
