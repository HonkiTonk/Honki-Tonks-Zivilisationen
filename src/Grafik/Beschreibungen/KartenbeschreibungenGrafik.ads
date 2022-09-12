pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen;

package KartenbeschreibungenGrafik is

   function BeschreibungZusatzgrund
     (KartenGrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum)
      return Wide_Wide_String;

   function BeschreibungBasisgrund
     (KartenGrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum)
      return Wide_Wide_String;

   function BeschreibungFluss
     (KartenFlussExtern : in KartengrundDatentypen.Kartenfluss_Vorhanden_Enum)
      return Wide_Wide_String;

   function BeschreibungRessource
     (KartenRessourceExtern : in KartengrundDatentypen.Kartenressourcen_Vorhanden_Enum)
      return Wide_Wide_String;

end KartenbeschreibungenGrafik;
