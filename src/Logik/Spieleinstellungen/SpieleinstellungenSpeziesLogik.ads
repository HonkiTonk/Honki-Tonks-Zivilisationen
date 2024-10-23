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
   
   
   
   function EineSpeziesBelegt
     return Boolean;
   
private
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;
      
   FreieFelder : KartenDatentypen.SenkrechteSichtweiteNatural;
   
   SpeziesAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   SpielerartAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   SpieleranzahlAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
   SpeziesMenschSchnellstart : SpeziesDatentypen.Spezies_Vorhanden_Enum;
   SpeziesKISchnellstart : SpeziesDatentypen.Spezies_Vorhanden_Enum;
   
   GezogeneKoordinate : KartenRecords.KartenfeldNaturalRecord;
   KartenWert : KartenRecords.KartenfeldNaturalRecord;
   Zusatzkoordinate : KartenRecords.KartenfeldNaturalRecord;
      
   type KoordinatenArray is array (1 .. 2) of KartenRecords.KartenfeldNaturalRecord;
   StartKoordinaten : KoordinatenArray;
   
   procedure BelegungÄndern
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum);

   procedure StartpunktFestlegen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      StartkoordinateEinsExtern : in KartenRecords.KartenfeldNaturalRecord;
      StartkoordinateZweiExtern : in KartenRecords.KartenfeldNaturalRecord)
     with
       Pre => (
                 StartkoordinateEinsExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 StartkoordinateEinsExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 StartkoordinateZweiExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 StartkoordinateZweiExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   

   function StartpunktPrüfen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      NotAusExtern : in ZahlenDatentypen.NotAus)
      return Boolean;
   
   function ZusatzfeldBestimmen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      NotAusExtern : in ZahlenDatentypen.NotAus)
      return KartenRecords.KartenfeldNaturalRecord
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              ),
   
       Post => (
                  ZusatzfeldBestimmen'Result.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
                and
                  ZusatzfeldBestimmen'Result.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               );

end SpieleinstellungenSpeziesLogik;
