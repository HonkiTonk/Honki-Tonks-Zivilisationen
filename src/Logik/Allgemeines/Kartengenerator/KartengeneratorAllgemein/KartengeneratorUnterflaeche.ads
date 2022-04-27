pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen;
with KartengrundDatentypen;

package KartengeneratorUnterflaeche is

   procedure KartengeneratorUnterfläche;
   
private
   
   ---------------------- Beim umbenennen/verschieben/sortieren des KartengrundDatentypen.Kartengrund_Enum das hier auch anpassen.
   GrundOben : KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
   GrundUnten : KartengrundDatentypen.Kartengrund_Vorhanden_Enum;

   procedure UnterflächeErzeugen
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv);

end KartengeneratorUnterflaeche;
