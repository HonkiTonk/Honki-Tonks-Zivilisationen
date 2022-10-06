pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen;

private with TastenbelegungDatentypen;

package SichtweitenGrafik is
   
   procedure SichtweiteBewegungsfeldFestlegen;
   
   procedure ZoomstufeÄndern
     (ÄnderungExtern : in KartenDatentypen.Kartenfeld);
   
   procedure StandardSichtweiten;
   
   
   
   function SichtweiteLesen
     (YXExtern : in Boolean)
     return KartenDatentypen.KartenfeldPositiv;
   
   function BewegungsfeldLesen
     (YXExtern : in Boolean)
     return KartenDatentypen.KartenfeldPositiv;
   
   function SichtbereichKarteBerechnen
     return KartenDatentypen.SichtbereichAnfangEndeArray;
   
private
   
   WelcheZoomanpassung : TastenbelegungDatentypen.Tastenbelegung_Bewegung_Erweitert_Enum;
   
   MaximaleZoomstufe : constant KartenDatentypen.KartenfeldPositiv := 10;
   StandardZoomstufe : constant KartenDatentypen.KartenfeldPositiv := 4;
   MinimaleZoomstufe : KartenDatentypen.KartenfeldPositiv := KartenDatentypen.KartenfeldPositiv'First;
   AktuelleZoomstufe : KartenDatentypen.KartenfeldPositiv := StandardZoomstufe;

end SichtweitenGrafik;
