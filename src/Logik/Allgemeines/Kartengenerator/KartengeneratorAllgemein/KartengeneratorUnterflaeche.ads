pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen;
with KartenGrundDatentypen;

package KartengeneratorUnterflaeche is

   procedure KartengeneratorUnterfläche;
   
private
   
   ---------------------- Beim umbenennen/verschieben/sortieren des KartenGrundDatentypen.Kartengrund_Enum das hier auch anpassen.
   GrundOben : KartenGrundDatentypen.Kartengrund_Vorhanden_Enum;
   GrundUnten : KartenGrundDatentypen.Kartengrund_Vorhanden_Enum;

   procedure UnterflächeErzeugen
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv);

end KartengeneratorUnterflaeche;
