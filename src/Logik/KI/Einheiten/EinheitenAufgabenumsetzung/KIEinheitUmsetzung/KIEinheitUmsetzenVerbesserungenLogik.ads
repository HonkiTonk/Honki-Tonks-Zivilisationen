with SpeziesDatentypen;
with EinheitenRecords;
with EinheitenKonstanten;

private with KartenRecords;
private with AufgabenDatentypen;
private with KartenverbesserungDatentypen;
private with BefehleDatentypen;

with LeseGrenzen;
with LeseSpeziesbelegung;

package KIEinheitUmsetzenVerbesserungenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   function WelcheVerbesserungAnlegen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
private
   
   WelcheVerbesserung : AufgabenDatentypen.Einheiten_Aufgabe_Vorhanden_Enum;
   
   VorhandeneVerbesserung : KartenverbesserungDatentypen.Verbesserung_Enum;
   
   Befehl : BefehleDatentypen.Einheitenbelegung_Enum;
   
   EinheitKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;

end KIEinheitUmsetzenVerbesserungenLogik;
