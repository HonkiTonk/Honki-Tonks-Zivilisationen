with KartenverbesserungDatentypen;

package AufgabenbeschreibungenGrafik is
   pragma Elaborate_Body;

   function KurzbeschreibungVerbesserung
     (KartenVerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum)
      return Wide_Wide_String;

   function LangbeschreibungVerbesserung
     (KartenVerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum)
      return Wide_Wide_String;

   function KurzbeschreibungWeg
     (KartenWegExtern : in KartenverbesserungDatentypen.Weg_Vorhanden_Enum)
      return Wide_Wide_String;

   function LangbeschreibungWeg
     (KartenWegExtern : in KartenverbesserungDatentypen.Weg_Vorhanden_Enum)
      return Wide_Wide_String;

end AufgabenbeschreibungenGrafik;
