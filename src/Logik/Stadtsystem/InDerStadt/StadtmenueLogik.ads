with RassenDatentypen;
with StadtRecords;
with StadtKonstanten;

private with BefehleDatentypen;

with LeseGrenzen;
with LeseRassenbelegung;

package StadtmenueLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   procedure Stadtmenü
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => StadtRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
              );

private

   Befehlsauswahl : BefehleDatentypen.Stadtbefehle_Enum;

   procedure Stadtkarte;



   function WasIstAusgewählt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Boolean
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => StadtRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
              );

   function Mausbefehle
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      AuswahlExtern : in BefehleDatentypen.Stadtbefehle_Vorhanden_Enum)
      return Boolean
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => StadtRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
              );

end StadtmenueLogik;
