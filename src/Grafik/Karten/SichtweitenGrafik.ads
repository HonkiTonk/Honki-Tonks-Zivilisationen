with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen;
with SpielVariablen;

private with TastenbelegungDatentypen;

package SichtweitenGrafik is
   pragma Elaborate_Body;
   
   procedure SichtweiteBewegungsfeldFestlegen;
   
   procedure ZoomstufeÄndern
     (ÄnderungExtern : in KartenDatentypen.Kartenfeld);
   
   procedure StandardSichtweiten;
   
   
   
   function SichtweiteLesen
     return KartenDatentypen.KartenfeldPositiv;
   
   function BewegungsfeldLesen
     return KartenDatentypen.KartenfeldPositiv;
   
   function UntenRechts
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   WelcheZoomanpassung : TastenbelegungDatentypen.Tastenbelegung_Bewegung_Erweitert_Enum;
   
   MaximaleZoomstufe : constant KartenDatentypen.KartenfeldPositiv := 10;
   StandardZoomstufe : constant KartenDatentypen.KartenfeldPositiv := 4;
   MinimaleZoomstufe : KartenDatentypen.KartenfeldPositiv := KartenDatentypen.KartenfeldPositiv'First;
   AktuelleZoomstufe : KartenDatentypen.KartenfeldPositiv := StandardZoomstufe;

end SichtweitenGrafik;
