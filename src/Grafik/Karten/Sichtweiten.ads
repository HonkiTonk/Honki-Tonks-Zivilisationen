pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen;

package Sichtweiten is
   
   procedure SichtweiteBewegungsfeldFestlegen;
   
   procedure ZoomstufeÄndern
     (ÄnderungExtern : in KartenDatentypen.Kartenfeld);
   
   procedure StandardSichtweiten;
   
   
   
   function SichtweiteLesen
     return KartenDatentypen.KartenfeldPositiv;
   
   function BewegungsfeldLesen
      return KartenDatentypen.KartenfeldPositiv;
   
private
   
   -- Eventuell die Zoomstufen so anpassen, dass die YAchse ein wenig kleiner ist als die XAchse, wegen der Seitenleiste. äöü
   MaximaleZoomstufe : constant KartenDatentypen.KartenfeldPositiv := 10;
   StandardZoomstufe : constant KartenDatentypen.KartenfeldPositiv := 4;
   MinimaleZoomstufe : KartenDatentypen.KartenfeldPositiv := KartenDatentypen.KartenfeldPositiv'First;
   AktuelleZoomstufe : KartenDatentypen.KartenfeldPositiv := StandardZoomstufe;

end Sichtweiten;
