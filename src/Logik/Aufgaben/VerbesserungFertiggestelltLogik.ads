private with SpeziesDatentypen;
private with EinheitenRecords;
private with AufgabenDatentypen;
private with KartenverbesserungDatentypen;
private with KartenRecords;
private with EinheitenKonstanten;

private with LeseGrenzen;
private with LeseSpeziesbelegung;

package VerbesserungFertiggestelltLogik is
   pragma Elaborate_Body;

   procedure VerbesserungFertiggestellt;
   
private
   use type SpeziesDatentypen.Spieler_Enum;
   
   WelcheAufgabe : AufgabenDatentypen.Einheitenbefehle_Verbesserungen_Enum;
   
   Koordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   type VerbesserungArray is array (AufgabenDatentypen.Einheitenbefehle_Gebilde_Enum'Range) of KartenverbesserungDatentypen.Karten_Verbesserung_Gebilde_Enum;
   Verbesserung : constant VerbesserungArray := (
                                                 AufgabenDatentypen.Mine_Bauen_Enum    => KartenverbesserungDatentypen.Mine_Enum,
                                                 AufgabenDatentypen.Farm_Bauen_Enum    => KartenverbesserungDatentypen.Farm_Enum,
                                                 AufgabenDatentypen.Festung_Bauen_Enum => KartenverbesserungDatentypen.Festung_Enum
                                                );
   
   procedure VerbesserungFertiggestelltPrüfen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure VerbesserungAngelegt
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure AufgabeNachfolgerVerschieben
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end VerbesserungFertiggestelltLogik;
