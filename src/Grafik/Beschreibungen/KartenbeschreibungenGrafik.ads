with KartengrundDatentypen;
with KartenextraDatentypen;

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
     (KartenFlussExtern : in KartenextraDatentypen.Fluss_Vorhanden_Enum)
      return Wide_Wide_String;

   function LangbeschreibungFluss
     (KartenFlussExtern : in KartenextraDatentypen.Fluss_Vorhanden_Enum)
      return Wide_Wide_String;

   function KurzbeschreibungRessource
     (KartenRessourceExtern : in KartenextraDatentypen.Ressourcen_Vorhanden_Enum)
      return Wide_Wide_String;

   function LangbeschreibungRessource
     (KartenRessourceExtern : in KartenextraDatentypen.Ressourcen_Vorhanden_Enum)
      return Wide_Wide_String;

   function KurzbeschreibungFeldeffekte
     (FeldeffekteExtern : in KartengrundDatentypen.Effekt_Kartenfeld_Enum)
      return Wide_Wide_String;

   function LangbeschreibungFeldeffekte
     (FeldeffekteExtern : in KartengrundDatentypen.Effekt_Kartenfeld_Enum)
      return Wide_Wide_String;

end KartenbeschreibungenGrafik;
