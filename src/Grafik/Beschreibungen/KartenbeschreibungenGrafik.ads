pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen;

package KartenbeschreibungenGrafik is
   pragma Elaborate_Body;

   function KurzbeschreibungBasisgrund
     (KartenGrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum)
      return Wide_Wide_String;

   function LangbeschreibungBasisgrund
     (KartenGrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum)
      return Wide_Wide_String;

   function KurzbeschreibungZusatzgrund
     (KartenGrundExtern : in KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum)
      return Wide_Wide_String;

   function LangbeschreibungZusatzgrund
     (KartenGrundExtern : in KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum)
      return Wide_Wide_String;

   function KurzbeschreibungFluss
     (KartenFlussExtern : in KartengrundDatentypen.Kartenfluss_Vorhanden_Enum)
      return Wide_Wide_String;

   function LangbeschreibungFluss
     (KartenFlussExtern : in KartengrundDatentypen.Kartenfluss_Vorhanden_Enum)
      return Wide_Wide_String;

   function KurzbeschreibungRessource
     (KartenRessourceExtern : in KartengrundDatentypen.Kartenressourcen_Vorhanden_Enum)
      return Wide_Wide_String;

   function LangbeschreibungRessource
     (KartenRessourceExtern : in KartengrundDatentypen.Kartenressourcen_Vorhanden_Enum)
      return Wide_Wide_String;

end KartenbeschreibungenGrafik;
