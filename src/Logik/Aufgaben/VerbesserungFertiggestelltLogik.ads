with SpeziesDatentypen;
with EinheitenRecords;
with EinheitenKonstanten;

private with AufgabenDatentypen;
private with KartenverbesserungDatentypen;
private with KartenRecords;

with LeseSpeziesbelegung;
with LeseGrenzen;

package VerbesserungFertiggestelltLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   
   procedure VerbesserungFertiggestellt
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
private
   
   WelcheAufgabe : AufgabenDatentypen.Einheitenbefehle_Verbesserungen_Enum;
   
   Koordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   type VerbesserungArray is array (AufgabenDatentypen.Einheitenbefehle_Gebilde_Enum'Range) of KartenverbesserungDatentypen.Verbesserung_Gebilde_Enum;
   Verbesserung : constant VerbesserungArray := (
                                                 AufgabenDatentypen.Mine_Bauen_Enum    => KartenverbesserungDatentypen.Mine_Enum,
                                                 AufgabenDatentypen.Farm_Bauen_Enum    => KartenverbesserungDatentypen.Farm_Enum,
                                                 AufgabenDatentypen.Festung_Bauen_Enum => KartenverbesserungDatentypen.Festung_Enum
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
